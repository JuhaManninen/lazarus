{%MainUnit ../extctrls.pp}

{ TPaintBox

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

constructor TPaintBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  SetInitialBounds(0,0,GetControlClassDefaultSize.X,GetControlClassDefaultSize.Y);
end;

class procedure TPaintBox.WSRegisterClass;
begin
  inherited WSRegisterClass;
  RegisterPaintBox;
end;

procedure TPaintBox.Paint;
begin
  if csDesigning in ComponentState then begin
    Canvas.Brush.Color := Color;
    with Canvas do
    begin
      Pen.Style := psDash;
      Pen.Color:=clBlack;
      Brush.Style := bsClear;
      Rectangle(0, 0, Self.Width - 1, Self.Height - 1);
      Line(0,0,Self.Width-1,Self.Height-1);
      Line(Self.Width-1,0,0,Self.Height-1);
    end;
    exit;
  end;
  if Assigned(OnPaint) then begin
    Canvas.Font := Font;
    Canvas.Brush.Color := Color;
    inherited Paint;
  end;
end;

class function TPaintBox.GetControlClassDefaultSize: TPoint;
begin
  Result.X:=105;
  Result.Y:=105;
end;

// included by extctrls.pp
