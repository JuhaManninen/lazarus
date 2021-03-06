{%MainUnit ../dbctrls.pas}

{******************************************************************************
                                     TDBLookupComboBox
                    data aware lookup Combo Box, base found in dbctrls.pp
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

{ TDBLookupComboBox }

constructor TDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLookup:= TDBLookup.Create(Self);
  FDataLink.OnActiveChange:= @ActiveChange;
end;

procedure TDBLookupComboBox.Loaded;
begin
  inherited Loaded;
  if FDataLink.Active then
    ActiveChange(Self);
end;

procedure TDBLookupComboBox.UpdateData(Sender: TObject);
begin
  FLookup.UpdateData(Text);
end;

procedure TDBLookupComboBox.ActiveChange(Sender: TObject);
begin
  if FDataLink.Active then
    FLookup.Initialize(FDataLink, Items)
  else FLookup.Initialize(nil, nil);
  inherited;
end;

procedure TDBLookupComboBox.UpdateText;
begin
  Text:= FLookup.ListFieldValue;
end;

function TDBLookupComboBox.GetKeyField: string;
begin
  Result := FLookup.KeyField;
end;

function TDBLookupComboBox.GetListField: string;
begin
  Result := FLookup.ListField;
end;

function TDBLookupComboBox.GetListFieldIndex: Integer;
begin
  Result := FLookup.ListFieldIndex;
end;

function TDBLookupComboBox.GetListSource: TDataSource;
begin
  Result := FLookup.ListSource;
end;

function TDBLookupComboBox.GetLookupCache: boolean;
begin
  Result := FLookup.LookupCache;
end;

procedure TDBLookupComboBox.SetKeyField(const Value: string);
begin
  FLookup.KeyField:= Value;
end;

procedure TDBLookupComboBox.SetListField(const Value: string);
begin
  FLookup.ListField:= Value;
end;

procedure TDBLookupComboBox.SetListFieldIndex(const Value: Integer);
begin
  FLookup.ListFieldIndex:= Value;
end;

procedure TDBLookupComboBox.SetListSource(const Value: TDataSource);
begin
  FLookup.ListSource:= Value;
end;

procedure TDBLookupComboBox.SetLookupCache(const Value: boolean);
begin
  FLookup.LookupCache := Value;
end;

procedure TDBLookupComboBox.FinalizeWnd;
begin
  inherited FinalizeWnd;
  FLookup.FControlItems := Items;
end;

procedure TDBLookupComboBox.InitializeWnd;
begin
  inherited InitializeWnd;
  FLookup.FControlItems := Items;
end;

