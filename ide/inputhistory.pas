{
/***************************************************************************
                             inputhistory.pas
                             ----------------

 ***************************************************************************/

 ***************************************************************************
 *                                                                         *
 *   This source is free software; you can redistribute it and/or modify   *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This code is distributed in the hope that it will be useful, but      *
 *   WITHOUT ANY WARRANTY; without even the implied warranty of            *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
 *   General Public License for more details.                              *
 *                                                                         *
 *   A copy of the GNU General Public License is available on the World    *
 *   Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can also      *
 *   obtain it by writing to the Free Software Foundation,                 *
 *   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.        *
 *                                                                         *
 ***************************************************************************

  Author: Mattias Gaertner
  

}
unit InputHistory;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DiffPatch, IDEProcs, AvgLvlTree,
  Laz_XMLCfg, LazConf, Dialogs, LCLProc;

{$ifdef Windows}
{$define CaseInsensitiveFilenames}
{$endif}

const
  // these are the names of the various history lists in the IDE:
  hlPublishProjectDestDirs = 'PublishProjectDestinationDirectories';
  hlPublishProjectCommandsAfter = 'PublishProjectCommmandsAfter';
  hlPublishProjectIncludeFileFilter = 'PublishProjectIncludeFileFilter';
  hlPublishProjectExcludeFileFilter = 'PublishProjectExcludeFileFilter';
  hlMakeResourceStringSections = 'MakeResourceStringSections';
  hlMakeResourceStringPrefixes = 'MakeResourceStringPrefixes';
  hlMakeResourceStringLengths = 'MakeResourceStringLengths';
  hlCodeToolsDirectories = 'CodeToolsDirectories';
  hlCompilerOptsImExport = 'CompilerOptsImExport';
  hlLaunchingApplication = 'LaunchingApplication';
  hlCmdLineParameters = 'CommandLineParameters';
  hlWorkingDirectory = 'WorkingDirectory';

type
  TFileDialogSettings = record
    InitialDir: string;
    Width: integer;
    Height: integer;
    HistoryList: TStringList;
    MaxHistory: integer;
  end;
  
  
  { THistoryList - a TStringList to store a history list }
  
  THistoryList = class(TStringList)
  private
    FMaxCount: integer;
    FName: string;
    procedure SetMaxCount(const AValue: integer);
    procedure SetName(const AValue: string);
  public
    constructor Create;
    destructor Destroy;  override;
    function Push(const Entry: string): integer;
    procedure LoadFromXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure SaveToXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure AppendEntry(const Entry: string);
  public
    property Name: string read FName write SetName;
    property MaxCount: integer read FMaxCount write SetMaxCount;
  end;
  
  
  { THistoryLists - list of THistoryList }
  
  THistoryLists = class
  private
    FItems: TList;
    function GetItems(Index: integer): THistoryList;
    function GetXMLListPath(const Path: string; i: integer): string;
  public
    constructor Create;
    destructor Destroy;  override;
    procedure Clear;
    function Count: integer;
    procedure LoadFromXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure SaveToXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    function IndexOfName(const Name: string): integer;
    function GetList(const Name: string;
      CreateIfNotExists: boolean): THistoryList;
    procedure Add(const ListName, Entry: string);
    property Items[Index: integer]: THistoryList read GetItems;
  end;
  
  
  { TFPCConfigCacheItem }
  
  TFPCConfigCacheItem = class
  public
    Options: string;
    SearchPath: string;
    FPCSrcDir: string;
    UnitLinks: string;
    procedure LoadFromXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure SaveToXMLConfig(XMLConfig: TXMLConfig; const Path: string);
  end;
  
  
  { TFPCConfigCache }
  
  TFPCConfigCache = class
  private
    FCompilerAge: longint;
    FCompilerPath: string;
    FItems: TList; // list of TFPCConfigCacheItem
    function GetCount: integer;
    function GetItems(Index: integer): TFPCConfigCacheItem;
    procedure SetCompilerPath(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function FindItem(const Options: string): integer;
    procedure SetItem(const Options, SearchPath, FPCSrcDir, UnitLinks: string);
    procedure LoadFromXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure SaveToXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    function Valid(CheckCompiler: boolean): boolean;
    function UnitLinksNeedUpdate(const Options, SearchPath,
                                 FPCSrcDir: string): boolean;
    function GetUnitLinks(const Options: string): string;
  public
    property CompilerPath: string read FCompilerPath write SetCompilerPath;
    property CompilerAge: longint read FCompilerAge;
    property Count: integer read GetCount;
    property Items[Index: integer]: TFPCConfigCacheItem read GetItems;
  end;
  
  
  { TInputHistories }

  TLazFindInFileSearchOption = (
    fifMatchCase,
    fifWholeWord,
    fifRegExpr,
    fifMultiLine,
    fifSearchProject, // search in all project files
    fifSearchOpen,    // search in all open files in editor
    fifSearchDirectories,// search in directories
    fifIncludeSubDirs,
    fifReplace,  // replace and ask user before each replace
    fifReplaceAll // replace without asking user
    );
  TLazFindInFileSearchOptions = set of TLazFindInFileSearchOption;
  
  TInputHistories = class
  private
    FDiffFlags: TTextDiffFlags;
    FDiffText2: string;
    FDiffText2OnlySelection: boolean;
    FFileDialogSettings: TFileDialogSettings;
    FFilename: string;
  
    // Find- and replace-history
    FFindHistory: TStringList;
    FFindInFilesSearchOptions: TLazFindInFileSearchOptions;
    FLastConvertDelphiPackage: string;
    FLastConvertDelphiProject: string;
    FLastConvertDelphiUnit: string;
    FReplaceHistory: TStringList;
    FFindInFilesPathHistory: TStringList;
    FFindInFilesMaskHistory: TStringList;
    FMaxFindHistory: Integer;
    
    // Unit dependencies
    FUnitDependenciesHistory: TStringList;
    FMaxUnitDependenciesHistory: integer;
    
    // FPC config cache
    FFPCConfigCache: TFPCConfigCache;

    // various history lists
    FHistoryLists: THistoryLists;
    
    // file encodings
    fFileEncodings: TStringToStringTree;
    
    procedure SetFilename(const AValue: string);
  public
    constructor Create;
    destructor Destroy;  override;
    procedure Clear;
    procedure Load;
    procedure Save;
    procedure LoadFromXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure SaveToXMLConfig(XMLConfig: TXMLConfig; const Path: string);
    procedure SetLazarusDefaultFilename;

    // Find- and replace-history
    function AddToFindHistory(const AFindStr: string): boolean;
    function AddToReplaceHistory(const AReplaceStr: String): boolean;
    function AddToFindInFilesPathHistory(const APathStr: String): boolean;
    function AddToFindInFilesMaskHistory(const AMaskStr: String): boolean;
    // Unit dependencies
    function AddToUnitDependenciesHistory(const ARootFilename: String): boolean;

    function LastFPCUnitLinksValid: boolean;
    function LastFPCUnitLinksNeedsUpdate(const Options, SearchPath,
                                         FPCSrcDir: string): boolean;
    procedure SetLastFPCUnitLinks(const FPCPath, FPCOptions,
                                  SearchPath, FPCSrcDir, UnitLinks: string);
    
    // filedialog
    procedure ApplyFileDialogSettings(DestDialog: TFileDialog);
    procedure StoreFileDialogSettings(SourceDialog: TFileDialog);
    procedure SetFileDialogSettingsInitialDir(const InitialDir: string);
    function SelectDirectory(const Title: string;
                             MustExist: boolean = true;
                             const InitialDir: string = '';
                             const Directory: string = ''): string;
  public
    property Filename: string read FFilename write SetFilename;

    // Find- and replace-history
    property MaxFindHistory: Integer read FMaxFindHistory write FMaxFindHistory;
    property FindHistory: TStringList read FFindHistory write FFindHistory;
    property ReplaceHistory: TStringList read FReplaceHistory write FReplaceHistory;
    property FindInFilesPathHistory: TStringList read FFindInFilesPathHistory
                                                 write FFindInFilesPathHistory;
    property FindInFilesMaskHistory: TStringList read FFindInFilesMaskHistory
                                                 write FFindInFilesMaskHistory;
    property FindInFilesSearchOptions: TLazFindInFileSearchOptions
               read FFindInFilesSearchOptions write FFindInFilesSearchOptions;

    // Unit dependencies
    property UnitDependenciesHistory: TStringList read FUnitDependenciesHistory;
    property MaxUnitDependenciesHistory: integer
      read FMaxUnitDependenciesHistory write FMaxUnitDependenciesHistory;

    // FPC config cache
    property FPCConfigCache: TFPCConfigCache read FFPCConfigCache;

    // filedialogs
    property FileDialogSettings: TFileDialogSettings
      read FFileDialogSettings write FFileDialogSettings;
      
    // various history lists
    property HistoryLists: THistoryLists read FHistoryLists;
    
    // diff dialog
    property DiffFlags: TTextDiffFlags read FDiffFlags write FDiffFlags;
    property DiffText2: string read FDiffText2 write FDiffText2;
    property DiffText2OnlySelection: boolean read FDiffText2OnlySelection
                                             write FDiffText2OnlySelection;

    // Delphi conversion
    property LastConvertDelphiProject: string read FLastConvertDelphiProject
                                              write FLastConvertDelphiProject;
    property LastConvertDelphiPackage: string read FLastConvertDelphiPackage
                                              write FLastConvertDelphiPackage;
    property LastConvertDelphiUnit: string read FLastConvertDelphiUnit
                                           write FLastConvertDelphiUnit;
                                           
    // file encodings
    property FileEncodings: TStringToStringTree read fFileEncodings write fFileEncodings;
  end;

const
  LazFindInFileSearchOptionsDefault = [fifSearchOpen];
  LazFindInFileSearchOptionNames: array[TLazFindInFileSearchOption] of string =(
    'MatchCase',
    'WholeWord',
    'RegExpr',
    'MultiLine',
    'SearchProject',
    'SearchOpen',
    'SearchDirectories',
    'IncludeSubDirs',
    'Replace',
    'ReplaceAll'
    );

var
  InputHistories: TInputHistories = nil;
  

implementation


const
  DefaultHistoryFile = 'inputhistory.xml';
  InputHistoryVersion = 1;
  DefaultDiffFlags = [tdfIgnoreCase,tdfIgnoreEmptyLineChanges,
                      tdfIgnoreLineEnds,tdfIgnoreTrailingSpaces];

{ TInputHistories }

procedure TInputHistories.SetFilename(const AValue: string);
begin
  FFilename:=AValue;
end;

constructor TInputHistories.Create;
begin
  inherited Create;
  FFilename:='';

  // Find- and replace-history
  FMaxFindHistory:=20;
  FFindHistory:=TStringList.Create;
  FReplaceHistory:=TStringList.Create;
  FFindInFilesPathHistory:=TStringList.Create;
  FFindInFilesMaskHistory:=TStringList.Create;
  FFindInFilesSearchOptions:=LazFindInFileSearchOptionsDefault;

  // unit dependencies
  FUnitDependenciesHistory:=TStringList.Create;
  FMaxUnitDependenciesHistory:=20;
  
  // file dialog
  FFileDialogSettings.HistoryList:=TStringList.Create;
  FFileDialogSettings.MaxHistory:=20;
  
  // various history lists
  FHistoryLists:=THistoryLists.Create;
  
  FFPCConfigCache:=TFPCConfigCache.Create;
  
  fFileEncodings:=TStringToStringTree.Create({$IFDEF CaseInsensitiveFilenames}false{$ELSE}true{$ENDIF});
  
  Clear;
end;

destructor TInputHistories.Destroy;
begin
  FreeAndNil(FHistoryLists);
  FreeAndNil(FFileDialogSettings.HistoryList);
  FreeAndNil(FUnitDependenciesHistory);
  FreeAndNil(FFindHistory);
  FreeAndNil(FReplaceHistory);
  FreeAndNil(FFindInFilesPathHistory);
  FreeAndNil(FFindInFilesMaskHistory);
  FreeAndNil(FFPCConfigCache);
  FreeAndNil(fFileEncodings);
  inherited Destroy;
end;

procedure TInputHistories.Clear;
begin
  FHistoryLists.Clear;
  FFindHistory.Clear;
  FReplaceHistory.Clear;
  FFindInFilesPathHistory.Clear;
  FFindInFilesMaskHistory.Clear;
  with FFileDialogSettings do begin
    HistoryList.Clear;
    Width:=0;
    Height:=0;
    InitialDir:='';
  end;
  FDiffFlags:=DefaultDiffFlags;
  FDiffText2:='';
  FDiffText2OnlySelection:=false;
  FFPCConfigCache.Clear;
  FLastConvertDelphiProject:='';
  FLastConvertDelphiUnit:='';
  fFileEncodings.Clear;
end;

procedure TInputHistories.LoadFromXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
var
  DiffFlag: TTextDiffFlag;
  FIFOption: TLazFindInFileSearchOption;
begin
  // Find- and replace-history
  FMaxFindHistory:=XMLConfig.GetValue(Path+'Find/History/Max',FMaxFindHistory);
  LoadRecentList(XMLConfig,FFindHistory,Path+'Find/History/Find/');
  LoadRecentList(XMLConfig,FReplaceHistory,Path+'Find/History/Replace/');
  LoadRecentList(XMLConfig,FFindInFilesPathHistory,Path+
                                            'FindInFiles/History/Paths/');
  LoadRecentList(XMLConfig,FFindInFilesMaskHistory,Path+
                                            'FindInFiles/History/Masks/');
  FFindInFilesSearchOptions:=[];
  for FIFOption:=Low(TLazFindInFileSearchOption)
  to High(TLazFindInFileSearchOption) do begin
    if XMLConfig.GetValue(
      Path+'FindInFiles/Options/'+LazFindInFileSearchOptionNames[FIFOption],
      FIFOption in LazFindInFileSearchOptionsDefault)
    then
      Include(FFindInFilesSearchOptions,FIFOption);
  end;

  // unit dependencies
  LoadRecentList(XMLConfig,FUnitDependenciesHistory,Path+'UnitDependencies/History/');
  // fpc config cache
  FFPCConfigCache.LoadFromXMLConfig(XMLConfig,'FPCConfigCache/');
  // file dialog
  with FFileDialogSettings do begin
    Width:=XMLConfig.GetValue(Path+'FileDialog/Width',0);
    Height:=XMLConfig.GetValue(Path+'FileDialog/Height',0);
    InitialDir:=XMLConfig.GetValue(Path+'FileDialog/InitialDir','');
    MaxHistory:=XMLConfig.GetValue(Path+'FileDialog/MaxHistory',20);
    LoadRecentList(XMLConfig,HistoryList,Path+'FileDialog/HistoryList/');
  end;
  // history lists
  FHistoryLists.LoadFromXMLConfig(XMLConfig,Path+'HistoryLists/');
  // diff dialog
  FDiffFlags:=[];
  for DiffFlag:=Low(TTextDiffFlag) to High(TTextDiffFlag) do begin
    if XMLConfig.GetValue(
      Path+'DiffDialog/Options/'+TextDiffFlagNames[DiffFlag],
      DiffFlag in DefaultDiffFlags)
    then
      Include(FDiffFlags,DiffFlag);
  end;
  FDiffText2:=XMLConfig.GetValue(Path+'DiffDialog/Text2/Name','');
  FDiffText2OnlySelection:=
    XMLConfig.GetValue(Path+'DiffDialog/Text2/OnlySelection',false);
    
  // delphi conversion
  FLastConvertDelphiProject:=XMLConfig.GetValue(Path+'Conversion/Delphi/Project','');
  FLastConvertDelphiPackage:=XMLConfig.GetValue(Path+'Conversion/Delphi/Package','');
  FLastConvertDelphiUnit:=XMLConfig.GetValue(Path+'Conversion/Delphi/Unit','');
end;

procedure TInputHistories.SaveToXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
var
  DiffFlag: TTextDiffFlag;
  FIFOption: TLazFindInFileSearchOption;
begin
  // Find- and replace-history
  XMLConfig.SetDeleteValue(Path+'Find/History/Max',FMaxFindHistory,20);
  SaveRecentList(XMLConfig,FFindHistory,Path+'Find/History/Find/');
  SaveRecentList(XMLConfig,FReplaceHistory,Path+'Find/History/Replace/');
  SaveRecentList(XMLConfig,FFindInFilesPathHistory,Path+
                                            'FindInFiles/History/Paths/');
  SaveRecentList(XMLConfig,FFindInFilesMaskHistory,Path+
                                            'FindInFiles/History/Masks/');
  for FIFOption:=Low(TLazFindInFileSearchOption)
  to High(TLazFindInFileSearchOption) do begin
    XMLConfig.SetDeleteValue(
      Path+'FindInFiles/Options/'+LazFindInFileSearchOptionNames[FIFOption],
      FIFOption in FindInFilesSearchOptions,
      FIFOption in LazFindInFileSearchOptionsDefault);
  end;

  // unit dependencies
  SaveRecentList(XMLConfig,FUnitDependenciesHistory,Path+'UnitDependencies/History/');
  // fpc config cache
  FFPCConfigCache.SaveToXMLConfig(XMLConfig,'FPCConfigCache/');
  // file dialog
  with FFileDialogSettings do begin
    XMLConfig.SetDeleteValue(Path+'FileDialog/Width',Width,0);
    XMLConfig.SetDeleteValue(Path+'FileDialog/Height',Height,0);
    XMLConfig.SetDeleteValue(Path+'FileDialog/InitialDir',InitialDir,'');
    XMLConfig.SetDeleteValue(Path+'FileDialog/MaxHistory',MaxHistory,20);
    SaveRecentList(XMLConfig,HistoryList,Path+'FileDialog/HistoryList/');
  end;
  // history lists
  FHistoryLists.SaveToXMLConfig(XMLConfig,Path+'HistoryLists/');
  // diff dialog
  for DiffFlag:=Low(TTextDiffFlag) to High(TTextDiffFlag) do begin
    XMLConfig.SetDeleteValue(
      Path+'DiffDialog/Options/'+TextDiffFlagNames[DiffFlag],
      DiffFlag in DiffFlags,DiffFlag in DefaultDiffFlags);
  end;
  XMLConfig.SetDeleteValue(Path+'DiffDialog/Text2/Name',FDiffText2,'');
  XMLConfig.SetDeleteValue(Path+'DiffDialog/Text2/OnlySelection',
                           FDiffText2OnlySelection,false);
  // delphi conversion
  XMLConfig.SetDeleteValue(Path+'Conversion/Delphi/Project',
                           FLastConvertDelphiProject,'');
  XMLConfig.SetDeleteValue(Path+'Conversion/Delphi/Package',
                           FLastConvertDelphiPackage,'');
  XMLConfig.SetDeleteValue(Path+'Conversion/Delphi/Unit',
                           FLastConvertDelphiUnit,'');
end;

procedure TInputHistories.SetLazarusDefaultFilename;
var
  ConfFileName: string;
begin
  ConfFileName:=SetDirSeparators(
                             GetPrimaryConfigPath+'/'+DefaultHistoryFile);
  CopySecondaryConfigFile(DefaultHistoryFile);
  FFilename:=ConfFilename;
end;

procedure TInputHistories.Load;
var
  XMLConfig: TXMLConfig;
  //FileVersion: integer;
begin
  try
    XMLConfig:=TXMLConfig.Create(FFileName);
    //FileVersion:=XMLConfig.GetValue('InputHistory/Version/Value',0);
    LoadFromXMLConfig(XMLConfig,'InputHistory/');
    XMLConfig.Free;
  except
    on E: Exception do begin
      DebugLn('[TCodeToolsOptions.Load]  error reading "',FFilename,'" ',E.Message);
    end;
  end;
end;

procedure TInputHistories.Save;
var
  XMLConfig: TXMLConfig;
begin
  try
    InvalidateFileStateCache;
    XMLConfig:=TXMLConfig.CreateClean(FFileName);
    XMLConfig.SetDeleteValue('InputHistory/Version/Value',
      InputHistoryVersion,0);
    SaveToXMLConfig(XMLConfig,'InputHistory/');
    XMLConfig.Flush;
    XMLConfig.Free;
  except
    on E: Exception do begin
      DebugLn('[TInputHistories.Save]  error writing "',FFilename,'" ',E.Message);
    end;
  end;
end;

function TInputHistories.AddToFindHistory(const AFindStr: string): boolean;
begin
  Result:=AddToRecentList(AFindStr,FFindHistory,FMaxFindHistory);
end;

function TInputHistories.AddToReplaceHistory(const AReplaceStr: String): boolean;
begin
  Result:=AddToRecentList(AReplaceStr,FReplaceHistory,FMaxFindHistory);
end;

function TInputHistories.AddToFindInFilesPathHistory(const APathStr: String): boolean;
begin
  Result:= AddToRecentList(APathStr,FFindInFilesPathHistory,FMaxFindHistory);
end;

function TInputHistories.AddToFindInFilesMaskHistory(const AMaskStr: String): boolean;
begin
  Result:= AddToRecentList(AMaskStr,FFindInFilesMaskHistory,FMaxFindHistory);
end;
function TInputHistories.AddToUnitDependenciesHistory(
  const ARootFilename: String): boolean;
begin
  Result:=AddToRecentList(ARootFilename,FUnitDependenciesHistory,
                  FMaxUnitDependenciesHistory);
end;

function TInputHistories.LastFPCUnitLinksValid: boolean;
begin
  Result:=FFPCConfigCache.Valid(false);
end;

function TInputHistories.LastFPCUnitLinksNeedsUpdate(
  const Options, SearchPath, FPCSrcDir: string): boolean;
begin
  Result:=FFPCConfigCache.UnitLinksNeedUpdate(Options,SearchPath,FPCSrcDir);
end;

procedure TInputHistories.SetLastFPCUnitLinks(const FPCPath, FPCOptions,
  SearchPath, FPCSrcDir, UnitLinks: string);
begin
  FFPCConfigCache.CompilerPath:=FPCPath;
  FFPCConfigCache.SetItem(FPCOptions,SearchPath,FPCSrcDir,UnitLinks);
end;

procedure TInputHistories.ApplyFileDialogSettings(DestDialog: TFileDialog);
begin
  DestDialog.InitialDir:=FFileDialogSettings.InitialDir;
  DestDialog.Width:=FFileDialogSettings.Width;
  DestDialog.Height:=FFileDialogSettings.Height;
  
  DestDialog.HistoryList:=FFileDialogSettings.HistoryList;
end;

procedure TInputHistories.StoreFileDialogSettings(SourceDialog: TFileDialog);
var s: string;
begin
  FFileDialogSettings.InitialDir:=SourceDialog.InitialDir;
  FFileDialogSettings.Width:=SourceDialog.Width;
  FFileDialogSettings.Height:=SourceDialog.Height;
  s:=ExtractFilePath(FFileDialogSettings.InitialDir);
  if s<>'' then
    AddToRecentList(s,FFileDialogSettings.HistoryList,
                    FFileDialogSettings.MaxHistory);
end;

procedure TInputHistories.SetFileDialogSettingsInitialDir(const InitialDir: string);
begin
  FFileDialogSettings.InitialDir := InitialDir;
end;

function TInputHistories.SelectDirectory(const Title: string;
  MustExist: boolean; const InitialDir: string;
  const Directory: string): string;
var
  WorkDirectoryDialog: TSelectDirectoryDialog;
begin
  Result:='';
  WorkDirectoryDialog := TSelectDirectoryDialog.Create(nil);
  try
    ApplyFileDialogSettings(WorkDirectoryDialog);
    if MustExist then
      WorkDirectoryDialog.Options:=WorkDirectoryDialog.Options+[ofFileMustExist];
    if InitialDir <> '' then
      WorkDirectoryDialog.InitialDir := InitialDir;
    if Directory<>'' then
      WorkDirectoryDialog.Filename := Directory;
    if WorkDirectoryDialog.Execute then begin
      Result := WorkDirectoryDialog.Filename;
    end;
    InputHistories.StoreFileDialogSettings(WorkDirectoryDialog);
  finally
    WorkDirectoryDialog.Free;
  end;
end;

{ THistoryList }

procedure THistoryList.SetMaxCount(const AValue: integer);
begin
  if FMaxCount=AValue then exit;
  FMaxCount:=AValue;
end;

procedure THistoryList.SetName(const AValue: string);
begin
  if FName=AValue then exit;
  FName:=AValue;
end;

constructor THistoryList.Create;
begin
  FMaxCount:=20;
end;

destructor THistoryList.Destroy;
begin
  inherited Destroy;
end;

function THistoryList.Push(const Entry: string): integer;
begin
  AddToRecentList(Entry,Self,MaxCount);
  Result:=-1;
end;

procedure THistoryList.LoadFromXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
begin
  if FName='' then
    FName:=XMLConfig.GetValue(Path+'Name','');
  FMaxCount:=XMLConfig.GetValue(Path+'MaxCount',MaxCount);
  LoadRecentList(XMLConfig,Self,Path);
end;

procedure THistoryList.SaveToXMLConfig(XMLConfig: TXMLConfig; const Path: string
  );
begin
  XMLConfig.SetDeleteValue(Path+'Name',Name,'');
  XMLConfig.SetDeleteValue(Path+'MaxCount',MaxCount,20);
  SaveRecentList(XMLConfig,Self,Path);
end;

procedure THistoryList.AppendEntry(const Entry: string);
begin
  if (Count<MaxCount) and (IndexOf(Entry)<0) then
    Add(Entry);
end;

{ THistoryLists }

function THistoryLists.GetItems(Index: integer): THistoryList;
begin
  Result:=THistoryList(FItems[Index]);
end;

function THistoryLists.GetXMLListPath(const Path: string; i: integer): string;
begin
  Result:=Path+'List'+IntToStr(i)+'/';
end;

constructor THistoryLists.Create;
begin
  FItems:=TList.Create;
end;

destructor THistoryLists.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

procedure THistoryLists.Clear;
var i: integer;
begin
  for i:=0 to Count-1 do
    Items[i].Free;
  FItems.Clear;
end;

function THistoryLists.Count: integer;
begin
  Result:=FItems.Count;
end;

procedure THistoryLists.LoadFromXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
var
  MergeCount, i: integer;
  CurList: THistoryList;
  ListName, ListPath: string;
begin
  MergeCount:=XMLConfig.GetValue(Path+'Count',0);
  for i:=0 to MergeCount-1 do begin
    ListPath:=GetXMLListPath(Path,i);
    ListName:=XMLConfig.GetValue(ListPath+'Name','');
    if ListName='' then continue;
    CurList:=GetList(ListName,true);
    CurList.LoadFromXMLConfig(XMLConfig,ListPath);
  end;
end;

procedure THistoryLists.SaveToXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
var
  i, CurID: integer;
begin
  XMLConfig.SetDeleteValue(Path+'Count',Count,0);
  CurID:=0;
  for i:=0 to Count-1 do begin
    if Items[i].Count>0 then begin
      Items[i].SaveToXMLConfig(XMLConfig,GetXMLListPath(Path,CurID));
      inc(CurID);
    end;
  end;
end;

function THistoryLists.IndexOfName(const Name: string): integer;
begin
  Result:=Count-1;
  while (Result>=0) and (AnsiCompareText(Items[Result].Name,Name)<>0) do
    dec(Result);
end;

function THistoryLists.GetList(const Name: string;
  CreateIfNotExists: boolean): THistoryList;
var
  i: integer;
begin
  i:=IndexOfName(Name);
  if i>=0 then
    Result:=Items[i]
  else begin
    Result:=THistoryList.Create;
    Result.Name:=Name;
    FItems.Add(Result);
  end;
end;

procedure THistoryLists.Add(const ListName, Entry: string);
begin
  GetList(ListName,true).Push(Entry);
end;

{ TFPCConfigCache }

function TFPCConfigCache.GetCount: integer;
begin
  Result:=FItems.Count;
end;

function TFPCConfigCache.GetItems(Index: integer): TFPCConfigCacheItem;
begin
  Result:=TFPCConfigCacheItem(FItems[Index]);
end;

procedure TFPCConfigCache.SetCompilerPath(const AValue: string);
var
  ResolvedFilename: String;
begin
  if FCompilerPath=AValue then exit;
  Clear;
  FCompilerPath:=AValue;
  ResolvedFilename:=ReadAllLinks(FCompilerPath,false);
  if FileExistsUTF8(ResolvedFilename) then
    FCompilerAge:=FileAgeUTF8(ResolvedFilename)
  else
    FCompilerAge:=-1;
end;

constructor TFPCConfigCache.Create;
begin
  FItems:=TList.Create;
  FCompilerAge:=-1;
end;

destructor TFPCConfigCache.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

procedure TFPCConfigCache.Clear;
var
  i: Integer;
begin
  FCompilerPath:='';
  FCompilerAge:=-1;
  for i:=0 to FItems.Count-1 do Items[i].Free;
  FItems.Clear;
end;

function TFPCConfigCache.FindItem(const Options: string): integer;
begin
  Result:=FItems.Count-1;
  while (Result>=0) and (Options<>Items[Result].Options) do dec(Result);
end;

procedure TFPCConfigCache.SetItem(const Options, SearchPath, FPCSrcDir,
  UnitLinks: string);
var
  i: Integer;
  CurItem: TFPCConfigCacheItem;
begin
  i:=FindItem(Options);
  if i<0 then begin
    CurItem:=TFPCConfigCacheItem.Create;
    FItems.Add(CurItem);
  end else
    CurItem:=Items[i];
  CurItem.Options:=Options;
  CurItem.SearchPath:=SearchPath;
  CurItem.FPCSrcDir:=FPCSrcDir;
  CurItem.UnitLinks:=UnitLinks;
end;

procedure TFPCConfigCache.LoadFromXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
var
  NewCount: Integer;
  i: Integer;
  NewItem: TFPCConfigCacheItem;
  OldCompilerAge: Integer;
  NewCompilerPath: String;
begin
  NewCompilerPath:=XMLConfig.GetValue(Path+'CompilerPath','');
  OldCompilerAge:=FCompilerAge;
  FCompilerAge:=XMLConfig.GetValue(Path+'CompilerDate',-1);
  if FCompilerAge<>OldCompilerAge then Clear;
  CompilerPath:=NewCompilerPath;
  NewCount:=XMLConfig.GetValue(Path+'Items/Count',0);
  for i:=1 to NewCount do begin
    NewItem:=TFPCConfigCacheItem.Create;
    NewItem.LoadFromXMLConfig(XMLConfig,Path+'Item'+IntToStr(i)+'/');
    FItems.Add(NewItem);
  end;
end;

procedure TFPCConfigCache.SaveToXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
var
  i: Integer;
begin
  XMLConfig.SetDeleteValue(Path+'CompilerPath',FCompilerPath,'');
  XMLConfig.SetDeleteValue(Path+'CompilerDate',FCompilerAge,-1);
  XMLConfig.SetDeleteValue(Path+'Items/Count',Count,0);
  for i:=1 to Count do begin
    Items[i-1].SaveToXMLConfig(XMLConfig,Path+'Item'+IntToStr(i)+'/');
  end;
end;

function TFPCConfigCache.Valid(CheckCompiler: boolean): boolean;
var
  ResolvedFilename: String;
begin
  Result:=(FCompilerPath<>'') and (FCompilerAge>=0);
  if Result and CheckCompiler then begin
    ResolvedFilename:=ReadAllLinks(FCompilerPath,false);
    if FileExistsUTF8(ResolvedFilename)
    and (FileAgeUTF8(ResolvedFilename)=FCompilerAge) then
      exit;
    FCompilerAge:=-1;
    Result:=false;
  end;
end;

function TFPCConfigCache.UnitLinksNeedUpdate(const Options, SearchPath,
  FPCSrcDir: string): boolean;
var
  i: Integer;
begin
  Result:=true;
  if not Valid(false) then exit;
  // check if option was already cached
  i:=FindItem(Options);
  if i<0 then exit;
  // check if search path changed
  if Items[i].SearchPath<>SearchPath then exit;
  // check if FPCSrcDir changed
  if Items[i].FPCSrcDir<>FPCSrcDir then exit;
  // check if compiler changed
  if not Valid(true) then exit;
  Result:=false;
end;

function TFPCConfigCache.GetUnitLinks(const Options: string): string;
var
  i: Integer;
begin
  i:=FindItem(Options);
  if i<0 then
    Result:=''
  else
    Result:=Items[i].UnitLinks;
end;

{ TFPCConfigCacheItem }

procedure TFPCConfigCacheItem.LoadFromXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
begin
  Options:=XMLConfig.GetValue(Path+'Options/Value','');
  SearchPath:=LineBreaksToDelimiter(
                            XMLConfig.GetValue(Path+'SearchPath/Value',''),';');
  FPCSrcDir:=XMLConfig.GetValue(Path+'FPCSrcDir/Value','');
  UnitLinks:=XMLConfig.GetValue(Path+'UnitLinks/Value','');
end;

procedure TFPCConfigCacheItem.SaveToXMLConfig(XMLConfig: TXMLConfig;
  const Path: string);
begin
  XMLConfig.SetDeleteValue(Path+'Options/Value',Options,'');
  XMLConfig.SetDeleteValue(Path+'SearchPath/Value',SearchPath,'');
  XMLConfig.SetDeleteValue(Path+'FPCSrcDir/Value',FPCSrcDir,'');
  XMLConfig.SetDeleteValue(Path+'UnitLinks/Value',UnitLinks,'');
end;

initialization
  InputHistories:= nil;


end.

