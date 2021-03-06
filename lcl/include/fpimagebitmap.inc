{%MainUnit ../graphics.pp}

{******************************************************************************
                              TFPImageBitmap
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

{ TFPImageBitmap }

class function TFPImageBitmap.GetFileExtensions: string;
begin
  Result:='';
end;

procedure TFPImageBitmap.FinalizeReader(AReader: TFPCustomImageReader);
begin
end;

procedure TFPImageBitmap.FinalizeWriter(AWriter: TFPCustomImageWriter);
var
  LazWriter: ILazImageWriter;
begin
  if Supports(AWriter, ILazImageWriter, LazWriter)
  then LazWriter.Finalize;
end;

function TFPImageBitmap.GetMimeType: string;
{$IFDEF VerboseLCLTodos}{$note implement}{$ENDIF}
var
  DefaultFileExt: String;
  i: Integer;
begin
  DefaultFileExt:=GetFileExtensions;
  i:=1;
  while (i<=length(DefaultFileExt)) and (DefaultFileExt[i]<>';') do
    inc(i);
  if i<=length(DefaultFileExt) then
    DefaultFileExt:=copy(DefaultFileExt,1,i);
  Result:='image/'+DefaultFileExt;
end;

procedure TFPImageBitmap.InitializeReader(AImage: TLazIntfImage; AReader: TFPCustomImageReader);
begin
  AReader.OnProgress := @Progress;
end;

procedure TFPImageBitmap.InitializeWriter(AImage: TLazIntfImage; AWriter: TFPCustomImageWriter);
var
  LazWriter: ILazImageWriter;
begin
  AWriter.OnProgress := @Progress;
  if Supports(AWriter, ILazImageWriter, LazWriter)
  then LazWriter.Initialize(AImage);
end;

class function TFPImageBitmap.IsFileExtensionSupported(
  const FileExtension: string): boolean;
var
  Extensions: String;
  StartPos: Integer;
  EndPos: Integer;
  i: Integer;
  Ext: String;
begin
  Result:=false;
  if FileExtension='' then exit;
  Extensions:=GetFileExtensions;
  if Extensions='' then exit;
  Ext:=FileExtension;
  if Ext[1]='.'  then begin
    Ext:=copy(Ext,2,length(Ext));
    if Ext='' then exit;
  end;
  StartPos:=1;
  while StartPos<=length(Extensions) do begin
    if not (Extensions[StartPos] in [';',' ']) then begin
      EndPos:=StartPos;
      while (EndPos<=length(Extensions)) and (Extensions[EndPos]<>';') do
        inc(EndPos);
      if EndPos-StartPos=length(Ext) then begin
        i:=1;
        while (i<=length(Ext))
        and (upcase(Extensions[StartPos+i-1])=upcase(Ext[i])) do
          inc(i);
        if i>length(Ext) then begin
          Result:=true;
          exit;
        end;
      end;
      StartPos:=EndPos;
    end else
      inc(StartPos);
  end;
end;

function TFPImageBitmap.LazarusResourceTypeValid(const ResourceType: string): boolean;
begin
  Result:=IsFileExtensionSupported(ResourceType);
end;

procedure TFPImageBitmap.ReadStream(AStream: TMemoryStream; ASize: Longint);
var
  SCB: TSharedCustomBitmap;
  IntfImg: TLazIntfImage;
  ImgReader: TFPCustomImageReader;
  LazReader: ILazImageReader;
begin
  IntfImg := nil;
  ImgReader := nil;
  try
    // read image
    ImgReader := GetReaderClass.Create;
    IntfImg := TLazIntfImage.Create(0,0,[]);
    InitializeReader(IntfImg, ImgReader);
    if Supports(ImgReader, ILazImageReader, LazReader)
    then LazReader.UpdateDescription := True
    else IntfImg.DataDescription := GetDescriptionFromDevice(0, 0, 0); // fallback to default
    ImgReader.ImageRead(AStream, IntfImg);
    FinalizeReader(ImgReader);

    // no need to care about unsharing image, thats done by calling proc
    SCB := TSharedCustomBitmap(FSharedImage);
    SCB.FImage.FreeData;
    IntfImg.GetRawImage(SCB.FImage, True);
    SCB.FHasMask := IntfImg.HasMask;
    if not SCB.FHasMask
    then SCB.FImage.Description.MaskBitsPerPixel := 0;
    FPixelFormatNeedsUpdate := True;
  finally
    LazReader := nil;
    IntfImg.Free;
    ImgReader.Free;
  end;
end;

procedure TFPImageBitmap.WriteStream(AStream: TMemoryStream);
var
  IntfImg: TLazIntfImage;
  ImgWriter: TFPCustomImageWriter;
begin
  // write image to temporary stream

  ImgWriter := nil;
  IntfImg := TLazIntfImage.Create(0,0,[]);
  try
    ImgWriter := GetWriterClass.Create;
    IntfImg.SetRawImage(GetRawImagePtr^, False);
    InitializeWriter(IntfImg, ImgWriter);
    IntfImg.SaveToStream(AStream, ImgWriter);
    FinalizeWriter(ImgWriter);
  finally
    IntfImg.Free;
    ImgWriter.Free;
  end;
end;

