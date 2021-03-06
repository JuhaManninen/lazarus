{ Copyright (C) 2004

 *****************************************************************************
 *                                                                           *
 *  See the file COPYING.modifiedLGPL.txt, included in this distribution,    *
 *  for details about the copyright.                                         *
 *                                                                           *
 *  This program is distributed in the hope that it will be useful,          *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
 *                                                                           *
 *****************************************************************************

  Author: Mattias Gaertner
  
  Abstract:
    Common IDE dialogs.
}
unit IDEDialogs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Dialogs;

type
  TIDESelectDirectory = function(const Title, InitialDir: string): string of object;
  TInitIDEFileDialog = procedure(AFileDialog: TFileDialog) of object;
  TStoreIDEFileDialog = procedure(AFileDialog: TFileDialog) of object;
  TIDEMessageDialog = function(const aCaption, aMsg: string;
                               DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
                               const HelpKeyword: string = ''): Integer of object;
  TIDEQuestionDialog = function(const aCaption, aMsg: string;
                                DlgType: TMsgDlgType; Buttons: array of const;
                                const HelpKeyword: string = ''): Integer of object;
function LazSelectDirectory(const Title: string; const InitialDir: string = ''
  ): string;

var
  LazIDESelectDirectory: TIDESelectDirectory = nil;// set by the IDE
  InitIDEFileDialog: TInitIDEFileDialog = nil;
  StoreIDEFileDialog: TStoreIDEFileDialog = nil  ;
  IDEMessageDialog: TIDEMessageDialog = nil;
  IDEQuestionDialog: TIDEQuestionDialog = nil;

function IDEMessageDialogAb(const aCaption, aMsg: string;
                   DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
                   ShowAbort: boolean; const HelpKeyword: string = ''): Integer;
function IDEQuestionDialogAb(const aCaption, aMsg: string;
                   DlgType: TMsgDlgType; Buttons: array of const;
                   HideAbort: boolean; const HelpKeyword: string = ''): Integer;


implementation

function LazSelectDirectory(const Title: string; const InitialDir: string
  ): string;
begin
  Result:=LazIDESelectDirectory(Title,InitialDir);
end;

function IDEMessageDialogAb(const aCaption, aMsg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; ShowAbort: boolean; const HelpKeyword: string
  ): Integer;
begin
  if ShowAbort then begin
    // add an abort button for 'Cancel all'
    // and replace a Cancel with Ignore
    Buttons:=Buttons+[mbAbort];
    if mbCancel in Buttons then
      Buttons:=Buttons-[mbCancel]+[mbIgnore];
  end;
  Result:=IDEMessageDialog(aCaption,aMsg,DlgType,Buttons,HelpKeyword);
end;

function IDEQuestionDialogAb(const aCaption, aMsg: string;
  DlgType: TMsgDlgType; Buttons: array of const;
  HideAbort: boolean; const HelpKeyword: string): Integer;
var
  NewButtons: array of TVarRec;
  i: Integer;
  j: Integer;
begin
  SetLength(NewButtons,High(Buttons)-Low(Buttons)+1);
  i:=low(Buttons);
  j:=0;
  while i<=High(Buttons) do begin
    if HideAbort
    and (Buttons[i].VType=vtInteger)
    and (Buttons[i].VInteger=mrAbort) then begin
      // skip abort button
      inc(i);
      // and skip abort caption
      if Buttons[i].VType<>vtInteger then
        inc(i);
    end else begin
      NewButtons[j]:=Buttons[i];
      inc(i);
      inc(j);
    end;
  end;
  SetLength(NewButtons,j);
  Result:=IDEQuestionDialog(aCaption,aMsg,DlgType,NewButtons,HelpKeyword);
end;

end.

