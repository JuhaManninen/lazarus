{%MainUnit win32int.pp}
{ $Id$ }
{******************************************************************************
                 All GTK interface communication implementations.
                   Initial Revision  : Sun Nov 23 23:53:53 2003


  !! Keep alphabetical !!

  Support routines go to gtkproc.pp

 ******************************************************************************
 Implementation
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

//##apiwiz##sps##   // Do not remove

function TWin32WidgetSet.AddEventHandler(AHandle: THandle; AFlags: dword; 
  AEventHandler: TWaitHandleEvent; AData: PtrInt): PEventHandler;
var
  listlen: dword;
  lListIndex: pdword;
begin
  listlen := Length(FWaitHandles);
  if FWaitHandleCount = listlen then
  begin
    inc(listlen, 16);
    SetLength(FWaitHandles, listlen);
    SetLength(FWaitHandlers, listlen);
  end;
  New(lListIndex);
  FWaitHandles[FWaitHandleCount] := AHandle;
  FWaitHandlers[FWaitHandleCount].ListIndex := lListIndex;
  FWaitHandlers[FWaitHandleCount].UserData := AData;
  FWaitHandlers[FWaitHandleCount].OnEvent := AEventHandler;
  lListIndex^ := FWaitHandleCount;
  Inc(FWaitHandleCount);
{$ifdef DEBUG_ASYNCEVENTS}  
  DebugLn('Waiting for handle: ', IntToHex(AHandle, 8));
{$endif}
  Result := lListIndex;
end;

function TWin32WidgetSet.AddPipeEventHandler(AHandle: THandle;
  AEventHandler: TPipeEvent; AData: PtrInt): PPipeEventHandler;
var
  lHandler: PPipeEventInfo;
begin
  if AEventHandler = nil then exit;
  New(lHandler);
  lHandler^.Handle := AHandle;
  lHandler^.UserData := AData;
  lHandler^.OnEvent := AEventHandler;
  lHandler^.Prev := nil;
  lHandler^.Next := FWaitPipeHandlers;
  if FWaitPipeHandlers <> nil then
    FWaitPipeHandlers^.Prev := lHandler;
  FWaitPipeHandlers := lHandler;
  Result := lHandler;
end;

function TWin32WidgetSet.AddProcessEventHandler(AHandle: THandle;
  AEventHandler: TChildExitEvent; AData: PtrInt): PProcessEventHandler;
var
  lProcessEvent: PProcessEvent;
begin
  if AEventHandler = nil then exit;
  New(lProcessEvent);
  lProcessEvent^.Handle := AHandle;
  lProcessEvent^.UserData := AData;
  lProcessEvent^.OnEvent := AEventHandler;
  lProcessEvent^.Handler := AddEventHandler(AHandle, 0, 
    @HandleProcessEvent, PtrInt(lProcessEvent));
  Result := lProcessEvent;
end;

{------------------------------------------------------------------------------
  Method:  ExtUTF8Out

  As ExtTextOut except that Str is treated as UTF8
 ------------------------------------------------------------------------------}
function TWin32WidgetSet.ExtUTF8Out(DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect;
  Str: PChar; Count: Longint; Dx: PInteger): Boolean;
begin
  Result := ExtTextOut(DC, X, Y, Options, Rect, Str, Count, Dx);
end;

{------------------------------------------------------------------------------
  function FontCanUTF8(Font: HFont): boolean;

  True if font recognizes Unicode UTF8 encoding.
 ------------------------------------------------------------------------------}
function TWin32WidgetSet.FontCanUTF8(Font: HFont): boolean;
begin
  {$ifdef WindowsUnicodeSupport}
    Result := True;
  {$else}
    Result := False;
  {$endif}
end;

procedure TWin32WidgetSet.HandleProcessEvent(AData: PtrInt; AFlags: dword);
var
  lProcessEvent: PProcessEvent absolute AData;
  exitcode: dword;
begin
  if not Windows.GetExitCodeProcess(lProcessEvent^.Handle, exitcode) then
    exitcode := 0;
  lProcessEvent^.OnEvent(lProcessEvent^.UserData, cerExit, exitcode);
end;

{------------------------------------------------------------------------------
  Function: RawImage_QueryDescription
  Params: AFlags:
          ADesc:
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.RawImage_QueryDescription(AFlags: TRawImageQueryFlags; var ADesc: TRawImageDescription): Boolean;
begin
  if riqfAlpha in AFlags
  then begin
    //always return rgba description
    if not (riqfUpdate in AFlags)
    then ADesc.Init;

    ADesc.Format := ricfRGBA;
    ADesc.Depth := 32;
    ADesc.BitOrder := riboReversedBits;
    ADesc.ByteOrder := riboLSBFirst;
    ADesc.LineOrder := riloTopToBottom;
    ADesc.LineEnd := rileDWordBoundary;
    ADesc.BitsPerPixel := 32;

    ADesc.AlphaPrec := 8;
    ADesc.AlphaShift := 24;

    if riqfRGB in AFlags
    then begin
      ADesc.RedPrec := 8;
      ADesc.GreenPrec := 8;
      ADesc.BluePrec := 8;
      ADesc.RedShift := 16;
      ADesc.GreenShift := 8;
      ADesc.BlueShift := 0;
    end;
    
    AFlags := AFlags - [riqfRGB, riqfAlpha, riqfUpdate];
    if AFlags = [] then Exit(True);
    
    // continue with default
    Include(AFlags, riqfUpdate);
  end;

  Result := inherited RawImage_QueryDescription(AFlags, ADesc);
  // reduce mem
  if Result and (ADesc.Depth = 24) 
  then ADesc.BitsPerPixel := 24;
end;

procedure TWin32WidgetSet.RemoveProcessEventHandler(var AHandler: PProcessEventHandler);
var
  lProcessEvent: PProcessEvent absolute AHandler;
begin
  if AHandler = nil then exit;
  RemoveEventHandler(lProcessEvent^.Handler);
  Dispose(lProcessEvent);
  AHandler := nil;
end;

function TWin32WidgetSet.AppHandle: THandle;
begin
  Result:= FAppHandle;
end;

{------------------------------------------------------------------------------
  Function:
  Params:

  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.CreateStandardCursor(ACursor: SmallInt): hCursor;
begin
  Result := 0;
  if ACursor < crLow then Exit;
  if ACursor > crHigh then Exit;

  case ACursor of
    crSqlWait..crDrag,
    crHandPoint, crNone: begin
      // TODO: load custom cursors here not in the LCL
    end;
  else
    Result := Windows.LoadCursor(0, LclCursorToWin32CursorMap[ACursor]);
  end;
end;

{------------------------------------------------------------------------------
  Method: CallbackAllocateHWnd
  Params:   None
  Returns:  Nothing

  Callback for the AllocateHWnd function
 ------------------------------------------------------------------------------}
procedure CallbackAllocateHWnd(Ahwnd: HWND; uMsg: UINT; wParam: WParam; lParam: LParam); stdcall;
var
  Msg: TLMessage;
  PMethod: ^TLCLWndMethod;
begin
  FillChar(Msg, SizeOf(Msg), #0);
  
  Msg.msg := uMsg;
  Msg.wParam := wParam;
  Msg.lParam := lParam;

  {------------------------------------------------------------------------------
    Here we get the callback WndMethod associated with this window
   ------------------------------------------------------------------------------}
  PMethod := Pointer(Widgetset.GetWindowLong(ahwnd, GWL_USERDATA));

  if Assigned(PMethod) then PMethod^(Msg);
   
  Windows.DefWindowProc(ahwnd, uMsg, wParam, lParam);
end;

{------------------------------------------------------------------------------
  Method: TWin32WidgetSet.AllocateHWnd
  Params:   Method  - The callback method for the window. Can be nil
  Returns:  A window handle

  Allocates a non-visible window that can be utilized to receive and send message
  
  On Windows, you must call Windows.DefWindowProc(MyHandle, Msg.msg, Msg.wParam, msg.lParam);
  in your callback function, if you provide one at all, of course.
 ------------------------------------------------------------------------------}
function TWin32WidgetSet.AllocateHWnd(Method: TLCLWndMethod): HWND;
var
  PMethod: ^TLCLWndMethod;
begin
  Result := Windows.CreateWindow(@ClsName[0],
   '', WS_OVERLAPPED, 0, 0, 0, 0, 0, 0, MainInstance, nil);

  {------------------------------------------------------------------------------
    SetWindowLong has only space for 1 pointer on each slot, but a method is
   referenced as a structure with 2 pointers, so here we allocate memory for
   the structure before it can be used to transport data between the callback
   and this function
   ------------------------------------------------------------------------------}
  if Assigned(Method) then
  begin
    Getmem(PMethod, SizeOf(TMethod));
    PMethod^ := Method;

    Self.SetWindowLong(Result, GWL_USERDATA, PtrInt(PMethod));
  end;
  
  Self.SetWindowLong(Result, GWL_WNDPROC, PtrInt(@CallbackAllocateHWnd))
end;

{------------------------------------------------------------------------------
  Method: TWin32WidgetSet.DeallocateHWnd
  Params:   Wnd   - A Window handle, that was created with AllocateHWnd
  Returns:  Nothing
 ------------------------------------------------------------------------------}
procedure TWin32WidgetSet.DeallocateHWnd(Wnd: HWND);
var
  PMethod: ^TLCLWndMethod;
begin
  PMethod := Pointer(Self.GetWindowLong(Wnd, GWL_USERDATA));

  if Wnd <> 0 then Windows.DestroyWindow(Wnd);

  {------------------------------------------------------------------------------
    This must be done after DestroyWindow, otherwise a Access Violation will
   happen when WM_CLOSE message is sent to the callback

    This memory is for the TMethod structure allocated on AllocateHWnd
   ------------------------------------------------------------------------------}
  if Assigned(PMethod) then Freemem(PMethod);
end;

{------------------------------------------------------------------------------
  Procedure:
  Params:

  Returns:

 ------------------------------------------------------------------------------}
procedure TWin32WidgetSet.DrawArrow(Arrow: TComponent; Canvas: TPersistent);
const
    { up, down, left, right }
  ArrowTypeToState: array[TArrowType] of dword = (DFCS_SCROLLUP, DFCS_SCROLLDOWN,
    DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT);
var
  drawRect: Windows.RECT;
  canvasHandle: HDC;
begin
  drawRect := TControl(Arrow).ClientRect;
  canvasHandle := TCanvas(Canvas).Handle;
  Windows.FillRect(canvasHandle, drawRect, GetSysColorBrush(COLOR_BTNFACE));
  dec(drawRect.Left, 2);
  dec(drawRect.Top, 2);
  inc(drawRect.Right, 2);
  inc(drawRect.Bottom, 2);
  Windows.DrawFrameControl(TCanvas(Canvas).Handle, drawRect,
	DFC_SCROLL, ArrowTypeToState[TArrow(Arrow).ArrowType]);
end;

procedure TWin32WidgetSet.DrawDefaultDockImage(AOldRect, ANewRect: TRect; AOperation: TDockImageOperation);
const
  LineSize = 4;

  procedure DrawHorzLine(DC: HDC; x1, x2, y: integer); inline;
  begin
    PatBlt(DC, x1, y, x2 - x1, LineSize, PATINVERT);
  end;

  procedure DrawVertLine(DC: HDC; y1, y2, x: integer); inline;
  begin
    PatBlt(DC, x, y1, LineSize, y2 - y1, PATINVERT);
  end;

  procedure DefaultDockImage(ARect: TRect);
  var
    DC: HDC;
    NewBrush, OldBrush: HBrush;
  begin
    DC := GetDCEx(0, 0, DCX_LOCKWINDOWUPDATE); // drawing during tracking
    try
      NewBrush := CreatePatternBrush(Win32WidgetSet.DotsPatternBitmap);
      OldBrush := SelectObject(DC, NewBrush);
      with ARect do
      begin
        DrawHorzLine(DC, Left, Right, Top);
        DrawVertLine(DC, Top + LineSize, Bottom - LineSize, Left);
        DrawHorzLine(DC, Left, Right, Bottom - LineSize);
        DrawVertLine(DC, Top + LineSize, Bottom - LineSize, Right - LineSize);
      end;
      DeleteObject(SelectObject(DC, OldBrush));
    finally
      ReleaseDC(0, DC);
    end;
  end;

begin
  if AOperation in [disMove, disHide] then
    DefaultDockImage(AOldRect);
  if AOperation in [disMove, disShow] then
    DefaultDockImage(ANewRect);
end;

procedure TWin32WidgetSet.DrawGrid(DC: HDC; const R: TRect; DX, DY: Integer);
var
  x, y: integer;
  ALogPen: TLogPen;
begin
  GetObject(GetCurrentObject(DC, OBJ_PEN), SizeOf(ALogPen), @ALogPen);
  x := R.Left;
  while x <= R.Right do
  begin
    y := R.Top;
    while y <= R.Bottom do
    begin
      SetPixel(DC, X, Y, ALogPen.lopnColor);
      Inc(y, DY);
    end;
    Inc(x, DX);
  end;
end;

{------------------------------------------------------------------------------
  Function: GetAcceleratorString
  Params: AVKey:
          AShiftState:
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.GetAcceleratorString(const AVKey: Byte; const AShiftState: TShiftState): String;
begin
  //TODO: Implement
  Result := '';
end;

{------------------------------------------------------------------------------
  Function: GetControlConstraints
  Params: Constraints: TObject
  Returns: true on success

  Updates the constraints object (e.g. TSizeConstraints) with interface specific
  bounds.
 ------------------------------------------------------------------------------}
function TWin32WidgetSet.GetControlConstraints(Constraints: TObject): boolean;
var
  SizeConstraints: TSizeConstraints absolute Constraints;
  SizeRect: TRect;
  Height, Width: Integer;
  FixedHeight, FixedWidth: boolean;
  MinWidth, MinHeight, MaxWidth, MaxHeight: Integer;
begin
  Result := True;

  if Constraints is TSizeConstraints then
  begin
    if (SizeConstraints.Control=nil) then exit;

    FixedHeight := false;
    FixedWidth := false;

    MinWidth := 0;
    MinHeight := 0;
    MaxWidth := 0;
    MaxHeight := 0;

    if SizeConstraints.Control is TCustomCalendar then
    begin
      FixedHeight := true;
      FixedWidth := true;
    end
    else if SizeConstraints.Control is TCustomComboBox then
    begin
      // win32 combo (but not csSimple) has fixed height
      FixedHeight := TCustomComboBox(SizeConstraints.Control).Style <> csSimple;
    end
    // The ProgressBar needs a minimum Height of 10 when themed,
    // as required by Windows, otherwise it's image is corrupted
    else if ThemeServices.ThemesEnabled and (SizeConstraints.Control is TCustomProgressBar) then
    begin
      MinHeight := 10;

      SizeConstraints.SetInterfaceConstraints(
        MinWidth, MinHeight, MaxWidth, MaxHeight);
    end;
    
    if (FixedHeight or FixedWidth)
      and TWinControl(SizeConstraints.Control).HandleAllocated then 
    begin
      Windows.GetWindowRect(TWinControl(SizeConstraints.Control).Handle, @SizeRect);

      if FixedHeight then
        Height := SizeRect.Bottom - SizeRect.Top
      else
        Height := 0;
      if FixedWidth then
        Width := SizeRect.Right - SizeRect.Left
      else
        Width := 0;
        
      SizeConstraints.SetInterfaceConstraints(Width, Height, Width, Height);
    end;
  end;
end;

{------------------------------------------------------------------------------
  function TWin32WidgetSet.IntfSendsUTF8KeyPress: boolean;

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.IntfSendsUTF8KeyPress: boolean;
begin
  {$ifdef WindowsUnicodeSupport}
  Result := true;
  {$else}
  Result := false;
  {$endif}
end;

{------------------------------------------------------------------------------
  Function: RawImage_CreateBitmaps
  Params: ARawImage:
          ABitmap:
          AMask:
          ASkipMask: When set there is no mask created
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.RawImage_CreateBitmaps(const ARawImage: TRawImage; out ABitmap, AMask: HBitmap; ASkipMask: Boolean): Boolean;
var
  ADesc: TRawImageDescription absolute ARawImage.Description;
  DC: HDC;
  Info: record
    Header: Windows.TBitmapInfoHeader;
    Colors: array[0..1] of Cardinal; // reserve extra color for mono bitmaps
  end;
  BitsPtr: Pointer;
  DataSize: PtrUInt;
  Align: Byte;
begin
  Result := False;
  AMask := 0;

  if not ((ADesc.BitsPerPixel = 1) and (ADesc.LineEnd = rileWordBoundary)) then
  begin
    FillChar(Info, SizeOf(Info), 0);
    Info.Header.biSize := SizeOf(Info.Header);
    Info.Header.biWidth := ADesc.Width;
    Info.Header.biHeight := -ADesc.Height; // create top to bottom
    Info.Header.biPlanes := 1;
    Info.Header.biBitCount := ADesc.BitsPerPixel;
    Info.Header.biCompression := BI_RGB;
    {BitmapInfo.bmiHeader.biSizeImage := 0;}
    { first color is black, second color is white, for monochrome bitmap }
    Info.Colors[1] := $FFFFFFFF;

    DC := Windows.GetDC(0);
    // Use createDIBSection, since only devicedepth bitmaps can be selected into a DC
    // when they are created with createDIBitmap
    //  ABitmap := Windows.CreateDIBitmap(DC, Info.Header, CBM_INIT, ARawImage.Data, Windows.PBitmapInfo(@Info)^, DIB_RGB_COLORS);
    ABitmap := Windows.CreateDIBSection(DC, Windows.PBitmapInfo(@Info)^, DIB_RGB_COLORS, BitsPtr, 0, 0);
    Windows.ReleaseDC(0, DC);

    if ABitmap = 0 then
    begin
      DebugLn('Windows.CreateDIBSection returns 0. Reason = ' + GetLastErrorText(Windows.GetLastError));
      Exit;
    end;
    if BitsPtr = nil then Exit;

    // copy the image data
    DataSize := (Windows.MulDiv(ADesc.BitsPerPixel, ADesc.Width, 8) + 3) and not 3;
    Align := DataSize and 3;
    if Align <> 0
    then DataSize := DataSize + PtrUInt(4 - Align);
    DataSize := DataSize * ADesc.Height;
    if DataSize > ARawImage.DataSize
    then DataSize := ARawImage.DataSize;
    Move(ARawImage.Data^, BitsPtr^, DataSize);
  end
  else
    ABitmap := Windows.CreateBitmap(ADesc.Width, ADesc.Height, 1, 1, ARawImage.Data);
    
  //DbgDumpBitmap(ABitmap, 'CreateBitmaps - Image');
  if ASkipMask then Exit(True);

  AMask := Windows.CreateBitmap(ADesc.Width, ADesc.Height, 1, 1, ARawImage.Mask);
  if AMask = 0 then  
    DebugLn('Windows.CreateBitmap returns 0. Reason = ' + GetLastErrorText(Windows.GetLastError));
  Result := AMask <> 0;
  //DbgDumpBitmap(AMask, 'CreateBitmaps - Mask');
end;

{------------------------------------------------------------------------------
  Function: RawImage_DescriptionFromBitmap
  Params: ABitmap:
          ADesc:
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.RawImage_DescriptionFromBitmap(ABitmap: HBITMAP; out ADesc: TRawImageDescription): Boolean;
var
  ASize: Integer;
  WinDIB: Windows.TDIBSection;
begin
  ASize := Windows.GetObject(ABitmap, SizeOf(WinDIB), @WinDIB);
  Result := ASize > 0;
  if Result then
  begin
    FillRawImageDescription(WinDIB.dsBm, ADesc);
    // if it is not DIB then alpha in bitmaps is not supported => use 0 alpha prec
    if ASize < SizeOf(WinDIB) then
      ADesc.AlphaPrec := 0;
  end;
end;

{------------------------------------------------------------------------------
  Function: RawImage_DescriptionFromDevice
  Params: ADC:
          ADesc:
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.RawImage_DescriptionFromDevice(ADC: HDC; out ADesc: TRawImageDescription): Boolean;
var
  DC: HDC;
begin
  Result := True;
  
  ADesc.Init;

  if ADC = 0
  then DC := Windows.GetDC(0)
  else DC := ADC;

  ADesc.Format := ricfRGBA;
  ADesc.Width := Windows.GetDeviceCaps(DC, HORZRES);
  ADesc.Height := Windows.GetDeviceCaps(DC, VERTRES);
  ADesc.Depth := Windows.GetDeviceCaps(DC, BITSPIXEL) * Windows.GetDeviceCaps(DC, PLANES);
  ADesc.BitOrder := riboReversedBits;
  ADesc.ByteOrder := riboLSBFirst;
  ADesc.LineOrder := riloTopToBottom;
  ADesc.LineEnd := rileDWordBoundary;
  ADesc.BitsPerPixel := ADesc.Depth;

  if (Windows.GetDeviceCaps(DC, RASTERCAPS) and RC_PALETTE) <> 0
  then begin
    // has palette
    ADesc.PaletteColorCount := Windows.GetDeviceCaps(DC, NUMCOLORS);
  end;
  
  if ADC = 0
  then Windows.ReleaseDC(0, DC);

  FillRawImageDescriptionColors(ADesc);

  ADesc.MaskBitsPerPixel := 1;
  ADesc.MaskShift := 0;
  ADesc.MaskLineEnd := rileWordBoundary;
  ADesc.MaskBitOrder := riboReversedBits;
end;

{------------------------------------------------------------------------------
  Function: RawImage_FromBitmap
  Params: ABitmap:
          AMask:
          ARect:
          ARawImage:
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.RawImage_FromBitmap(out ARawImage: TRawImage; ABitmap, AMask: HBITMAP; ARect: PRect = nil): Boolean;
var
  WinDIB: Windows.TDIBSection;
  WinBmp: Windows.TBitmap absolute WinDIB.dsBm;
  ASize: Integer;
  R: TRect;
begin
  ARawImage.Init;
  FillChar(WinDIB, SizeOf(WinDIB), 0);
  ASize := Windows.GetObject(ABitmap, SizeOf(WinDIB), @WinDIB);
  if ASize = 0
  then Exit(False);

  //DbgDumpBitmap(ABitmap, 'FromBitmap - Image');
  //DbgDumpBitmap(AMask, 'FromMask - Mask');

  FillRawImageDescription(WinBmp, ARawImage.Description);
  // if it is not DIB then alpha in bitmaps is not supported => use 0 alpha prec
  if ASize < SizeOf(WinDIB) then
    ARawImage.Description.AlphaPrec := 0;
    
  if ARect = nil
  then begin
    R := Rect(0, 0, WinBmp.bmWidth, WinBmp.bmHeight);
  end
  else begin
    R := ARect^;
    if R.Top > WinBmp.bmHeight then
      R.Top := WinBmp.bmHeight;
    if R.Bottom > WinBmp.bmHeight then
      R.Bottom := WinBmp.bmHeight;
    if R.Left > WinBmp.bmWidth then
      R.Left := WinBmp.bmWidth;
    if R.Right > WinBmp.bmWidth then
      R.Right := WinBmp.bmWidth;
  end;

  ARawImage.Description.Width := R.Right - R.Left;
  ARawImage.Description.Height := R.Bottom - R.Top;
  
  // copy bitmap
  Result := GetBitmapBytes(WinBmp, ABitmap, R, ARawImage.Description.LineEnd, ARawImage.Description.LineOrder, ARawImage.Data, ARawImage.DataSize);

  // check mask
  if AMask <> 0 then
  begin
    if Windows.GetObject(AMask, SizeOf(WinBmp), @WinBmp) = 0
    then Exit(False);

    Result := GetBitmapBytes(WinBmp, AMask, R, ARawImage.Description.MaskLineEnd, ARawImage.Description.LineOrder, ARawImage.Mask, ARawImage.MaskSize);
  end
  else begin
    ARawImage.Description.MaskBitsPerPixel := 0;
  end;
end;

{------------------------------------------------------------------------------
  Function: RawImage_FromDevice
  Params: ADC:
          ARect:
          ARawImage:
  Returns:

 ------------------------------------------------------------------------------}
function TWin32WidgetSet.RawImage_FromDevice(out ARawImage: TRawImage; ADC: HDC; const ARect: TRect): Boolean;
const
  FILL_PIXEL: array[0..3] of Byte = ($00, $00, $00, $FF);
var
  Info: record
    Header: Windows.TBitmapInfoHeader;
    Colors: array[0..1] of Cardinal; // reserve extra color for mono bitmaps
  end;

  BitsPtr: Pointer;

  copyDC, fillDC: HDC;
  bmp, copyOld, fillOld, copyBmp, fillBmp: HBITMAP;
  w, h: Integer;

begin
  if Windows.GetObjectType(ADC) = OBJ_MEMDC
  then begin
    // we can use bitmap directly
    bmp := Windows.GetCurrentObject(ADC, OBJ_BITMAP);
    copyBmp := 0;
  end
  else begin
    // we need to copy the image
    // use a dibsection, so we can easily retrieve the bytes
    copyDC := Windows.CreateCompatibleDC(ADC);

    w := Windows.GetDeviceCaps(ADC, DESKTOPHORZRES);
    if w = 0
    then w := Windows.GetDeviceCaps(ADC, HORZRES);
    h := Windows.GetDeviceCaps(ADC, DESKTOPVERTRES);
    if h = 0
    then h := Windows.GetDeviceCaps(ADC, VERTRES);

    FillChar(Info, SizeOf(Info), 0);
    Info.Header.biSize := SizeOf(Info.Header);
    Info.Header.biWidth := w;
    Info.Header.biHeight := -h;
    Info.Header.biPlanes := 1;
    Info.Header.biBitCount := Windows.GetDeviceCaps(ADC, BITSPIXEL);
    Info.Header.biCompression := BI_RGB;

    copyBmp := Windows.CreateDIBSection(copyDC, Windows.PBitmapInfo(@Info)^, DIB_RGB_COLORS, BitsPtr, 0, 0);
    copyOld := Windows.SelectObject(copyDC, copyBmp);

    // prefill bitmap, to create an alpha channel in case of 32bpp bitmap
    if Info.Header.biBitCount > 24
    then begin
      // using a stretchblt is faster than filling the memory ourselves,
      // which is in its turn faster than using a 24bpp bitmap
      fillBmp := Windows.CreateBitmap(1, 1, 1, 32, @FILL_PIXEL);
      fillDC := Windows.CreateCompatibleDC(ADC);
      fillOld := Windows.SelectObject(fillDC, fillBmp);

      Windows.StretchBlt(copyDC, 0, 0, w, h, fillDC, 0, 0, 1, 1, SRCCOPY);

      Windows.SelectObject(fillDC, fillOld);
      Windows.DeleteDC(fillDC);
      Windows.DeleteObject(fillBmp);

      Windows.BitBlt(copyDC, 0, 0, w, h, ADC, 0, 0, SRCPAINT);
    end
    else begin
      // copy image
      Windows.BitBlt(copyDC, 0, 0, w, h, ADC, 0, 0, SRCCOPY);
    end;

    Windows.SelectObject(copyDC, copyOld);
    Windows.DeleteDC(copyDC);

    bmp := copyBmp;
  end;
  
  if bmp = 0 then Exit(False);

  Result := RawImage_FromBitmap(ARawImage, bmp, 0, @ARect);
  if copyBmp <> 0
  then Windows.DeleteObject(copyBmp);
end;

procedure TWin32WidgetSet.RemoveEventHandler(var AHandler: PEventHandler);
var
  lListIndex: pdword absolute AHandler;
  I: dword;
begin
  if AHandler = nil then exit;
{$ifdef DEBUG_ASYNCEVENTS}
  DebugLn('Removing handle: ', IntToHex(FWaitHandles[lListIndex^], 8));
  if Length(FWaitHandles) > 0 then
    DebugLn(' WaitHandleCount=', IntToStr(FWaitHandleCount), ', WaitHandle[0]=', IntToHex(FWaitHandles[0], 8));
{$endif}
  // swap with last one
  if FWaitHandleCount >= 2 then
  begin
    I := lListIndex^;
    FWaitHandles[I] := FWaitHandles[FWaitHandleCount-1];
    FWaitHandlers[I] := FWaitHandlers[FWaitHandleCount-1];
    FWaitHandlers[I].ListIndex^ := I;
  end;
  Dec(FWaitHandleCount);
  Dispose(lListIndex);
  AHandler := nil;
end;

procedure TWin32WidgetSet.RemovePipeEventHandler(var AHandler: PPipeEventHandler);
var
  lHandler: PPipeEventInfo absolute AHandler;
begin
  if AHandler = nil then exit;
  if lHandler^.Prev <> nil then
    lHandler^.Prev^.Next := lHandler^.Next
  else
    FWaitPipeHandlers := lHandler^.Next;
  if lHandler^.Next <> nil then
    lHandler^.Next^.Prev := lHandler^.Prev;
  Dispose(lHandler);
  AHandler := nil;
end;

//##apiwiz##eps##   // Do not remove, no wizard declaration after this line
