{ PropertyEditor

  Copyright (C) <year> <name of author> <contact>

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}
unit SynPropertyEditObjectList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLProc,
  SynGutterBase, SynEditMiscClasses,
  LResources, PropEdits, Forms, StdCtrls, ComCtrls, Dialogs,
  ObjInspStrConsts, Controls, IDEImagesIntf, typinfo;

type

  { TSynPropertEditClassList }

  TSynPropertyEditObjectList = class(TListPropertyEditor)
  protected
    function ReadElementCount: integer; override;
    function ReadElement(Index: integer): TPersistent; override;
    function ClassList: TStringList; virtual; abstract;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    class function ShowClassListEditor(AClassList: TSynObjectList;
      OwnerPersistent: TPersistent; const PropName: String): TCustomForm;
  end;

  { TSynPropertyEditGutterPartList }

  TSynPropertyEditGutterPartList = class(TSynPropertyEditObjectList)
  protected
    function ClassList: TStringList; override;
  end;

  { TSynObjectPartListPropertyEditorForm }

  TSynObjectPartListPropertyEditorForm = class(TForm)
    SynObjectPartsListBox: TListBox;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    ClassComboBox: TComboBox;
    DeleteButton: TToolButton;
    ToolButton3: TToolButton;
    MoveUpButton: TToolButton;
    MoveDownButton: TToolButton;
    procedure AddButtonClick(Sender: TObject);
    procedure SynObjectPartsListBoxClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure MoveUpButtonClick(Sender: TObject);
  private
    FSynObjectPartList: TSynObjectList;
    FOwnerPersistent: TPersistent;
    FPropertyName: String;
    FClassesList: TStringList;
  protected
    procedure UpdateCaption;
    procedure UpdateButtons;
    procedure ComponentRenamed(AComponent: TComponent);
    procedure PersistentDeleting(APersistent: TPersistent);
    procedure RefreshPropertyValues;
  public
    procedure FillSynObjectPartsListBox;
    procedure SelectInObjectInspector(UnselectAll: Boolean);
    procedure SetSynObjectPartList(NewSynObjectPartList: TSynObjectList;
                    NewClassesList: TStringList;
                    NewOwnerPersistent: TPersistent; const NewPropName: String);
    procedure Modified;
  public
    property SynObjectPartList: TSynObjectList read FSynObjectPartList;
    property OwnerPersistent: TPersistent read FOwnerPersistent;
    property PropertyName: String read FPropertyName;
  end;

  procedure RegisterGutterPartClass(AClass: TSynGutterPartBaseClass; AName: String);
implementation

const
  SynObjectPartListForm: TSynObjectPartListPropertyEditorForm = nil;
  KnownSynGutterPartClasses: TStringList = nil;

procedure RegisterGutterPartClass(AClass: TSynGutterPartBaseClass; AName: String);
begin
  if KnownSynGutterPartClasses = nil then
    KnownSynGutterPartClasses := TStringList.Create;
  KnownSynGutterPartClasses.AddObject(AName, TObject(Pointer(AClass)));
end;

{ TSynObjectPartListPropertyEditorForm }

procedure TSynObjectPartListPropertyEditorForm.AddButtonClick(Sender: TObject);
var
  i: Integer;
begin
  if (SynObjectPartList = nil) or (FClassesList = nil) then Exit;

  i := ClassComboBox.ItemIndex;
  if (i < 0) or (i >= FClassesList.Count) then
    exit;
  TSynObjectListItemClass(Pointer(FClassesList.Objects[i])).Create(SynObjectPartList);

  FillSynObjectPartsListBox;
  if SynObjectPartsListBox.Items.Count > 0 then
    SynObjectPartsListBox.ItemIndex := SynObjectPartsListBox.Items.Count - 1;
  SelectInObjectInspector(False);
  UpdateButtons;
  UpdateCaption;
  Modified;
end;

procedure TSynObjectPartListPropertyEditorForm.SynObjectPartsListBoxClick(Sender: TObject);
begin
  UpdateButtons;
  UpdateCaption;
  SelectInObjectInspector(False);
end;

procedure TSynObjectPartListPropertyEditorForm.DeleteButtonClick(Sender: TObject);
var
  I : Integer;
  NewItemIndex: Integer;
begin
  if SynObjectPartList = nil then Exit;

  I := SynObjectPartsListBox.ItemIndex;
  if (I >= 0) and (I < SynObjectPartList.Count) then
  begin
    if MessageDlg(oisConfirmDelete,
      Format(oisDeleteItem, ['"', SynObjectPartList.BaseItems[I].DisplayName, '"']),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // select other item, or unselect
      NewItemIndex := I + 1;
      while (NewItemIndex < SynObjectPartsListBox.Items.Count)
      and (SynObjectPartsListBox.Selected[NewItemIndex]) do Inc(NewItemIndex);

      if NewItemIndex = SynObjectPartsListBox.Items.Count then
      begin
        NewItemIndex := 0;
        while (NewItemIndex < Pred(I))
        and not (SynObjectPartsListBox.Selected[NewItemIndex]) do Inc(NewItemIndex);

        if NewItemIndex = I then NewItemIndex := -1;
      end;

      SynObjectPartsListBox.ItemIndex := -1;

      if NewItemIndex > I then Dec(NewItemIndex);
      // unselect all items in OI
      SelectInObjectInspector(True);
      // now delete
      SynObjectPartList.BaseItems[I].Free;
      // update listbox after whatever happened
      FillSynObjectPartsListBox;
      // set NewItemIndex
      if NewItemIndex < SynObjectPartsListBox.Items.Count then
      begin
        SynObjectPartsListBox.ItemIndex := NewItemIndex;
        SelectInObjectInspector(False);
      end;
      Modified;
    end;
  end;
  UpdateButtons;
  UpdateCaption;
end;

procedure TSynObjectPartListPropertyEditorForm.FormCreate(Sender: TObject);
begin
  ToolBar1.Images := IDEImages.Images_16;
  AddButton.Caption := oiColEditAdd;
  DeleteButton.Caption := oiColEditDelete;
  MoveUpButton.Caption := oiColEditUp;
  MoveDownButton.Caption := oiColEditDown;
  AddButton.ImageIndex := IDEImages.LoadImage(16, 'laz_add');
  DeleteButton.ImageIndex := IDEImages.LoadImage(16, 'laz_delete');
  MoveUpButton.ImageIndex := IDEImages.LoadImage(16, 'arrow_up');
  MoveDownButton.ImageIndex := IDEImages.LoadImage(16, 'arrow_down');
end;

procedure TSynObjectPartListPropertyEditorForm.FormDestroy(Sender: TObject);
begin
  if GlobalDesignHook <> nil then
    GlobalDesignHook.RemoveAllHandlersForObject(Self);
end;

procedure TSynObjectPartListPropertyEditorForm.MoveDownButtonClick(Sender: TObject);
var
  I: Integer;
begin
  if SynObjectPartList = nil then Exit;

  I := SynObjectPartsListBox.ItemIndex;
  if I >= SynObjectPartList.Count - 1 then Exit;

  SynObjectPartList.BaseItems[I].Index := I + 1;
  SynObjectPartsListBox.ItemIndex := I + 1;

  FillSynObjectPartsListBox;
  SelectInObjectInspector(False);
  Modified;
end;

procedure TSynObjectPartListPropertyEditorForm.MoveUpButtonClick(Sender: TObject);
var
  I: Integer;
begin
  if SynObjectPartList = nil then Exit;

  I := SynObjectPartsListBox.ItemIndex;
  if I < 0 then Exit;

  SynObjectPartList.BaseItems[I].Index := I - 1;
  SynObjectPartsListBox.ItemIndex := I - 1;

  FillSynObjectPartsListBox;
  SelectInObjectInspector(False);
  Modified;
end;

procedure TSynObjectPartListPropertyEditorForm.UpdateCaption;
var
  NewCaption: String;
begin
  //"Editing ComponentName.PropertyName[Index]"
  if OwnerPersistent is TComponent then
    NewCaption := TComponent(OwnerPersistent).Name
  else
    if OwnerPersistent <> nil then
      NewCaption := OwnerPersistent.GetNamePath
    else
      NewCaption := '';

  if NewCaption <> '' then NewCaption := NewCaption + '.';
  NewCaption := oiColEditEditing + ' ' + NewCaption + PropertyName;

  if SynObjectPartsListBox.ItemIndex > -1 then
    NewCaption := NewCaption + '[' + IntToStr(SynObjectPartsListBox.ItemIndex) + ']';
  Caption := NewCaption;
end;

procedure TSynObjectPartListPropertyEditorForm.UpdateButtons;
var
  I: Integer;
begin
  if SynObjectPartList = nil then begin
    AddButton.Enabled := False;
    DeleteButton.Enabled := False;
    MoveUpButton.Enabled := False;
    MoveDownButton.Enabled := False;
    exit;
  end;
  I := SynObjectPartsListBox.ItemIndex;
  AddButton.Enabled := True;
  DeleteButton.Enabled := I > -1;
  MoveUpButton.Enabled := I > 0;
  MoveDownButton.Enabled := (I >= 0) and (I < SynObjectPartList.Count - 1);
end;

procedure TSynObjectPartListPropertyEditorForm.ComponentRenamed(AComponent: TComponent);
begin
  if AComponent = OwnerPersistent then UpdateCaption;
end;

procedure TSynObjectPartListPropertyEditorForm.PersistentDeleting(APersistent: TPersistent);
var
  OldSynObjectPartList: TSynObjectList;
begin
  debugln(['TSynObjectPartListPropertyEditorForm.PersistentDeleting ']);
  if APersistent = OwnerPersistent then
  begin
    debugln('xxxxxxx');
    OldSynObjectPartList := SynObjectPartList;
    SetSynObjectPartList(nil, nil, nil, '');
    SelectInObjectInspector(True);
    GlobalDesignHook.Unselect(OldSynObjectPartList); // XXX unselect all the individual parts
    if GlobalDesignHook.LookupRoot = OldSynObjectPartList then
      GlobalDesignHook.LookupRoot := nil;
    Hide;
  end;
end;


procedure TSynObjectPartListPropertyEditorForm.RefreshPropertyValues;
begin
  FillSynObjectPartsListBox;
  Modified;
end;

procedure TSynObjectPartListPropertyEditorForm.FillSynObjectPartsListBox;
var
  I: Integer;
  CurItem: String;
  Cnt: Integer;
begin
  SynObjectPartsListBox.Items.BeginUpdate;
  try
    if SynObjectPartList <> nil then Cnt := SynObjectPartList.Count
    else Cnt := 0;

    // add or replace list items
    for I := 0 to Cnt - 1 do
    begin
      CurItem := IntToStr(I) + ' - ' + SynObjectPartList.BaseItems[I].DisplayName;
      if I >= SynObjectPartsListBox.Items.Count then
        SynObjectPartsListBox.Items.Add(CurItem)
      else
        SynObjectPartsListBox.Items[I] := CurItem;
    end;

    // delete unneeded list items
    if Cnt > 0 then
    begin
      while SynObjectPartsListBox.Items.Count > Cnt do
      begin
        SynObjectPartsListBox.Items.Delete(SynObjectPartsListBox.Items.Count - 1);
      end;
    end
    else
    begin
      SynObjectPartsListBox.Items.Clear;
    end;
  finally
    SynObjectPartsListBox.Items.EndUpdate;
    UpdateButtons;
    UpdateCaption;
  end;
end;

procedure TSynObjectPartListPropertyEditorForm.SelectInObjectInspector(UnselectAll: Boolean);
var
  I: Integer;
  NewSelection: TPersistentSelectionList;
begin
  if SynObjectPartList = nil then Exit;
  // select in OI
  NewSelection := TPersistentSelectionList.Create;
  try
    if not UnselectAll then
    begin
      for I := 0 to SynObjectPartsListBox.Items.Count - 1 do
        if SynObjectPartsListBox.Selected[I] then
          NewSelection.Add(SynObjectPartList.BaseItems[I]);
    end;
    GlobalDesignHook.SetSelection(NewSelection);
    GlobalDesignHook.LookupRoot := GetLookupRootForComponent(OwnerPersistent);
  finally
    NewSelection.Free;
  end;
end;

procedure TSynObjectPartListPropertyEditorForm.SetSynObjectPartList
  (NewSynObjectPartList: TSynObjectList; NewClassesList: TStringList;
   NewOwnerPersistent: TPersistent; const NewPropName: String);
begin
  if (FSynObjectPartList = NewSynObjectPartList)
    and (FClassesList = NewClassesList)
    and (FOwnerPersistent = NewOwnerPersistent)
    and (FPropertyName = NewPropName) then Exit;

  FSynObjectPartList := NewSynObjectPartList;
  FClassesList := NewClassesList;
  if assigned(FClassesList) then
    ClassComboBox.Items.Assign(FClassesList)
  else
    ClassComboBox.Clear;
  if ClassComboBox.Items.Count >0 then
    ClassComboBox.ItemIndex := 0;

  // Can not use NewOwnerPersistent since it points to the SynGutter
  if NewSynObjectPartList <> nil then
    FOwnerPersistent := NewSynObjectPartList.Owner // The SynEdit
  else
    FOwnerPersistent := nil;

  FPropertyName := NewPropName;
  //debugln('TSynObjectPartListPropertyEditorForm.SetSynObjectPartList A SynObjectPartList=',dbgsName(FSynObjectPartList),' OwnerPersistent=',dbgsName(OwnerPersistent),' PropName=',PropertyName);
  if GlobalDesignHook <> nil then
  begin
    if FOwnerPersistent <> nil then
    begin
      GlobalDesignHook.AddHandlerComponentRenamed(@ComponentRenamed);
      GlobalDesignHook.AddHandlerPersistentDeleting(@PersistentDeleting);
      GlobalDesignHook.AddHandlerRefreshPropertyValues(@RefreshPropertyValues);
    end
    else
    begin
      GlobalDesignHook.RemoveAllHandlersForObject(Self);
    end;
  end;

  FillSynObjectPartsListBox;
  UpdateCaption;
end;

procedure TSynObjectPartListPropertyEditorForm.Modified;
begin
  GlobalDesignHook.Modified(Self);
  //SelectInObjectInspector(False);
end;

{ TSynPropertyEditObjectList }

function TSynPropertyEditObjectList.ReadElementCount: integer;
var
  SynObjectList: TSynObjectList;
begin
  SynObjectList := TSynObjectList(GetObjectValue);
  if (SynObjectList <> nil) and (SynObjectList is TSynObjectList) then
    Result:=SynObjectList.Count
  else
    Result:=0;
end;

function TSynPropertyEditObjectList.ReadElement(Index: integer): TPersistent;
var
  SynObjectList: TSynObjectList;
begin
  SynObjectList := TSynObjectList(GetObjectValue);
  Result := SynObjectList.BaseItems[Index];
end;

function TSynPropertyEditObjectList.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TSynPropertyEditObjectList.Edit;
var
  TheSynObjectList: TSynObjectList;
begin
  TheSynObjectList := TSynObjectList(GetObjectValue);
  if TheSynObjectList = nil then
    raise Exception.Create('ObjectPartList=nil');
  ShowClassListEditor(TheSynObjectList, GetComponent(0), GetName);
end;

class function TSynPropertyEditObjectList.ShowClassListEditor(AClassList: TSynObjectList;
  OwnerPersistent: TPersistent; const PropName: String): TCustomForm;
begin
  if SynObjectPartListForm = nil then
    SynObjectPartListForm := TSynObjectPartListPropertyEditorForm.Create(Application);
  SynObjectPartListForm.SetSynObjectPartList(AClassList, ClassList, OwnerPersistent, PropName);
  SynObjectPartListForm.EnsureVisible;
  Result := SynObjectPartListForm;
end;

{ TSynPropertyEditGutterPartList }

function TSynPropertyEditGutterPartList.ClassList: TStringList;
begin
  Result := KnownSynGutterPartClasses;
end;

initialization
  {$I synpropertyeditobjectlist.lrs}

  if KnownSynGutterPartClasses = nil then
    KnownSynGutterPartClasses := TStringList.Create;

finalization
  FreeAndNil(KnownSynGutterPartClasses);

end.

