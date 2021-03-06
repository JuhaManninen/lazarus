{%MainUnit gtkextra.pp}
{ $Id$ }
{
 *****************************************************************************
 *                                                                           *
 *  This file is part of the Lazarus Component Library (LCL)                 *
 *                                                                           *
 *  See the file COPYING.modifiedLGPL.txt, included in this distribution,        *
 *  for details about the copyright.                                         *
 *                                                                           *
 *  This program is distributed in the hope that it will be useful,          *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
 *                                                                           *
 *****************************************************************************
}

function GTK_TYPE_CELL_VIEW: GType;
begin
  GTK_TYPE_CELL_VIEW:=gtk_cell_view_get_type;
end;

function GTK_CELL_VIEW(obj: pointer): PGtkCellView;
begin
  GTK_CELL_VIEW:=PGtkCellView(GTK_CHECK_CAST(obj,GTK_TYPE_CELL_VIEW));
end;

function GTK_IS_CELL_VIEW(obj: pointer): boolean;
begin
  GTK_IS_CELL_VIEW:=GTK_CHECK_TYPE(obj,GTK_TYPE_CELL_VIEW);
end;

function GTK_IS_CELL_VIEW_CLASS(klass: pointer): boolean;
begin
  GTK_IS_CELL_VIEW_CLASS:=GTK_CHECK_CLASS_TYPE(klass,GTK_TYPE_CELL_VIEW);
end;

function gtk_cell_view_get_model(cell_view: PGtkCellView): PGtkTreeModel;
var
  Value: TGvalue;
begin
  FillByte(Value,SizeOf(Value),0);
  g_value_init(@Value,GTK_TYPE_TREE_MODEL);
  g_object_get_property(PGObject(Cell_View),'model',@Value);
  Result:=PGtkTreeModel(g_value_get_object(@Value));
end;

{$ifdef windows}
procedure gdk_window_copy_area(Dest : PGDKWindow; GC : PGDKGC; DestX,
  DestY : Longint; SRC : PGDKWindow; XSRC, YSRC, Width, Height : Longint);
begin
  gdk_draw_pixmap(Dest, GC, Src, XSrc, YSrc, DestX, DestY, Width, Height);
end;
{$endif}
