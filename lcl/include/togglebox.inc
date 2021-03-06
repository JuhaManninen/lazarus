{%MainUnit ../stdctrls.pp}

{
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
{------------------------------------------------------------------------------}

class procedure TToggleBox.WSRegisterClass;
begin
  inherited WSRegisterClass;
  RegisterToggleBox;
end;

constructor TToggleBox.Create(TheOwner : TComponent);
begin
  inherited Create(TheOwner);
  fCompStyle := csToggleBox;
  AutoSize:=false;
end;

{------------------------------------------------------------------------------}

// included by stdctrls.pp
