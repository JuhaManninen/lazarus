{%MainUnit ../forms.pp}

{******************************************************************************
                                  TScreen
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

const
  MonitorSearchFlags: array[TMonitorDefaultTo] of DWord =
  (
 { mdNearest } MONITOR_DEFAULTTONEAREST,
 { mdNull    } MONITOR_DEFAULTTONULL,
 { mdPrimary } MONITOR_DEFAULTTOPRIMARY
  );

function EnumMonitors(hMonitor: HMONITOR; hdcMonitor: HDC; lprcMonitor: PRect;
    dwData: LPARAM): LongBool; extdecl;
var
  Screen: TScreen absolute dwData;
  Monitor: TMonitor;
begin
  Monitor := TMonitor.Create;
  Monitor.FHandle := hMonitor;
  Monitor.FMonitorNum := Screen.FMonitors.Add(Monitor);
  Result := True;
end;

function EnumFontsNoDups(var LogFont: TEnumLogFontEx; var Metric: TNewTextMetricEx;
  FontType: Longint; Data: LParam): LongInt; extdecl;
var
  L: TStrings;
  S: String;
begin
  L := TStrings(PtrInt(Data));
  S := LogFont.elfLogFont.lfFaceName;
  if L.IndexOf(S) < 0 then
    L.Add(S);
  Result := 1;
end;

function ScreenGetSystemFont: HFont;
begin
  Result := Screen.SystemFont.Reference.Handle;
end;

{------------------------------------------------------------------------------
  Method: TScreen.Create
  Params:  AOwner: the owner of the class
  Returns: Nothing

  Constructor for the class.
 ------------------------------------------------------------------------------}
constructor TScreen.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFonts := TStringlist.Create;
  FCursorMap := TMap.Create(its4, SizeOf(HCursor));
  FMonitors := TMonitorList.Create;
  TStringlist(FFonts).Sorted := True;
  FCustomForms := TList.Create;
  FCustomFormsZOrdered := TList.Create;
  FFormList := TList.Create;
  FDataModuleList := TList.Create;
  FPixelsPerInch := ScreenInfo.PixelsPerInchX;
  FSaveFocusedList := TList.Create;

  AddDataModule := @DoAddDataModule;
  RemoveDataModule := @DoRemoveDataModule;
  OnGetSystemFont := @ScreenGetSystemFont;
end;

{------------------------------------------------------------------------------
  Method: TScreen.Destroy
  Params:  None
  Returns: Nothing

  Destructor for the class.
 ------------------------------------------------------------------------------}
destructor TScreen.Destroy;
var
  HandlerType: TScreenNotification;
begin
  for HandlerType := Low(FScreenHandlers) to High(FScreenHandlers) do
    FreeThenNil(FScreenHandlers[HandlerType]);
  AddDataModule := Nil;
  RemoveDataModule := Nil;
  FreeThenNil(FHintFont);
  FreeThenNil(FIconFont);
  FreeThenNil(FMenuFont);
  FreeThenNil(FSystemFont);
  FreeThenNil(FDataModuleList);
  FreeThenNil(FFormList);
  FreeThenNil(FCustomForms);
  FreeThenNil(FCustomFormsZOrdered);
  FreeThenNil(FSaveFocusedList);
  FreeThenNil(FFonts);
  // DestroyCursors; - free on widgetset free
  FCursorMap.Free;
  FMonitors.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------
  function TScreen.CustomFormIndex(AForm: TCustomForm): integer;
 ------------------------------------------------------------------------------}
function TScreen.CustomFormIndex(AForm: TCustomForm): integer;
begin
  Result := FCustomForms.Count - 1;
  while (Result >= 0) and (CustomForms[Result] <> AForm) do
    Dec(Result);
end;

{------------------------------------------------------------------------------
  function TScreen.FormIndex(AForm: TForm): integer;
 ------------------------------------------------------------------------------}
function TScreen.FormIndex(AForm: TForm): integer;
begin
  Result := FFormList.Count - 1;
  while (Result >= 0) and (Forms[Result] <> AForm) do
    Dec(Result);
end;

{------------------------------------------------------------------------------
  function TScreen.CustomFormZIndex(AForm: TCustomForm): integer;
 ------------------------------------------------------------------------------}
function TScreen.CustomFormZIndex(AForm: TCustomForm): integer;
begin
  Result:=FCustomFormsZOrdered.Count-1;
  while (Result>=0) and (CustomFormsZOrdered[Result]<>AForm) do dec(Result);
end;

procedure TScreen.MoveFormToFocusFront(ACustomForm: TCustomForm);
begin
  if (Self=nil) or (ACustomForm=nil)
  or (csDestroying in ACustomForm.ComponentState) then
    RaiseGDBException('TScreen.MoveFormToFocusFront');
  if (FCustomForms.Count=0) or (TObject(FCustomForms[0])<>ACustomForm) then
  begin
    FCustomForms.Remove(ACustomForm);
    FCustomForms.Insert(0, ACustomForm);
  end;
  if ACustomForm is TForm then begin
    if (FFormList.Count=0) or (TObject(FFormList[0])<>ACustomForm) then begin
      FFormList.Remove(ACustomForm);
      FFormList.Insert(0, ACustomForm);
    end;
  end;
  MoveFormToZFront(ACustomForm);
end;

procedure TScreen.MoveFormToZFront(ACustomForm: TCustomForm);
//var i: Integer;
begin
  if (FCustomFormsZOrdered.Count=0)
  or (TObject(FCustomFormsZOrdered[0])<>ACustomForm) then begin
    FCustomFormsZOrdered.Remove(ACustomForm);
    FCustomFormsZOrdered.Insert(0, ACustomForm);
    //for i:=0 to FCustomFormsZOrdered.Count-1 do
    //  DebugLn(['TScreen.MoveFormToZFront ',i,'/',FCustomFormsZOrdered.Count,' ',dbgsName(CustomFormsZOrdered[i])]);
  end;
end;

function TScreen.GetCurrentModalForm: TCustomForm;
var
  i: Integer;
begin
  i:=GetCurrentModalFormZIndex;
  if (i>=0) then
    Result:=CustomFormsZOrdered[i]
  else
    Result:=nil;
end;

function TScreen.GetCurrentModalFormZIndex: Integer;
begin
  Result:=0;
  while (Result<CustomFormCount)
  and (not (fsModal in CustomFormsZOrdered[Result].FormState)) do
    inc(Result);
  if Result=CustomFormCount then Result:=-1;
end;

function TScreen.CustomFormBelongsToActiveGroup(AForm: TCustomForm): Boolean;
var
  CurForm: TCustomForm;
  i: Integer;
begin
  i:=0;
  Result:=false;
  while (i<CustomFormCount) do begin
    CurForm:=CustomFormsZOrdered[i];
    if CurForm=AForm then
      Result:=true;
    if fsModal in CurForm.FormState then exit;
    inc(i);
  end;
end;

function TScreen.FindForm(const FormName: string): TCustomForm;
var
  i: Integer;
begin
  for i:=0 to FCustomForms.Count-1 do
    if CompareText(TCustomForm(FCustomForms[i]).Name,FormName)=0 then
      exit(TCustomForm(FCustomForms[i]));
  Result:=nil;
end;

function TScreen.FindDataModule(const DataModuleName: string): TDataModule;
var
  i: Integer;
begin
  for i:=0 to FDataModuleList.Count-1 do
    if CompareText(TDataModule(FDataModuleList[i]).Name, DataModuleName)=0 then
    begin
      Result:=TDataModule(FDataModuleList[i]);
      Exit;
    end;
  Result:=nil;
end;

procedure TScreen.UpdateScreen;
var
  DC: HDC;
begin
  DC:=GetDC(0);
  FPixelsPerInch:=GetDeviceCaps(DC,LOGPIXELSX);
  ReleaseDC(0,DC);
end;

procedure TScreen.AddHandlerFormAdded(OnFormAdded: TScreenFormEvent;
  AsLast: Boolean);
begin
  AddHandler(snFormAdded,TMethod(OnFormAdded),AsLast);
end;

procedure TScreen.RemoveHandlerFormAdded(OnFormAdded: TScreenFormEvent);
begin
  RemoveHandler(snFormAdded,TMethod(OnFormAdded));
end;

procedure TScreen.AddHandlerRemoveForm(OnRemoveForm: TScreenFormEvent;
  AsLast: Boolean);
begin
  AddHandler(snRemoveForm,TMethod(OnRemoveForm),AsLast);
end;

procedure TScreen.RemoveHandlerRemoveForm(OnRemoveForm: TScreenFormEvent);
begin
  RemoveHandler(snRemoveForm,TMethod(OnRemoveForm));
end;

procedure TScreen.AddHandlerActiveControlChanged(
  OnActiveControlChanged: TScreenControlEvent; AsLast: Boolean);
begin
  AddHandler(snActiveControlChanged,TMethod(OnActiveControlChanged),AsLast);
end;

procedure TScreen.RemoveHandlerActiveControlChanged(
  OnActiveControlChanged: TScreenControlEvent);
begin
  RemoveHandler(snActiveControlChanged,TMethod(OnActiveControlChanged));
end;

procedure TScreen.AddHandlerActiveFormChanged(
  OnActiveFormChanged: TScreenActiveFormChangedEvent; AsLast: Boolean);
begin
  AddHandler(snActiveFormChanged,TMethod(OnActiveFormChanged),AsLast);
end;

procedure TScreen.RemoveHandlerActiveFormChanged(
  OnActiveFormChanged: TScreenActiveFormChangedEvent);
begin
  RemoveHandler(snActiveFormChanged,TMethod(OnActiveFormChanged));
end;

procedure TScreen.RemoveAllHandlersOfObject(AnObject: TObject);
var
  HandlerType: TScreenNotification;
begin
  for HandlerType:=Low(TScreenNotification) to High(TScreenNotification) do
    FScreenHandlers[HandlerType].RemoveAllMethodsOfObject(AnObject);
  inherited RemoveAllHandlersOfObject(AnObject);
end;

{
  Disable all forms except SkipForm. If DisabledList is available then add forms
  to that list and return it, otherwise return new list. Used to show forms and
  other dialogs modal
}
function TScreen.DisableForms(SkipForm: TCustomForm; DisabledList: TList = nil): TList;
var
  i: integer;
  AForm: TCustomForm;
begin
  Result := DisabledList;
  if Result = nil then
    Result := TList.Create;
  for i := 0 to CustomFormCount - 1 do
  begin
    AForm := CustomForms[i];
    if (AForm <> SkipForm) and AForm.HandleAllocated then
    begin
      // we cannot use AForm.Enabled := False; since it checks csDesigning
      // but we need this for IDE too. We also cannot check AForm.Visible -
      // it returns wrong info for the forms opened in the designer
      if IsWindowEnabled(AForm.Handle) and IsWindowVisible(AForm.Handle) then
      begin
        EnableWindow(AForm.Handle, False);
        Result.Add(AForm);
      end;
    end;
  end;
end;

{
  Enable all forms from AFormList and destroy list. Used to restore state after
  DisableForms
}
procedure TScreen.EnableForms(var AFormList: TList);
var
  i: integer;
  AForm: TCustomForm;
begin
  if AFormList = nil then
    Exit;
  for i := AFormList.Count - 1 downto 0 do
  begin
    AForm := TCustomForm(AFormList[i]);
    if (CustomFormIndex(AForm) <> -1) and AForm.HandleAllocated then
      EnableWindow(AForm.Handle, True);
  end;
  FreeAndNil(AFormList);
end;

function TScreen.MonitorFromPoint(const Point: TPoint;
  MonitorDefault: TMonitorDefaultTo): TMonitor;
var
  MonitorHandle: HMONITOR;
  i: integer;
  R: TRect;
begin
  MonitorHandle := WidgetSet.MonitorFromPoint(Point, MonitorSearchFlags[MonitorDefault]);
  for i := 0 to MonitorCount - 1 do
    if Monitors[i].Handle = MonitorHandle then
      Exit(Monitors[i]);
  if MonitorHandle = MONITOR_UNIMPL then
  begin
    R.TopLeft := Point;
    R.BottomRight := Point;
    Result := MonitorFromRect(R, MonitorDefault);
  end
  else
    Result := nil;
end;

function TScreen.MonitorFromRect(const Rect: TRect;
  MonitorDefault: TMonitorDefaultTo): TMonitor;
var
  MonitorHandle: HMONITOR;
  i, Square, Distance, BestSquare, BestDistance: integer;
  MonitorRect, Intersection: TRect;
  Nearest: TMonitor;
begin
  MonitorHandle := WidgetSet.MonitorFromRect(@Rect, MonitorSearchFlags[MonitorDefault]);
  for i := 0 to MonitorCount - 1 do
    if Monitors[i].Handle = MonitorHandle then
      Exit(Monitors[i]);
  // we are here => interface does not support our search functions
  if MonitorHandle = MONITOR_UNIMPL then
  begin
    Result := nil;
    BestSquare := -1;
    BestDistance := MaxInt;
    Nearest := nil;
    for i := 0 to MonitorCount - 1 do
    begin
      MonitorRect := Monitors[i].BoundsRect;
      if IntersectRect(Intersection, Rect, MonitorRect) then
      begin
        with Intersection do
          Square := Abs(Right - Left) * Abs(Bottom - Top);
        if Square > BestSquare then
        begin
          BestSquare := Square;
          Result := Monitors[i];
        end
      end;
      with MonitorRect do
        Distance := Min(Min(Abs(Rect.Left - Right), Abs(Rect.Right - Left)),
                        Min(Abs(Rect.Top - Bottom), Abs(Rect.Bottom - Top)));
      if Distance < BestDistance then
      begin
        BestDistance := Distance;
        Nearest := Monitors[i];
      end;
    end;
    if Result = nil then
    begin
      if MonitorDefault = mdPrimary then
        Result := PrimaryMonitor
      else
      if MonitorDefault = mdNull then
        Result := nil
      else
        Result := Nearest;
    end;
  end
  else
    Result := nil;
end;

function TScreen.MonitorFromWindow(const Handle: THandle;
  MonitorDefault: TMonitorDefaultTo): TMonitor;
var
  MonitorHandle: HMONITOR;
  i: integer;
  R: TRect;
begin
  MonitorHandle := WidgetSet.MonitorFromWindow(Handle, MonitorSearchFlags[MonitorDefault]);
  for i := 0 to MonitorCount - 1 do
    if Monitors[i].Handle = MonitorHandle then
      Exit(Monitors[i]);
  if MonitorHandle = MONITOR_UNIMPL then
  begin
    GetWindowRect(Handle, R);
    Result := MonitorFromRect(R, MonitorDefault);
  end
  else
    Result := nil;
end;

procedure GetScreenFontsList(FontList: TStrings);
var
  lf: TLogFont;
  DC: HDC;
begin
  lf.lfCharSet := DEFAULT_CHARSET;
  lf.lfFaceName := '';
  lf.lfPitchAndFamily := 0;
  DC := GetDC(0);
  try
    EnumFontFamiliesEx(DC, @lf, @EnumFontsNoDups, PtrInt(FontList), 0);
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------
  function TScreen.GetFonts : TStrings;
 ------------------------------------------------------------------------------}
function TScreen.GetFonts : TStrings;
begin
  if FFonts.Count=0 then begin
    GetScreenFontsList(FFonts);
    TStringList(FFonts).Sort;
  end;
  Result := FFonts;
end;

{------------------------------------------------------------------------------
  procedure TScreen.DeleteCursor(Index: Integer);
 ------------------------------------------------------------------------------}
procedure TScreen.DeleteCursor(AIndex: Integer);
var
  ACursor: HCursor;
begin
  if not FCursorMap.GetData(AIndex, ACursor) then Exit;
  WidgetSet.DestroyCursor(ACursor);
  FCursorMap.Delete(AIndex);
end;

{------------------------------------------------------------------------------
  procedure TScreen.DestroyCursors;
 ------------------------------------------------------------------------------}
procedure TScreen.DestroyCursors;
var
  Iterator: TMapIterator;
  ACursor: HCURSOR;
begin
  Iterator := TMapIterator.Create(FCursorMap);
  Iterator.First;
  while not Iterator.EOM do
  begin
    Iterator.GetData(ACursor);
    WidgetSet.DestroyCursor(ACursor);
    Iterator.Next;
  end;
  Iterator.Free;
  FCursorMap.Clear;
end;

procedure TScreen.DestroyMonitors;
begin
  FMonitors.Clear;
end;

{------------------------------------------------------------------------------
  function TScreen.GetCursors(Index: Integer): HCURSOR;
 ------------------------------------------------------------------------------}
function TScreen.GetCursors(AIndex: Integer): HCURSOR;
begin
  Result := 0;
  //if AIndex = crNone then Exit;
  if FCursorMap.GetData(AIndex, Result) then Exit;
  
  Result := FDefaultCursor;
  if AIndex > crHigh then Exit;
  if AIndex < crLow then Exit;
  
  // not yet loaded
  Result := WidgetSet.CreateStandardCursor(AIndex);
  if (Result = 0) and (AIndex <> crDefault) then
    Result := LoadCursorFromLazarusResource('cur_' + IntToStr(-AIndex));
  if Result = 0 then
    Exit;
  
  FCursorMap.Add(AIndex, Result);
end;

{------------------------------------------------------------------------------
  function TScreen.GetCustomFormCount: Integer;
 ------------------------------------------------------------------------------}
function TScreen.GetCustomFormCount: Integer;
begin
  Result:=FCustomForms.Count;
end;

function TScreen.GetCustomFormZOrderCount: Integer;
begin
  Result:=FCustomFormsZOrdered.Count;
end;

{------------------------------------------------------------------------------
  function TScreen.GetCustomForms(Index: Integer): TCustomForm;
 ------------------------------------------------------------------------------}
function TScreen.GetCustomForms(Index: Integer): TCustomForm;
begin
  Result := TCustomForm(FCustomForms[Index]);
end;

{------------------------------------------------------------------------------
  function TScreen.GetCustomFormsZOrdered(Index: Integer): TCustomForm;
 ------------------------------------------------------------------------------}
function TScreen.GetCustomFormsZOrdered(Index: Integer): TCustomForm;
begin
  Result := TCustomForm(FCustomFormsZOrdered[Index]);
end;

function TScreen.GetDataModuleCount: Integer;
begin
  Result:=FDataModuleList.Count;
end;

function TScreen.GetDataModules(AIndex: Integer): TDataModule;
begin
  Result := TDataModule(FDataModuleList.Items[AIndex]);
end;

function TScreen.GetDesktopHeight: Integer;
begin
  Result := GetSystemMetrics(SM_CYVIRTUALSCREEN);
end;

function TScreen.GetDesktopWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXVIRTUALSCREEN);
end;

{------------------------------------------------------------------------------
  Function: TScreen.AddForm
  Params:   FForm: The form to be added
  Returns:  Nothing

  Do not use this procedure. This procedure is used by TScreen internally.
 ------------------------------------------------------------------------------}
procedure TScreen.AddForm(AForm: TCustomForm);
var
  i: Integer;
begin
  FCustomForms.Add(AForm);
  FCustomFormsZOrdered.Add(AForm);
  if AForm is TForm then
  begin
    FFormList.Add(AForm);
    Application.UpdateVisible;
  end;
  i := FScreenHandlers[snFormAdded].Count;
  while FScreenHandlers[snFormAdded].NextDownIndex(i) do
    TScreenFormEvent(FScreenHandlers[snFormAdded][i])(Self, AForm);
end;

{------------------------------------------------------------------------------
  Function: TScreen.GetFormCount
  Params:   none
  Returns:  The count of forms. (TODO: discribe this better; my English is not perfect)

  Returns the count of forms. (TODO: discribe this better; my English is not perfect)
 ------------------------------------------------------------------------------}
function TScreen.GetFormCount: Integer;
begin
  Result := FFormList.Count;
end;

{------------------------------------------------------------------------------
  Function: TScreen.GetForms
  Params:   IIndex: The index of the form
  Returns:  A form stored in FFormList

  This function is used by the Forms property.
 ------------------------------------------------------------------------------}
function TScreen.GetForms(IIndex: Integer): TForm;
begin
  Result := TForm(FFormList.Items[IIndex]);
end;

{------------------------------------------------------------------------------
  Method:  TScreen.GetWidth
  Params:  none
  Returns: Screen Width

  returns the screen width
 ------------------------------------------------------------------------------}
function TScreen.GetWidth : Integer;
begin
  Result := GetSystemMetrics(SM_CXSCREEN);
end;

{------------------------------------------------------------------------------
  Method:  TScreen.GetHeight
  Params:  none
  Returns: Screen Height

  Returns the Screen Height
 ------------------------------------------------------------------------------}
function TScreen.GetHeight : Integer;
begin
  Result := GetSystemMetrics(SM_CYSCREEN);
end;

function TScreen.GetMonitor(Index: Integer): TMonitor;
begin
  Result := FMonitors[Index];
end;

function TScreen.GetMonitorCount: Integer;
begin
  if FMonitors.Count = 0 then
    UpdateMonitors;
  Result := FMonitors.Count;
end;

function TScreen.GetPrimaryMonitor: TMonitor;
var
  i: integer;
begin
  for i := 0 to MonitorCount - 1 do
    if Monitors[i].Primary then
      Exit(Monitors[i]);
  Result := nil;
end;

function TScreen.GetSystemFont: TFont;
begin
  if (FSystemFont = nil) then
    FSystemFont := TFont.Create;
  if not WidgetSet.InitStockFont(FSystemFont, sfSystem) then
  begin
    FSystemFont.FontData := DefFontData;
    FSystemFont.Color := clWindowText;
  end;
  Result := FSystemFont;
end;

function TScreen.GetHintFont: TFont;
begin
  if (FHintFont = nil) then
    FHintFont := TFont.Create;
  if not WidgetSet.InitStockFont(FHintFont, sfHint) then
  begin
    FHintFont.FontData := DefFontData;
    FHintFont.Color := clInfoText;
  end;
  Result := FHintFont;
end;

function TScreen.GetIconFont: TFont;
begin
  if (FIconFont = nil) then
    FIconFont := TFont.Create;
  if not WidgetSet.InitStockFont(FIconFont, sfIcon) then
  begin
    FIconFont.FontData := DefFontData;
    FIconFont.Color := clWindowText;
  end;
  Result := FIconFont;
end;

function TScreen.GetMenuFont: TFont;
begin
  if (FMenuFont = nil) then
    FMenuFont := TFont.Create;
  if not WidgetSet.InitStockFont(FMenuFont, sfMenu) then
  begin
    FMenuFont.FontData := DefFontData;
    FMenuFont.Color := clMenuText;
  end;
  Result := FMenuFont;
end;

{------------------------------------------------------------------------------

  Function: TScreen.RemoveForm
  Params:   FForm: The form to be removed
  Returns:  Nothing

 ------------------------------------------------------------------------------}
procedure TScreen.RemoveForm(AForm: TCustomForm);
var
  i: Integer;
begin
  i := FScreenHandlers[snRemoveForm].Count;
  while FScreenHandlers[snRemoveForm].NextDownIndex(i) do
    TScreenFormEvent(FScreenHandlers[snRemoveForm][i])(Self, AForm);
  FCustomForms.Remove(AForm);
  FCustomFormsZOrdered.Remove(AForm);
  FFormList.Remove(AForm);
  Application.UpdateVisible;
end;

{------------------------------------------------------------------------------
  procedure TScreen.SetCursor(const AValue: TCursor);
 ------------------------------------------------------------------------------}
procedure TScreen.SetCursor(const AValue: TCursor);
begin
  if AValue <> Cursor then
  begin
    FCursor := AValue;
    WidgetSet.SetCursor(Cursors[FCursor]);
  end;
  Inc(FCursorCount);
end;

{------------------------------------------------------------------------------
  procedure TScreen.SetCursors(Index: Integer; const AValue: HCURSOR);
 ------------------------------------------------------------------------------}
procedure TScreen.SetCursors(AIndex: Integer; const AValue: HCURSOR);
begin
  case AIndex of
    crDefault: begin
      if (AValue = 0) and (WidgetSet <> nil) then
        FDefaultCursor := WidgetSet.CreateStandardCursor(crDefault)
      else
        FDefaultCursor := AValue
    end;
{    crNone: begin
    end;}
  else
    DeleteCursor(AIndex);
    if AValue <> 0 then
      FCursorMap.Add(AIndex, AValue);
  end;
end;

procedure TScreen.SetHintFont(const AValue: TFont);
begin
  if (FHintFont = nil) then
    FHintFont := TFont.Create;
  FHintFont.Assign(AValue);
end;

procedure TScreen.SetIconFont(const AValue: TFont);
begin
  if (FIconFont = nil) then
    FIconFont := TFont.Create;
  FIconFont.Assign(AValue);
end;

procedure TScreen.SetMenuFont(const AValue: TFont);
begin
  if (FMenuFont = nil) then
    FMenuFont := TFont.Create;
  FMenuFont.Assign(AValue);
end;

procedure TScreen.SetSystemFont(const AValue: TFont);
begin
  if (FSystemFont = nil) then
    FSystemFont := TFont.Create;
  FSystemFont.Assign(AValue);
end;

{------------------------------------------------------------------------------
  procedure TScreen.UpdateLastActive;
 ------------------------------------------------------------------------------}
procedure TScreen.UpdateLastActive;

  procedure NotifyOnActiveFormChanged;
  var
    i: Integer;
    Handler: TScreenFormEvent;
  begin
    if Assigned(FOnActiveFormChange) then FOnActiveFormChange(Self);
    i:=FScreenHandlers[snActiveFormChanged].Count;
    while FScreenHandlers[snActiveFormChanged].NextDownIndex(i) do begin
      Handler:=TScreenFormEvent(FScreenHandlers[snActiveFormChanged][i]);
      Handler(Self,FLastActiveCustomForm);
    end;
  end;

  procedure NotifyOnActiveControlChanged;
  var
    i: Integer;
    Handler: TScreenControlEvent;
  begin
    if Assigned(FOnActiveControlChange) then FOnActiveControlChange(Self);
    i:=FScreenHandlers[snActiveControlChanged].Count;
    while FScreenHandlers[snActiveControlChanged].NextDownIndex(i) do begin
      Handler:=TScreenControlEvent(FScreenHandlers[snActiveControlChanged][i]);
      Handler(Self,FLastActiveControl);
    end;
  end;

begin
  if FLastActiveCustomForm <> FActiveCustomForm then
  begin
    FLastActiveCustomForm := FActiveCustomForm;
    NotifyOnActiveFormChanged;
  end;
  if FLastActiveControl <> FActiveControl then
  begin
    FLastActiveControl := FActiveControl;
    NotifyOnActiveControlChanged;
  end;
end;

procedure TScreen.UpdateMonitors;
begin
  DestroyMonitors;
  EnumDisplayMonitors(0, nil, @EnumMonitors, LParam(Self));
end;

procedure TScreen.RestoreLastActive;
begin
  if (FLastActiveControl <> nil) and FLastActiveControl.CanFocus then
    FLastActiveControl.SetFocus
  else
  if (FLastActiveCustomForm <> nil) and FLastActiveCustomForm.CanFocus then
    FLastActiveCustomForm.SetFocus;
end;

{------------------------------------------------------------------------------
  procedure TScreen.AddHandler(HandlerType: TScreenNotification;
    const Handler: TMethod);
 ------------------------------------------------------------------------------}
procedure TScreen.AddHandler(HandlerType: TScreenNotification;
  const Handler: TMethod; AsLast: Boolean);
begin
  if Handler.Code=nil then RaiseGDBException('TScreen.AddHandler');
  if FScreenHandlers[HandlerType]=nil then
    FScreenHandlers[HandlerType]:=TMethodList.Create;
  FScreenHandlers[HandlerType].Add(Handler,AsLast);
end;

procedure TScreen.RemoveHandler(HandlerType: TScreenNotification;
  const Handler: TMethod);
begin
  FScreenHandlers[HandlerType].Remove(Handler);
end;

procedure TScreen.DoAddDataModule(DataModule: TDataModule);
begin
  FDataModuleList.Add(DataModule);
end;

procedure TScreen.DoRemoveDataModule(DataModule: TDataModule);
begin
  FDataModuleList.Remove(DataModule);
end;

// included by forms.pp
