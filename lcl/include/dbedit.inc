{%MainUnit ../dbctrls.pp}

{******************************************************************************
                                     TDBEdit
                    data aware Edit, base found in dbctrls.pp
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

// included by dbctrls.pp

{ Private Methods }

//update the caption on next record etc...
procedure TDBEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then begin
    //use the right EditMask if any
    //EditMask := FDataLink.Field.EditMask; doesn't exist yet

    //if we are focused its possible to edit,
    //if the field is currently modifiable
    if Focused and FDataLink.CanModify then begin
      //display the real text since we can modify it
      //Text := FDataLink.Field.DisplayText//this is wrong, but Text seems Broken
      Text := FDatalink.Field.Text;
      SelectAll;
    end else
      //otherwise display the pretified/formated text since we can't
      EditText := FDataLink.Field.DisplayText;
    MaxLength := FDatalink.Field.Size;
  end
  else begin
    //todo: uncomment this when TField implements EditMask
    //EditMask := ''
    Text := '';
  end;
end;

procedure TDBEdit.ActiveChange(Sender: TObject);
begin
  if FDatalink.Active then 
    DataChange(Sender)
  else begin
    Text := '';
    FDataLink.Reset;
  end;
end;

procedure TDBEdit.LayoutChange(Sender: TObject);
begin
  DataChange(Sender);
end;

procedure TDBEdit.UpdateData(Sender: TObject);
begin
  //the field is being updated, probably for post
  //so we are getting called to make sure its
  //up-to-date and matches any modifications
  //since its possible to have a mask for say
  //date or currency we need to make sure the
  //text is valid before we update this is in
  //case for instance they call table.post via
  //a keyboard shortcut while still focused, before
  //the changes have been validated
  ValidateEdit;
  FDataLink.Field.Text := Text;
  //FDataLink.Field.AsString := Text;// I shouldn't have to do this, but text seems broken
end;

procedure TDBEdit.FocusRequest(Sender: TObject);
begin
  //the FieldLink has requested the control
  //recieve focus for some reason..
  //perhaps an error occured?
  SetFocus;
end;

function TDBEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TDBEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TDBEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TDBEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBEdit.SetReadOnly(Value: Boolean);
begin
  inherited;
  FDataLink.ReadOnly := Value;
end;

procedure TDBEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBEdit.SetDataSource(Value: TDataSource);
begin
  ChangeDataSource(Self,FDataLink,Value);
end;

function TDBEdit.IsReadOnly: boolean;
begin
  // This function in unneccesary for fpc versions > 2.2.4.
  // In those versions FDatalink.CanModify already checks if the dataset is active.
  // So this temporary method should be removed in the future, and the calls to
  // 'not IsReadOnly' should then be replaced by calls to FDatalink.CanModify.
  If FDatalink.Active then
    Result := not FDatalink.CanModify
  else
    Result := False;
end;

procedure TDBEdit.CMGetDataLink(var Message: TLMessage);
begin
  Message.Result := PtrUInt(FDataLink);
end;

{ Protected Methods}
procedure TDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key,Shift);
  if Key=VK_ESCAPE then begin
    //cancel out of editing by reset on esc
    FDataLink.Reset;
    SelectAll;
    Key := VK_UNKNOWN;
  end else
  if Key in [VK_DELETE, VK_BACK] then begin
    if not IsReadOnly then
      FDatalink.Edit
    else
      Key := VK_UNKNOWN;
  end else
  if Key=VK_TAB then begin
    if FDataLink.CanModify and FDatalink.Editing then
      FDataLink.UpdateRecord;
  end;
end;

procedure TDBEdit.KeyPress(var Key: char);
  function CanAcceptKey: boolean;
  begin
    Result := Field.IsValidChar(Key) and
              (Field.DataType<>ftAutoInc);
  end;
var
  SavedKey: Char;
begin
  SavedKey := Key;
  inherited KeyPress(Key);
  //TCustomMaskEdit sets all normal Keys (and BackSpace) to #0 if IsMasked
  //but not if control is ReadOnly
  if (not IsMasked) or (inherited ReadOnly) then
  begin
    case Key of
      #8: // special keys
        if not IsReadOnly then
          FDatalink.Edit
        else
          Key:=#0;

      #32..#255: //standard keys
        if not IsReadOnly and CanAcceptKey then
          FDatalink.Edit
        else
          Key:=#0;
    end;//case
  end
  else
  begin
    case SavedKey of
      #8: // special keys
        if not IsReadOnly then
          FDatalink.Edit;
      #32..#255: //standard keys
        if not IsReadOnly and CanAcceptKey then
          FDatalink.Edit;
    end;//case
  end;
end;

procedure TDBEdit.Loaded;
begin
  inherited Loaded;
  //need to make sure the state is updated on first load
  if (csDesigning in ComponentState) then
    DataChange(Self);
end;

procedure TDBEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  // if the datasource is being removed then we need to make sure
  // we are updated or we can get AV/Seg's *cough* as I foolishly
  // discovered firsthand....
  if (Operation=opRemove) then begin
    if (FDataLink<>nil) and (AComponent=DataSource) then
      DataSource:=nil;
  end;
end;

function TDBEdit.EditCanModify: Boolean;
begin
  //should follow the FieldLink for this one
  Result := FDataLink.Edit;
end;

function TDBEdit.GetEditText: string;
begin
  if not (csDesigning in ComponentState) and not FDatalink.Active then begin
    Result := '';
    exit;
  end;
  Result:=inherited GetEditText;
end;

procedure TDBEdit.Change;
begin
  //need to override this to make sure the datalink gets notified
  //its been modified, then when post etc, it will call
  //updatedata to update the field data with current value
  FDataLink.Modified;

  inherited Change;
end;

procedure TDBEdit.Reset;
begin
  //need to override this to make sure the datalink gets reset
  //if the changes get canceled
  FDataLink.reset;

  inherited Reset;
end;

procedure TDBEdit.WMSetFocus(var Message: TLMSetFocus);
begin
  inherited WMSetFocus(Message);
  if not FDatalink.Editing then
    FDatalink.Reset;
end;

procedure TDBEdit.WMKillFocus(var Message: TLMKillFocus);
begin
  inherited WMKillFocus(Message);
  if not FDatalink.Editing then
    FDatalink.Reset
  else
    FDatalink.UpdateRecord;
end;

procedure TDBEdit.LMPasteFromClip(var Message: TLMessage);
begin
  if not IsReadOnly then
    FDatalink.Edit;
  inherited LMPasteFromClip(Message);
end;

procedure TDBEdit.LMCutToClip(var Message: TLMessage);
begin
  if not IsReadOnly then
    FDatalink.Edit;
  inherited LMCutToClip(Message);
end;

{ Public Methods }
constructor TDBEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := @DataChange;
  FDataLink.OnUpdateData := @UpdateData;
  FDataLink.OnActiveChange := @ActiveChange;
  FDataLink.OnLayoutChange := @LayoutChange;
end;

destructor TDBEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

