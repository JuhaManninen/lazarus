{  $Id$  }
{
 /***************************************************************************
                             debugmanager.pp
                             ---------------
      TDebugManager controls all debugging related stuff in the IDE.


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
}
unit DebugManager;

{$mode objfpc}{$H+}

interface

{$I ide.inc}
{off $define VerboseDebugger}

uses
{$IFDEF IDE_MEM_CHECK}
  MemCheck,
{$ENDIF}
  Classes, SysUtils, Forms, Controls, Dialogs, Menus, ExtCtrls, FileUtil, LCLProc,
  Laz_XMLCfg,
  { for Get/SetForegroundWindow }
  LCLType, LCLIntf,
  SynEdit, CodeCache, CodeToolManager,
  MenuIntf, IDECommands, LazIDEIntf, ProjectIntf,
  LazConf,
  CompilerOptions, EditorOptions, EnvironmentOpts, ProjectOpts, KeyMapping, SourceEditor,
  ProjectDefs, Project, IDEProcs, InputHistory, Debugger, CmdLineDebugger,
  IDEOptionDefs, LazarusIDEStrConsts,
  MainBar, MainIntf, MainBase, BaseBuildManager,
  SourceMarks,
  DebuggerDlg, Watchesdlg, BreakPointsdlg, BreakPropertyDlg, LocalsDlg, WatchPropertyDlg,
  CallStackDlg, EvaluateDlg, RegistersDlg, AssemblerDlg, DebugOutputForm, ExceptionDlg,
  InspectDlg,
  GDBMIDebugger, SSHGDBMIDebugger, ProcessDebugger,
  BaseDebugManager;


type
  TDebugDialogType = (
    ddtOutput,
    ddtBreakpoints,
    ddtWatches,
    ddtLocals,
    ddtCallStack,
    ddtEvaluate,
    ddtRegisters,
    ddtAssembler,
    ddtInspect
    );

  { TDebugManager }

  TDebugManager = class(TBaseDebugManager)
    procedure BreakAutoContinueTimer(Sender: TObject);
    // Menu events
    procedure mnuViewDebugDialogClick(Sender: TObject);
    procedure mnuResetDebuggerClicked(Sender: TObject);

    // SrcNotebook events
    function OnSrcNotebookAddWatchesAtCursor(Sender: TObject): boolean;

    // Debugger events
    procedure DebuggerBreakPointHit(ADebugger: TDebugger; ABreakPoint: TBaseBreakPoint; var ACanContinue: Boolean);
    procedure DebuggerChangeState(ADebugger: TDebugger; OldState: TDBGState);
    procedure DebuggerCurrentLine(Sender: TObject; const ALocation: TDBGLocationRec);
    procedure DebuggerOutput(Sender: TObject; const AText: String);
    procedure DebuggerException(Sender: TObject;
      const AExceptionType: TDBGExceptionType;
      const AExceptionClass, AExceptionText: String;
      out AContinue: Boolean);

    // Dialog events
    procedure DebugDialogDestroy(Sender: TObject);
  private
    FDebugger: TDebugger;
    FDialogs: array[TDebugDialogType] of TDebuggerDlg;
    FPrevShownWindow: HWND;
    // keep track of the last reported location
    FCurrentLocation: TDBGLocationRec;
    // last hit breakpoint
    FCurrentBreakpoint: TIDEBreakpoint;
    FAutoContinueTimer: TTimer;

    // When a source file is not found, the user can choose one
    // here are all choices stored
    FUserSourceFiles: TStringList;

    // when the debug output log is not open, store the debug log internally
    FHiddenDebugOutputLog: TStringList;

    procedure SetDebugger(const ADebugger: TDebugger);

    // Breakpoint routines
    procedure CreateSourceMarkForBreakPoint(const ABreakpoint: TIDEBreakPoint;
                                            ASrcEdit: TSourceEditor);
    procedure GetSourceEditorForBreakPoint(const ABreakpoint: TIDEBreakPoint;
                                           var ASrcEdit: TSourceEditor);

    // Dialog routines
    procedure ViewDebugDialog(const ADialogType: TDebugDialogType);
    procedure DestroyDebugDialog(const ADialogType: TDebugDialogType);
    procedure InitDebugOutputDlg;
    procedure InitBreakPointDlg;
    procedure InitWatchesDlg;
    procedure InitLocalsDlg;
    procedure InitCallStackDlg;
    procedure InitEvaluateDlg;
    procedure InitRegistersDlg;
    procedure InitAssemblerDlg;
    procedure InitInspectDlg;

    procedure FreeDebugger;
    procedure ResetDebugger;
  protected
    function  GetState: TDBGState; override;
    function  GetCommands: TDBGCommands; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Reset; override;

    procedure ConnectMainBarEvents; override;
    procedure ConnectSourceNotebookEvents; override;
    procedure SetupMainBarShortCuts; override;
    procedure UpdateButtonsAndMenuItems; override;

    procedure LoadProjectSpecificInfo(XMLConfig: TXMLConfig;
                                      Merge: boolean); override;
    procedure SaveProjectSpecificInfo(XMLConfig: TXMLConfig;
                                      Flags: TProjectWriteFlags); override;
    procedure DoRestoreDebuggerMarks(AnUnitInfo: TUnitInfo); override;
    procedure ClearDebugOutputLog;

    function InitDebugger: Boolean; override;

    function DoPauseProject: TModalResult; override;
    function DoStepIntoProject: TModalResult; override;
    function DoStepOverProject: TModalResult; override;
    function DoRunToCursor: TModalResult; override;
    function DoStopProject: TModalResult; override;
    procedure DoToggleCallStack; override;
    procedure ProcessCommand(Command: word; var Handled: boolean); override;

    function RunDebugger: TModalResult; override;
    procedure EndDebugging; override;
    function Evaluate(const AExpression: String;
                      var AResult: String): Boolean; override;
    procedure Inspect(const AExpression: String); override;

    function GetFullFilename(var Filename: string; AskUserIfNotFound: Boolean): Boolean; override;

    function DoCreateBreakPoint(const AFilename: string; ALine: integer;
                                WarnIfNoDebugger: boolean): TModalResult; override;

    function DoDeleteBreakPoint(const AFilename: string;
                                ALine: integer): TModalResult; override;
    function DoDeleteBreakPointAtMark(
                        const ASourceMark: TSourceMark): TModalResult; override;

    function ShowBreakPointProperties(const ABreakpoint: TIDEBreakPoint): TModalresult; override;
    function ShowWatchProperties(const AWatch: TIDEWatch): TModalresult; override;
  end;


implementation


const
  DebugDlgIDEWindow: array[TDebugDialogType] of TNonModalIDEWindow = (
    nmiwDbgOutput,  nmiwBreakPoints, nmiwWatches, nmiwLocals, nmiwCallStack,
    nmiwEvaluate, nmiwRegisters, nmiwAssembler, nmiwInspect
  );

type

  { TManagedBreakPoint }

  TManagedBreakPoint = class(TIDEBreakPoint)
  private
    FMaster: TDBGBreakPoint;
    FSourceMark: TSourceMark;
    procedure OnSourceMarkBeforeFree(Sender: TObject);
    procedure OnSourceMarkCreatePopupMenu(SenderMark: TSourceMark;
                                          const AddMenuItem: TAddMenuItemProc);
    procedure OnSourceMarkGetHint(SenderMark: TSourceMark; var Hint: string);
    procedure OnSourceMarkPositionChanged(Sender: TObject);
    procedure OnToggleEnableMenuItemClick(Sender: TObject);
    procedure OnDeleteMenuItemClick(Sender: TObject);
    procedure OnViewPropertiesMenuItemClick(Sender: TObject);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure DoChanged; override;
    function GetHitCount: Integer; override;
    function GetValid: TValidState; override;
    procedure SetEnabled(const AValue: Boolean); override;
    procedure SetInitialEnabled(const AValue: Boolean); override;
    procedure SetExpression(const AValue: String); override;
    procedure SetSourceMark(const AValue: TSourceMark);
    procedure UpdateSourceMark;
    procedure UpdateSourceMarkImage;
    procedure UpdateSourceMarkLineColor;
  public
    destructor Destroy; override;
    procedure ResetMaster;
    function GetSourceLine: integer; override;
    procedure CopySourcePositionToBreakPoint;
    procedure SetLocation(const ASource: String; const ALine: Integer); override;
    property SourceMark: TSourceMark read FSourceMark write SetSourceMark;
  end;

  TManagedBreakPoints = class(TIDEBreakPoints)
  private
    FMaster: TDBGBreakPoints;
    FManager: TDebugManager;
    procedure SetMaster(const AValue: TDBGBreakPoints);
  protected
    procedure NotifyAdd(const ABreakPoint: TIDEBreakPoint); override;
    procedure NotifyRemove(const ABreakPoint: TIDEBreakPoint); override;
  public
    constructor Create(const AManager: TDebugManager);
    property Master: TDBGBreakPoints read FMaster write SetMaster;
  end;

  TManagedWatch = class(TIDEWatch)
  private
    FMaster: TDBGWatch;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure DoChanged; override;
    function GetValid: TValidState; override;
    function GetValue: String; override;
    procedure SetEnabled(const AValue: Boolean); override;
    procedure SetExpression(const AValue: String); override;
  public
    destructor Destroy; override;
    procedure ResetMaster;
  end;

  { TManagedWatches }

  TManagedWatches = class(TIDEWatches)
  private
    FMaster: TDBGWatches;
    FManager: TDebugManager;
    procedure WatchesChanged(Sender: TObject);
    procedure SetMaster(const AMaster: TDBGWatches);
  protected
    procedure NotifyAdd(const AWatch: TIDEWatch); override;
    procedure NotifyRemove(const AWatch: TIDEWatch); override;
  public
    constructor Create(const AManager: TDebugManager);
    destructor Destroy; override;
    property Master: TDBGWatches read FMaster write SetMaster;
  end;

  { TManagedLocals }

  TManagedLocals = class(TIDELocals)
  private
    FMaster: TDBGLocals;
    procedure LocalsChanged(Sender: TObject);
    procedure SetMaster(const AMaster: TDBGLocals);
  protected
    function GetName(const AnIndex: Integer): String; override;
    function GetValue(const AnIndex: Integer): String; override;
  public
    function Count: Integer; override;
    property Master: TDBGLocals read FMaster write SetMaster;
  end;

  { TManagedLineInfo }

  TManagedLineInfo = class(TIDELineInfo)
  private
    FMaster: TDBGLineInfo;
    procedure LineInfoChanged(const ASender: TObject; const ASource: String);
    procedure SetMaster(const AMaster: TDBGLineInfo);
  protected
    function GetSource(const AnIndex: integer): String; override;
    function GetValue(const AnIndex: Integer; const ALine: Integer): TDbgPtr; override;
  public
    function Count: Integer; override;
    function IndexOf(const ASource: String): integer; override;
    procedure Request(const ASource: String); override;
    property Master: TDBGLineInfo read FMaster write SetMaster;
  end;

  { TManagedRegisters }

  TManagedRegisters = class(TIDERegisters)
  private
    FMaster: TDBGRegisters;
    procedure RegistersChanged(Sender: TObject);
    procedure SetMaster(const AMaster: TDBGRegisters);
  protected
    function GetModified(const AnIndex: Integer): Boolean; override;
    function GetName(const AnIndex: Integer): String; override;
    function GetValue(const AnIndex: Integer): String; override;
  public
    function Count: Integer; override;
    property Master: TDBGRegisters read FMaster write SetMaster;
  end;

  { TManagedCallStack }

  TManagedCallStack = class(TIDECallStack)
  private
    FMaster: TDBGCallStack;
    procedure CallStackChanged(Sender: TObject);
    procedure CallStackClear(Sender: TObject);
    procedure CallStackCurrent(Sender: TObject);
    procedure SetMaster(AMaster: TDBGCallStack);
  protected
    function CheckCount: Boolean; override;
    function GetCurrent: TCallStackEntry; override;
    function InternalGetEntry(AIndex: Integer): TCallStackEntry; override;
    procedure SetCurrent(AValue: TCallStackEntry); override;
  public
    procedure PrepareRange(AIndex, ACount: Integer); override;
    property Master: TDBGCallStack read FMaster write SetMaster;
  end;

  TManagedSignal = class(TIDESignal)
  private
    FMaster: TDBGSignal;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure ResetMaster;
  end;

  { TManagedSignals }

  TManagedSignals = class(TIDESignals)
  private
    FMaster: TDBGSignals;
    FManager: TDebugManager;
    procedure SetMaster(const AValue: TDBGSignals);
  protected
    procedure AddDefault;
  public
    constructor Create(const AManager: TDebugManager);
    procedure Reset; override;
    property Master: TDBGSignals read FMaster write SetMaster;
  end;

  TManagedException = class(TIDEException)
  private
    FMaster: TDBGException;
  protected
    procedure DoChanged; override;
  public
    procedure ResetMaster;
  end;

  { TManagedExceptions }

  TManagedExceptions = class(TIDEExceptions)
  private
    FMaster: TDBGExceptions;
    FManager: TDebugManager;
    procedure SetMaster(const AValue: TDBGExceptions);
  protected
    procedure AddDefault;
    procedure SetIgnoreAll(const AValue: Boolean); override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create(const AManager: TDebugManager);
    procedure AddIfNeeded(AName: string);
    procedure Reset; override;
    property Master: TDBGExceptions read FMaster write SetMaster;
  end;

{ TManagedLineInfo }

procedure TManagedLineInfo.LineInfoChanged(const ASender: TObject; const ASource: String);
begin
  NotifyChange(ASource);
end;

procedure TManagedLineInfo.SetMaster(const AMaster: TDBGLineInfo);
begin
  if FMaster = AMaster then Exit;

  if FMaster <> nil
  then begin
    FMaster.OnChange := nil;
  end;

  FMaster := AMaster;

  if FMaster <> nil
  then begin
    FMaster.OnChange := @LineInfoChanged;
  end;
end;

function TManagedLineInfo.GetSource(const AnIndex: integer): String;
begin
  if Master = nil
  then Result := inherited GetSource(AnIndex)
  else Result := Master.Sources[AnIndex];
end;

function TManagedLineInfo.GetValue(const AnIndex: Integer; const ALine: Integer): TDbgPtr;
begin
  if Master = nil
  then Result := inherited GetValue(AnIndex, ALine)
  else Result := Master.Values[AnIndex, ALine];
end;

function TManagedLineInfo.IndexOf(const ASource: String): integer;
begin
  if Master = nil
  then Result := inherited IndexOf(ASource)
  else Result := Master.IndexOf(ASource);
end;

function TManagedLineInfo.Count: Integer;
begin
  if Master = nil
  then Result := inherited Count
  else Result := Master.Count;
end;

procedure TManagedLineInfo.Request(const ASource: String);
begin
  if Master = nil
  then inherited Request(ASource)
  else Master.Request(ASource);
end;

{ TManagedCallStack }

procedure TManagedCallStack.CallStackChanged(Sender: TObject);
begin
  // Clear it first to force the count update
  Clear;
  NotifyChange;
end;

procedure TManagedCallStack.CallStackClear(Sender: TObject);
begin
  // Don't clear, set it to 0 so there are no entries shown
  SetCount(0);
  NotifyChange;
end;

procedure TManagedCallStack.CallStackCurrent(Sender: TObject);
begin
  NotifyCurrent;
end;

function TManagedCallStack.CheckCount: Boolean;
begin
  Result := Master <> nil;
  if Result
  then SetCount(Master.Count);
end;

function TManagedCallStack.GetCurrent: TCallStackEntry;
begin
  if Master = nil
  then Result := nil
  else Result := Master.Current;
end;

function TManagedCallStack.InternalGetEntry(AIndex: Integer): TCallStackEntry;
begin
  Assert(FMaster <> nil);

  Result := FMaster.Entries[AIndex];
end;

procedure TManagedCallStack.SetCurrent(AValue: TCallStackEntry);
begin
  if Master = nil then Exit;

  Master.Current := AValue;
end;

procedure TManagedCallStack.PrepareRange(AIndex, ACount: Integer);
begin
  if FMaster <> nil
  then FMaster.PrepareRange(AIndex, ACount)
  else inherited PrepareRange(AIndex, ACount);
end;

procedure TManagedCallStack.SetMaster(AMaster: TDBGCallStack);
var
  DoNotify: Boolean;
begin
  if FMaster = AMaster then Exit;

  if FMaster <> nil
  then begin
    FMaster.OnChange := nil;
    FMaster.OnClear := nil;
    FMaster.OnCurrent := nil;
    DoNotify := FMaster.Count <> 0;
  end
  else DoNotify := False;

  FMaster := AMaster;

  if FMaster = nil
  then begin
    SetCount(0);
  end
  else begin
    FMaster.OnChange := @CallStackChanged;
    FMaster.OnClear := @CallStackClear;
    FMaster.OnCurrent := @CallStackCurrent;
    DoNotify := DoNotify or (FMaster.Count <> 0);
  end;

  if DoNotify
  then NotifyChange;
end;

{ TManagedLocals }

procedure TManagedLocals.LocalsChanged(Sender: TObject);
begin
  NotifyChange;
end;

procedure TManagedLocals.SetMaster(const AMaster: TDBGLocals);
var
  DoNotify: Boolean;
begin
  if FMaster = AMaster then Exit;

  if FMaster <> nil
  then begin
    FMaster.OnChange := nil;
    DoNotify := FMaster.Count <> 0;
  end
  else DoNotify := False;

  FMaster := AMaster;

  if FMaster <> nil
  then begin
    FMaster.OnChange := @LocalsChanged;
    DoNotify := DoNotify or (FMaster.Count <> 0);
  end;

  if DoNotify
  then NotifyChange;
end;

function TManagedLocals.GetName(const AnIndex: Integer): String;
begin
  if Master = nil
  then Result := inherited GetName(AnIndex)
  else Result := Master.Names[AnIndex];
end;

function TManagedLocals.GetValue(const AnIndex: Integer): String;
begin
  if Master = nil
  then Result := inherited GetValue(AnIndex)
  else Result := Master.Values[AnIndex];
end;

function TManagedLocals.Count: Integer;
begin
  if Master = nil
  then Result := 0
  else Result := Master.Count;
end;

{ TManagedRegisters }

procedure TManagedRegisters.RegistersChanged(Sender: TObject);
begin
  NotifyChange;
end;

procedure TManagedRegisters.SetMaster(const AMaster: TDBGRegisters);
var
  DoNotify: Boolean;
begin
  if FMaster = AMaster then Exit;

  if FMaster <> nil
  then begin
    FMaster.OnChange := nil;
    DoNotify := FMaster.Count <> 0;
  end
  else DoNotify := False;

  FMaster := AMaster;

  if FMaster <> nil
  then begin
    FMaster.OnChange := @RegistersChanged;
    DoNotify := DoNotify or (FMaster.Count <> 0);
  end;

  if DoNotify
  then NotifyChange;
end;

function TManagedRegisters.GetModified(const AnIndex: Integer): Boolean;
begin
  if Master = nil
  then Result := inherited GetModified(AnIndex)
  else Result := Master.Modified[AnIndex];
end;

function TManagedRegisters.GetName(const AnIndex: Integer): String;
begin
  if Master = nil
  then Result := inherited GetName(AnIndex)
  else Result := Master.Names[AnIndex];
end;

function TManagedRegisters.GetValue(const AnIndex: Integer): String;
begin
  if Master = nil
  then Result := inherited GetValue(AnIndex)
  else Result := Master.Values[AnIndex];
end;

function TManagedRegisters.Count: Integer;
begin
  if Master = nil
  then Result := 0
  else Result := Master.Count;
end;

{ TManagedWatch }

procedure TManagedWatch.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (TManagedWatches(GetOwner).FMaster <> nil)
  and (Dest is TDBGWatch)
  then begin
    Assert(FMaster=nil, 'TManagedWatch.AssignTo already has a master');
    if FMaster<>nil then FMaster.Slave := nil;
    FMaster := TDBGWatch(Dest);
    FMaster.Slave := Self;
  end;
end;

procedure TManagedWatch.DoChanged;
begin
  if (FMaster <> nil)
  and (FMaster.Slave = nil)
  then FMaster := nil;

  inherited DoChanged;
end;

function TManagedWatch.GetValid: TValidState;
begin
  if FMaster = nil
  then Result := inherited GetValid
  else Result := FMaster.Valid;
end;

function TManagedWatch.GetValue: String;
begin
  if FMaster = nil
  then Result := inherited GetValue
  else Result := FMaster.Value;
end;

procedure TManagedWatch.SetEnabled(const AValue: Boolean);
begin
  if Enabled = AValue then Exit;
  inherited SetEnabled(AValue);
  if FMaster <> nil then FMaster.Enabled := AValue;
end;

procedure TManagedWatch.SetExpression(const AValue: String);
begin
  if AValue = Expression then Exit;
  inherited SetExpression(AValue);
  if FMaster <> nil then FMaster.Expression := AValue;
end;

destructor TManagedWatch.Destroy;
begin
  ResetMaster;
  inherited Destroy;
end;

procedure TManagedWatch.ResetMaster;
begin
  if FMaster <> nil then FMaster.Slave := nil;
  FMaster := nil;
end;

{ TManagedWatches }

procedure TManagedWatches.SetMaster(const AMaster: TDBGWatches);
var
  n: Integer;
begin
  if FMaster = AMaster then Exit;

  if FMaster <> nil
  then FMaster.OnChange := nil;

  FMaster := AMaster;
  if FMaster = nil
  then begin
    for n := 0 to Count - 1 do
      TManagedWatch(Items[n]).ResetMaster;
  end
  else begin
    FMaster.Assign(Self);
    FMaster.OnChange := @WatchesChanged;
  end;
end;

procedure TManagedWatches.WatchesChanged(Sender: TObject);
begin
  Changed;
end;

procedure TManagedWatches.NotifyAdd(const AWatch: TIDEWatch);
var
  W: TDBGWatch;
begin
  inherited;

  if FManager.FDebugger <> nil
  then begin
    W := FManager.FDebugger.Watches.Add(AWatch.Expression);
    W.Assign(AWatch);
  end;
end;

procedure TManagedWatches.NotifyRemove(const AWatch: TIDEWatch);
begin
  inherited NotifyRemove(AWatch);
end;

constructor TManagedWatches.Create(const AManager: TDebugManager);
begin
  FMaster := nil;
  FManager := AManager;
  inherited Create(TManagedWatch);
end;

destructor TManagedWatches.Destroy;
begin
  if Master <> nil then FMaster.OnChange := nil;
  inherited Destroy;
end;

{ TManagedException }

procedure TManagedException.DoChanged;
var
  E: TDBGExceptions;
begin
  E := TManagedExceptions(GetOwner).FMaster;
  if ((FMaster = nil) = Enabled) and (E <> nil)
  then begin
    if Enabled then
    begin
      FMaster := E.Find(Name);
      if FMaster = nil then
        FMaster := E.Add(Name);
    end
    else FreeAndNil(FMaster);
  end;

  inherited DoChanged;
end;

procedure TManagedException.ResetMaster;
begin
  FMaster := nil;
end;

{ TManagedExceptions }

constructor TManagedExceptions.Create(const AManager: TDebugManager);
begin
  FMaster := nil;
  FManager := AManager;
  inherited Create(TManagedException);
  AddDefault;
end;

procedure TManagedExceptions.Reset;
begin
  inherited Reset;
  AddDefault;
end;

procedure TManagedExceptions.SetMaster(const AValue: TDBGExceptions);
var
  n: Integer;
  Item: TIDEException;
begin
  if FMaster = AValue then Exit;
  FMaster := AValue;
  if FMaster = nil
  then begin
    for n := 0 to Count - 1 do
      TManagedException(Items[n]).ResetMaster;
  end
  else begin
    // Do not assign, add only enabled exceptions
    for n := 0 to Count - 1 do
    begin
      Item := Items[n];
      if Item.Enabled and (FMaster.Find(Item.Name) = nil)
      then FMaster.Add(Item.Name);
    end;
    FMaster.IgnoreAll := IgnoreAll;
  end;
end;

procedure TManagedExceptions.AddDefault;
begin
  AddIfNeeded('EAbort');
  AddIfNeeded('ECodetoolError');
  AddIfNeeded('EFOpenError');
end;

procedure TManagedExceptions.SetIgnoreAll(const AValue: Boolean);
begin
  inherited SetIgnoreAll(AValue);
  Project1.Modified := True;
end;

procedure TManagedExceptions.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited Notify(Item, Action);
  if Project1 <> nil then
    Project1.Modified := True;
end;

procedure TManagedExceptions.AddIfNeeded(AName: string);
begin
  if Find(AName) = nil then
    Add(AName);
end;

{ TManagedSignal }

procedure TManagedSignal.AssignTo (Dest: TPersistent );
begin
  inherited AssignTo(Dest);
  if (TManagedSignals(GetOwner).FMaster <> nil)
  and (Dest is TDBGSignal)
  then begin
    FMaster := TDBGSignal(Dest);
  end;
end;

procedure TManagedSignal.ResetMaster;
begin
  FMaster := nil;
end;

{ TManagedSignals }

constructor TManagedSignals.Create(const AManager: TDebugManager);
begin
  FMaster := nil;
  FManager := AManager;
  inherited Create(TManagedSignal);
  AddDefault;
end;

procedure TManagedSignals.Reset;
begin
  inherited Reset;
  AddDefault;
end;

procedure TManagedSignals.SetMaster(const AValue: TDBGSignals);
var
  n: Integer;
begin
  if FMaster = AValue then Exit;
  FMaster := AValue;
  if FMaster = nil
  then begin
    for n := 0 to Count - 1 do
      TManagedSignal(Items[n]).ResetMaster;
  end
  else begin
    FMaster.Assign(Self);
  end;
end;

procedure TManagedSignals.AddDefault;
begin
  // todo: add default signals
end;

{ TManagedBreakPoints }

constructor TManagedBreakPoints.Create(const AManager: TDebugManager);
begin
  FMaster := nil;
  FManager := AManager;
  inherited Create(TManagedBreakPoint);
end;

procedure TManagedBreakPoints.SetMaster(const AValue: TDBGBreakPoints);
var
  n: Integer;
begin
  if FMaster = AValue then Exit;

  FMaster := AValue;
  if FMaster = nil
  then begin
    for n := 0 to Count - 1 do
      TManagedBreakPoint(Items[n]).ResetMaster;
  end
  else begin
    FMaster.Assign(Self);
  end;
end;

procedure TManagedBreakPoints.NotifyAdd(const ABreakPoint: TIDEBreakPoint);
var
  BP: TBaseBreakPoint;
begin
{$ifdef VerboseDebugger}
  debugln('TManagedBreakPoints.NotifyAdd A ',ABreakpoint.Source,' ',IntToStr(ABreakpoint.Line));
{$endif}
  ABreakpoint.InitialEnabled := True;
  ABreakpoint.Enabled := True;

  inherited;

  if FManager.FDebugger <> nil
  then begin
    BP := FManager.FDebugger.BreakPoints.Add(ABreakpoint.Source, ABreakpoint.Line);
    BP.Assign(ABreakPoint);
  end;
  FManager.CreateSourceMarkForBreakPoint(ABreakpoint,nil);
  Project1.Modified := True;
end;

procedure TManagedBreakPoints.NotifyRemove(const ABreakPoint: TIDEBreakPoint);
begin
{$ifdef VerboseDebugger}
  debugln(['TManagedBreakPoints.NotifyRemove A ',ABreakpoint.Source,' ',ABreakpoint.Line,' ',TManagedBreakPoint(ABreakpoint).SourceMark <> nil]);
{$endif}

  inherited;
  if FManager.FCurrentBreakpoint = ABreakPoint
  then FManager.FCurrentBreakpoint := nil;

  TManagedBreakPoint(ABreakpoint).SourceMark.Free;

  if Project1 <> nil
  then Project1.Modified := True;
end;


{ TManagedBreakPoint }

procedure TManagedBreakPoint.SetSourceMark(const AValue: TSourceMark);
begin
  if FSourceMark=AValue then exit;
  if FSourceMark<>nil then begin
    FSourceMark.RemoveAllHandlersForObject(Self);
    FSourceMark.Data:=nil;
  end;
  FSourceMark:=AValue;
  if FSourceMark<>nil then begin
    FSourceMark.AddPositionChangedHandler(@OnSourceMarkPositionChanged);
    FSourceMark.AddBeforeFreeHandler(@OnSourceMarkBeforeFree);
    FSourceMark.Data:=Self;
    FSourceMark.IsBreakPoint:=true;
    FSourceMark.Line:=Line;
    FSourceMark.Visible:=true;
    FSourceMark.AddGetHintHandler(@OnSourceMarkGetHint);
    FSourceMark.AddCreatePopupMenuHandler(@OnSourceMarkCreatePopupMenu);
    UpdateSourceMark;
  end;
end;

procedure TManagedBreakPoint.OnSourceMarkPositionChanged(Sender: TObject);
begin
  CopySourcePositionToBreakPoint;
end;

procedure TManagedBreakPoint.OnToggleEnableMenuItemClick(Sender: TObject);
begin
  Enabled:=not Enabled;
  InitialEnabled:=Enabled;
end;

procedure TManagedBreakPoint.OnDeleteMenuItemClick(Sender: TObject);
begin
  Free;
end;

procedure TManagedBreakPoint.OnViewPropertiesMenuItemClick(Sender: TObject);
begin
  DebugBoss.ShowBreakPointProperties(Self);
end;

procedure TManagedBreakPoint.OnSourceMarkBeforeFree(Sender: TObject);
begin
  SourceMark:=nil;
end;

procedure TManagedBreakPoint.OnSourceMarkGetHint(SenderMark: TSourceMark;
  var Hint: string);
begin
  Hint:=GetBreakPointStateDescription(Self)+LineEnding
      +'Hitcount: '+IntToStr(Hitcount)+LineEnding
      +'Action: '+GetBreakPointActionsDescription(Self)+LineEnding
      +'Condition: '+Expression;
end;

procedure TManagedBreakPoint.OnSourceMarkCreatePopupMenu(
  SenderMark: TSourceMark; const AddMenuItem: TAddMenuItemProc);
begin
  if Enabled then
    AddMenuItem('Disable Breakpoint',true,@OnToggleEnableMenuItemClick)
  else
    AddMenuItem('Enable Breakpoint',true,@OnToggleEnableMenuItemClick);
  AddMenuItem('Delete Breakpoint',true,@OnDeleteMenuItemClick);
  AddMenuItem('View Breakpoint Properties',true,@OnViewPropertiesMenuItemClick);
  // add separator
  AddMenuItem('-',true,nil);
end;

procedure TManagedBreakPoint.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (TManagedBreakPoints(GetOwner).FMaster <> nil)
  and (Dest is TDBGBreakPoint)
  then begin
    Assert(FMaster=nil, 'TManagedBreakPoint.AssignTO already has Master');
    if FMaster <> nil then FMaster.Slave := nil;
    FMaster := TDBGBreakPoint(Dest);
    FMaster.Slave := Self;
  end;
end;

destructor TManagedBreakPoint.Destroy;
begin
  if FMaster <> nil
  then begin
    FMaster.Slave := nil;
    FreeAndNil(FMaster);
  end;
  inherited Destroy;
end;

procedure TManagedBreakPoint.DoChanged;
begin
  if (FMaster <> nil)
  and (FMaster.Slave = nil)
  then FMaster := nil;

  inherited DoChanged;
  UpdateSourceMark;
end;

function TManagedBreakPoint.GetHitCount: Integer;
begin
  if FMaster = nil
  then Result := 0
  else Result := FMaster.HitCount;
end;

function TManagedBreakPoint.GetValid: TValidState;
begin
  if FMaster = nil
  then Result := vsUnknown
  else Result := FMaster.Valid;
end;

procedure TManagedBreakPoint.ResetMaster;
begin
  if FMaster <> nil then FMaster.Slave := nil;
  FMaster := nil;
  Changed;
end;

function TManagedBreakPoint.GetSourceLine: integer;
begin
  if FSourceMark<>nil then
    Result:=FSourceMark.Line
  else
    Result:=inherited GetSourceLine;
end;

procedure TManagedBreakPoint.CopySourcePositionToBreakPoint;
begin
  if FSourceMark=nil then exit;
  SetLocation(Source,FSourceMark.Line);
end;

procedure TManagedBreakPoint.SetEnabled(const AValue: Boolean);
begin
  if Enabled = AValue then exit;
  inherited SetEnabled(AValue);
  if FMaster <> nil then FMaster.Enabled := AValue;
end;

procedure TManagedBreakPoint.SetInitialEnabled(const AValue: Boolean);
begin
  if InitialEnabled = AValue then exit;
  inherited SetInitialEnabled(AValue);
  if FMaster <> nil then FMaster.InitialEnabled := AValue;
end;

procedure TManagedBreakPoint.SetExpression(const AValue: String);
begin
  if AValue=Expression then exit;
  inherited SetExpression(AValue);
  if FMaster <> nil then FMaster.Expression := AValue;
end;

procedure TManagedBreakPoint.SetLocation(const ASource: String;
  const ALine: Integer);
begin
  if (Source = ASource) and (Line = ALine) then exit;
  inherited SetLocation(ASource, ALine);
  if FMaster<>nil then FMaster.SetLocation(ASource,ALine);
  if Project1 <> nil
  then Project1.Modified := True;
end;

procedure TManagedBreakPoint.UpdateSourceMarkImage;
var
  Img: Integer;
begin
  if SourceMark = nil then Exit;
  case Valid of
    vsValid:
      if Enabled then
        Img := SourceEditorMarks.ActiveBreakPointImg
      else
        Img := SourceEditorMarks.InactiveBreakPointImg;
    vsInvalid:
      Img := SourceEditorMarks.InvalidBreakPointImg;
    else
      Img := SourceEditorMarks.UnknownBreakPointImg;
  end;
  SourceMark.ImageIndex := Img;
end;

procedure TManagedBreakPoint.UpdateSourceMarkLineColor;
var
  aha: TAdditionalHilightAttribute;
begin
  if SourceMark = nil then Exit;
  aha := ahaNone;
  case Valid of
    vsValid:
      if Enabled then
        aha := ahaEnabledBreakpoint
      else
        aha := ahaDisabledBreakpoint;
    vsInvalid:
      aha := ahaInvalidBreakpoint;
    else
      aha := ahaUnknownBreakpoint;
  end;
  SourceMark.LineColorAttrib := aha;
end;

procedure TManagedBreakPoint.UpdateSourceMark;
begin
  UpdateSourceMarkImage;
  UpdateSourceMarkLineColor;
end;


//-----------------------------------------------------------------------------
// Menu events
//-----------------------------------------------------------------------------

function TDebugManager.GetFullFilename(var Filename: string; AskUserIfNotFound: Boolean): Boolean;
var
  SrcFile: String;
  n: Integer;
  UserFilename: string;
  OpenDialog: TOpenDialog;
  AnUnitInfo: TLazProjectFile;
begin
  Result:=False;
  if Destroying then exit;

  // some debuggers (e.g. gdb) sometimes returns linux path delims under windows
  // => fix that
  Filename := TrimFilename(Filename);
  SrcFile := Filename;
  SrcFile := MainIDE.FindSourceFile(SrcFile, Project1.ProjectDirectory,
                      [fsfSearchForProject, fsfUseIncludePaths, fsfUseDebugPath]);
  if SrcFile = '' then SrcFile := Filename;

  if not FilenameIsAbsolute(SrcFile)
  then begin
    // first attempt to get a longer name
    // short file, look in the user list
    for n := 0 to FUserSourceFiles.Count - 1 do
    begin
      UserFilename := FUserSourceFiles[n];
      if CompareFileNames(ExtractFilenameOnly(SrcFile),
        ExtractFilenameOnly(UserFilename)) = 0
      then begin
        if FileExistsUTF8(UserFilename)
        then begin
          FUserSourceFiles.Move(n, 0); // move most recent first
          SrcFile := UserFilename;
          Break;
        end;
      end;
    end;
  end;

  if not FilenameIsAbsolute(SrcFile) then
  begin
    AnUnitInfo := Project1.FindFile(SrcFile, [pfsfOnlyEditorFiles]);
    if AnUnitInfo <> nil then
    begin
      // the file is an unsaved file -> can not be extended
      Result := True;
      Exit;
    end;
  end;

  if ((not FilenameIsAbsolute(SrcFile)) or (not FileExistsUTF8(SrcFile)))
  and AskUserIfNotFound
  then begin

    if MessageDlg(lisFileNotFound,
      Format(lisTheFileWasNotFoundDoYouWantToLocateItYourself, ['"',
        SrcFile, '"', #13, #13, #13])
      ,mtConfirmation, [mbYes, mbNo], 0) <> mrYes
    then Exit;

    repeat
      OpenDialog:=TOpenDialog.Create(nil);
      try
        InputHistories.ApplyFileDialogSettings(OpenDialog);
        OpenDialog.Title:=lisOpenFile+' '+SrcFile;
        OpenDialog.Options:=OpenDialog.Options+[ofFileMustExist];
        OpenDialog.FileName := SrcFile;
        if not OpenDialog.Execute then
          exit;
        SrcFile:=CleanAndExpandFilename(OpenDialog.FileName);
        InputHistories.StoreFileDialogSettings(OpenDialog);
      finally
        OpenDialog.Free;
      end;
    until FilenameIsAbsolute(SrcFile) and FileExistsUTF8(SrcFile);

    FUserSourceFiles.Insert(0, SrcFile);
  end;

  if SrcFile<>''
  then begin
    Filename:=SrcFile;
    Result:=True;
  end;
end;

procedure TDebugManager.BreakAutoContinueTimer(Sender: TObject);
begin
  FAutoContinueTimer.Enabled := False;
  FDebugger.Run;
end;

procedure TDebugManager.DebuggerBreakPointHit(ADebugger: TDebugger;
  ABreakPoint: TBaseBreakPoint; var ACanContinue: Boolean);
begin
  FCurrentBreakPoint := nil;
  if FBreakPoints = nil then Exit;
  if ABreakpoint = nil then Exit;
  if ACanContinue then Exit;

  FCurrentBreakPoint := FBreakPoints.Find(ABreakPoint.Source, ABreakPoint.SourceLine);
end;

procedure TDebugManager.mnuViewDebugDialogClick(Sender: TObject);
begin
  ViewDebugDialog(TDebugDialogType((Sender as TIDEMenuItem).Tag));
end;

procedure TDebugManager.mnuResetDebuggerClicked(Sender: TObject);
begin
  ResetDebugger;
end;


//-----------------------------------------------------------------------------
// ScrNoteBook events
//-----------------------------------------------------------------------------

function TDebugManager.OnSrcNotebookAddWatchesAtCursor(Sender : TObject
  ): boolean;
var
  SE: TSourceEditor;
  WatchVar: String;
begin
  Result:=false;

  // get the sourceEditor.
  SE := TSourceNotebook(Sender).GetActiveSE;
  if not Assigned(SE) then Exit;
  WatchVar := SE.GetWordAtCurrentCaret;
  if WatchVar = ''  then Exit;

  if (Watches.Find(WatchVar) = nil)
  and (Watches.Add(WatchVar) = nil)
  then Exit;

  Result:=true;
end;

//-----------------------------------------------------------------------------
// Debugger events
//-----------------------------------------------------------------------------

procedure TDebugManager.DebuggerException(Sender: TObject;
  const AExceptionType: TDBGExceptionType;
  const AExceptionClass, AExceptionText: String;
  out AContinue: Boolean);

  function GetTitle: String;
  begin
    Result := Project1.Title;
    if Result = '' then
      Result := ExtractFileName(FDebugger.FileName);
  end;

var
  ExceptMsg: string;
  msg: String;
  Ignore: Boolean;
begin
  if Destroying then
  begin
    AContinue := True;
    Exit;
  end
  else
    AContinue := False;

  if AExceptionText = ''
  then
    msg := Format('Project %s raised exception class ''%s''.',
                  [GetTitle, AExceptionClass])
  else begin
    ExceptMsg := AExceptionText;
    // if AExceptionText is not a valid UTF8 string,
    // then assume it has the ansi encoding and convert it
    if FindInvalidUTF8Character(pchar(ExceptMsg),length(ExceptMsg), False) > 0 then
      ExceptMsg := AnsiToUtf8(ExceptMsg);
    msg := Format('Project %s raised exception class ''%s'' with message:%s%s',
                  [GetTitle, AExceptionClass, #13, ExceptMsg]);
  end;

  if AExceptionType <> deInternal then
    MessageDlg('Error', msg, mtError, [mbOk], 0)
  else
  begin
    AContinue := ExecuteExceptionDialog(msg, Ignore) = mrCancel;
    if Ignore then
      TManagedExceptions(Exceptions).AddIfNeeded(AExceptionClass);
  end;
end;

procedure TDebugManager.DebuggerOutput(Sender: TObject; const AText: String);
begin
  if Destroying then exit;
  if FDialogs[ddtOutput] <> nil then
    TDbgOutputForm(FDialogs[ddtOutput]).AddText(AText)
  else begin
    // store it internally, and copy it to the dialog, when the user opens it
    if fHiddenDebugOutputLog=nil then
      fHiddenDebugOutputLog:=TStringList.Create;
    fHiddenDebugOutputLog.Add(AText);
    while fHiddenDebugOutputLog.Count>100 do
      fHiddenDebugOutputLog.Delete(0);
  end;
end;

procedure TDebugManager.DebuggerChangeState(ADebugger: TDebugger;
  OldState: TDBGState);
const
  // dsNone, dsIdle, dsStop, dsPause, dsInit, dsRun, dsError
  TOOLSTATEMAP: array[TDBGState] of TIDEToolStatus = (
    // dsNone, dsIdle, dsStop, dsPause, dsInit,     dsRun,      dsError
    itNone, itNone, itNone, itDebugger, itDebugger, itDebugger, itDebugger
  );
  //STATENAME: array[TDBGState] of string = (
  //  'dsNone', 'dsIdle', 'dsStop', 'dsPause', 'dsInit', 'dsRun', 'dsError'
  //);
var
  Editor: TSourceEditor;
begin
  if (ADebugger<>FDebugger) or (ADebugger=nil) then
    RaiseException('TDebugManager.OnDebuggerChangeState');

  if Destroying or (MainIDE=nil) or (MainIDE.ToolStatus=itExiting) then
    exit;

  if FDebugger.State=dsError
  then begin
    Include(FManagerStates,dmsDebuggerObjectBroken);
    if dmsInitializingDebuggerObject in FManagerStates
    then Include(FManagerStates,dmsInitializingDebuggerObjectFailed);
  end;

  //DebugLn('[TDebugManager.OnDebuggerChangeState] state: ', STATENAME[FDebugger.State]);

  // All conmmands
  // -------------------
  // dcRun, dcPause, dcStop, dcStepOver, dcStepInto, dcRunTo, dcJumpto, dcBreak, dcWatch
  // -------------------

  UpdateButtonsAndMenuItems;
  if MainIDE.ToolStatus in [itNone,itDebugger]
  then MainIDE.ToolStatus := TOOLSTATEMAP[FDebugger.State];

  FAutoContinueTimer.Enabled := false;
  if (FDebugger.State in [dsRun])
  then begin
    // hide IDE during run
    if EnvironmentOptions.HideIDEOnRun and (MainIDE.ToolStatus=itDebugger)
    then MainIDE.HideIDE;

    if FPrevShownWindow <> 0 then
    begin
      SetForegroundWindow(FPrevShownWindow);
      FPrevShownWindow := 0;
    end;
    FCurrentBreakPoint := nil;
  end
  else begin
    if (FCurrentBreakPoint <> nil) and (FCurrentBreakPoint.AutoContinueTime > 0) then
    begin
      FAutoContinueTimer.Enabled := True;
      FAutoContinueTimer.Interval := FCurrentBreakPoint.AutoContinueTime;
    end
    else if (OldState in [dsRun]) then
    begin
      MainIDE.UnhideIDE;
      FPrevShownWindow := GetForegroundWindow;
      Application.BringToFront;
    end;
  end;

  // unmark execution line
  if (FDebugger.State <> dsPause) and (SourceNotebook <> nil)
  then begin
    Editor := SourceNotebook.GetActiveSE;
    if Editor <> nil
    then Editor.ExecutionLine := -1;
  end;

  if ((FDebugger.State = dsPause) or
      ((FDebugger.State = dsRun) and (OldState = dsInit))
     ) and (SourceNotebook <> nil)
  then begin
    Editor := SourceNotebook.GetActiveSE;
    if (Editor <> nil) and not Editor.HasExecutionMarks
    then Editor.FillExecutionMarks;
  end;

  if not (FDebugger.State in [dsRun, dsPause]) and (SourceNotebook <> nil) then
    SourceNotebook.ClearExecutionMarks;

  case FDebugger.State of
    dsError: begin
    {$ifdef VerboseDebugger}
      DebugLn('Ooops, the debugger entered the error state');
    {$endif}
      MessageDlg(lisDebuggerError,
        Format(lisDebuggerErrorOoopsTheDebuggerEnteredTheErrorState, [#13#13,
          #13, #13#13]),
        mtError, [mbOK],0);
    end;
    dsStop: begin
      if (OldState<>dsIdle)
      then begin
        if EnvironmentOptions.DebuggerShowStopMessage
        then begin
          MessageDlg(lisExecutionStopped,
            Format(lisExecutionStoppedOn, [#13#13]), mtInformation, [mbOK],0);
        end;
        FDebugger.FileName := '';

        if FDialogs[ddtAssembler] <> nil
        then TAssemblerDlg(FDialogs[ddtAssembler]).SetLocation(nil, 0);
      end;
    end;
  end;
end;

procedure TDebugManager.DebuggerCurrentLine(Sender: TObject; const ALocation: TDBGLocationRec);
// debugger paused program due to pause or error
// -> show the current execution line in editor
// if SrcLine < 1 then no source is available
var
  SrcFile: String;
  NewSource: TCodeBuffer;
  Editor: TSourceEditor;
  SrcLine: Integer;
  i: Integer;
  StackEntry: TCallStackEntry;
  FocusEditor: Boolean;
begin
  if (Sender<>FDebugger) or (Sender=nil) then exit;
  if Destroying then exit;

  FCurrentLocation := ALocation;
  SrcFile := ALocation.SrcFile;
  SrcLine := ALocation.SrcLine;

  if SrcLine < 1
  then begin
    ViewDebugDialog(ddtAssembler);

    if FDialogs[ddtAssembler] = nil
    then begin
      // TODO: change into assemblerview failure
      MessageDlg(lisExecutionPaused,
        Format(lisExecutionPausedAdress, [#13#13,
          HexStr(ALocation.Address, FDebugger.TargetWidth div 4), #13,
          ALocation.FuncName, #13, ALocation.SrcFile, #13#13#13, #13]),
        mtInformation, [mbOK],0);

      // jump to the deepest stack frame with debugging info
      i:=0;
      while (i < FDebugger.CallStack.Count) do
      begin
        StackEntry := FDebugger.CallStack.Entries[i];
        if StackEntry.Line > 0
        then begin
          SrcLine := StackEntry.Line;
          SrcFile := StackEntry.Source;
          StackEntry.Current := True;
          Break;
        end;
        Inc(i);
      end;
      if SrcLine < 1 then Exit;
    end;
  end;

  if FDialogs[ddtAssembler] <> nil
  then begin
    TAssemblerDlg(FDialogs[ddtAssembler]).SetLocation(FDebugger, Alocation.Address);
    if SrcLine < 1 then Exit;
  end;

  if not GetFullFilename(SrcFile, true) then exit;

  NewSource := CodeToolBoss.LoadFile(SrcFile, true, false);
  if NewSource = nil
  then begin
    MessageDlg(lisDebugUnableToLoadFile,
      Format(lisDebugUnableToLoadFile2, ['"', SrcFile, '"']),
      mtError,[mbCancel],0);
    Exit;
  end;

  // clear old error and execution lines
  if SourceNotebook <> nil
  then begin
    SourceNotebook.ClearExecutionLines;
    SourceNotebook.ClearErrorLines;
  end;
  // jump editor to execution line
  FocusEditor := (FCurrentBreakPoint = nil) or (FCurrentBreakPoint.AutoContinueTime = 0);
  if MainIDE.DoJumpToCodePos(nil,nil,NewSource,1,SrcLine,-1,true, FocusEditor)<>mrOk
  then exit;

  // mark execution line
  if SourceNotebook <> nil
  then Editor := SourceNotebook.GetActiveSE
  else Editor := nil;

  if Editor <> nil
  then begin
    if not Editor.HasExecutionMarks then
      Editor.FillExecutionMarks;
    Editor.ExecutionLine := SrcLine;
  end;
end;

//-----------------------------------------------------------------------------
// Debugger dialog routines
//-----------------------------------------------------------------------------

// Common handler
// The tag of the destroyed form contains the form variable pointing to it
procedure TDebugManager.DebugDialogDestroy(Sender: TObject);
var
  DlgType: TDebugDialogType;
begin
  for DlgType:=Low(TDebugDialogType) to High(TDebugDialogType) do begin
    if FDialogs[DlgType]<>Sender then continue;
    case DlgType of
    ddtOutput:
      begin
        if fHiddenDebugOutputLog=nil then
          fHiddenDebugOutputLog:=TStringList.Create;
        TDbgOutputForm(FDialogs[ddtOutput]).GetLogText(fHiddenDebugOutputLog);
      end;
    end;
    FDialogs[DlgType]:=nil;
    exit;
  end;
  RaiseException('Invalid debug window '+Sender.ClassName);
end;

procedure TDebugManager.ViewDebugDialog(const ADialogType: TDebugDialogType);
const
  DEBUGDIALOGCLASS: array[TDebugDialogType] of TDebuggerDlgClass = (
    TDbgOutputForm, TBreakPointsDlg, TWatchesDlg, TLocalsDlg, TCallStackDlg,
    TEvaluateDlg, TRegistersDlg, TAssemblerDlg, TIDEInspectDlg
  );
var
  CurDialog: TDebuggerDlg;
begin
  if Destroying then exit;
  if FDialogs[ADialogType] = nil
  then begin
    FDialogs[ADialogType] := DEBUGDIALOGCLASS[ADialogType].Create(Self);
    CurDialog:=FDialogs[ADialogType];
    CurDialog.Name:=NonModalIDEWindowNames[DebugDlgIDEWindow[ADialogType]];
    CurDialog.Tag := Integer(ADialogType);
    CurDialog.OnDestroy := @DebugDialogDestroy;
    EnvironmentOptions.IDEWindowLayoutList.Apply(CurDialog,CurDialog.Name);
    case ADialogType of
      ddtOutput:      InitDebugOutputDlg;
      ddtBreakpoints: InitBreakPointDlg;
      ddtWatches:     InitWatchesDlg;
      ddtLocals:      InitLocalsDlg;
      ddtRegisters:   InitRegistersDlg;
      ddtCallStack:   InitCallStackDlg;
      ddtEvaluate:    InitEvaluateDlg;
      ddtAssembler:   InitAssemblerDlg;
      ddtInspect:     InitInspectDlg;
    end;
  end
  else begin
    CurDialog:=FDialogs[ADialogType];
    if (CurDialog is TBreakPointsDlg)
    then begin
      if (Project1<>nil) then
        TBreakPointsDlg(CurDialog).BaseDirectory:=Project1.ProjectDirectory;
    end;
  end;
  if (CurDialog is tEvaluateDlg) and  (sourceNotebook<>nil)
  then begin
    if SourceNotebook.GetActiveSE.SelectionAvailable then
      TEvaluateDlg(CurDialog).FindText := SourceNotebook.GetActiveSE.Selection
    else
      TEvaluateDlg(CurDialog).FindText := SourceNotebook.GetActiveSE.GetWordAtCurrentCaret;
  end;
  FDialogs[ADialogType].Show;
end;

procedure TDebugManager.DestroyDebugDialog(const ADialogType: TDebugDialogType);
begin
  if FDialogs[ADialogType] = nil then Exit;
  FDialogs[ADialogType].OnDestroy := nil;
  FDialogs[ADialogType].Free;
  FDialogs[ADialogType] := nil;
end;

procedure TDebugManager.InitDebugOutputDlg;
var
  TheDialog: TDbgOutputForm;
begin
  TheDialog := TDbgOutputForm(FDialogs[ddtOutput]);
  if FHiddenDebugOutputLog <> nil
  then begin
    TheDialog.SetLogText(FHiddenDebugOutputLog);
    FreeAndNil(FHiddenDebugOutputLog);
  end;
end;

procedure TDebugManager.InitBreakPointDlg;
var
  TheDialog: TBreakPointsDlg;
begin
  TheDialog:=TBreakPointsDlg(FDialogs[ddtBreakpoints]);
  if Project1 <> nil
  then TheDialog.BaseDirectory := Project1.ProjectDirectory;
  TheDialog.BreakPoints := FBreakPoints;
end;

procedure TDebugManager.InitWatchesDlg;
var
  TheDialog: TWatchesDlg;
begin
  TheDialog := TWatchesDlg(FDialogs[ddtWatches]);
  TheDialog.Watches := FWatches;
end;

procedure TDebugManager.InitLocalsDlg;
var
  TheDialog: TLocalsDlg;
begin
  TheDialog := TLocalsDlg(FDialogs[ddtLocals]);
  TheDialog.Locals := FLocals;
end;

procedure TDebugManager.InitRegistersDlg;
var
  TheDialog: TRegistersDlg;
begin
  TheDialog := TRegistersDlg(FDialogs[ddtRegisters]);
  TheDialog.Registers := FRegisters;
end;

procedure TDebugManager.InitAssemblerDlg;
var
  TheDialog: TAssemblerDlg;
begin
  TheDialog := TAssemblerDlg(FDialogs[ddtAssembler]);
  TheDialog.SetLocation(FDebugger, FCurrentLocation.Address);
end;

procedure TDebugManager.InitInspectDlg;
var
  TheDialog: TIDEInspectDlg;
begin
  TheDialog := TIDEInspectDlg(FDialogs[ddtInspect]);
  TheDialog.Execute(FDebugger, nil, nil, nil);
end;

procedure TDebugManager.InitCallStackDlg;
var
  TheDialog: TCallStackDlg;
begin
  TheDialog := TCallStackDlg(FDialogs[ddtCallStack]);
  TheDialog.CallStack := FCallStack;
  TheDialog.BreakPoints := FBreakPoints;
end;

procedure TDebugManager.InitEvaluateDlg;
begin
  // todo: pass current selection
end;

constructor TDebugManager.Create(TheOwner: TComponent);
var
  DialogType: TDebugDialogType;
begin
  for DialogType := Low(TDebugDialogType) to High(TDebugDialogType) do
    FDialogs[DialogType] := nil;

  FDebugger := nil;
  FBreakPoints := TManagedBreakPoints.Create(Self);
  FBreakPointGroups := TIDEBreakPointGroups.Create;
  FWatches := TManagedWatches.Create(Self);
  FExceptions := TManagedExceptions.Create(Self);
  FSignals := TManagedSignals.Create(Self);
  FLocals := TManagedLocals.Create;
  FLineInfo := TManagedLineInfo.Create;
  FCallStack := TManagedCallStack.Create;
  FRegisters := TManagedRegisters.Create;

  FUserSourceFiles := TStringList.Create;

  FAutoContinueTimer := TTimer.Create(Self);
  FAutoContinueTimer.Enabled := False;
  FAutoContinueTimer.OnTimer := @BreakAutoContinueTimer;

  inherited Create(TheOwner);
end;

destructor TDebugManager.Destroy;
var
  DialogType: TDebugDialogType;
begin
  FDestroying := true;

  FreeAndNil(FAutoContinueTimer);

  for DialogType := Low(TDebugDialogType) to High(TDebugDialogType) do
    DestroyDebugDialog(DialogType);

  SetDebugger(nil);

  FreeAndNil(FWatches);
  FreeAndNil(FBreakPoints);
  FreeAndNil(FBreakPointGroups);
  FreeAndNil(FCallStack);
  FreeAndNil(FExceptions);
  FreeAndNil(FSignals);
  FreeAndNil(FLocals);
  FreeAndNil(FLineInfo);
  FreeAndNil(FRegisters);

  FreeAndNil(FUserSourceFiles);
  FreeAndNil(FHiddenDebugOutputLog);

  inherited Destroy;
end;

procedure TDebugManager.Reset;
begin
  FBreakPoints.Clear;
  FBreakPointGroups.Clear;
  FWatches.Clear;
  FExceptions.Reset;
  FSignals.Reset;
  FUserSourceFiles.Clear;
end;

procedure TDebugManager.ConnectMainBarEvents;
begin
  with MainIDEBar do begin
    itmViewWatches.OnClick := @mnuViewDebugDialogClick;
    itmViewWatches.Tag := Ord(ddtWatches);
    itmViewBreakPoints.OnClick := @mnuViewDebugDialogClick;
    itmViewBreakPoints.Tag := Ord(ddtBreakPoints);
    itmViewLocals.OnClick := @mnuViewDebugDialogClick;
    itmViewLocals.Tag := Ord(ddtLocals);
    itmViewRegisters.OnClick := @mnuViewDebugDialogClick;
    itmViewRegisters.Tag := Ord(ddtRegisters);
    itmViewCallStack.OnClick := @mnuViewDebugDialogClick;
    itmViewCallStack.Tag := Ord(ddtCallStack);
    itmViewAssembler.OnClick := @mnuViewDebugDialogClick;
    itmViewAssembler.Tag := Ord(ddtAssembler);
    itmViewDebugOutput.OnClick := @mnuViewDebugDialogClick;
    itmViewDebugOutput.Tag := Ord(ddtOutput);

    itmRunMenuResetDebugger.OnClick := @mnuResetDebuggerClicked;

//    itmRunMenuInspect.OnClick := @mnuViewDebugDialogClick;
    itmRunMenuEvaluate.OnClick := @mnuViewDebugDialogClick;
    itmRunMenuEvaluate.Tag := Ord(ddtEvaluate);
//    itmRunMenuAddWatch.OnClick := @;
//    itmRunMenuAddBpSource.OnClick := @;
  end;
end;

procedure TDebugManager.ConnectSourceNotebookEvents;
begin
  SourceNotebook.OnAddWatchAtCursor := @OnSrcNotebookAddWatchesAtCursor;
end;

procedure TDebugManager.SetupMainBarShortCuts;

  function GetCommand(ACommand: word): TIDECommand;
  begin
    Result:=IDECommandList.FindIDECommand(ACommand);
  end;

begin
  with MainIDEBar do
  begin
    itmViewWatches.Command:=GetCommand(ecToggleWatches);
    itmViewBreakpoints.Command:=GetCommand(ecToggleBreakPoints);
    itmViewDebugOutput.Command:=GetCommand(ecToggleDebuggerOut);
    itmViewLocals.Command:=GetCommand(ecToggleLocals);
    itmViewRegisters.Command:=GetCommand(ecToggleRegisters);
    itmViewCallStack.Command:=GetCommand(ecToggleCallStack);
    itmViewAssembler.Command:=GetCommand(ecToggleAssembler);


    itmRunMenuInspect.Command:=GetCommand(ecInspect);
    itmRunMenuEvaluate.Command:=GetCommand(ecEvaluate);
    itmRunMenuAddWatch.Command:=GetCommand(ecAddWatch);
  end;
end;

procedure TDebugManager.UpdateButtonsAndMenuItems;
var
  DebuggerInvalid: boolean;
begin
  if (MainIDE=nil) or (MainIDE.ToolStatus = itExiting)
  then exit;

  DebuggerInvalid:=(FDebugger=nil) or (MainIDE.ToolStatus<>itDebugger);
  with MainIDEBar do begin
    // For 'run' and 'step' bypass 'idle', so we can set the filename later
    RunSpeedButton.Enabled := DebuggerInvalid
                 or (dcRun in FDebugger.Commands) or (FDebugger.State = dsIdle);
    itmRunMenuRun.Enabled := RunSpeedButton.Enabled;
    PauseSpeedButton.Enabled := (not DebuggerInvalid)
                                and (dcPause in FDebugger.Commands);
    itmRunMenuPause.Enabled := PauseSpeedButton.Enabled;
    StepIntoSpeedButton.Enabled := DebuggerInvalid
            or (dcStepInto in FDebugger.Commands) or (FDebugger.State = dsIdle);
    itmRunMenuStepInto.Enabled := StepIntoSpeedButton.Enabled;
    StepOverSpeedButton.Enabled := DebuggerInvalid or
              (dcStepOver in FDebugger.Commands)  or (FDebugger.State = dsIdle);
    itmRunMenuStepOver.Enabled := StepOverSpeedButton.Enabled;

    itmRunMenuRunToCursor.Enabled := DebuggerInvalid
                                     or (dcRunTo in FDebugger.Commands);
    itmRunMenuStop.Enabled := not DebuggerInvalid;
    StopSpeedButton.Enabled := itmRunMenuStop.Enabled;

    itmRunMenuEvaluate.Enabled := (not DebuggerInvalid)
                              and (dcEvaluate in FDebugger.Commands);
    // TODO: add other debugger menuitems
    // TODO: implement by actions
  end;
end;

{------------------------------------------------------------------------------
  procedure TDebugManager.LoadProjectSpecificInfo(XMLConfig: TXMLConfig;
                                  Merge: boolean);

  Called when the main project is loaded from the XMLConfig.
------------------------------------------------------------------------------}
procedure TDebugManager.LoadProjectSpecificInfo(XMLConfig: TXMLConfig;
  Merge: boolean);
begin
  if Merge then begin
    // keep it simple: just load from the session and don't merge
  end;
  FBreakPointGroups.LoadFromXMLConfig(XMLConfig,
                                     'Debugging/'+XMLBreakPointGroupsNode+'/');
  FBreakPoints.LoadFromXMLConfig(XMLConfig,'Debugging/'+XMLBreakPointsNode+'/',
                                 @Project1.LongenFilename,
                                 @FBreakPointGroups.GetGroupByName);
  FWatches.LoadFromXMLConfig(XMLConfig,'Debugging/'+XMLWatchesNode+'/');
  FExceptions.LoadFromXMLConfig(XMLConfig,'Debugging/'+XMLExceptionsNode+'/');
end;

{------------------------------------------------------------------------------
  procedure TDebugManager.SaveProjectSpecificInfo(XMLConfig: TXMLConfig;
                                   Flags: TProjectWriteFlags);

  Called when the main project is saved to an XMLConfig.
------------------------------------------------------------------------------}
procedure TDebugManager.SaveProjectSpecificInfo(XMLConfig: TXMLConfig;
  Flags: TProjectWriteFlags);
begin
  if not (pwfDoNotSaveSessionInfo in Flags) then begin
    FBreakPointGroups.SaveToXMLConfig(XMLConfig,
                                      'Debugging/'+XMLBreakPointGroupsNode+'/');
    FBreakPoints.SaveToXMLConfig(XMLConfig,'Debugging/'+XMLBreakPointsNode+'/',
                                 @Project1.ShortenFilename);
    FWatches.SaveToXMLConfig(XMLConfig,'Debugging/'+XMLWatchesNode+'/');
    FExceptions.SaveToXMLConfig(XMLConfig,'Debugging/'+XMLExceptionsNode+'/');
  end;
end;

procedure TDebugManager.DoRestoreDebuggerMarks(AnUnitInfo: TUnitInfo);
var
  ASrcEdit: TSourceEditor;
  i: Integer;
  CurBreakPoint: TIDEBreakPoint;
  SrcFilename: String;
begin
  if (AnUnitInfo.EditorIndex < 0) or Destroying then exit;
  ASrcEdit := SourceNotebook.Editors[AnUnitInfo.EditorIndex];
  // set breakpoints for this unit
  SrcFilename:=AnUnitInfo.Filename;
  for i := 0 to FBreakpoints.Count-1 do
  begin
    CurBreakPoint := FBreakpoints[i];
    if CompareFileNames(CurBreakPoint.Source, SrcFilename) = 0 then
      CreateSourceMarkForBreakPoint(CurBreakPoint, ASrcEdit);
  end;
end;

procedure TDebugManager.CreateSourceMarkForBreakPoint(
  const ABreakpoint: TIDEBreakPoint; ASrcEdit: TSourceEditor);
var
  ManagedBreakPoint: TManagedBreakPoint;
  NewSrcMark: TSourceMark;
begin
  if not (ABreakpoint is TManagedBreakPoint) then
    RaiseException('TDebugManager.CreateSourceMarkForBreakPoint');
  ManagedBreakPoint:=TManagedBreakPoint(ABreakpoint);

  if (ManagedBreakPoint.SourceMark<>nil) or Destroying then exit;
  if ASrcEdit=nil then
    GetSourceEditorForBreakPoint(ManagedBreakPoint,ASrcEdit);
  if ASrcEdit=nil then exit;
  NewSrcMark:=TSourceMark.Create(ASrcEdit.EditorComponent,nil);
  ManagedBreakPoint.SourceMark:=NewSrcMark;
  SourceEditorMarks.Add(NewSrcMark);
  ASrcEdit.EditorComponent.Marks.Add(NewSrcMark);
end;

procedure TDebugManager.GetSourceEditorForBreakPoint(
  const ABreakpoint: TIDEBreakPoint; var ASrcEdit: TSourceEditor);
var
  Filename: String;
begin
  Filename:=ABreakpoint.Source;
  if Filename<>'' then
    ASrcEdit:=SourceNotebook.FindSourceEditorWithFilename(ABreakpoint.Source)
  else
    ASrcEdit:=nil;
end;

procedure TDebugManager.ClearDebugOutputLog;
begin
  if FDialogs[ddtOutput] <> nil then
    TDbgOutputForm(FDialogs[ddtOutput]).Clear
  else if fHiddenDebugOutputLog<>nil then
    fHiddenDebugOutputLog.Clear;
end;

//-----------------------------------------------------------------------------
// Debugger routines
//-----------------------------------------------------------------------------

procedure TDebugManager.FreeDebugger;
var
  dbg: TDebugger;
begin
  dbg := FDebugger;
  SetDebugger(nil);
  dbg.Free;
  FManagerStates := [];

  if MainIDE.ToolStatus = itDebugger
  then MainIDE.ToolStatus := itNone;
end;

procedure TDebugManager.ResetDebugger;
var
  OldState: TDBGState;
begin
  OldState := State;
  if OldState = dsNone then Exit;

  EndDebugging;
//  OnDebuggerChangeState(FDebugger, OldState);
//  InitDebugger;
end;

function TDebugManager.InitDebugger: Boolean;
var
  LaunchingCmdLine, LaunchingApplication, LaunchingParams: String;
  NewWorkingDir: String;
  DebuggerClass: TDebuggerClass;
begin
{$ifdef VerboseDebugger}
  DebugLn('[TDebugManager.DoInitDebugger] A');
{$endif}

  Result := False;
  if (Project1.MainUnitID < 0) or Destroying then Exit;

  DebuggerClass := FindDebuggerClass(EnvironmentOptions.DebuggerClass);
  if DebuggerClass = nil then
    DebuggerClass := TProcessDebugger;

  LaunchingCmdLine := BuildBoss.GetRunCommandLine;

  SplitCmdLine(LaunchingCmdLine, LaunchingApplication, LaunchingParams);

  if BuildBoss.GetProjectUsesAppBundle then
  begin
    // it is Application Bundle (darwin only)

    if not DirectoryExistsUTF8(LaunchingApplication) then
    begin
      if MessageDlg(lisLaunchingApplicationInvalid,
        Format(lisTheLaunchingApplicationBundleDoesNotExists,
          [LaunchingCmdLine, #13, #13, #13, #13]),
        mtError, [mbYes, mbNo, mbCancel], 0) = mrYes then
      begin
        if not CreateProjectApplicationBundle(Project1) then Exit;
      end
      else
        Exit;
    end;

    if DebuggerClass = TProcessDebugger then
    begin // use executable path inside Application Bundle (darwin only)
      LaunchingApplication := LaunchingApplication + '/Contents/MacOS/' +
        ExtractFileNameOnly(LaunchingApplication);
      LaunchingParams := LaunchingParams;
    end;
  end
  else
    if not FileIsExecutable(LaunchingApplication)
    then begin
      MessageDlg(lisLaunchingApplicationInvalid,
        Format(lisTheLaunchingApplicationDoesNotExistsOrIsNotExecuta, ['"',
          LaunchingCmdLine, '"', #13, #13, #13]),
        mtError, [mbOK],0);
      Exit;
    end;

  //todo: this check depends on the debugger class
  if (DebuggerClass <> TProcessDebugger)
  and not FileIsExecutable(EnvironmentOptions.DebuggerFilename)
  then begin
    MessageDlg(lisDebuggerInvalid,
      Format(lisTheDebuggerDoesNotExistsOrIsNotExecutableSeeEnviro, ['"',
        EnvironmentOptions.DebuggerFilename, '"', #13, #13, #13]),
      mtError,[mbOK],0);
    Exit;
  end;

  if (dmsDebuggerObjectBroken in FManagerStates)
  then FreeDebugger;

  // check if debugger is already created with the right type
  if (FDebugger <> nil)
  and (not (FDebugger is DebuggerClass)
        or (FDebugger.ExternalDebugger <> EnvironmentOptions.DebuggerFilename)
      )
  then begin
    // the current debugger is the wrong type -> free it
    FreeDebugger;
  end;

  // create debugger object
  if FDebugger = nil
  then SetDebugger(DebuggerClass.Create(EnvironmentOptions.DebuggerFilename));

  if FDebugger = nil
  then begin
    // something went wrong
    Exit;
  end;

  ClearDebugOutputLog;

  FDebugger.OnBreakPointHit := @DebuggerBreakPointHit;
  FDebugger.OnState         := @DebuggerChangeState;
  FDebugger.OnCurrent       := @DebuggerCurrentLine;
  FDebugger.OnDbgOutput     := @DebuggerOutput;
  FDebugger.OnException     := @DebuggerException;

  if FDebugger.State = dsNone
  then begin
    Include(FManagerStates,dmsInitializingDebuggerObject);
    Exclude(FManagerStates,dmsInitializingDebuggerObjectFailed);
    FDebugger.Init;
    Exclude(FManagerStates,dmsInitializingDebuggerObject);
    if dmsInitializingDebuggerObjectFailed in FManagerStates
    then begin
      FreeDebugger;
      Exit;
    end;
  end;

  Project1.RunParameterOptions.AssignEnvironmentTo(FDebugger.Environment);
  NewWorkingDir:=Project1.RunParameterOptions.WorkingDirectory;
  if (NewWorkingDir<>'') and (not DirectoryExistsUTF8(NewWorkingDir)) then begin
    MessageDlg(lisUnableToRun,
      Format(lisTheWorkingDirectoryDoesNotExistPleaseCheckTheWorki, ['"',
        NewWorkingDir, '"', #13]),
      mtError,[mbCancel],0);
    exit;
  end;
  if NewWorkingDir='' then begin
    NewWorkingDir:=ExtractFilePath(BuildBoss.GetProjectTargetFilename(Project1));
    if (NewWorkingDir<>'') and (not DirectoryExistsUTF8(NewWorkingDir)) then begin
      MessageDlg(lisUnableToRun,
        Format(lisTheDestinationDirectoryDoesNotExistPleaseCheckTheP, ['"',
          NewWorkingDir, '"', #13]),
        mtError,[mbCancel],0);
      exit;
    end;
  end;
  FDebugger.WorkingDir:=CleanAndExpandDirectory(NewWorkingDir);
  // set filename after workingdir
  FDebugger.FileName := LaunchingApplication;
  FDebugger.Arguments := LaunchingParams;
  FDebugger.ShowConsole := not Project1.CompilerOptions.Win32GraphicApp;

  // check if debugging needs restart
  // mwe: can this still happen ?
  if (dmsDebuggerObjectBroken in FManagerStates)
  then begin
    FreeDebugger;
    Exit;
  end;

  Result := True;
{$ifdef VerboseDebugger}
  DebugLn('[TDebugManager.DoInitDebugger] END');
{$endif}
end;

// still part of main, should go here when processdebugger is finished
//
//function TDebugManager.DoRunProject: TModalResult;

function TDebugManager.DoPauseProject: TModalResult;
begin
  Result := mrCancel;
  if (MainIDE.ToolStatus <> itDebugger)
  or (FDebugger = nil) or Destroying
  then Exit;
  FDebugger.Pause;
  Result := mrOk;
end;

function TDebugManager.DoStepIntoProject: TModalResult;
begin
  if (MainIDE.DoInitProjectRun <> mrOK)
  or (MainIDE.ToolStatus <> itDebugger)
  or (FDebugger = nil) or Destroying
  then begin
    Result := mrAbort;
    Exit;
  end;

  FDebugger.StepInto;
  Result := mrOk;
end;

function TDebugManager.DoStepOverProject: TModalResult;
begin
  if (MainIDE.DoInitProjectRun <> mrOK)
  or (MainIDE.ToolStatus <> itDebugger)
  or (FDebugger = nil) or Destroying
  then begin
    Result := mrAbort;
    Exit;
  end;

  FDebugger.StepOver;
  Result := mrOk;
end;

function TDebugManager.DoStopProject: TModalResult;
begin
  Result := mrCancel;
  SourceNotebook.ClearExecutionLines;
  if (MainIDE.ToolStatus=itDebugger) and (FDebugger<>nil) and (not Destroying)
  then begin
    FDebugger.Stop;
  end;
  if (dmsDebuggerObjectBroken in FManagerStates) then begin
    if (MainIDE.ToolStatus=itDebugger) then
      MainIDE.ToolStatus:=itNone;
  end;
  Result := mrOk;
end;

procedure TDebugManager.DoToggleCallStack;
begin
  ViewDebugDialog(ddtCallStack);
end;

procedure TDebugManager.ProcessCommand(Command: word; var Handled: boolean);
begin
  //debugln('TDebugManager.ProcessCommand ',dbgs(Command));
  Handled:=true;
  case Command of
  ecPause:             DoPauseProject;
  ecStepInto:          DoStepIntoProject;
  ecStepOver:          DoStepOverProject;
  ecRunToCursor:       DoRunToCursor;
  ecStopProgram:       DoStopProject;
  ecResetDebugger:     ResetDebugger;
  ecToggleCallStack:   DoToggleCallStack;
  ecEvaluate:          ViewDebugDialog(ddtEvaluate);
  ecToggleWatches:     ViewDebugDialog(ddtWatches);
  ecToggleBreakPoints: ViewDebugDialog(ddtBreakpoints);
  ecToggleDebuggerOut: ViewDebugDialog(ddtOutput);
  ecToggleLocals:      ViewDebugDialog(ddtLocals);
  else
    Handled:=false;
  end;
end;

function TDebugManager.RunDebugger: TModalResult;
begin
{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.RunDebugger A ',DbgS(FDebugger<>nil),' Destroying=',DbgS(Destroying));
{$endif}
  Result:=mrCancel;
  if Destroying then exit;
  if (FDebugger <> nil) then
  begin
  {$ifdef VerboseDebugger}
    DebugLn('TDebugManager.RunDebugger B ',FDebugger.ClassName);
  {$endif}
    // check if debugging needs restart
    if (dmsDebuggerObjectBroken in FManagerStates)
    and (MainIDE.ToolStatus=itDebugger) then begin
      MainIDE.ToolStatus:=itNone;
      Result:=mrCancel;
      exit;
    end;
    FDebugger.Run;
    Result:=mrOk;
  end;
end;

procedure TDebugManager.EndDebugging;
begin
  if FDebugger <> nil then FDebugger.Done;
  // if not already freed
  FreeDebugger;
end;

function TDebugManager.Evaluate(const AExpression: String;
  var AResult: String): Boolean;
begin
  Result := (not Destroying)
        and (MainIDE.ToolStatus = itDebugger)
        and (FDebugger <> nil)
        and (dcEvaluate in FDebugger.Commands)
        and FDebugger.Evaluate(AExpression, AResult)
end;

procedure TDebugManager.Inspect(const AExpression: String);
begin
  if Destroying then Exit;
  ViewDebugDialog(ddtInspect);
  if FDialogs[ddtInspect] <> nil then
  begin
    // todo: fill data, properties, methods
    TIDEInspectDlg(FDialogs[ddtInspect]).Execute(FDebugger, nil, nil, nil);
  end;
end;

function TDebugManager.DoCreateBreakPoint(const AFilename: string;
  ALine: integer; WarnIfNoDebugger: boolean): TModalResult;
begin
  if WarnIfNoDebugger
  and ((FindDebuggerClass(EnvironmentOptions.DebuggerClass)=nil)
    or (not FileIsExecutable(EnvironmentOptions.DebuggerFilename)))
  then begin
    if QuestionDlg(lisDbgMangNoDebuggerSpecified,
      Format(lisDbgMangThereIsNoDebuggerSpecifiedSettingBreakpointsHaveNo, [#13]
        ),
      mtWarning, [mrCancel, mrIgnore, lisDbgMangSetTheBreakpointAnyway], 0)
      <>mrIgnore
    then
      exit;
  end;

  FBreakPoints.Add(AFilename, ALine);
  Result := mrOK
end;

function TDebugManager.DoDeleteBreakPoint(const AFilename: string;
  ALine: integer): TModalResult;
var
  OldBreakPoint: TIDEBreakPoint;
begin
  OldBreakPoint:=FBreakPoints.Find(AFilename,ALine);
  if OldBreakPoint=nil then exit(mrOk);
  OldBreakPoint.Free;
  Project1.Modified:=true;
  Result := mrOK
end;

function TDebugManager.DoDeleteBreakPointAtMark(const ASourceMark: TSourceMark
  ): TModalResult;
var
  OldBreakPoint: TIDEBreakPoint;
begin
  // consistency check
  if (ASourceMark=nil) or (not ASourceMark.IsBreakPoint)
  or (ASourceMark.Data=nil) or (not (ASourceMark.Data is TIDEBreakPoint)) then
    RaiseException('TDebugManager.DoDeleteBreakPointAtMark');

{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.DoDeleteBreakPointAtMark A ',ASourceMark.GetFilename,
    ' ',IntToStr(ASourceMark.Line));
{$endif}
  OldBreakPoint:=TIDEBreakPoint(ASourceMark.Data);
{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.DoDeleteBreakPointAtMark B ',OldBreakPoint.ClassName,
    ' ',OldBreakPoint.Source,' ',IntToStr(OldBreakPoint.Line));
{$endif}
  OldBreakPoint.Free;
  Project1.Modified:=true;
  Result := mrOK
end;

function TDebugManager.DoRunToCursor: TModalResult;
var
  ActiveSrcEdit: TSourceEditor;
  ActiveUnitInfo: TUnitInfo;
  UnitFilename: string;
begin
{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.DoRunToCursor A');
{$endif}
  if (MainIDE.DoInitProjectRun <> mrOK)
  or (MainIDE.ToolStatus <> itDebugger)
  or (FDebugger = nil) or Destroying
  then begin
    Result := mrAbort;
    Exit;
  end;
{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.DoRunToCursor B');
{$endif}

  Result := mrCancel;

  MainIDE.GetCurrentUnitInfo(ActiveSrcEdit,ActiveUnitInfo);
  if (ActiveSrcEdit=nil) or (ActiveUnitInfo=nil)
  then begin
    MessageDlg(lisRunToFailed, lisPleaseOpenAUnitBeforeRun, mtError,
      [mbCancel],0);
    Result := mrCancel;
    Exit;
  end;

  if not ActiveUnitInfo.Source.IsVirtual
  then UnitFilename:=ActiveUnitInfo.Filename
  else UnitFilename:=BuildBoss.GetTestUnitFilename(ActiveUnitInfo);

{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.DoRunToCursor C');
{$endif}
  FDebugger.RunTo(ExtractFilename(UnitFilename),
                  ActiveSrcEdit.EditorComponent.CaretY);

{$ifdef VerboseDebugger}
  DebugLn('TDebugManager.DoRunToCursor D');
{$endif}
  Result := mrOK;
end;

function TDebugManager.GetState: TDBGState;
begin
  if FDebugger = nil
  then Result := dsNone
  else Result := FDebugger.State;
end;

function TDebugManager.GetCommands: TDBGCommands;
begin
  if FDebugger = nil
  then Result := []
  else Result := FDebugger.Commands;
end;

function TDebugManager.ShowBreakPointProperties(const ABreakpoint: TIDEBreakPoint): TModalresult;
begin
  Result := TBreakPropertyDlg.Create(Self, ABreakpoint).ShowModal;
end;

function TDebugManager.ShowWatchProperties(const AWatch: TIDEWatch): TModalresult;
begin
  Result := TWatchPropertyDlg.Create(Self, AWatch).ShowModal;
end;

procedure TDebugManager.SetDebugger(const ADebugger: TDebugger);
begin
  if FDebugger = ADebugger then Exit;
  FDebugger := ADebugger;
  if FDebugger = nil
  then begin
    TManagedBreakpoints(FBreakpoints).Master := nil;
    TManagedWatches(FWatches).Master := nil;
    TManagedLocals(FLocals).Master := nil;
    TManagedLineInfo(FLineInfo).Master := nil;
    TManagedCallStack(FCallStack).Master := nil;
    TManagedExceptions(FExceptions).Master := nil;
    TManagedSignals(FSignals).Master := nil;
    TManagedRegisters(FRegisters).Master := nil;
  end
  else begin
    TManagedBreakpoints(FBreakpoints).Master := FDebugger.BreakPoints;
    TManagedWatches(FWatches).Master := FDebugger.Watches;
    TManagedLocals(FLocals).Master := FDebugger.Locals;
    TManagedLineInfo(FLineInfo).Master := FDebugger.LineInfo;
    TManagedCallStack(FCallStack).Master := FDebugger.CallStack;
    TManagedExceptions(FExceptions).Master := FDebugger.Exceptions;
    TManagedSignals(FSignals).Master := FDebugger.Signals;
    TManagedRegisters(FRegisters).Master := FDebugger.Registers;
  end;
end;

end.


