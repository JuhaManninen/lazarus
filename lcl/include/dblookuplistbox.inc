{%MainUnit ../dbctrls.pas}

{******************************************************************************
                                     TDBListBox
                    data aware ListBox, base found in dbctrls.pp
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
{ TDBLookupListBox }

constructor TDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLookup:= TDBLookup.Create(Self);
  FDataLink.OnActiveChange:= @ActiveChange;
end;


procedure TDBLookupListBox.Loaded;
begin
  inherited Loaded;
  if FDataLink.Active then
    ActiveChange(Self);
end;

procedure TDBLookupListBox.UpdateData(Sender: TObject);
begin
  if (ItemIndex < 0) then
    Exit;
  FLookup.UpdateData(Items[ItemIndex]);
end;

procedure TDBLookupListBox.ActiveChange(Sender: TObject);
begin
  if FDataLink.Active then
  begin
    FLookup.Initialize(FDataLink, Items);
    DataChange(Self);
  end
  else FLookup.Initialize(nil,nil);
end;

procedure TDBLookupListBox.DataChange(Sender: TObject);
begin
  ItemIndex:= Items.IndexOf(FLookup.ListFieldValue);
end;

procedure TDBLookupListBox.FinalizeWnd;
begin
  inherited FinalizeWnd;
  FLookup.FControlItems := Items;
end;

procedure TDBLookupListBox.InitializeWnd;
begin
  inherited InitializeWnd;
  FLookup.FControlItems := Items;
end;

function TDBLookupListBox.GetKeyField: string;
begin
  Result := FLookup.KeyField;
end;

function TDBLookupListBox.GetListField: string;
begin
  Result := FLookup.ListField;
end;

function TDBLookupListBox.GetListFieldIndex: Integer;
begin
  Result := FLookup.ListFieldIndex;
end;

function TDBLookupListBox.GetListSource: TDataSource;
begin
  Result := FLookup.ListSource;
end;

function TDBLookupListBox.GetLookupCache: boolean;
begin
  Result := FLookup.LookupCache;
end;

procedure TDBLookupListBox.SetKeyField(const Value: string);
begin
  FLookup.KeyField:= Value;
end;

procedure TDBLookupListBox.SetListField(const Value: string);
begin
  FLookup.ListField:= Value;
end;

procedure TDBLookupListBox.SetListFieldIndex(const Value: Integer);
begin
  FLookup.ListFieldIndex:= Value;
end;

procedure TDBLookupListBox.SetListSource(const Value: TDataSource);
begin
  FLookup.ListSource:= Value;
end;

procedure TDBLookupListBox.SetLookupCache(const Value: boolean);
begin
  FLookup.LookupCache := Value;
end;

