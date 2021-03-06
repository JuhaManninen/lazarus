{%MainUnit gtk2int.pas}
{******************************************************************************
                                   TGtk2WidgetSet
 ******************************************************************************

 *****************************************************************************
 *                                                                           *
 *  This file is part of the Lazarus Component Library (LCL)                 *
 *                                                                           *
 *  See the file COPYING.modifiedLGPL.txt, included in this distribution,    *
 *  for details about the copyright.                                         *
 *                                                                           *
 *  This program is distributed in the hope that it will be useful,          *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
 *                                                                           *
 *****************************************************************************
}

{$IFOPT C-}
// Uncomment for local trace
//  {$C+}
//  {$DEFINE ASSERT_IS_ON}
{$ENDIF}

function GTK2FocusCB( widget: PGtkWidget; event:PGdkEventFocus;
  data: gPointer) : GBoolean; cdecl;
var
  Status : gBoolean;
begin
  Status := GTKFocusCB(Widget, Event, Data);

  if GtkWidgetIsA(Widget,GTK_APIWIDGETCLIENT_TYPE) then
    Result := Status
  else
    Result := False;
end;

function GTK2FocusCBAfter(widget: PGtkWidget; event:PGdkEventFocus;
  data: gPointer) : GBoolean; cdecl;
var
  Status : gBoolean;
begin
  Status := GTKFocusCBAfter(Widget, Event, Data);

  if GtkWidgetIsA(Widget,GTK_APIWIDGETCLIENT_TYPE) then
    Result := Status
  else
    Result := False;
end;

function gtk2HideCB( widget: PGtkWidget; data: gPointer) : GBoolean; cdecl;
var
   Status : GBoolean;
begin
  Status := gtkHideCB(Widget, Data);

  if GtkWidgetIsA(Widget,GTK_APIWIDGETCLIENT_TYPE) then
    Result := Status
  else
    Result := False;
end;

function GTK2KeyDown(Widget: PGtkWidget; Event : pgdkeventkey;
  Data: gPointer) : GBoolean; cdecl;
begin
  //debugln('GTK2KeyDown ',DbgSName(TObject(Data)));
  Result := HandleGtkKeyUpDown(Widget, Event, Data, True, True, 'key-press-event');
end;

function GTK2KeyDownAfter(Widget: PGtkWidget; Event : pgdkeventkey;
  Data: gPointer) : GBoolean; cdecl;
begin
  //debugln('GTK2KeyDownAfter ',DbgSName(TObject(Data)));
  Result := HandleGtkKeyUpDown(Widget, Event, Data, False, True, 'key-press-event');
end;

function GTK2KeyUp(Widget: PGtkWidget; Event : pgdkeventkey;
  Data: gPointer) : GBoolean; cdecl;
begin
  //debugln('GTK2KeyUp ',DbgSName(TObject(Data)));
  Result := HandleGtkKeyUpDown(Widget, Event, Data, True, False, 'key-release-event');
end;

function GTK2KeyUpAfter(Widget: PGtkWidget; Event : pgdkeventkey;
  Data: gPointer) : GBoolean; cdecl;
begin
  //debugln('GTK2KeyUpAfter ',DbgSName(TObject(Data)));
  Result := HandleGtkKeyUpDown(Widget, Event, Data, False, False, 'key-release-event');
end;

function GTK2KillFocusCB(widget: PGtkWidget; event:PGdkEventFocus;
  data: gPointer) : GBoolean; cdecl;
var
  Status : gBoolean;
begin
  Status := GTKKillFocusCB(Widget, Event, Data);

  if GtkWidgetIsA(Widget,GTK_APIWIDGETCLIENT_TYPE) then
    Result := Status
  else
    Result := False;
end;

function GTK2KillFocusCBAfter(widget: PGtkWidget; event:PGdkEventFocus;
  data: gPointer) : GBoolean; cdecl;
var
  Status : gBoolean;
begin
  Status := GTKKillFocusCBAfter(Widget, Event, Data);

  if GtkWidgetIsA(Widget,GTK_APIWIDGETCLIENT_TYPE) then
    Result := Status
  else
    Result := False;
end;

function gtk2PopupMenuCB(Widget: PGtkWidget; data: gPointer): gboolean; cdecl;
var
  Msg: TLMMouse;
  x, y: gint;
begin
  FillChar(Msg, SizeOf(Msg), #0);

  Msg.Msg := LM_CONTEXTMENU;
  Msg.Keys := 0; // todo: true keystate
  gtk_widget_get_pointer(Widget, @x, @y);

  if x > Widget^.allocation.width then
    x := Widget^.allocation.width
  else
  if x < 0 then
    x := 0;

  if y > Widget^.allocation.height then
    y := Widget^.allocation.height
  else
  if y < 0 then
    y := 0;

  Msg.XPos := x;
  Msg.YPos := y;

  Result := DeliverMessage(TComponent(data), Msg) <> 0;
end;

function gtk2showCB( widget: PGtkWidget; data: gPointer) : GBoolean; cdecl;
var
   Status : GBoolean;
begin
  Status := gtkshowCB(Widget, Data);

  if GtkWidgetIsA(Widget,GTK_APIWIDGETCLIENT_TYPE) then
    Result := Status
  else
    Result := False;
end;

procedure gtk_clb_toggle(cellrenderertoggle : PGtkCellRendererToggle; arg1 : PGChar;
                         WinControl: TWinControl); cdecl;
var
  aWidget : PGTKWidget;
  aTreeModel : PGtkTreeModel;
  aTreeIter : TGtkTreeIter;
  value : pgValue;
begin
  aWidget := GetWidgetInfo(Pointer(WinControl.Handle), True)^.CoreWidget;
  aTreeModel := gtk_tree_view_get_model (GTK_TREE_VIEW(aWidget));
  if (gtk_tree_model_get_iter_from_string (aTreeModel, @aTreeIter, arg1)) then begin
    aTreeIter.stamp := GTK_LIST_STORE (aTreeModel)^.stamp; //strange hack
    value := g_new0(SizeOf(TgValue), 1);
    gtk_tree_model_get_value(aTreeModel, @aTreeIter, 0, value);

    g_value_set_boolean(value, not g_value_get_boolean(value));

    gtk_list_store_set_value (GTK_LIST_STORE (aTreeModel), @aTreeIter, 0, value);
    g_value_unset(value);
    g_free(value);
  end;
end;

procedure gtk_clb_toggle_row_activated(treeview : PGtkTreeView; arg1 : PGtkTreePath;
                                  arg2 : PGtkTreeViewColumn; data : gpointer); cdecl;
var
  aTreeModel : PGtkTreeModel;
  aTreeIter : TGtkTreeIter;
  value : PGValue;
begin
  aTreeModel := gtk_tree_view_get_model (treeview);
  if (gtk_tree_model_get_iter (aTreeModel, @aTreeIter, arg1)) then begin
    aTreeIter.stamp := GTK_LIST_STORE (aTreeModel)^.stamp; //strange hack
    value := g_new0(SizeOf(TgValue), 1);
    gtk_tree_model_get_value(aTreeModel, @aTreeIter, 0, value);

    g_value_set_boolean(value, not g_value_get_boolean(value));

    gtk_list_store_set_value (GTK_LIST_STORE (aTreeModel), @aTreeIter, 0, value);
    g_value_unset(value);
    g_free(value);
  end;
end;

procedure gtk_commit_cb (context: PGtkIMContext; const Str: Pgchar;
  Data: Pointer); cdecl;
begin
  //DebugLn(['gtk_commit_cb ',dbgstr(Str),'="',Str,'"']);
  im_context_string:=Str;
end;

{$IfNDef GTK2_2}
procedure gtkTreeSelectionCountSelectedRows(model : PGtkTreeModel; path : PGtkTreePath;
                                  iter : PGtkTreeIter; data : PGint); cdecl;
begin
  If Assigned(Data) then
    Inc(Data^);
end;

Type
  PPGList = ^PGList;
  
procedure gtkTreeSelectionGetSelectedRows(model : PGtkTreeModel; path : PGtkTreePath;
                                  iter : PGtkTreeIter; data : PPGList); cdecl;
begin
  If Assigned(Data) then
    Data^ := g_list_append(Data^, gtk_tree_path_copy(path));
end;
{$EndIf}

{ TGtk2WidgetSet }

{------------------------------------------------------------------------------
  procedure TGtk2WidgetSet.AppendText(Sender: TObject; Str: PChar);
 ------------------------------------------------------------------------------}
procedure TGtk2WidgetSet.AppendText(Sender: TObject; Str: PChar);
var
  Widget : PGtkWidget;
  aTextBuffer : PGtkTextBuffer;
  aTextIter1  : TGtkTextIter;
  aTextIter2  : TGtkTextIter;
begin
  if Str=nil then exit;

  if (Sender is TWinControl) then begin
    case TWinControl(Sender).fCompStyle of
      csMemo:
      begin
       Widget:= GetWidgetInfo(Pointer(TWinControl(Sender).Handle), True)^.CoreWidget;
        aTextBuffer := gtk_text_view_get_buffer(GTK_TEXT_VIEW(Widget));
        gtk_text_buffer_begin_user_action(aTextBuffer);
        gtk_text_buffer_get_bounds(aTextBuffer, @aTextIter1, @aTextIter2);
        gtk_text_buffer_insert(aTextBuffer, @aTextIter2, str, StrLen(str));
        gtk_text_buffer_end_user_action(aTextBuffer);
      end;
      {else
        inherited AppendText(Sender, Str);}
    end;
  end;
end;

function TGtk2WidgetSet.GetDeviceContextClass: TGtkDeviceContextClass;
begin
  Result := TGtk2DeviceContext;
end;

function TGtk2WidgetSet.GetText(Sender: TComponent; var Text: String): Boolean;
var
  CS: PChar;
  Widget : PGtkWidget;
  aTextBuffer : PGtkTextBuffer;
  aTextIter1  : TGtkTextIter;
  aTextIter2  : TGtkTextIter;
begin
  Result := True;
  case TControl(Sender).fCompStyle of
   csEdit: begin
             Widget:= GTK_WIDGET(Pointer(TWinControl(Sender).Handle));
             CS := gtk_editable_get_chars(GTK_EDITABLE(Widget), 0, -1);
             Text := StrPas(CS);
             g_free(CS);
           end;

   csMemo    : begin
                 Widget:= GetWidgetInfo(Pointer(TWinControl(Sender).Handle), True)^.CoreWidget;
                  aTextBuffer := gtk_text_view_get_buffer(GTK_TEXT_VIEW(Widget));
                  gtk_text_buffer_get_bounds(aTextBuffer, @aTextIter1, @aTextIter2);
                  CS := gtk_text_buffer_get_text(aTextBuffer, @aTextIter1, @aTextIter2, True);
                  Text := StrPas(CS);
                  g_free(CS);
               end;
  {else
    Result := inherited GetText(Sender, Text);}
  end;
end;

{------------------------------------------------------------------------------
  Function: TGtk2WidgetSet.SetCallbackEx
  Params: Msg - message for which to set a callback
          sender - object to which callback will be send
  Returns:  nothing

  Applies a Message to the sender
 ------------------------------------------------------------------------------}
procedure TGTK2WidgetSet.SetCallbackEx(const AMsg: LongInt;
  const AGTKObject: PGTKObject; const ALCLObject: TObject; Direct: boolean);

  procedure ConnectSenderSignal(const AnObject:PGTKObject; const ASignal: PChar;
    const ACallBackProc: Pointer);
  begin
    ConnectSignal(AnObject,ASignal,ACallBackProc,TComponent(ALCLObject));
  end;

  procedure ConnectSenderSignalAfter(const AnObject:PGTKObject;
    const ASignal: PChar; const ACallBackProc: Pointer);
  begin
    ConnectSignalAfter(AnObject,ASignal,ACallBackProc,TComponent(ALCLObject));
  end;

  procedure ConnectSenderSignal(const AnObject:PGTKObject; const ASignal: PChar;
    const ACallBackProc: Pointer; const ReqSignalMask: TGdkEventMask);
  begin
    ConnectSignal(AnObject,ASignal,ACallBackProc,ALCLObject,
                  ReqSignalMask);
  end;

  procedure ConnectSenderSignalAfter(const AnObject:PGTKObject;
    const ASignal: PChar; const ACallBackProc: Pointer;
    const ReqSignalMask: TGdkEventMask);
  begin
    ConnectSignalAfter(AnObject,ASignal,ACallBackProc,ALCLObject,
                       ReqSignalMask);
  end;

  procedure ConnectFocusEvents(const AnObject: PGTKObject);
  begin
    //DebugLn(['ConnectFocusEvents ',GetWidgetDebugReport(PGtkWidget(AnObject))]);
    ConnectSenderSignal(AnObject, 'focus-in-event', @gtk2FocusCB);
    ConnectSenderSignalAfter(AnObject, 'focus-in-event', @gtk2FocusCBAfter);
    ConnectSenderSignal(AnObject, 'focus-out-event', @gtk2KillFocusCB);
    ConnectSenderSignalAfter(AnObject, 'focus-out-event', @gtk2KillFocusCBAfter);
  end;

  procedure ConnectKeyPressReleaseEvents(const AnObject: PGTKObject);
  begin
    //debugln('gtk2object ConnectKeyPressReleaseEvents A ALCLObject=',DbgSName(ALCLObject));
    ConnectSenderSignal(AnObject,
      'key-press-event', @GTK2KeyDown, GDK_KEY_PRESS_MASK);
    ConnectSenderSignalAfter(AnObject,
      'key-press-event', @GTK2KeyDownAfter, GDK_KEY_PRESS_MASK);
    ConnectSenderSignal(AnObject,
      'key-release-event', @GTK2KeyUp, GDK_KEY_RELEASE_MASK);
    ConnectSenderSignalAfter(AnObject,
      'key-release-event', @GTK2KeyUpAfter, GDK_KEY_RELEASE_MASK);
  end;

var
  gObject, gFixed, gCore: PGTKObject;
begin
  //debugln('gtk2object.inc TGtkWidgetSet.SetCallback A ALCLObject=',DbgSName(ALCLObject),' AMsg=',dbgs(AMsg));
  if Direct then
  begin
    gObject := AGTKObject;
    gFixed := AGTKObject;
    gCore := AGTKObject;
  end
  else
  begin
    // gObject
    if AGTKObject = nil then gObject := ObjectToGTKObject(ALCLObject)
    else gObject := AGTKObject;

    if gObject = nil then Exit;

    // gFixed is the widget with the client area (e.g. TGroupBox, TForm have this)
    gFixed := PGTKObject(GetFixedWidget(gObject));
    if gFixed = nil then gFixed := gObject;

    // gCore is the main widget (e.g. TListView has this)
    gCore:= PGtkObject(GetWidgetInfo(gObject, True)^.CoreWidget);
  end;

  case AMsg of
    LM_FOCUS :
    begin
      ConnectFocusEvents(gCore);
    end;

    LM_GRABFOCUS:
    begin
      ConnectSenderSignal(gObject, 'grab_focus', @gtkActivateCB);
    end;

    LM_CHAR,
    LM_KEYDOWN,
    LM_KEYUP,
    LM_SYSCHAR,
    LM_SYSKEYDOWN,
    LM_SYSKEYUP:
    begin
      if (ALCLObject is TCustomComboBox) then
        ConnectKeyPressReleaseEvents(PgtkObject(PgtkCombo(gObject)^.entry))
      else if (ALCLObject is TCustomForm) then
        ConnectKeyPressReleaseEvents(gObject);

      ConnectKeyPressReleaseEvents(gCore);
    end;

    LM_SHOWWINDOW :
    begin
      ConnectSenderSignal(gObject, 'show', @gtk2showCB);
      ConnectSenderSignal(gObject, 'hide', @gtk2hideCB);
    end;

    LM_CONTEXTMENU:
      ConnectSenderSignal(gCore, 'popup-menu', @gtk2PopupMenuCB);

  else
    inherited SetCallbackEx(AMsg, AGTKObject, ALCLObject, Direct);
  end;
end;

procedure TGtk2WidgetSet.SetLabelCaption(const ALabel: PGtkLabel;
  const ACaption: String);
var
  s: String;
  i: Integer;
begin
  s := '';
  i := 1;
  while i <=  Length(ACaption) do
  begin
    case ACaption[i] of
      '_': s := s + '__';
      '&':
        if (i < Length(ACaption)) and (ACaption[i + 1] = '&') then
        begin
          s := s + '&';
          inc(i);
        end
        else
          s := s + '_';
    else
      s := s + ACaption[i];
    end;
    inc(i);
  end;
  gtk_label_set_text_with_mnemonic(ALabel, PChar(s));
end;

{------------------------------------------------------------------------------
  procedure TGtk2WidgetSet.SetSelectionMode(Sender: TObject; Widget: PGtkWidget;
    MultiSelect, ExtendedSelect: boolean);
------------------------------------------------------------------------------}
procedure TGtk2WidgetSet.SetSelectionMode(Sender: TObject; Widget: PGtkWidget;
  MultiSelect, ExtendedSelect: boolean);
var
  AControl: TWinControl;
  SelectionMode: TGtkSelectionMode;
  Selection : PGtkTreeSelection;
begin
  AControl:=TWinControl(Sender);
  if (AControl is TWinControl) and
    (AControl.fCompStyle in [csListBox, csCheckListBox]) then
  begin
    if MultiSelect then
      SelectionMode:= GTK_SELECTION_MULTIPLE
    else
      SelectionMode:= GTK_SELECTION_SINGLE;
      
    Selection := gtk_tree_view_get_selection(GTK_TREE_VIEW(
       GetWidgetInfo(Widget, True)^.CoreWidget));
    gtk_tree_selection_set_mode(Selection, SelectionMode);
  end;
end;

procedure TGtk2WidgetSet.SetWidgetFont(const AWidget: PGtkWidget; const AFONT: tFont);
var
  FontDesc: PPangoFontDescription;
  UseFont: PPangoLayout;
begin
  if GtkWidgetIsA(AWidget,GTKAPIWidget_GetType) then begin
    // the GTKAPIWidget is self drawn, so no use to change the widget style.
    exit;
  end;


  UseFont := PGdiObject(AFont.Reference.Handle)^.GDIFontObject;
  FontDesc := pango_layout_get_font_description(UseFont);
  gtk_widget_modify_font(AWidget, FontDesc);
end;

(*
{------------------------------------------------------------------------------
  function TGtk2WidgetSet.SetTopIndex(Sender: TObject; NewTopIndex: integer
    ): integer;
------------------------------------------------------------------------------}
function TGtk2WidgetSet.SetTopIndex(Sender: TObject; NewTopIndex: integer
  ): integer;
var
  aTreeView: PGtkTreeView;
  aTreeModel  : PGtkTreeModel;
  aTreeColumn  : PGtkTreeViewColumn;
  aTreeIter   : TGtkTreeIter;
  aTreePath   : PGtkTreePath;
  Count : Integer;
begin
  Result:=0;
  if not (Sender is TWinControl) then exit;
  case TWinControl(Sender).fCompStyle of

  csListBox, csCheckListBox:
    begin
      aTreeView := GTK_TREE_VIEW(GetWidgetInfo(Pointer(TWinControl(Sender).Handle), True)^.CoreWidget);
      aTreeModel := gtk_tree_view_get_model(aTreeView);

      If NewTopIndex < 0 then
        NewTopIndex := 0
      else begin
        Count := gtk_tree_model_iter_n_children(aTreeModel,nil);

        If NewTopIndex >= Count then
          NewTopIndex := Count - 1;
      end;
      
      if gtk_tree_model_iter_nth_child(aTreeModel,@aTreeIter, nil, NewTopIndex) then begin
        aTreePath := gtk_tree_model_get_path(aTreeModel, @aTreeIter);
        aTreeColumn := gtk_tree_view_get_column(aTreeView, 0);
        gtk_tree_view_scroll_to_cell(aTreeView, aTreePath, aTreeColumn, False, 0.0, 0.0);
        gtk_tree_path_free(aTreePath);
      end;
    end;
  end;
end;
*)

function TGtk2WidgetSet.CreateThemeServices: TThemeServices;
begin
  Result := TGtk2ThemeServices.Create;
end;

constructor TGtk2WidgetSet.Create;
begin
  inherited Create;
  im_context:=gtk_im_multicontext_new;
  g_signal_connect (G_OBJECT (im_context), 'commit',
    G_CALLBACK (@gtk_commit_cb), nil);
end;

destructor TGtk2WidgetSet.Destroy;
begin
  g_object_unref(im_context);
  im_context:=nil;
  im_context_widget:=nil;
  inherited Destroy;
end;

function TGtk2WidgetSet.LCLPlatform: TLCLPlatform;
begin
  Result:= lpGtk2;
end;

procedure TGtk2WidgetSet.AppInit(var ScreenInfo: TScreenInfo);
begin
  inherited AppInit(ScreenInfo);
  {$if defined(cpui386) or defined(cpux86_64)}
  // needed otherwise some gtk theme engines crash with division by zero
  {$IFNDEF DisableGtkDivZeroFix}
    {$IFDEF windows}
      Set8087CW($133F);
    {$ELSE}
      SetExceptionMask(GetExceptionMask + [exZeroDivide]);
    {$ENDIF}
  {$ENDIF}
  {$ifend}
end;

function TGtk2WidgetSet.AppHandle: Thandle;
begin
  {$ifdef windows}
  Result := GetAppHandle;
  {$else}
  Result := inherited AppHandle;
  {$endif}
end;

{$IFDEF ASSERT_IS_ON}
  {$UNDEF ASSERT_IS_ON}
  {$C-}
{$ENDIF}
