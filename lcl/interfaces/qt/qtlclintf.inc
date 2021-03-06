{%MainUnit qtint.pp}
{ $Id$ }

{******************************************************************************
                  All QT interface support routines
                   Initial Revision  : Sat Jan 17 19:00:00 2004


  !! Keep alphabetical !!

  Support routines go to qtproc.pp

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

function TQtWidgetSet.AddEventHandler(AHandle: THandle; AFlags: dword;
  AEventHandler: TWaitHandleEvent; AData: PtrInt): PEventHandler;
begin
  // todo
  Result := nil;
end;

function TQtWidgetSet.AddPipeEventHandler(AHandle: THandle;
  AEventHandler: TPipeEvent; AData: PtrInt): PPipeEventHandler;
begin
  // todo
  Result := nil;
end;

function TQtWidgetSet.AddProcessEventHandler(AHandle: THandle;
  AEventHandler: TChildExitEvent; AData: PtrInt): PProcessEventHandler;
begin
  // todo
  Result := nil;
end;

{------------------------------------------------------------------------------
  Function: CreateStandardCursor
  Params:
  Returns:
 ------------------------------------------------------------------------------}
function TQtWidgetSet.CreateStandardCursor(ACursor: SmallInt): HCURSOR;
var
  CursorShape: QtCursorShape;
begin
  Result := 0;
  if ACursor < crLow then Exit;
  if ACursor > crHigh then Exit;

  // TODO: map is better
  case TCursor(ACursor) of
    crNone      : CursorShape := QtBlankCursor;
    crArrow     : CursorShape := QtArrowCursor;
    crCross     : CursorShape := QtCrossCursor;
    crIBeam     : CursorShape := QtIBeamCursor;
    crSizeAll   : CursorShape := QtSizeAllCursor;
    crSizeNESW  : CursorShape := QtSizeBDiagCursor;
    crSizeNS    : CursorShape := QtSizeVerCursor;
    crSizeNWSE  : CursorShape := QtSizeFDiagCursor;
    crSizeWE    : CursorShape := QtSizeHorCursor;
    crSizeNW    : CursorShape := QtSizeFDiagCursor;
    crSizeN     : CursorShape := QtSizeVerCursor;
    crSizeNE    : CursorShape := QtSizeBDiagCursor;
    crSizeW     : CursorShape := QtSizeHorCursor;
    crSizeE     : CursorShape := QtSizeHorCursor;
    crSizeSW    : CursorShape := QtSizeBDiagCursor;
    crSizeS     : CursorShape := QtSizeVerCursor;
    crSizeSE    : CursorShape := QtSizeFDiagCursor;
    crUpArrow   : CursorShape := QtUpArrowCursor;
    crHourGlass : CursorShape := QtWaitCursor;
    crHSplit    : CursorShape := QtSplitHCursor;
    crVSplit    : CursorShape := QtSplitVCursor;
    crNo        : CursorShape := QtForbiddenCursor;
    crAppStart  : CursorShape := QtBusyCursor;
    crHelp      : CursorShape := QtWhatsThisCursor;
    crHandPoint : CursorShape := QtPointingHandCursor;
  else
    CursorShape := QtCursorShape(-1);
  end;
  if CursorShape <> QtCursorShape(-1) then
    Result := HCURSOR(TQtCursor.Create(CursorShape));
end;

{------------------------------------------------------------------------------
  Function: DrawArrow
  Params:
  Returns:
 ------------------------------------------------------------------------------}
procedure TQtWidgetSet.DrawArrow(Arrow: TComponent; Canvas: TPersistent);
const
  QtArrowTypeMap: array[TArrowType] of QStylePrimitiveElement =
  (
{atUp   } QStylePE_IndicatorArrowUp,
{atDown } QStylePE_IndicatorArrowDown,
{atLeft } QStylePE_IndicatorArrowLeft,
{atRight} QStylePE_IndicatorArrowRight
  );
var
  DC: TQtDeviceContext;
  ARect: TRect;
  StyleOption: QStyleOptionH;
begin
  DC := TQtDeviceContext(TCanvas(Canvas).Handle);
  ARect := TControl(Arrow).ClientRect;
  
  StyleOption := QStyleOption_create(1, integer(QStyleOptionSO_Default));
  try
    // I dont know the reason, but under windows down arrow size is very small
    // and is not dependent on passed ARect.
    // There is nothing in qt source that can cause such bad painting.
    // Other styles draw down arrow very well.
    QStyleOption_initFrom(StyleOption, DC.Parent);
    QStyleOption_setRect(StyleOption, @ARect);
    QStyle_drawPrimitive(QApplication_style, QtArrowTypeMap[TArrow(Arrow).ArrowType],
      StyleOption, DC.Widget, DC.Parent);
  finally
    QStyleOption_destroy(StyleOption);
  end;
end;

procedure TQtWidgetSet.DrawDefaultDockImage(AOldRect, ANewRect: TRect; AOperation: TDockImageOperation);
begin
  if FDockImage = nil then
    FDockImage := QRubberBand_create(QRubberBandRectangle);

  QRubberBand_setGeometry(FDockImage, @ANewRect);
  case AOperation of
    disShow: QWidget_show(FDockImage);
    disHide: QWidget_hide(FDockImage);
  end;
end;

procedure TQtWidgetSet.DrawGrid(DC: HDC; const R: TRect; DX, DY: Integer);
var
  QtDC: TQtDeviceContext absolute DC;
  X, Y: Integer;
  W, H: Integer;
begin
  if not IsValidDC(DC) then
    exit;
  QtDC.save;
  try
    W := (R.Right - R.Left - 1) div DX;
    H := (R.Bottom - R.Top - 1) div DY;

    for X := 0 to W do
      for Y := 0 to H do
        QtDC.drawPoint(R.Left + X * DX, R.Top + Y * DY + 1);
  finally
    QtDC.restore;
  end;
end;

{------------------------------------------------------------------------------
  Function: FontCanUTF8
  Params:
  Returns:
 ------------------------------------------------------------------------------}
function TQtWidgetSet.FontCanUTF8(Font: HFont): Boolean;
begin
  Result := IsValidGDIObject(Font);
end;

{------------------------------------------------------------------------------
  Function: FontIsMonoSpace
  Params:
  Returns:
 ------------------------------------------------------------------------------}
function TQtWidgetSet.FontIsMonoSpace(Font: HFont): Boolean;
var
  QtFontInfo: QFontInfoH;
begin
  Result := IsValidGDIObject(Font);
  if Result then
  begin
    QtFontInfo := QFontInfo_create(TQtFont(Font).Widget);
    try
  	  Result := QFontInfo_fixedPitch(QtFontInfo);
    finally
	    QFontInfo_destroy(QtFontInfo);
    end;
  end;
end;


function TQtWidgetSet.GetDesignerDC(WindowHandle: HWND): HDC;
var
  Widget: TQtWidget;
begin
  Widget := TQtWidget(WindowHandle);

  if (Widget <> nil) and (Widget is TQtDesignWidget) then
    Result := TQtDesignWidget(Widget).DesignContext
  else
    Result := 0;

  if Result = 0 then
    Result := GetDC(WindowHandle);
end;

{------------------------------------------------------------------------------
  Function: IntfSendsUTF8KeyPress
  Params:
  Returns:
 ------------------------------------------------------------------------------}

function TQtWidgetSet.IntfSendsUTF8KeyPress: boolean;
begin
  Result := True;
end;

function TQtWidgetSet.IsDesignerDC(WindowHandle: HWND; DC: HDC): Boolean;
begin
  Result := (WindowHandle <> 0) and (TQtWidget(WindowHandle) is TQtDesignWidget);
  if Result then
    Result := TQtDesignWidget(WindowHandle).DesignContext = DC;
end;

{------------------------------------------------------------------------------
  Function: PromptUser
  Params:
  Returns:

  Note: Qt appears to map Esc key to Cancel button, so no need for EscapeResult.
 ------------------------------------------------------------------------------}
function TQtWidgetSet.PromptUser(const DialogCaption : string;
                                 const DialogMessage : string;
                                       DialogType    : LongInt;
                                       Buttons       : PLongInt;
                                       ButtonCount   : LongInt;
                                       DefaultIndex  : LongInt;
                                       EscapeResult  : LongInt) : LongInt;
var
  BtnIdx     : LongInt;
  QResult    : QMessageBoxStandardButton;
  QtMessageBox: TQtMessageBox;
begin
  ReleaseCapture;
  QtMessageBox := TQtMessageBox.Create(nil);
  QtMessageBox.AttachEvents;
  try
    {Convert LCL "id" button values to Qt values}
    for BtnIdx := 0 to ButtonCount-1 do
    begin
      case Buttons[BtnIdx] of
        idButtonYes      : QtMessageBox.AddButton(QMessageBoxYes, rsMbYes, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonNo       : QtMessageBox.AddButton(QMessageBoxNo, rsMbNo, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonOK       : QtMessageBox.AddButton(QMessageBoxOk, rsMbOk, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonCancel   : QtMessageBox.AddButton(QMessageBoxCancel, rsMbCancel, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonAbort    : QtMessageBox.AddButton(QMessageBoxAbort, rsMbAbort, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonRetry    : QtMessageBox.AddButton(QMessageBoxRetry, rsMbRetry, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonIgnore   : QtMessageBox.AddButton(QMessageBoxIgnore, rsMbIgnore, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonNoToAll  : QtMessageBox.AddButton(QMessageBoxNoToAll, rsMbNoToAll, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonYesToAll : QtMessageBox.AddButton(QMessageBoxYesToAll, rsMbYesToAll, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonHelp     : QtMessageBox.AddButton(QMessageBoxHelp, rsMbHelp, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
        idButtonClose    : QtMessageBox.AddButton(QMessageBoxClose, rsMbClose, BtnIdx = DefaultIndex, BtnIdx = EscapeResult);
      end;
    end;

    if DialogCaption <> '' then
      QtMessageBox.Title := DialogCaption
    else
      case DialogType of
        idDialogWarning: QtMessageBox.Title := rsMtWarning;
        idDialogError: QtMessageBox.Title := rsMtError;
        idDialogInfo : QtMessageBox.Title := rsMtInformation;
        idDialogConfirm : QtMessageBox.Title := rsMtConfirmation;
      end;

    QtMessageBox.MessageStr := DialogMessage;

    case DialogType of
      idDialogWarning: QtMessageBox.MsgBoxType := QMessageBoxWarning;
      idDialogError: QtMessageBox.MsgBoxType := QMessageBoxCritical;
      idDialogInfo : QtMessageBox.MsgBoxType := QMessageBoxInformation;
      idDialogConfirm : QtMessageBox.MsgBoxType := QMessageBoxQuestion;
      else
        QtMessageBox.MsgBoxType := QMessageBoxNoIcon;
    end;

    QResult := QtMessageBox.exec;
  finally
    QtMessageBox.Free;
  end;
   {Convert Qt result to LCL "id" dialog result}
  case QResult of
    QMessageBoxOk       : Result := idButtonOK;
    QMessageBoxCancel   : Result := idButtonCancel;
    QMessageBoxAbort    : Result := idButtonAbort;
    QMessageBoxRetry    : Result := idButtonRetry;
    QMessageBoxIgnore   : Result := idButtonIgnore;
    QMessageBoxYes      : Result := idButtonYes;
    QMessageBoxNo       : Result := idButtonNo;
    // QMessageBoxAll      : no equivalent
    QMessageBoxNoToAll  : Result := idButtonNoToAll;
    QMessageBoxYesToAll : Result := idButtonYesToAll;
    else
      Result := -1;
  end;
end;  {TQtWidgetSet.PromptUser}

{------------------------------------------------------------------------------
  Function: RawImage_CreateBitmaps
  Params: ARawImage:
          ABitmap:
          AMask:
          ASkipMask: When set, no mask is created
  Returns:

  This functions is for TBitmap support

  The memory allocation code was added because it is necessary for
  TBitmap.LoadFromDevice support. For other operations it isnt needed
 ------------------------------------------------------------------------------}
function TQtWidgetSet.RawImage_CreateBitmaps(const ARawImage: TRawImage; out ABitmap, AMask: HBitmap; ASkipMask: Boolean): Boolean;
var
  Desc: TRawImageDescription absolute ARawImage.Description;
  NewData: PByte;
  ImageFormat: QImageFormat;
begin
  Result := False;
  ABitmap := 0;
  AMask := 0;

  //MWE: shouldn't the memory get copied at the place where it is needed,
  //     its not really oo if the bitmap (or thisr party) needs this to do it here.
  if ARawImage.DataSize > 0 then
  begin
    NewData := GetMem(ARawImage.DataSize);
    Move(ARawImage.Data^, NewData^, ARawImage.DataSize);
  end
  else
    NewData := nil;
    
  // this is only a rough implementation, there is no check against bitsperpixel
  case Desc.Depth of
    1: ImageFormat := QImageFormat_Mono;
    //2..14: ;
    15, 16: ImageFormat := QImageFormat_RGB16;
    24: ImageFormat := QImageFormat_RGB32;
    32: ImageFormat := QImageFormat_ARGB32;
  else
    ImageFormat := QImageFormat_ARGB32;
  end;
  ABitmap := HBitmap(TQtImage.Create(NewData, Desc.Width, Desc.Height, ImageFormat, True));
  Result := ABitmap <> 0;
  
  if ASkipMask then Exit;

  if (ARawImage.Mask <> nil) and (ARawImage.MaskSize > 0) then
  begin
    NewData := GetMem(ARawImage.MaskSize);
    Move(ARawImage.Mask^, NewData^, ARawImage.MaskSize);
  end
  else
    NewData := nil;
    
  AMask := HBitmap(TQtImage.Create(NewData, Desc.Width, Desc.Height, QImageFormat_Mono, True));
end;

{------------------------------------------------------------------------------
  Function: RawImage_DescriptionFromBitmap
  Params: ABitmap:
          ADesc:
  Returns:

  Describes the inner format utilized by Qt + the specific information for this image
 ------------------------------------------------------------------------------}
function TQtWidgetSet.RawImage_DescriptionFromBitmap(ABitmap: HBITMAP; out ADesc: TRawImageDescription): Boolean;
const
  QImageFormatToDepth: array[QImageFormat] of integer =
  (
 { QImageFormat_Invalid              } 0,
 { QImageFormat_Mono                 } 1,
 { QImageFormat_MonoLSB              } 1,
 { QImageFormat_Indexed8             } 8,
 { QImageFormat_RGB32                } 24,
 { QImageFormat_ARGB32               } 32,
 { QImageFormat_ARGB32_Premultiplied } 32,
 { QImageFormat_RGB16                } 16,
 {$IF DEFINED(USE_QT_44) or DEFINED(USE_QT_45)}
  { QImageFormat_ARGB8565_Premultiplied         } 24,
  { QImageFormat_RGB666                         } 24,
  { QImageFormat_ARGB6666_Premultiplied         } 24,
  { QImageFormat_RGB555                         } 16,
  { QImageFormat_ARGB8555_Premultiplied         } 24,
  { QImageFormat_RGB888                         } 24,
  { QImageFormat_RGB444                         } 16,
  { QImageFormat_ARGB4444_Premultiplied         } 16,
{$ENDIF}
 { QImageNImageFormats               } 0
  );
var
  Image: TQtImage absolute ABitmap;
begin
  Result := CheckBitmap(ABitmap, 'RawImage_DescriptionFromBitmap');
  if not Result then Exit;

  //FillStandardDescription(ADesc);
  ADesc.Init;
  ADesc.Width := Image.Width;
  ADesc.Height := Image.Height;

  ADesc.BitOrder := riboReversedBits;
  ADesc.ByteOrder := riboLSBFirst;
  ADesc.LineOrder := riloTopToBottom;
  ADesc.LineEnd := rileDWordBoundary;

  ADesc.Depth := QImageFormatToDepth[Image.getFormat];
  ADesc.BitsPerPixel := ADesc.Depth;
  if ADesc.BitsPerPixel = 24 then
    ADesc.BitsPerPixel := 32;

  ADesc.Format := ricfRGBA;
  case ADesc.Depth of
    1, 8:
      begin
        ADesc.Format := ricfGray;

        ADesc.RedPrec := ADesc.BitsPerPixel;
      end;
    16:
      begin
        ADesc.Depth := 15;

        ADesc.RedPrec := 5;
        ADesc.GreenPrec := 5;
        ADesc.BluePrec := 5;

        ADesc.RedShift := 10;
        ADesc.GreenShift := 5;
        ADesc.BlueShift := 0;
      end;
    24:
      begin
        ADesc.RedPrec := 8;
        ADesc.GreenPrec := 8;
        ADesc.BluePrec := 8;

        ADesc.RedShift := 16;
        ADesc.GreenShift := 8;
        ADesc.BlueShift := 0;
      end;
    32:
      begin
        ADesc.AlphaPrec := 8;
        ADesc.RedPrec := 8;
        ADesc.GreenPrec := 8;
        ADesc.BluePrec := 8;

        ADesc.AlphaShift := 24;
        ADesc.RedShift := 16;
        ADesc.GreenShift := 8;
        ADesc.BlueShift := 0;
      end;
  end;
end;

{------------------------------------------------------------------------------
  Function: RawImage_DescriptionFromDevice
  Params: ADC:
          ADesc:
  Returns:

  Describes the standard format utilized by Qt
 ------------------------------------------------------------------------------}
function TQtWidgetSet.RawImage_DescriptionFromDevice(ADC: HDC; out ADesc: TRawImageDescription): Boolean;
begin
  Result := true;

  FillStandardDescription(ADesc);
end;

{------------------------------------------------------------------------------
  Function: RawImage_FromBitmap
  Params: ABitmap:
          AMask:
          ARect:
          ARawImage:
  Returns:

  Creates a raw image from a bitmap
 ------------------------------------------------------------------------------}
function TQtWidgetSet.RawImage_FromBitmap(out ARawImage: TRawImage; ABitmap, AMask: HBITMAP; ARect: PRect = nil): Boolean;
var
  Desc: TRawImageDescription absolute ARawImage.Description;
  Image: TQtImage absolute ABitmap;
  Mask: TQtImage absolute AMask;
  
  WorkImage, WorkMask: TQtImage;
  R: TRect;
  Width, Height: Integer;
begin
  Result := False;
  
  if not CheckBitmap(ABitmap, 'RawImage_FromBitmap') then Exit;
  if (AMask <> 0) and not CheckBitmap(AMask, 'RawImage_FromBitmap (mask)') then Exit;

  ARawImage.Init;
  RawImage_DescriptionFromBitmap(ABitmap, Desc);

  if ARect = nil
  then begin
    Width := Image.Width;
    Height := Image.Height;
    R := Rect(0, 0, Width, Height)
  end
  else begin
    R := ARect^;
    Width := R.Right - R.Left;
    Height := R.Bottom - R.Top;
  end;
  
  if (Width = Image.Width) and (Height = Image.Height)
  then begin
    WorkImage := Image;
    WorkMask := Mask;
  end
  else begin
    WorkImage := TQtImage.Create;
    WorkImage.CopyFrom(Image.Handle, R.Left, R.Top, Width, Height);
    if Mask <> nil then
    begin
      WorkMask := TQtImage.Create;
      WorkMask.CopyFrom(Mask.Handle, R.Left, R.Top, Width, Height);
    end
    else
      WorkMask := nil;
  end;

  Desc.Width := WorkImage.width;
  Desc.Height := WorkImage.height;

  // copy data
  ARawImage.DataSize := WorkImage.numBytes;
  ReAllocMem(ARawImage.Data, ARawImage.DataSize);
  if ARawImage.DataSize > 0 then
    Move(WorkImage.bits^, ARawImage.Data^, ARawImage.DataSize);

  if WorkMask <> nil
  then begin
    Desc.MaskLineEnd := rileDWordBoundary;
    Desc.MaskBitOrder := riboReversedBits;
    Desc.MaskBitsPerPixel := 1;
    ARawImage.MaskSize := WorkMask.numBytes;
    ReAllocMem(ARawImage.Mask, ARawImage.MaskSize);
    if ARawImage.MaskSize > 0 then
      Move(WorkMask.bits^, ARawImage.Mask^, ARawImage.MaskSize);
  end;
  
  if WorkImage <> Image then
    WorkImage.Free;
  if WorkMask <> Mask then
    WorkMask.Free;

  Result := True;
end;

{------------------------------------------------------------------------------
  Function: RawImage_FromDevice
  Params: ADC:
          ARect:
          ARawImage:
  Returns:

  This function is utilized when the function TBitmap.LoadFromDevice is called

  The main use for this function is to get a screenshot. It may have other uses,
   but this is the only one implemented here.

  MWE: exept for the desktop, there is always a bitmep selected in the DC.
       So get this internal bitmap and pass it to RawImage_FromBitmap
 ------------------------------------------------------------------------------}
function TQtWidgetSet.RawImage_FromDevice(out ARawImage: TRawImage; ADC: HDC; const ARect: TRect): Boolean;
var
  Desc: TRawImageDescription absolute ARawImage.Description;

  //SrcWidth, SrcHeight: Integer;
  WinID: Cardinal;
  DCSize: TSize;
  Pixmap: TQtPixmap;
  Image: QImageH;
  Context: TQtDeviceContext;
  
  procedure RawImage_FromImage(AImage: QImageH);
  begin
    ARawImage.DataSize := QImage_numBytes(AImage);
    ARawImage.Data := GetMem(ARawImage.DataSize);
    Move(QImage_bits(AImage)^, ARawImage.Data^, ARawImage.DataSize);
    ARawImage.Mask := nil;
  end;
  
begin
  {$ifdef VerboseQtWinAPI}
    WriteLn('Trace:> [WinAPI GetRawImageFromDevice] SrcDC: ', dbghex(ADC),
     ' SrcWidth: ', dbgs(ARect.Right - ARect.Left),
     ' SrcHeight: ', dbgs(ARect.Bottom - ARect.Top));
  {$endif}

  // todo: copy only passed rectangle

  Result := True;

  ARawImage.Init;
  FillStandardDescription(ARawImage.Description);
  Context := TQtDeviceContext(ADC);

  with DCSize, Context.getDeviceSize do
  begin
    cx := x;
    cy := y;
  end;
  
  Pixmap := TQtPixmap.Create(@DCSize);
  
  if Context.Parent <> nil then
  begin
    WinID := QWidget_winId(Context.Parent);
    try
      // if you have dual monitors then getDeviceSize return
      // more width than screen width, but grabWindow will only grab one
      // screen, so its width will be less
      // Solution: we can either pass prefered size to grabWindow or
      // correct Description size after. I see the first solution as more correct.
      Pixmap.grabWindow(WinID, 0, 0, DCSize.cx, DCSize.cy);
      Image := QImage_Create;
      Pixmap.toImage(Image);
      RawImage_FromImage(Image);
      QImage_destroy(Image);
    finally
      Pixmap.Free;
    end;
  end else
  begin
    if Context.vImage <> nil then
      RawImage_FromImage(Context.vImage.Handle)
    else
      Result := False;
  end;

  // In this case we use the size of the context
  Desc.Width := DCSize.cx;
  Desc.Height := DCSize.cy;

  {$ifdef VerboseQtWinAPI}
    WriteLn('Trace:< [WinAPI GetRawImageFromDevice]');
  {$endif}
end;

{------------------------------------------------------------------------------
  Function: RawImage_QueryDescription
  Params: AFlags:
          ADesc:
  Returns:

 ------------------------------------------------------------------------------}
function TQtWidgetSet.RawImage_QueryDescription(AFlags: TRawImageQueryFlags; var ADesc: TRawImageDescription): Boolean;
begin
  Result := inherited RawImage_QueryDescription(AFlags, ADesc);
  if ADesc.BitsPerPixel > 8 then
    ADesc.BitsPerPixel := 32
  else
  if ADesc.BitsPerPixel > 1 then
    ADesc.BitsPerPixel := 8;
end;

function TQtWidgetSet.ReleaseDesignerDC(Window: HWND; DC: HDC): Integer;
begin
  Result := 1;
end;

procedure TQtWidgetSet.RemoveEventHandler(var AHandler: PEventHandler);
begin
  // todo
end;

procedure TQtWidgetSet.RemovePipeEventHandler(var AHandler: PPipeEventHandler);
begin
  // todo
end;

procedure TQtWidgetSet.RemoveProcessEventHandler(var AHandler: PProcessEventHandler);
begin
  // todo
end;

function TQtWidgetSet.TextUTF8Out(DC: HDC; X, Y: Integer; Str: PChar; Count: Longint): Boolean;
begin
  Result := False;
  if IsValidDC(DC) then
    Result := TextOut(DC, X, Y, Str, Count);
end;

//##apiwiz##eps##   // Do not remove, no wizard declaration after this line
