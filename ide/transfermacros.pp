{  $Id$  }
{
 /***************************************************************************
                       idemacros.pp  -  macros for tools
                       ---------------------------------


 ***************************************************************************/

 *****************************************************************************
 *                                                                           *
 *  See the file COPYING.modifiedLGPL.txt, included in this distribution,        *
 *  for details about the copyright.                                         *
 *                                                                           *
 *  This program is distributed in the hope that it will be useful,          *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
 *                                                                           *
 *****************************************************************************

  Author: Mattias Gaertner

  Abstract:
    This unit defines the classes TTransferMacro and TTransferMacroList. These
    classes store and substitute macros in strings. Transfer macros are an
    easy way to transfer some ide variables to programs like the compiler,
    the debugger and all the other tools.
    Transfer macros have the form $(macro_name). It is also possible to define
    macro functions, which have the form $macro_func_name(parameter).
    The default macro functions are:
      $Ext(filename) - equal to ExtractFileExt
      $Path(filename) - equal to ExtractFilePath
      $Name(filename) - equal to ExtractFileName
      $NameOnly(filename) - equal to ExtractFileName but without extension.
      $MakeDir(filename) - append path delimiter
      $MakeFile(filename) - chomp path delimiter
      $Trim(filename) - equal to TrimFilename

  ToDo:
    sort items to accelerate find

}
unit TransferMacros;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, LCLProc, FileUtil, LazarusIDEStrConsts, MacroIntf;

type
  TTransferMacro = class;

  TOnSubstitution = procedure(TheMacro: TTransferMacro; const MacroName: string;
    var s:string; const Data: PtrInt; var Handled, Abort: boolean) of object;

  TMacroFunction = function(const s: string; const Data: PtrInt;
                            var Abort: boolean): string of object;
  
  TTransferMacroFlag = (
    tmfInteractive
    );
  TTransferMacroFlags = set of TTransferMacroFlag;

  TTransferMacro = class
  public
    Name: string;
    Value: string;
    Description: string;
    MacroFunction: TMacroFunction;
    Flags: TTransferMacroFlags;
    constructor Create(AName, AValue, ADescription:string;
      AMacroFunction: TMacroFunction; TheFlags: TTransferMacroFlags);
  end;

  TTransferMacroList = class
  private
    fItems: TList;  // list of TTransferMacro
    FMarkUnhandledMacros: boolean;
    fOnSubstitution: TOnSubstitution;
    function GetItems(Index: integer): TTransferMacro;
    procedure SetItems(Index: integer; NewMacro: TTransferMacro);
    procedure SetMarkUnhandledMacros(const AValue: boolean);
  protected
    function MF_Ext(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
    function MF_Path(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
    function MF_Name(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
    function MF_NameOnly(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
    function MF_MakeDir(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
    function MF_MakeFile(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
    function MF_Trim(const Filename:string; const Data: PtrInt; var Abort: boolean):string; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Index: integer]: TTransferMacro
       read GetItems write SetItems; default;
    procedure SetValue(const MacroName, NewValue: string);
    function Count: integer;
    procedure Clear;
    procedure Delete(Index: integer);
    procedure Add(NewMacro: TTransferMacro);
    function FindByName(const MacroName: string): TTransferMacro; virtual;
    function SubstituteStr(var s: string; const Data: PtrInt = 0): boolean; virtual;
    function StrHasMacros(const s: string): boolean;
    property OnSubstitution: TOnSubstitution
       read fOnSubstitution write fOnSubstitution;
    property MarkUnhandledMacros: boolean read FMarkUnhandledMacros
                                          write SetMarkUnhandledMacros;
  end;

{ TLazIDEMacros }

type
  TLazIDEMacros = class(TIDEMacros)
  public
    function StrHasMacros(const s: string): boolean; override;
    function SubstituteMacros(var s: string): boolean; override;
  end;
  
var
  GlobalMacroList: TTransferMacroList = nil;

const
  MaxParseStamp = $7fffffff;
  MinParseStamp = -$7fffffff;
  InvalidParseStamp = MinParseStamp-1;
type
  TCompilerParseStampIncreasedEvent = procedure of object;
var
  CompilerParseStamp: integer; // TimeStamp of base value for macros
  CompilerParseStampIncreased: TCompilerParseStampIncreasedEvent = nil;

procedure IncreaseCompilerParseStamp;

implementation

var
  IsIdentChar: array[char] of boolean;

procedure IncreaseCompilerParseStamp;
begin
  if CompilerParseStamp<MaxParseStamp then
    inc(CompilerParseStamp)
  else
    CompilerParseStamp:=MinParseStamp;
  if Assigned(CompilerParseStampIncreased) then
    CompilerParseStampIncreased();
end;

{ TTransferMacro }

constructor TTransferMacro.Create(AName, AValue, ADescription:string;
  AMacroFunction: TMacroFunction; TheFlags: TTransferMacroFlags);
begin
  Name:=AName;
  Value:=AValue;
  Description:=ADescription;
  MacroFunction:=AMacroFunction;
  Flags:=TheFlags;
end;

{ TTransferMacroList }

constructor TTransferMacroList.Create;
begin
  inherited Create;
  fItems:=TList.Create;
  FMarkUnhandledMacros:=true;
  Add(TTransferMacro.Create('Ext', '', lisTMFunctionExtractFileExtension,
    @MF_Ext, []));
  Add(TTransferMacro.Create('Path', '', lisTMFunctionExtractFilePath, @MF_Path,
    []));
  Add(TTransferMacro.Create('Name', '', lisTMFunctionExtractFileNameExtension,
                                    @MF_Name,[]));
  Add(TTransferMacro.Create('NameOnly', '', lisTMFunctionExtractFileNameOnly,
                                    @MF_NameOnly,[]));
  Add(TTransferMacro.Create('MakeDir', '', lisTMFunctionAppendPathDelimiter,
                                    @MF_MakeDir,[]));
  Add(TTransferMacro.Create('MakeFile', '', lisTMFunctionChompPathDelimiter,
                                    @MF_MakeFile,[]));
end;

destructor TTransferMacroList.Destroy;
begin
  Clear;
  fItems.Free;
  inherited Destroy;
end;

function TTransferMacroList.GetItems(Index: integer): TTransferMacro;
begin
  Result:=TTransferMacro(fItems[Index]);
end;

procedure TTransferMacroList.SetItems(Index: integer;
  NewMacro: TTransferMacro);
begin
  fItems[Index]:=NewMacro;
end;

procedure TTransferMacroList.SetMarkUnhandledMacros(const AValue: boolean);
begin
  if FMarkUnhandledMacros=AValue then exit;
  FMarkUnhandledMacros:=AValue;
end;

procedure TTransferMacroList.SetValue(const MacroName, NewValue: string);
var AMacro:TTransferMacro;
begin
  AMacro:=FindByName(MacroName);
  if AMacro<>nil then AMacro.Value:=NewValue;
end;

function TTransferMacroList.Count: integer;
begin
  Result:=fItems.Count;
end;

procedure TTransferMacroList.Clear;
var i:integer;
begin
  for i:=0 to fItems.Count-1 do Items[i].Free;
  fItems.Clear;
end;

procedure TTransferMacroList.Delete(Index: integer);
begin
  Items[Index].Free;
  fItems.Delete(Index);
end;

procedure TTransferMacroList.Add(NewMacro: TTransferMacro);
var
  l: Integer;
  r: Integer;
  m: Integer;
  cmp: Integer;
begin
  l:=0;
  r:=fItems.Count-1;
  m:=0;
  while l<=r do begin
    m:=(l+r) shr 1;
    cmp:=AnsiCompareText(NewMacro.Name,Items[m].Name);
    if cmp<0 then
      r:=m-1
    else if cmp>0 then
      l:=m+1
    else
      break;
  end;
  if (m<fItems.Count) and (AnsiCompareText(NewMacro.Name,Items[m].Name)>0) then
    inc(m);
  fItems.Insert(m,NewMacro);
  //if NewMacro.MacroFunction<>nil then
  //  debugln('TTransferMacroList.Add A ',NewMacro.Name);
end;

function TTransferMacroList.SubstituteStr(var s:string; const Data: PtrInt
  ): boolean;
var
  MacroStart,MacroEnd: integer;
  MacroName, MacroStr, MacroParam: string;
  AMacro: TTransferMacro;
  Handled, Abort: boolean;
  OldMacroLen: Integer;
  NewMacroEnd: Integer;
  NewMacroLen: Integer;
  BehindMacroLen: Integer;
  NewString: String;
  InFrontOfMacroLen: Integer;
  NewStringLen: Integer;
  NewStringPos: Integer;
  sLen: Integer;

  function SearchBracketClose(Position:integer): integer;
  var BracketClose:char;
  begin
    if s[Position]='(' then BracketClose:=')'
    else BracketClose:='}';
    inc(Position);
    while (Position<=length(s)) and (s[Position]<>BracketClose) do begin
      if (s[Position] in ['(','{']) then
        Position:=SearchBracketClose(Position);
      inc(Position);
    end;
    Result:=Position;
  end;

begin
  Result:=true;
  sLen:=length(s);
  MacroStart:=1;
  repeat
    while (MacroStart<sLen) do begin
      if (s[MacroStart]<>'$') then
        inc(MacroStart)
      else begin
        if (s[MacroStart+1]='$') then // skip $$
          inc(MacroStart,2)
        else
          break;
      end;
    end;
    if MacroStart>=sLen then break;
    
    MacroEnd:=MacroStart+1;
    while (MacroEnd<=sLen) and (IsIdentChar[s[MacroEnd]]) do
      inc(MacroEnd);

    if (MacroEnd<sLen) and (s[MacroEnd] in ['(','{']) then begin
      MacroName:=copy(s,MacroStart+1,MacroEnd-MacroStart-1);
      MacroEnd:=SearchBracketClose(MacroEnd)+1;
      if MacroEnd>sLen+1 then break;
      OldMacroLen:=MacroEnd-MacroStart;
      MacroStr:=copy(s,MacroStart,OldMacroLen);
      // Macro found
      Handled:=false;
      Abort:=false;
      if MacroName<>'' then begin
        if MacroName='PkgPath' then DebugLn(['TTransferMacroList.SubstituteStr MacroStr="',MacroStr,'"']);
        // Macro function -> substitute macro parameter first
        MacroParam:=copy(MacroStr,length(MacroName)+3,
                                  length(MacroStr)-length(MacroName)-3);
        if not SubstituteStr(MacroParam,Data) then begin
          Result:=false;
          exit;
        end;
        AMacro:=FindByName(MacroName);
        if Assigned(fOnSubstitution) then begin
          fOnSubstitution(AMacro,MacroName,MacroParam,Data,Handled,Abort);
          if Handled then
            MacroStr:=MacroParam
          else if Abort then begin
            Result:=false;
            exit;
          end;
        end;
        if (not Handled) and (AMacro<>nil) and (Assigned(AMacro.MacroFunction))
        then begin
          MacroStr:=AMacro.MacroFunction(MacroParam,Data,Abort);
          if Abort then begin
            Result:=false;
            exit;
          end;
          Handled:=true;
        end;  
      end else begin
        // Macro variable
        MacroName:=copy(s,MacroStart+2,OldMacroLen-3);
        AMacro:=FindByName(MacroName);
        if Assigned(fOnSubstitution) then begin
          fOnSubstitution(AMacro,MacroName,MacroName,Data,Handled,Abort);
          if Handled then
            MacroStr:=MacroName
          else if Abort then begin
            Result:=false;
            exit;
          end;
        end;
        if (not Handled) and (AMacro<>nil) then begin
          // standard macro
          if Assigned(AMacro.MacroFunction) then begin
            MacroStr:=AMacro.MacroFunction('',Data,Abort);
            if Abort then begin
              Result:=false;
              exit;
            end;
          end else begin
            MacroStr:=AMacro.Value;
          end;
          Handled:=true;
        end;
      end;
      // mark unhandled macros
      if not Handled and MarkUnhandledMacros then begin
        MacroStr:=Format(lisTMunknownMacro, [MacroStr]);
        Handled:=true;
      end;
      // replace macro with new value
      if Handled then begin
        NewMacroLen:=length(MacroStr);
        NewMacroEnd:=MacroStart+NewMacroLen;
        InFrontOfMacroLen:=MacroStart-1;
        BehindMacroLen:=sLen-MacroEnd+1;
        NewString:='';
        NewStringLen:=InFrontOfMacroLen+NewMacroLen+BehindMacroLen;
        if NewStringLen>0 then begin
          SetLength(NewString,NewStringLen);
          NewStringPos:=1;
          if InFrontOfMacroLen>0 then begin
            Move(s[1],NewString[NewStringPos],InFrontOfMacroLen);
            inc(NewStringPos,InFrontOfMacroLen);
          end;
          if NewMacroLen>0 then begin
            Move(MacroStr[1],NewString[NewStringPos],NewMacroLen);
            inc(NewStringPos,NewMacroLen);
          end;
          if BehindMacroLen>0 then begin
            Move(s[MacroEnd],NewString[NewStringPos],BehindMacroLen);
            inc(NewStringPos,BehindMacroLen);
          end;
        end;
        s:=NewString;
        sLen:=length(s);
        // continue after the replacement
        MacroEnd:=NewMacroEnd;
      end;
    end;
    MacroStart:=MacroEnd;
  until false;
  
  // convert $$ chars
  MacroStart:=2;
  while (MacroStart<sLen) do begin
    if (s[MacroStart]='$') and (s[MacroStart+1]='$') then begin
      System.Delete(s,MacroStart,1);
      dec(sLen);
    end;
    inc(MacroStart);
  end;
end;

function TTransferMacroList.StrHasMacros(const s: string): boolean;
// search for $( or $xxx(
var
  p: Integer;
  Len: Integer;
begin
  Result:=false;
  p:=1;
  Len:=length(s);
  while (p<Len) do begin
    if s[p]='$' then begin
      inc(p);
      if (p<Len) and (s[p]<>'$') then begin
        // skip macro function name
        while (p<Len) and (s[p]<>'(') do inc(p);
        if (p<Len) then begin
          Result:=true;
          exit;
        end;
      end else begin
        // $$ is not a macro
        inc(p);
      end;
    end else
      inc(p);
  end;
end;

function TTransferMacroList.FindByName(const MacroName: string): TTransferMacro;
var
  l: Integer;
  r: Integer;
  m: Integer;
  cmp: Integer;
begin
  l:=0;
  r:=fItems.Count-1;
  m:=0;
  while l<=r do begin
    m:=(l+r) shr 1;
    Result:=Items[m];
    cmp:=AnsiCompareText(MacroName,Result.Name);
    if cmp<0 then
      r:=m-1
    else if cmp>0 then
      l:=m+1
    else begin
      exit;
    end;
  end;
  Result:=nil;
end;

function TTransferMacroList.MF_Ext(const Filename:string;
  const Data: PtrInt; var Abort: boolean):string;
begin
  Result:=ExtractFileExt(Filename);
end;

function TTransferMacroList.MF_Path(const Filename:string; 
  const Data: PtrInt; var Abort: boolean):string;
begin
  Result:=TrimFilename(ExtractFilePath(Filename));
end;

function TTransferMacroList.MF_Name(const Filename:string; 
  const Data: PtrInt; var Abort: boolean):string;
begin
  Result:=ExtractFilename(Filename);
end;

function TTransferMacroList.MF_NameOnly(const Filename:string;
  const Data: PtrInt; var Abort: boolean):string;
var Ext:string;
begin
  Result:=ExtractFileName(Filename);
  Ext:=ExtractFileExt(Result);
  Result:=copy(Result,1,length(Result)-length(Ext));
end;

function TTransferMacroList.MF_MakeDir(const Filename: string;
  const Data: PtrInt; var Abort: boolean): string;
begin
  Result:=Filename;
  if (Result<>'') and (Result[length(Result)]<>PathDelim) then
    Result:=Result+PathDelim;
  Result:=TrimFilename(Result);
end;

function TTransferMacroList.MF_MakeFile(const Filename: string;
  const Data: PtrInt; var Abort: boolean): string;
var
  ChompLen: integer;
begin
  Result:=Filename;
  ChompLen:=0;
  while (length(Filename)>ChompLen)
  and (Filename[length(Filename)-ChompLen]=PathDelim) do
    inc(ChompLen);
  if ChompLen>0 then
    Result:=LeftStr(Result,length(Filename)-ChompLen);
  Result:=TrimFilename(Result);
end;

function TTransferMacroList.MF_Trim(const Filename: string; const Data: PtrInt;
  var Abort: boolean): string;
begin
  Result:=TrimFilename(Filename);
end;

{ TLazIDEMacros }

function TLazIDEMacros.StrHasMacros(const s: string): boolean;
begin
  Result:=GlobalMacroList.StrHasMacros(s);
end;

function TLazIDEMacros.SubstituteMacros(var s: string): boolean;
begin
  Result:=GlobalMacroList.SubstituteStr(s);
end;

procedure InternalInit;
var
  c: char;
begin
  for c:=Low(char) to High(char) do begin
    IsIdentChar[c]:=c in ['a'..'z','A'..'Z','0'..'9','_'];
  end;
end;

initialization
  InternalInit;

end.
