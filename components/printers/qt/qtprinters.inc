{%MainUnit ../osprinters.pas}
{
  Implementation for qtlcl printing
  Author: Zeljan Rikalo

 *****************************************************************************
 *                                                                           *
 *  This file is part of the Lazarus Component Library (LCL)                 *
 *                                                                           *
 *  See the file COPYING.modifiedLGPL.txt, included in this distribution,        *
 *  for details about the copyright.                                         *
 *                                                                           *
 *  This program is distributed in the hope that it will be useful,          *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
 *                                                                           *
 *****************************************************************************
 }
Uses InterfaceBase, LCLIntf;

{$IFNDEF USE_QT_44}
{$IFDEF WINDOWS}
const
  LibWinSpool = 'winspool.drv';
  
  PRINTER_ENUM_DEFAULT         = $00000001;
  PRINTER_ENUM_LOCAL           = $00000002;
  PRINTER_ENUM_CONNECTIONS     = $00000004;
  PRINTER_ENUM_FAVORITE        = $00000004;
  PRINTER_ENUM_NAME            = $00000008;
  PRINTER_ENUM_REMOTE          = $00000010;
  PRINTER_ENUM_SHARED          = $00000020;
  PRINTER_ENUM_NETWORK         = $00000040;
  PRINTER_ENUM_EXPAND          = $00004000;
  PRINTER_ENUM_CONTAINER       = $00008000;
  PRINTER_ENUM_ICONMASK        = $00ff0000;
  PRINTER_ENUM_ICON1           = $00010000;
  PRINTER_ENUM_ICON2           = $00020000;
  PRINTER_ENUM_ICON3           = $00040000;
  PRINTER_ENUM_ICON4           = $00080000;
  PRINTER_ENUM_ICON5           = $00100000;
  PRINTER_ENUM_ICON6           = $00200000;
  PRINTER_ENUM_ICON7           = $00400000;
  PRINTER_ENUM_ICON8           = $00800000;
  
type
  PPRINTER_INFO_1 = ^_PRINTER_INFO_1;
  _PRINTER_INFO_1 = packed Record
     Flags        : DWORD;
     pDescription : PChar;
     pName        : PChar;
     pComment     : PChar;
  end;

  PPRINTER_INFO_2 = ^_PRINTER_INFO_2;
  _PRINTER_INFO_2 = packed Record
     pServerName     : PChar;
     pPrinterName    : PChar;
     pShareName      : PChar;
     pPortName       : PChar;
     pDriverName     : PChar;
     pComment        : PChar;
     pLocation       : PChar;
     pDevMode        : PDeviceMode;
     pSepFile        : PChar;
     pPrintProcessor : PChar;
     pDatatype       : PChar;
     pParameters     : PChar;
     pSecurityDescriptor : Pointer;
     Attributes      : DWORD;
     Priority        : DWORD;
     DefaultPriority : DWORD;
     StartTime       : DWORD;
     UntilTime       : DWORD;
     Status          : DWORD;
     cJobs           : DWORD;
     AveragePPM      : DWORD;
  end;

  PPRINTER_INFO_4 = ^_PRINTER_INFO_4;
  _PRINTER_INFO_4 = packed Record
     pPrinterName : PChar;
     pServerName  : PChar;
     Attributes   : DWORD;
  end;

  PPRINTER_INFO_5 = ^_PRINTER_INFO_5;
  _PRINTER_INFO_5 = packed Record
     pPrinterName : PChar;
     pPortName    : PChar;
     Attributes   : DWORD;
     DeviceNotSelectedTimeout : DWORD;
     TransmissionRetryTimeout : DWORD;
  end;

function EnumPrinters(Flags: DWORD;  //Printer objet type
                      Name : PChar;  //Name of printer object
                      Level: DWORD;  //Information level
                      pPrinterEnum: Pointer; //Printer information buffer
                      cbBuf: DWORD; //Size of printer information buffer
                  var pcbNeeded,    //Bytes recieved or required
                      pcReturned: DWORD //Number of printers enumerated
                      ): BOOL; stdcall; external LibWinSpool name 'EnumPrintersA';
{$ENDIF}
{$ENDIF}

{ TQtPrinters }
procedure TQtPrinters.CreatePrintSettings;
var
  i: Integer;
begin
  {enumerate pages}
  FPagesEnum.Clear;
  FPagesEnum.Add('A4');
  FPagesEnum.Add('B5');
  FPagesEnum.Add('Letter');
  FPagesEnum.Add('Legal');
  FPagesEnum.Add('Executive');
  for i := 0 to 3 do
    FPagesEnum.Add('A'+IntToStr(i));
    
  for i := 5 to 9 do
    FPagesEnum.Add('A'+IntToStr(i));
    
  FPagesEnum.Add('B0');
  FPagesEnum.Add('B1');
  FPagesEnum.Add('B10');
  for i := 2 to 9 do
    if i <> 5 then
      FPagesEnum.Add('B'+IntToStr(i));
      
  FPagesEnum.Add('C5E');
  FPagesEnum.Add('Comm10E');
  FPagesEnum.Add('DLE');
  FPagesEnum.Add('Folio');
  FPagesEnum.Add('Ledger');
  FPagesEnum.Add('Tabloid');
  FPagesEnum.Add('Custom');
  {what to do with nPageSize
  QPrinterNPageSize = 30 }
end;

function TQtPrinters.GetPaperSize(Const Str: String): QPrinterPageSize;
var
  i: Integer;
begin
  Result := QPrinterA4;
  i := FPagesEnum.IndexOf(Str);
  if i >= 0 then
    Result := QPrinterPageSize(i);
end;

procedure TQtPrinters.BeginPage;
begin
  if Assigned(Canvas) then
    Canvas.Handle := HDC(QtDefaultPrinter.PrinterContext);
end;

procedure TQtPrinters.EndPage;
begin
  QtDefaultPrinter.PrinterContext;

  if Assigned(Canvas) then Canvas.Handle := 0;
  QtDefaultPrinter.endDoc;
end;

{$IFDEF USE_QT_44}
procedure TQtPrinters.EnumQPrinters(Lst: TStrings);
var
  i: Integer;
  PrnInfo: QPrinterInfoH;
  Prntr: QPrinterInfoH;
  PrnList: TPtrIntArray;
  PrnName: WideString;
begin

  inherited DoEnumPrinters(Lst);

  PrnInfo := QPrinterInfo_create();
  try
    Lst.Clear;
    QPrinterInfo_availablePrinters(PrnInfo, @PrnList);
    for i := Low(PrnList) to High(PrnList) do
    begin
      Prntr := QPrinterInfoH(PrnList[i]);
      if Assigned(Prntr) and not QPrinterInfo_isNull(Prntr) then
      begin
        QPrinterInfo_printerName(Prntr, @PrnName);
        PrnName := UTF8Encode(PrnName);
        if QPrinterInfo_isDefault(Prntr) then
          Lst.Insert(0, PrnName)
        else
          Lst.Add(PrnName);
      end;
    end;
  finally
    QPrinterInfo_destroy(PrnInfo);
  end;
end;
{$ELSE}
{$IFDEF WINDOWS}
procedure TQtPrinters.EnumQPrinters(Lst: TStrings);
  function getPrnStr(var Str: PChar): PChar;
  var
    P: PChar;
  begin
    Result := Str;
    if Str = nil then
     exit;
    P := Str;
    
    while P^ = ' ' do
      Inc(P);
      
    Result := P;
    
    while (P^ <> #0) and (P^ <> ',') do
      Inc(P);
      
    if P^ = ',' then
    begin
      P^ := #0;
      Inc(P);
    end;
    Str := P;
  end;

var
  CurrLine, Port: PChar;
  Buffer, PrinterInfo: PChar;
  I: Integer;
  Level: Byte;
  Flags, PrtCount, Needed: DWORD;
begin
  Lst.Clear;
  Level := 5;
  Flags := PRINTER_ENUM_CONNECTIONS or PRINTER_ENUM_LOCAL;
  Needed := 0;
  
  EnumPrinters(Flags, nil, Level, nil, 0, Needed, PrtCount);
  
  if Needed = 0 then
    Exit;
  GetMem(Buffer, Needed);
  Fillchar(Buffer^, Needed, 0);
  try
    if not EnumPrinters(Flags, nil, Level, PByte(Buffer), Needed, Needed, PrtCount) then
      Exit;
    PrinterInfo := Buffer;
    for I := 0 to PrtCount - 1 do
      if Level = 4 then
        with PPrinter_Info_4(PrinterInfo)^ do
        begin
          Lst.Add(pPrinterName);
          Inc(PrinterInfo, SizeOf(_PRINTER_INFO_4));
        end
      else
        with PPrinter_Info_5(PrinterInfo)^ do
        begin
          CurrLine := pPortName;
          Port := getPrnStr(CurrLine);
          while Port^ <> #0 do
          begin
            Lst.Add(pPrinterName);
            Port := getPrnStr(CurrLine);
          end;
          Inc(PrinterInfo, SizeOf(_PRINTER_INFO_5));
        end;
  finally
    FreeMem(Buffer, Needed);
  end;
end;

{$ELSE}
procedure TQtPrinters.EnumQPrinters(Lst: TStrings);
var
  i, Num: Integer;
  P: Pcups_dest_t;
  FCupsPrinters: Pcups_dest_t;
begin
  {Qt < 4.4 doesn't have anything to get printers list,
   but such information will be avaliable with QPrinterInfo in Qt 4.4.
   So, for qt 4.3 we are using cups printers for linux & darwin.}
  inherited DoEnumPrinters(Lst);

  if not CUPSLibInstalled then Exit;
  Lst.Clear;
  
  FCupsPrinters := nil;
  
  Num := cupsGetDests(@FcupsPrinters);
  for i := 0 to Num -1 do
  begin
    P := nil;
    P := @FCupsPrinters[i];
    if Assigned(P) then
    begin
      if P^.is_default<>0 then
        Lst.Insert(0,P^.name)
      else
        Lst.Add(P^.name);
    end;
  end;
end;
{$ENDIF}
{$ENDIF} // use_qt_44

procedure TQtPrinters.EnumQPapers(Lst: TStrings);
const
  SName = 'EnumQPapers';
begin
  Lst.Text := FPagesEnum.Text;
end;

function TQtPrinters.GetColorMode: QPrinterColorMode;
begin
  Result := QtDefaultPrinter.ColorMode;
end;

function TQtPrinters.GetFullPage: Boolean;
begin
  Result := QtDefaultPrinter.FullPage;
end;

function TQtPrinters.GetPageOrder: QPrinterPageOrder;
begin
  Result := QtDefaultPrinter.PageOrder;
end;

procedure TQtPrinters.SetColorMode(const AValue: QPrinterColorMode);
begin
  QtDefaultPrinter.ColorMode := AValue;
end;

procedure TQtPrinters.SetFullPage(const AValue: Boolean);
begin
  QtDefaultPrinter.FullPage := AValue;
end;

procedure TQtPrinters.SetPageOrder(const AValue: QPrinterPageOrder);
begin
  QtDefaultPrinter.PageOrder := AValue;
end;

constructor TQtPrinters.Create;
begin
  inherited Create;
  FPagesEnum := TStringList.Create;
  CreatePrintSettings;
end;

destructor TQtPrinters.Destroy;
begin
  FPagesEnum.Free;
  QtDefaultPrinter.endDoc;
  inherited Destroy;
end;

function TQtPrinters.Write(const Buffer; Count: Integer;
  var Written: Integer): Boolean;
begin
  Result := False;
  CheckRawMode(True);
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.Write(): Raw mode is not yet supported');
  {$ENDIF}
end;

procedure TQtPrinters.RawModeChanging;
begin
  inherited RawModeChanging;
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.RawModeChanging(): Raw mode is not yet supported');
  {$ENDIF}
end;

procedure TQtPrinters.Validate;
var
  P: String;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.Validate()');
  {$ENDIF}
  // if target paper is not supported, use the default
  P := DoGetPaperName;
  if PaperSize.SupportedPapers.IndexOf(P) = -1 then
    DoSetPaperName(DoGetDefaultPaperName);
end;

function TQtPrinters.GetXDPI: Integer;
begin
  Result :=  QtDefaultPrinter.Resolution;
  
  {DO NOT INITIALIZE PRINTERCONTEXT HERE , ASK DIRECTLY QPAINTDEVICE !}
  if (Printers.Count>0) and not RawMode then
    Result := QPaintDevice_logicalDpiX(QtDefaultPrinter.Handle);
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.GetXDPI() Result=',IntToStr(Result));
  {$ENDIF}
end;

function TQtPrinters.GetYDPI: Integer;
begin
  Result := QtDefaultPrinter.Resolution;
  
  {DO NOT INITIALIZE PRINTERCONTEXT HERE , ASK DIRECTLY QPAINTDEVICE !}
  if (Printers.Count>0) and not RawMode then
     Result := QPaintDevice_logicalDpiY(QtDefaultPrinter.Handle);
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.GetYDPI() Result=',IntToStr(Result));
  {$ENDIF}
end;

procedure TQtPrinters.DoBeginDoc;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoBeginDoc()');
  {$ENDIF}
  BeginPage;
end;

procedure TQtPrinters.DoNewPage;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoNewPage()');
  {$ENDIF}
  QtDefaultPrinter.PrinterContext;
  QtDefaultPrinter.NewPage;
end;

procedure TQtPrinters.DoEndDoc(aAborded: Boolean);
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoEndDoc()');
  {$ENDIF}
  inherited DoEndDoc(aAborded);
  EndPage;
end;

procedure TQtPrinters.DoAbort;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoAbort()');
  {$ENDIF}
  inherited DoAbort;
  if QtDefaultPrinter.Abort then
    QtDefaultPrinter.endDoc;
end;

procedure TQtPrinters.DoEnumPrinters(Lst: TStrings);
var
  Str: WideString;
  i: Integer;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoEnumPrinters()');
  {$ENDIF}
  Str := QtDefaultPrinter.PrinterName;
  EnumQPrinters(Lst);
  i := Lst.IndexOf(Str);
  if i > 0 then
    Lst.Move(i, 0);
end;

procedure TQtPrinters.DoResetPrintersList;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoResetPrintersList()');
  {$ENDIF}
  inherited DoResetPrintersList;
end;

procedure TQtPrinters.DoEnumPapers(Lst: TStrings);
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoEnumPapers()');
  {$ENDIF}
  EnumQPapers(Lst);
end;

function TQtPrinters.DoGetPaperName: string;
const
  SName = 'DoGetPaperName';
var
  i: Integer;
  Str: WideString;
begin
  i := QtDefaultPrinter.PageSize;
  Result := FPagesEnum[i];
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoGetPaperName() Result=',Result);
  {$ENDIF}
end;

function TQtPrinters.DoGetDefaultPaperName: string;
begin
  Result := FPagesEnum[0];
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoGetDefaultPaperName() Result=',Result);
  {$ENDIF}
end;

procedure TQtPrinters.DoSetPaperName(AName: string);
var
  O: TPrinterOrientation;
  i: Integer;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoSetPaperName() AName=',AName);
  {$ENDIF}
  O := DoGetOrientation;

  i := FPagesEnum.IndexOf(AName);
  if i >= 0 then
  begin
    QtDefaultPrinter.PageSize := i;
    DoSetOrientation(O);
  end else
    raise Exception.Create('TQtPrinters: Paper '+AName+' not supported.');
end;

function TQtPrinters.DoGetPaperRect(AName: string; var APaperRc: TPaperRect): Integer;
const
  SName = 'DoGetPaperRect';
var
  SavedSize: QPrinterPageSize;
  i: Integer;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoGetPaperRect() AName=', AName);
  {$ENDIF}
  Result := inherited DoGetPaperRect(aName,aPaperRc);
  i := FPagesEnum.IndexOf(AName);
  if (i >= 0) and (i = QtDefaultPrinter.pageSize) then
  begin
    {When we set QPrinter into FullPage, rect is not same
     on all platforms, this is fixed with qt-4.4}
    APaperRC.WorkRect := QtDefaultPrinter.pageRect;
    APaperRC.PhysicalRect := QtDefaultPrinter.paperRect;
    Result := 1;
  end;
end;

function TQtPrinters.DoSetPrinter(aName: string): Integer;
var
  StrList: TStringList;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoSetPrinter() aName=', aName);
  {$ENDIF}
  StrList := TStringList.Create;
  EnumQPrinters(StrList);
  try
    Result := StrList.IndexOf(AName);
    if Result >= 0 then
    begin
      if not QtDefaultPrinter.PrinterActive then
        QtDefaultPrinter.PrinterName := aName
      else
        raise Exception.Create('TQtPrinters: Cannot change printer while printing active !');
    end;
  finally
    StrList.Free;
  end;
end;

function TQtPrinters.DoGetCopies: Integer;
begin
  Result := inherited DoGetCopies;
  Result := QtDefaultPrinter.NumCopies;
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoGetCopies() Result=', IntToStr(Result));
  {$ENDIF}
end;

procedure TQtPrinters.DoSetCopies(AValue: Integer);
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoSetCopies() AValue=', IntToStr(AValue));
  {$ENDIF}
  inherited DoSetCopies(AValue);
  QtDefaultPrinter.NumCopies := AValue;
end;

function TQtPrinters.DoGetOrientation: TPrinterOrientation;
var
  O: QPrinterOrientation;
begin
  Result := inherited DoGetOrientation;
  O := QtDefaultPrinter.Orientation;
  case O of
    QPrinterPortrait: Result := poPortrait;
    QPrinterLandscape: Result := poLandscape;
  end;
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoGetOrientation() Result=', IntToStr(Ord(Result)));
  {$ENDIF}
end;

procedure TQtPrinters.DoSetOrientation(AValue: TPrinterOrientation);
var
  O: QPrinterOrientation;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoSetOrientation() AValue=', IntToStr(Ord(AValue)));
  {$ENDIF}

  inherited DoSetOrientation(aValue);

  case AValue of
    poPortrait: O := QPrinterPortrait;
    poLandscape: O := QPrinterLandscape;
    poReversePortrait: O := QPrinterPortrait;
    poReverseLandscape: O := QPrinterLandscape;
  end;
  if QtDefaultPrinter.Orientation <> O then
    QtDefaultPrinter.Orientation := O;
end;

function TQtPrinters.GetPrinterType: TPrinterType;
begin
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.GetPrinterType() Result=', IntToStr(Ord(Result)));
  {$ENDIF}
  Result := inherited GetPrinterType;
  {no type at this moment, QPrinterInfo (qt-4.4) should have this}
  Result := ptLocal;
end;

function TQtPrinters.DoGetPrinterState: TPrinterState;
var
  State: QPrinterPrinterState;
begin
  Result := inherited DoGetPrinterState;
  Result := psNoDefine;
  
  State := QtDefaultPrinter.PrinterState;
  case State of
    QPrinterIdle: Result := psReady;
    QPrinterActive: Result := psPrinting;
    QPrinterAborted,
    QPrinterError: Result := psStopped;
  end;
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.DoGetPrinterState() Result=', IntToStr(Ord(Result)));
  {$ENDIF}
end;

function TQtPrinters.GetCanPrint: Boolean;
begin
  Result := inherited GetCanPrint;
  Result := (DoGetPrinterState <> psStopped);
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.GetCanPrint() Result=',BoolToStr(Result));
  {$ENDIF}
end;

function TQtPrinters.GetCanRenderCopies: Boolean;
begin
  Result := inherited GetCanRenderCopies;
  Result := True;
  {$IFDEF VERBOSE_QT_PRINTING}
  DebugLn('TQtPrinters.GetCanRenderCopies() Result=',BoolToStr(Result));
  {$ENDIF}
end;

initialization
  Printer := TQtPrinters.Create;
  
finalization
  FreeAndNil(Printer);
  {$IFDEF UNIX}
  FinalizeCups;
  {$ENDIF}
