{%MainUnit gtk2wsstdctrls.pp}

{ Callbacks }

procedure Gtk2WS_MemoChanged(AGtkTextBuffer: PGtkTextBuffer; WidgetInfo: PWidgetInfo); cdecl;
var
  Mess: TLMessage;
begin
  EventTrace('Gtk2WS_MemoChanged', WidgetInfo^.LCLObject);
  if WidgetInfo^.ChangeLock > 0 then
  begin
    Dec(WidgetInfo^.ChangeLock);
    Exit;
  end;
  Mess.Msg := CM_TEXTCHANGED;
  DeliverMessage(WidgetInfo^.LCLObject, Mess);
end;

procedure Gtk2WS_MemoCutToClip(widget: PGtkWidget; WidgetInfo: PWidgetInfo); cdecl;
var
  Mess: TLMessage;
begin
  EventTrace('Gtk2WS_MemoCutToClip', WidgetInfo^.LCLObject);
  if (Widget=nil) then ;
  Mess.msg := LM_CUT;
  DeliverMessage(WidgetInfo^.LCLObject, Mess);
end;

procedure Gtk2WS_MemoCopyToClip(widget: PGtkWidget; WidgetInfo: PWidgetInfo); cdecl;
var
  Mess: TLMessage;
begin
  EventTrace('Gtk2WS_MemoCopyToClip', WidgetInfo^.LCLObject);
  if (Widget=nil) then ;
  Mess.msg := LM_COPY;
  DeliverMessage(WidgetInfo^.LCLObject, Mess);
end;

procedure Gtk2WS_MemoPasteFromClip(widget: PGtkWidget; WidgetInfo: PWidgetInfo); cdecl;
var
  Mess: TLMessage;
begin
  EventTrace('Gtk2WS_MemoPasteFromClip', WidgetInfo^.LCLObject);
  if (Widget=nil) then ;
  Mess.msg := LM_PASTE;
  DeliverMessage(WidgetInfo^.LCLObject, Mess);
end;

procedure Gtk2WS_MemoTextInserting (Textbuffer: PGtkTextBuffer; StartIter: PGtkTextIter;
             thetext: pgchar; NewTextLength: gint;  WidgetInfo: PWidgetInfo); cdecl;
var
  Memo: TCustomMemo;
  CurrLength, CutLength: integer;
begin
  { GTK2 does not provide its own max. length for memos
    so we have to do our own. }

  if TControl(WidgetInfo^.LCLObject) is TCustomMemo then
  begin
    Memo := TCustomMemo(WidgetInfo^.LCLObject);
    if Memo.MaxLength <= 0 then Exit;

    CurrLength := gtk_text_buffer_get_char_count(TextBuffer);
    if CurrLength + NewTextLength <= Memo.MaxLength then
      Exit;

    CutLength := CurrLength + NewTextLength - Memo.MaxLength;

    if NewTextLength - CutLength > 0 then
      gtk_text_buffer_insert(TextBuffer, StartIter, TheText, NewTextLength - CutLength);

    g_signal_stop_emission_by_name(PGtkObject(Textbuffer), 'insert-text');
  end;
end;



{ TGtk2WSCustomMemo }

class procedure TGtk2WSCustomMemo.SetCallbacks(const AGtkWidget: PGtkWidget;
  const AWidgetInfo: PWidgetInfo);
var
  TextBuf: PGtkTextBuffer;
begin
  TextBuf := gtk_text_view_get_buffer(PGtkTextView(AWidgetInfo^.CoreWidget));

  //TGtkWSBaseScrollingWinControl.SetCallbacks(AGtkWidget, AWidgetInfo);

  TGtkWSWinControl.SetCallbacks(PGtkObject(AGtkWidget), TComponent(AWidgetInfo^.LCLObject));
  
  SignalConnect(PGtkWidget(TextBuf), 'changed', @Gtk2WS_MemoChanged, AWidgetInfo);
  SignalConnect(PGtkWidget(TextBuf), 'insert-text', @Gtk2WS_MemoTextInserting, AWidgetInfo);

  //SetCallback(LM_ACTIVATE, AGTKObject,ALCLObject);
  
  SignalConnect(AWidgetInfo^.CoreWidget, 'cut-clipboard', @Gtk2WS_MemoCutToClip, AWidgetInfo);
  SignalConnect(AWidgetInfo^.CoreWidget, 'copy-clipboard', @Gtk2WS_MemoCopyToClip, AWidgetInfo);
  SignalConnect(AWidgetInfo^.CoreWidget, 'paste-clipboard', @Gtk2WS_MemoPasteFromClip, AWidgetInfo);
end;

class function TGtk2WSCustomMemo.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): TLCLIntfHandle;
var
  Widget,
  TempWidget: PGtkWidget;
  WidgetInfo: PWidgetInfo;
begin
  Widget := gtk_scrolled_window_new(nil, nil);
  Result := TLCLIntfHandle(PtrUInt(Widget));
  if Result = 0 then Exit;
  {$IFDEF DebugLCLComponents}
  DebugGtkWidgets.MarkCreated(Widget,dbgsName(AWinControl));
  {$ENDIF}

  WidgetInfo := CreateWidgetInfo(Pointer(Result), AWinControl, AParams);

  TempWidget := gtk_text_view_new();
  gtk_container_add(PGtkContainer(Widget), TempWidget);

  GTK_WIDGET_UNSET_FLAGS(PGtkScrolledWindow(Widget)^.hscrollbar, GTK_CAN_FOCUS);
  GTK_WIDGET_UNSET_FLAGS(PGtkScrolledWindow(Widget)^.vscrollbar, GTK_CAN_FOCUS);
  gtk_scrolled_window_set_policy(PGtkScrolledWindow(Widget),
                                     GTK_POLICY_AUTOMATIC,
                                     GTK_POLICY_AUTOMATIC);
  // add border for memo
  gtk_scrolled_window_set_shadow_type(PGtkScrolledWindow(Widget),
    BorderStyleShadowMap[TCustomEdit(AWinControl).BorderStyle]);
  
  SetMainWidget(Widget, TempWidget);
  GetWidgetInfo(Widget, True)^.CoreWidget := TempWidget;

  gtk_text_buffer_set_text(gtk_text_view_get_buffer(PGtkTextView(TempWidget)), PChar(TCustomMemo(AWinControl).Text), -1);
  gtk_text_view_set_editable(PGtkTextView(TempWidget), not TCustomMemo(AWinControl).ReadOnly);
  gtk_text_view_set_justification(PGtkTextView(TempWidget), aGtkJustification[TCustomMemo(AWinControl).Alignment]);
  if TCustomMemo(AWinControl).WordWrap then
    gtk_text_view_set_wrap_mode(PGtkTextView(TempWidget), GTK_WRAP_WORD)
  else
    gtk_text_view_set_wrap_mode(PGtkTextView(TempWidget), GTK_WRAP_NONE);

  gtk_text_view_set_accepts_tab(PGtkTextView(TempWidget), TCustomMemo(AWinControl).WantTabs);
  
  gtk_widget_show_all(Widget);

  Set_RC_Name(AWinControl, Widget);  
  SetCallbacks(Widget, WidgetInfo);
end;

class function TGtk2WSCustomMemo.GetStrings(const ACustomMemo: TCustomMemo
  ): TStrings;
var
TextView: PGtkTextView;
begin
  TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomMemo.Handle), False)^.CoreWidget);
  Result := TGtk2MemoStrings.Create(TextView, ACustomMemo);
end;

class procedure TGtk2WSCustomMemo.SetAlignment(const ACustomEdit: TCustomEdit;
  const AAlignment: TAlignment);
var
  TextView: PGtkTextView;
begin
  TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomEdit.Handle), False)^.CoreWidget);
  gtk_text_view_set_justification(TextView, aGtkJustification[AAlignment]);
end;


class procedure TGtk2WSCustomMemo.SetColor(const AWinControl: TWinControl);
var
  AWidget: PGTKWidget;
begin
  if not WSCheckHandleAllocated(AWinControl, 'SetColor') then
    Exit;
  AWidget := PGtkWidget(AWinControl.Handle);
  AWidget := GetWidgetInfo(AWidget, True)^.CoreWidget;
  Gtk2WidgetSet.SetWidgetColor(AWidget,
    AWinControl.Font.Color,
    AWinControl.Color,
    [GTK_STATE_NORMAL, GTK_STATE_ACTIVE, GTK_STATE_PRELIGHT, GTK_STYLE_BASE]);
end;

class procedure TGtk2WSCustomMemo.SetFont(const AWinControl: TWinControl;
  const AFont: TFont);
var
  AWidget: PGTKWidget;
begin
  if not WSCheckHandleAllocated(AWinControl, 'SetFont') then
    Exit;

  AWidget:= PGtkWidget(AWinControl.Handle);
  AWidget:= GetWidgetInfo(AWidget)^.CoreWidget;

  if AWidget <> nil then
  begin
    Gtk2WidgetSet.SetWidgetColor(AWidget, AFont.color, clNone,
       [GTK_STATE_NORMAL,GTK_STATE_ACTIVE,GTK_STATE_PRELIGHT,GTK_STATE_SELECTED,
        GTK_STYLE_TEXT]);
    Gtk2WidgetSet.SetWidgetFont(AWidget, AFont);
  end;
end;

class procedure TGtk2WSCustomMemo.SetSelStart(const ACustomEdit: TCustomEdit;
  NewStart: integer);
var
  MemoStrings: TGtk2MemoStrings;
begin
  if not WSCheckHandleAllocated(ACustomEdit, 'SetSelStart') then
    Exit;

  MemoStrings := TCustomMemo(ACustomEdit).Lines as TGtk2MemoStrings;
  MemoStrings.QueueCursorMove(NewStart);
end;

class procedure TGtk2WSCustomMemo.SetSelLength(const ACustomEdit: TCustomEdit;
  NewLength: integer);
var
  MemoStrings: TGtk2MemoStrings;
begin
  if not WSCheckHandleAllocated(ACustomEdit, 'SetSelLength') then
    Exit;

  MemoStrings := TCustomMemo(ACustomEdit).Lines as TGtk2MemoStrings;
  MemoStrings.QueueSelectLength(NewLength);
end;

class procedure TGtk2WSCustomMemo.SetWantTabs(const ACustomMemo: TCustomMemo;
  const NewWantTabs: boolean);
var
  TextView: PGtkTextView;
begin
  if not WSCheckHandleAllocated(ACustomMemo, 'SetWantTabs') then
    Exit;

  TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomMemo.Handle), False)^.CoreWidget);
  gtk_text_view_set_accepts_tab(TextView, NewWantTabs);
end;

class procedure TGtk2WSCustomMemo.SetEchoMode(const ACustomEdit: TCustomEdit;
  NewMode: TEchoMode);
begin
  // not supported
end;

class procedure TGtk2WSCustomMemo.SetPasswordChar(
  const ACustomEdit: TCustomEdit; NewChar: char);
begin
  // not supported
end;

class procedure TGtk2WSCustomMemo.SetCharCase(const ACustomEdit: TCustomEdit;
  NewCase: TEditCharCase);
begin
  // TODO: implement me!
end;

class procedure TGtk2WSCustomMemo.SetMaxLength(const ACustomEdit: TCustomEdit;
  NewLength: integer);
var
  Widget: PGtkWidget;
begin
  Widget:=PGtkWidget(ACustomEdit.Handle);
  if GtkWidgetIsA(Widget, GTK_TYPE_ENTRY) then
    gtk_entry_set_max_length(GTK_ENTRY(Widget), guint16(NewLength));
end;

class procedure TGtk2WSCustomMemo.SetReadOnly(const ACustomEdit: TCustomEdit;
  NewReadOnly: boolean);
var
  Widget: PGtkWidget;
begin
  Widget:=PGtkWidget(ACustomEdit.Handle);
  if GtkWidgetIsA(Widget, GTK_TYPE_ENTRY) then
    gtk_entry_set_editable(GTK_ENTRY(Widget), not ACustomEdit.ReadOnly);
end;

class procedure TGtk2WSCustomMemo.SetText(const AWinControl: TWinControl;
  const AText: string);
var
  TextBuf: PGtkTextBuffer;
  StartIter: TGtkTextIter;
begin
  if not WSCheckHandleAllocated(AWinControl, 'SetText') then
    Exit;
  TextBuf := gtk_text_view_get_buffer(PGtkTextView(GetWidgetInfo(Pointer(AWinControl.Handle), True)^.CoreWidget));
  gtk_text_buffer_set_text(TextBuf, PChar(AText), -1);
  gtk_text_buffer_get_start_iter(TextBuf, @StartIter);
  gtk_text_buffer_place_cursor(TextBuf, @StartIter);
end;

class procedure TGtk2WSCustomMemo.GetPreferredSize(
  const AWinControl: TWinControl; var PreferredWidth, PreferredHeight: integer;
  WithThemeSpace: Boolean);
begin
  GetGTKDefaultWidgetSize(AWinControl,PreferredWidth,PreferredHeight,
                          WithThemeSpace);
end;

class function TGtk2WSCustomMemo.GetSelStart(const ACustomEdit: TCustomEdit
  ): integer;
var
  TextView: PGtkTextView;
  TextBuffer: PGtkTextBuffer;
  TextMark: PGtkTextMark;
  TextIter: TGtkTextIter;
  StartIter, EndIter: TGtkTextIter;
  StartPos, EndPos: Integer;
begin
  Result := 0;
  if not WSCheckHandleAllocated(ACustomEdit, 'GetSelStart') then
    Exit;

  TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomEdit.Handle), False)^.CoreWidget);
  TextBuffer := gtk_text_view_get_buffer(TextView);
  TextMark := gtk_text_buffer_get_insert(TextBuffer);
  gtk_text_buffer_get_iter_at_mark(TextBuffer, @TextIter, TextMark);
  
  Result := gtk_text_iter_get_offset(@TextIter);
  if GetSelLength(ACustomEdit) = 0 then Exit;
  
  if not gtk_text_buffer_get_selection_bounds(TextBuffer, @StartIter, @EndIter) then Exit;
  
  StartPos := gtk_text_iter_get_offset(@StartIter);
  EndPos := gtk_text_iter_get_offset(@EndIter);
  
  Result := Min(StartPos, EndPos);
end;

class function TGtk2WSCustomMemo.GetSelLength(const ACustomEdit: TCustomEdit): integer;
var
  MemoStrings: TGtk2MemoStrings;
  TextView: PGtkTextView;
  TextBuffer: PGtkTextBuffer;
  StartIter, EndIter: TGtkTextIter;
begin
  Result := 0;
  if not WSCheckHandleAllocated(ACustomEdit, 'GetSelLength') then
    Exit;

  MemoStrings := TCustomMemo(ACustomEdit).Lines as TGtk2MemoStrings;
  Result := MemoStrings.QueueSelLength;

  if Result = -1 then
  begin
    Result := 0;
    TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomEdit.Handle), False)^.CoreWidget);
    TextBuffer := gtk_text_view_get_buffer(TextView);
    if not gtk_text_buffer_get_selection_bounds(TextBuffer, @StartIter, @EndIter) then Exit;

    Result := Abs(gtk_text_iter_get_offset(@EndIter) - gtk_text_iter_get_offset(@StartIter));
  end;
end;

class function TGtk2WSCustomMemo.GetCaretPos(const ACustomEdit: TCustomEdit): TPoint;
var
  TextView: PGtkTextView;
  TextBuffer: PGtkTextBuffer;
  TextMark: PGtkTextMark;
  TextIter: TGtkTextIter;
begin
  Result := Point(0, 0);
  if not WSCheckHandleAllocated(ACustomEdit, 'GetCaretPos') then
    Exit;
  TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomEdit.Handle), False)^.CoreWidget);
  TextBuffer := gtk_text_view_get_buffer(TextView);
  TextMark := gtk_text_buffer_get_insert(TextBuffer);
  gtk_text_buffer_get_iter_at_mark(TextBuffer, @TextIter, TextMark);

  Result.X := gtk_text_iter_get_line_offset(@TextIter);
  Result.Y := gtk_text_iter_get_line(@TextIter);
end;

class procedure TGtk2WSCustomMemo.SetCaretPos(const ACustomEdit: TCustomEdit;
  const NewPos: TPoint);
var
  TextView: PGtkTextView;
  TextBuffer: PGtkTextBuffer;
  TextIter: TGtkTextIter;
begin
  if not WSCheckHandleAllocated(ACustomEdit, 'SetCaretPos') then
    Exit;
  TextView := PGtkTextView(GetWidgetInfo(Pointer(ACustomEdit.Handle), False)^.CoreWidget);
  TextBuffer := gtk_text_view_get_buffer(TextView);

  if (NewPos.X < 0) or (NewPos.Y < 0)
    then Exit;

{ this is quicker, but crashes if given invalid coords:
  gtk_text_buffer_get_iter_at_line_offset(TextBuffer, @TextIter, NewPos.Y, NewPos.X); }

  if (NewPos.Y >= gtk_text_buffer_get_line_count(TextBuffer))
    then Exit;
  gtk_text_buffer_get_iter_at_line(TextBuffer, @TextIter, NewPos.Y);
  if (NewPos.X >= gtk_text_iter_get_chars_in_line(@TextIter))
    then Exit;
  gtk_text_iter_set_line_offset(@TextIter, NewPos.X);

  gtk_text_buffer_place_cursor(TextBuffer, @TextIter);
end;
