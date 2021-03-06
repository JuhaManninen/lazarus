{
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
unit editor_color_options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, StdCtrls, SynEdit,
  SynGutterCodeFolding, SynGutterLineNumber, SynGutterChanges,
  ExtCtrls, Dialogs, Graphics, LCLProc, SynEditMiscClasses, LCLType, Controls,
  EditorOptions, LazarusIDEStrConsts, IDEOptionsIntf, editor_general_options,
  IDEProcs, ColorBox, SynEditMarkupBracket;

type

  { TEditorColorOptionsFrame }

  TEditorColorOptionsFrame = class(TAbstractIDEOptionsEditor)
    BackGroundColorBox: TColorBox;
    BracketCombo: TComboBox;
    BracketLabel: TLabel;
    FrameColorBox: TColorBox;
    BackGroundLabel: TLabel;
    FrameColorLabel: TLabel;
    BackGroundUseDefaultCheckBox: TCheckBox;
    FrameColorUseDefaultCheckBox: TCheckBox;
    ForegroundColorBox: TColorBox;
    TextBoldCheckBox: TCheckBox;
    TextBoldRadioInvert: TRadioButton;
    TextBoldRadioOff: TRadioButton;
    TextBoldRadioOn: TRadioButton;
    TextBoldRadioPanel: TPanel;
    TextItalicCheckBox: TCheckBox;
    TextItalicRadioInvert: TRadioButton;
    TextItalicRadioOff: TRadioButton;
    TextItalicRadioOn: TRadioButton;
    TextItalicRadioPanel: TPanel;
    TextUnderlineCheckBox: TCheckBox;
    TextUnderlineRadioInvert: TRadioButton;
    TextUnderlineRadioOff: TRadioButton;
    TextUnderlineRadioOn: TRadioButton;
    TextUnderlineRadioPanel: TPanel;
    UseSyntaxHighlightCheckBox: TCheckBox;
    ColorElementListBox: TListBox;
    ColorPreview: TSynEdit;
    ColorSchemeComboBox: TComboBox;
    ColorSchemeLabel: TLabel;
    FileExtensionsComboBox: TComboBox;
    FileExtensionsLabel: TLabel;
    ForeGroundLabel: TLabel;
    ForeGroundUseDefaultCheckBox: TCheckBox;
    LanguageComboBox: TComboBox;
    LanguageLabel: TLabel;
    SetAllAttributesToDefaultButton: TButton;
    SetAttributeToDefaultButton: TButton;
    ElementAttributesGroupBox: TGroupBox;
    procedure ColorElementListBoxClick(Sender: TObject);
    procedure ColorElementListBoxSelectionChange(Sender: TObject; User: boolean);
    procedure ColorPreviewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ForegroundColorBoxChange(Sender: TObject);
    procedure GeneralCheckBoxOnChange(Sender: TObject);
    procedure ComboBoxOnExit(Sender: TObject);
    procedure SetAllAttributesToDefaultButtonClick(Sender: TObject);
    procedure SetAttributeToDefaultButtonClick(Sender: TObject);
    procedure TextStyleRadioOnChange(Sender: TObject);
    procedure ComboBoxOnChange(Sender: TObject);
    procedure ComboBoxOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FDialog: TAbstractOptionsEditorDialog;
    // current index in EditorOpts.EditOptHighlighterList
    CurHighlightElement: TSynHighlightElement;
    CurHighlightElementIsExtra: Boolean;
    CurHighlightElementIsSingle: Boolean;
    CurExtraElement: TAdditionalHilightAttribute;
    CurSingleElement: TSingleColorAttribute;

    UpdatingColor: Boolean;
    FFileExtensions: TStringList;  // list of LanguageName=FileExtensions
    FHighlighterList: TStringList; // list of "ColorScheme" Data=TSrcIDEHighlighter
    FColorSchemes: TStringList;    // list of LanguageName=ColorScheme

    PreviewSyn: TSrcIDEHighlighter;
    CurLanguageID: Integer;

    function GetCurFileExtensions(const LanguageName: String): String;
    procedure SetCurFileExtensions(const LanguageName, FileExtensions: String);
    procedure ShowCurAttribute;
    procedure FindCurHighlightElement;
    procedure FillColorElementListBox;
    procedure SetColorElementsToDefaults(OnlySelected: Boolean);
    function GetCurColorScheme(const LanguageName: String): String;
    procedure SetCurColorScheme(const LanguageName, ColorScheme: String);
    function GetHighlighter(SynClass: TCustomSynClass;
      const ColorScheme: String; CreateIfNotExists: Boolean): TSrcIDEHighlighter;
    procedure ClearHighlighters;
    procedure InvalidatePreviews;
    procedure SetPreviewSynInAllPreviews;

    function GetSingleColor(AElement: TSingleColorAttribute): TColor;
    procedure SetSingleColor(AEditor: TPreviewEditor;
      AElement: TSingleColorAttribute; AColor: TColor); overload;
    procedure SetSingleColor(AElement: TSingleColorAttribute; AColor: TColor); overload;

    procedure OnStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure OnSpecialLineMarkup(Sender: TObject; Line: Integer;
      var Special: boolean; aMarkup: TSynSelectedColor);

    function GeneralPage: TEditorGeneralOptionsFrame; inline;
  public
    destructor Destroy; override;

    function GetTitle: String; override;
    procedure Setup(ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings(AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings(AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

function DefaultToNone(AColor: TColor): TColor;
begin
  if AColor = clDefault then
    Result := clNone
  else
    Result := AColor;
end;

function NoneToDefault(AColor: TColor): TColor;
begin
  if AColor = clNone then
    Result := clDefault
  else
    Result := AColor;
end;

{ TEditorColorOptionsFrame }

procedure TEditorColorOptionsFrame.ColorElementListBoxClick(Sender: TObject);
begin
  FindCurHighlightElement;
end;

procedure TEditorColorOptionsFrame.ColorElementListBoxSelectionChange(
  Sender: TObject; User: boolean);
begin
  FindCurHighlightElement;
end;

procedure TEditorColorOptionsFrame.ColorPreviewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, NewIndex: Integer;
  Token: String;
  Attri: TSynHighlightElement;
  MouseXY, XY: TPoint;
  AddAttr: TAdditionalHilightAttribute;
begin
  MouseXY := Point(X, Y);
  XY := ColorPreview.PixelsToRowColumn(MouseXY);
  NewIndex := -1;
  // Gutter Colors
  if X <= ColorPreview.GutterWidth then begin
    for i := 0 to ColorPreview.Gutter.Parts.Count-1 do begin
      if ColorPreview.Gutter.Parts[i].Width > X then begin
        if ColorPreview.Gutter.Parts[i] is TSynGutterLineNumber then
          Token := AdditionalHighlightAttributes[ahaLineNumber]
        else
        if ColorPreview.Gutter.Parts[i] is TSynGutterChanges then
          Token := AdditionalHighlightAttributes[ahaModifiedLine]
        else
        if ColorPreview.Gutter.Parts[i] is TSynGutterCodeFolding then
          Token := AdditionalHighlightAttributes[ahaCodeFoldingTree]
        else
          Token := dlgGutter;
        NewIndex := ColorElementListBox.Items.IndexOf(Token);
        break;
      end;
      X := X - ColorPreview.Gutter.Parts[i].Width;
    end;
  end
  // Line Highlights
  else
  if CurLanguageID >= 0 then
  begin
    AddAttr := EditorOpts.HighlighterList[CurLanguageID].SampleLineToAddAttr(XY.Y);
    if AddAttr <> ahaNone then
      NewIndex := ColorElementListBox.Items.IndexOf(AdditionalHighlightAttributes[AddAttr]);
  end;
  if (NewIndex < 0) and (XY.Y = ColorPreview.CaretY) and
     (XY.X > Length(ColorPreview.Lines[XY.Y - 1])+1) then
    NewIndex := ColorElementListBox.Items.IndexOf(AdditionalHighlightAttributes[ahaLineHighlight]);
  // Pascal Highlights
  if NewIndex < 0 then
  begin
    Token := '';
    Attri := nil;
    ColorPreview.GetHighlighterAttriAtRowCol(XY, Token, Attri);
    if Attri = nil then
      Attri := PreviewSyn.WhitespaceAttribute;
    if Attri <> nil then
      NewIndex := ColorElementListBox.Items.IndexOf(Attri.Name);
  end;
  if NewIndex >= 0 then
  begin
    ColorElementListBox.ItemIndex := NewIndex;
    FindCurHighlightElement;
  end;
end;

procedure TEditorColorOptionsFrame.ForegroundColorBoxChange(Sender: TObject);
begin
  if Sender = ForegroundColorBox then
  begin
    if ((CurHighlightElement = nil) and not CurHighlightElementIsSingle) or UpdatingColor then
      Exit;
    UpdatingColor := True;
    if CurHighlightElementIsSingle then
      SetSingleColor(CurSingleElement, DefaultToNone(ForeGroundColorBox.Selected))
    else
      CurHighlightElement.Foreground := DefaultToNone(ForeGroundColorBox.Selected);
    ForeGroundUseDefaultCheckBox.Checked := ForeGroundColorBox.Selected = clDefault;
    InvalidatePreviews;
    UpdatingColor := False;
  end;
  if Sender = BackGroundColorBox then
  begin
    if (CurHighlightElement = nil) or UpdatingColor then
      Exit;
    UpdatingColor := True;
    CurHighlightElement.Background := DefaultToNone(BackGroundColorBox.Selected);
    BackGroundUseDefaultCheckBox.Checked := BackGroundColorBox.Selected = clDefault;
    InvalidatePreviews;
    UpdatingColor := False;
  end;
  if Sender = FrameColorBox then
  begin
    if (CurHighlightElement = nil) or UpdatingColor then
      Exit;
    UpdatingColor := True;
    CurHighlightElement.FrameColor := DefaultToNone(FrameColorBox.Selected);
    FrameColorUseDefaultCheckBox.Checked := FrameColorBox.Selected = clDefault;
    InvalidatePreviews;
    UpdatingColor := False;
  end;
end;

procedure TEditorColorOptionsFrame.GeneralCheckBoxOnChange(Sender: TObject);
begin
  if Sender = UseSyntaxHighlightCheckBox then
  begin
    SetPreviewSynInAllPreviews;
    Exit;
  end;

  if CurHighlightElement <> nil then
  begin
    if Sender = ForeGroundUseDefaultCheckBox then
      if UpdatingColor = False then
      begin
        UpdatingColor := True;
        if ForeGroundUseDefaultCheckBox.Checked then
        begin
          ForegroundColorBox.Tag := ForegroundColorBox.Selected;
          ForegroundColorBox.Selected := clDefault;
        end
        else
          ForegroundColorBox.Selected := ForegroundColorBox.Tag;
        if DefaultToNone(ForegroundColorBox.Selected) <> CurHighlightElement.Foreground then
        begin
          CurHighlightElement.Foreground := DefaultToNone(ForegroundColorBox.Selected);
          InvalidatePreviews;
        end;
        UpdatingColor := False;
      end;
    if Sender = BackGroundUseDefaultCheckBox then
      if UpdatingColor = False then
      begin
        if BackGroundUseDefaultCheckBox.Checked then
        begin
          BackGroundColorBox.Tag := BackGroundColorBox.Selected;
          BackGroundColorBox.Selected := clDefault;
        end
        else
          BackGroundColorBox.Selected := BackGroundColorBox.Tag;
        if DefaultToNone(BackGroundColorBox.Selected) <> CurHighlightElement.Background then
        begin
          CurHighlightElement.Background := DefaultToNone(BackGroundColorBox.Selected);
          InvalidatePreviews;
        end;
      end;
    if Sender = FrameColorUseDefaultCheckBox then
      if UpdatingColor = False then
      begin
        if FrameColorUseDefaultCheckBox.Checked then
        begin
          FrameColorBox.Tag := FrameColorBox.Selected;
          FrameColorBox.Selected := clDefault;
        end
        else
          FrameColorBox.Selected := FrameColorBox.Tag;
        if DefaultToNone(FrameColorBox.Selected) <> CurHighlightElement.FrameColor then
        begin
          CurHighlightElement.FrameColor := DefaultToNone(FrameColorBox.Selected);
          InvalidatePreviews;
        end;
      end;
    if Sender = TextBoldCheckBox then
      if CurHighlightElementIsExtra then
        TextStyleRadioOnChange(Sender)
      else
      if TextBoldCheckBox.Checked xor (fsBold in CurHighlightElement.Style) then
      begin
        if TextBoldCheckBox.Checked then
          CurHighlightElement.Style := CurHighlightElement.Style + [fsBold]
        else
          CurHighlightElement.Style := CurHighlightElement.Style - [fsBold];
        InvalidatePreviews;
      end;
    if Sender = TextItalicCheckBox then
      if CurHighlightElementIsExtra then
        TextStyleRadioOnChange(Sender)
      else
      if TextItalicCheckBox.Checked then
      begin
        if not (fsItalic in CurHighlightElement.Style) then
        begin
          CurHighlightElement.Style := CurHighlightElement.Style + [fsItalic];
          InvalidatePreviews;
        end;
      end
      else
      if (fsItalic in CurHighlightElement.Style) then
      begin
        CurHighlightElement.Style := CurHighlightElement.Style - [fsItalic];
        InvalidatePreviews;
      end;
    if Sender = TextUnderlineCheckBox then
      if CurHighlightElementIsExtra then
        TextStyleRadioOnChange(Sender)
      else
      if TextUnderlineCheckBox.Checked then
      begin
        if not (fsUnderline in CurHighlightElement.Style) then
        begin
          CurHighlightElement.Style := CurHighlightElement.Style + [fsUnderline];
          InvalidatePreviews;
        end;
      end
      else
      if (fsUnderline in CurHighlightElement.Style) then
      begin
        CurHighlightElement.Style := CurHighlightElement.Style - [fsUnderline];
        InvalidatePreviews;
      end;
  end
  else
  if CurHighlightElementIsSingle then
  begin
    if Sender = ForeGroundUseDefaultCheckBox then
      if UpdatingColor = False then
      begin
        UpdatingColor := True;
        if ForeGroundUseDefaultCheckBox.Checked then
        begin
          ForegroundColorBox.Tag := ForegroundColorBox.Selected;
          ForegroundColorBox.Selected := clDefault;
        end
        else
          ForegroundColorBox.Selected := ForegroundColorBox.Tag;
        if DefaultToNone(ForegroundColorBox.Selected) <> GetSingleColor(CurSingleElement) then
        begin
          SetSingleColor(CurSingleElement, DefaultToNone(ForegroundColorBox.Selected));
          InvalidatePreviews;
        end;
        UpdatingColor := False;
      end;
  end;
end;

procedure TEditorColorOptionsFrame.ComboBoxOnExit(Sender: TObject);

  procedure SetSingleColors(AColorScheme: String);
  var
    Scheme: TPascalColorScheme;
    s: TSingleColorAttribute;
  begin
    Scheme := EditorOpts.GetColorScheme(AColorScheme);
    for s := Low(TSingleColorAttribute) to High(TSingleColorAttribute) do
      SetSingleColor(s, Scheme.Single[s]);
  end;

var
  Box: TComboBox absolute Sender;
  NewVal, a: integer;
begin
  if Sender = ColorSchemeComboBox then
    with GeneralPage do
    begin
      if Box.Items.IndexOf(Box.Text) < 0 then
        SetComboBoxText(Box, GetCurColorScheme(PreviewSyn.LanguageName))
        // unknown color scheme -> switch back
      else
      if Box.Text <> GetCurColorScheme(PreviewSyn.LanguageName) then
      begin
        // change the colorscheme
        SetCurColorScheme(PreviewSyn.LanguageName, Box.Text);
        SetComboBoxText(Box, Box.Text);
        SetSingleColors(Box.Text);
        PreviewSyn := GetHighlighter(TCustomSynClass(PreviewSyn.ClassType),
          Box.Text, True);
        SetPreviewSynInAllPreviews;
        FillColorElementListBox;
        FindCurHighlightElement;
        InvalidatePreviews;
      end;
    end
  else
  if Sender = FileExtensionsComboBox then
  begin
    //DebugLn(['TEditorOptionsForm.ComboBoxOnExit Box.Text="',Box.Text,'" Old="',GetCurFileExtensions(PreviewSyn.LanguageName),'" PreviewSyn.LanguageName=',PreviewSyn.LanguageName]);
    if Box.Text <> GetCurFileExtensions(PreviewSyn.LanguageName) then
    begin
      SetCurFileExtensions(PreviewSyn.LanguageName, Box.Text);
      SetComboBoxText(Box, Box.Text);
    end;
    //DebugLn(['TEditorOptionsForm.ComboBoxOnExit Box.Text="',Box.Text,'" Now="',GetCurFileExtensions(PreviewSyn.LanguageName),'" PreviewSyn.LanguageName=',PreviewSyn.LanguageName]);
  end
  else
  if Sender = LanguageComboBox then
  begin
    if Box.Items.IndexOf(Box.Text) < 0 then
      SetComboBoxText(Box, PreviewSyn.LanguageName)// unknown language -> switch back
    else
    if Box.Text <> PreviewSyn.LanguageName then
    begin
      NewVal := EditorOpts.HighlighterList.FindByName(Box.Text);
      if NewVal >= 0 then
      begin
        SetComboBoxText(Box, Box.Text);
        CurLanguageID := NewVal;
        PreviewSyn    := GetHighlighter(
          EditorOpts.HighlighterList[CurLanguageID].SynClass,
          GetCurColorScheme(
          EditorOpts.HighlighterList[
          CurLanguageID].SynClass.GetLanguageName)
          , True);
        SetComboBoxText(ColorSchemeComboBox,
          GetCurColorScheme(PreviewSyn.LanguageName));
        SetComboBoxText(FileExtensionsComboBox,
          GetCurFileExtensions(PreviewSyn.LanguageName));
        with GeneralPage do
          for a := Low(PreviewEdits) to High(PreviewEdits) do
          begin
            PreviewEdits[a].Lines.Text := EditorOpts.HighlighterList[CurLanguageID].SampleSource;
            PreviewEdits[a].CaretXY := EditorOpts.HighlighterList[CurLanguageID].CaretXY;
            PreviewEdits[a].TopLine := 1;
            PreviewEdits[a].LeftChar := 1;
          end;
        SetPreviewSynInAllPreviews;
        FillColorElementListBox;
        FindCurHighlightElement;
        InvalidatePreviews;
      end;
    end;
  end
  else
  if Sender = BracketCombo then
  begin
    with GeneralPage do
      for a := Low(PreviewEdits) to High(PreviewEdits) do
        if PreviewEdits[a] <> nil then
        begin
          if BracketCombo.ItemIndex = 0 then
            PreviewEdits[a].Options := PreviewEdits[a].Options - [eoBracketHighlight]
          else
          begin
            PreviewEdits[a].Options := PreviewEdits[a].Options + [eoBracketHighlight];
            PreviewEdits[a].BracketHighlightStyle := TSynEditBracketHighlightStyle(BracketCombo.ItemIndex - 1);
          end;
        end;
  end;
end;

procedure TEditorColorOptionsFrame.SetAllAttributesToDefaultButtonClick(
  Sender: TObject);
begin
  SetColorElementsToDefaults(False);
end;

procedure TEditorColorOptionsFrame.SetAttributeToDefaultButtonClick(
  Sender: TObject);
begin
  SetColorElementsToDefaults(True);
end;

procedure TEditorColorOptionsFrame.TextStyleRadioOnChange(Sender: TObject);

  procedure CalcNewStyle(CheckBox: TCheckBox; RadioOn, RadioOff,
                         RadioInvert: TRadioButton; fs : TFontStyle;
                         Panel: TPanel);
  begin
    if CheckBox.Checked then
    begin
      Panel.Enabled := True;
      if RadioInvert.Checked then
      begin
        CurHighlightElement.Style     := CurHighlightElement.Style + [fs];
        CurHighlightElement.StyleMask := CurHighlightElement.StyleMask - [fs];
      end
      else
      if RadioOn.Checked then
      begin
        CurHighlightElement.Style     := CurHighlightElement.Style + [fs];
        CurHighlightElement.StyleMask := CurHighlightElement.StyleMask + [fs];
      end
      else
      if RadioOff.Checked then
      begin
        CurHighlightElement.Style     := CurHighlightElement.Style - [fs];
        CurHighlightElement.StyleMask := CurHighlightElement.StyleMask + [fs];
      end
    end
    else
    begin
      Panel.Enabled := False;
      CurHighlightElement.Style     := CurHighlightElement.Style - [fs];
      CurHighlightElement.StyleMask := CurHighlightElement.StyleMask - [fs];
    end;
  end;
begin
  if UpdatingColor or not CurHighlightElementIsExtra then
    Exit;

  if (Sender = TextBoldCheckBox) or
     (Sender = TextBoldRadioOn) or
     (Sender = TextBoldRadioOff) or
     (Sender = TextBoldRadioInvert) then
    CalcNewStyle(TextBoldCheckBox, TextBoldRadioOn, TextBoldRadioOff,
                    TextBoldRadioInvert, fsBold, TextBoldRadioPanel);

  if (Sender = TextItalicCheckBox) or
     (Sender = TextItalicRadioOn) or
     (Sender = TextItalicRadioOff) or
     (Sender = TextItalicRadioInvert) then
    CalcNewStyle(TextItalicCheckBox, TextItalicRadioOn, TextItalicRadioOff,
                    TextItalicRadioInvert, fsItalic, TextItalicRadioPanel);

  if (Sender = TextUnderlineCheckBox) or
     (Sender = TextUnderlineRadioOn) or
     (Sender = TextUnderlineRadioOff) or
     (Sender = TextUnderlineRadioInvert) then
    CalcNewStyle(TextUnderlineCheckBox, TextUnderlineRadioOn, TextUnderlineRadioOff,
                    TextUnderlineRadioInvert, fsUnderline, TextUnderlineRadioPanel);


  InvalidatePreviews;
end;

procedure TEditorColorOptionsFrame.ShowCurAttribute;
begin
  if ((CurHighlightElement = nil) and not CurHighlightElementIsSingle) or UpdatingColor then
    Exit;
  UpdatingColor := True;

  TextBoldRadioPanel.Visible := CurHighlightElementIsExtra;
  TextItalicRadioPanel.Visible := CurHighlightElementIsExtra;
  TextUnderlineRadioPanel.Visible := CurHighlightElementIsExtra;

  TextBoldCheckBox.Enabled := not CurHighlightElementIsSingle;
  TextItalicCheckBox.Enabled := not CurHighlightElementIsSingle;
  TextUnderlineCheckBox.Enabled := not CurHighlightElementIsSingle;

  ForeGroundLabel.Caption := dlgForecolor;
  BackGroundLabel.Caption := dlgBackColor;
  FrameColorLabel.Caption := dlgFrameColor;

  if CurHighlightElementIsSingle then
    ForeGroundLabel.Caption := dlgColor
  else
  if CurHighlightElementIsExtra and (CurExtraElement = ahaModifiedLine) then
  begin
    ForeGroundLabel.Caption := dlgSavedLineColor;
    FrameColorLabel.Caption := dlgUnsavedLineColor;
  end;

  if CurHighlightElementIsExtra then
  begin
    TextBoldCheckBox.Checked :=
      (fsBold in CurHighlightElement.Style) or
      (fsBold in CurHighlightElement.StyleMask);
    TextBoldRadioPanel.Enabled := TextBoldCheckBox.Checked;

    if not(fsBold in CurHighlightElement.StyleMask) then
      TextBoldRadioInvert.Checked := True
    else
    if fsBold in CurHighlightElement.Style then
      TextBoldRadioOn.Checked := True
    else
      TextBoldRadioOff.Checked := True;

    TextItalicCheckBox.Checked :=
      (fsItalic in CurHighlightElement.Style) or
      (fsItalic in CurHighlightElement.StyleMask);
    TextItalicRadioPanel.Enabled := TextItalicCheckBox.Checked;

    if not(fsItalic in CurHighlightElement.StyleMask) then
      TextItalicRadioInvert.Checked := True
    else
    if fsItalic in CurHighlightElement.Style then
      TextItalicRadioOn.Checked := True
    else
      TextItalicRadioOff.Checked := True;

    TextUnderlineCheckBox.Checked :=
      (fsUnderline in CurHighlightElement.Style) or
      (fsUnderline in CurHighlightElement.StyleMask);
    TextUnderlineRadioPanel.Enabled := TextUnderlineCheckBox.Checked;

    if not(fsUnderline in CurHighlightElement.StyleMask) then
      TextUnderlineRadioInvert.Checked := True
    else
    if fsUnderline in CurHighlightElement.Style then
      TextUnderlineRadioOn.Checked := True
    else
      TextUnderlineRadioOff.Checked := True;
  end
  else
  if not CurHighlightElementIsSingle then
  begin
    TextBoldCheckBox.Checked := fsBold in CurHighlightElement.Style;
    TextItalicCheckBox.Checked := fsItalic in CurHighlightElement.Style;
    TextUnderlineCheckBox.Checked := fsUnderline in CurHighlightElement.Style;
  end;

  BackGroundColorBox.Enabled := not CurHighlightElementIsSingle;
  FrameColorBox.Enabled := not CurHighlightElementIsSingle;
  BackGroundUseDefaultCheckBox.Enabled := not CurHighlightElementIsSingle;
  FrameColorUseDefaultCheckBox.Enabled := not CurHighlightElementIsSingle;
  if not CurHighlightElementIsSingle then
  begin
    ForegroundColorBox.Selected := NoneToDefault(CurHighlightElement.Foreground);
    if ForegroundColorBox.Selected = clDefault then
      ForegroundColorBox.Tag := ForegroundColorBox.DefaultColorColor
    else
      ForegroundColorBox.Tag := ForegroundColorBox.Selected;
    ForeGroundUseDefaultCheckBox.Checked := ForegroundColorBox.Selected = clDefault;

    BackGroundColorBox.Selected := NoneToDefault(CurHighlightElement.Background);
    if BackGroundColorBox.Selected = clDefault then
      BackGroundColorBox.Tag := BackGroundColorBox.DefaultColorColor
    else
      BackGroundColorBox.Tag := BackGroundColorBox.Selected;
    BackGroundUseDefaultCheckBox.Checked := BackGroundColorBox.Selected = clDefault;

    FrameColorBox.Selected := NoneToDefault(CurHighlightElement.FrameColor);
    if FrameColorBox.Selected = clDefault then
      FrameColorBox.Tag := FrameColorBox.DefaultColorColor
    else
      FrameColorBox.Tag := FrameColorBox.Selected;
    FrameColorUseDefaultCheckBox.Checked := FrameColorBox.Selected = clDefault;
  end
  else
  begin
    ForegroundColorBox.Selected := NoneToDefault(GetSingleColor(CurSingleElement));
    if ForegroundColorBox.Selected = clDefault then
      ForegroundColorBox.Tag := ForegroundColorBox.DefaultColorColor
    else
      ForegroundColorBox.Tag := ForegroundColorBox.Selected;
    ForeGroundUseDefaultCheckBox.Checked := ForegroundColorBox.Selected = clDefault;
  end;

  UpdatingColor := False;
end;

procedure TEditorColorOptionsFrame.FindCurHighlightElement;
var
  a, i: Integer;
  h: TAdditionalHilightAttribute;
  s: TSingleColorAttribute;
  Old: TSynHighlightElement;
begin
  Old := CurHighlightElement;
  CurHighlightElement := nil;
  CurSingleElement := Low(TSingleColorAttribute);
  CurExtraElement := Low(TAdditionalHilightAttribute);
  a := ColorElementListBox.ItemIndex;
  if (a >= 0) then
  begin
    i := PreviewSyn.AttrCount - 1;
    while (i >= 0) do
    begin
      if ColorElementListBox.Items[a] = PreviewSyn.Attribute[i].Name then
      begin
        CurHighlightElement := PreviewSyn.Attribute[i];
        break;
      end;
      dec(i);
    end;
  end;

  if (Old <> CurHighlightElement) or (CurHighlightElement = nil) then
  begin
    CurHighlightElementIsExtra := False;
    CurHighlightElementIsSingle := False;

    if CurHighlightElement <> nil then
    begin
      for h := Low(TAdditionalHilightAttribute) to High(TAdditionalHilightAttribute) do
        if ColorElementListBox.Items[a] = AdditionalHighlightAttributes[h] then
        begin
          CurHighlightElementIsExtra := True;
          CurExtraElement := h;
          break;
        end;
    end
    else
    begin
      for s := Low(TSingleColorAttribute) to High(TSingleColorAttribute) do
        if ColorElementListBox.Items[a] = SingleColorAttributes[s] then
        begin
          CurHighlightElementIsSingle := True;
          CurSingleElement := s;
          break;
        end;
    end;
    ShowCurAttribute;
  end;
end;

procedure TEditorColorOptionsFrame.FillColorElementListBox;
var
  i: Integer;
  s: TSingleColorAttribute;
begin
  with ColorElementListBox.Items do
  begin
    BeginUpdate;
    Clear;

    for i := 0 to PreviewSyn.AttrCount - 1 do
      if PreviewSyn.Attribute[i].Name <> '' then
        Add(PreviewSyn.Attribute[i].Name);

    // add single color attributes there
    for s := Low(TSingleColorAttribute) to High(TSingleColorAttribute) do
      Add(SingleColorAttributes[s]);

    EndUpdate;
  end;

  CurHighlightElement := nil;
  CurSingleElement := Low(TSingleColorAttribute);
  CurExtraElement := Low(TAdditionalHilightAttribute);
  CurHighlightElementIsExtra := False;
  CurHighlightElementIsSingle := False;
  if ColorElementListBox.Items.Count > 0 then
    ColorElementListBox.Selected[0] := True;
  FindCurHighlightElement;
end;

procedure TEditorColorOptionsFrame.SetColorElementsToDefaults(
  OnlySelected: Boolean);
var
  DefaultSyn: TSrcIDEHighlighter;
  PascalSyn: TPreviewPasSyn;
  i, j: Integer;
  CurSynClass: TCustomSynClass;
  Scheme: TPascalColorScheme;
  s: TSingleColorAttribute;
begin
  PascalSyn := TPreviewPasSyn(GetHighlighter(TPreviewPasSyn,
    ColorSchemeComboBox.Text, True));
  CurSynClass := TCustomSynClass(PreviewSyn.ClassType);
  DefaultSyn := CurSynClass.Create(nil);
  try
    EditorOpts.AddSpecialHilightAttribsToHighlighter(DefaultSyn);
    EditorOpts.ReadDefaultsForHighlighterSettings(DefaultSyn,
      ColorSchemeComboBox.Text, PascalSyn);
    Scheme := EditorOpts.GetColorScheme(ColorSchemeComboBox.Text);
    for i := 0 to DefaultSyn.AttrCount - 1 do
    begin
      if DefaultSyn.Attribute[i].Name = '' then
        continue;
      if OnlySelected then
      begin
        if (CurHighlightElement <> nil) and (DefaultSyn.Attribute[i].Name = CurHighlightElement.Name) then
          CopyHiLightAttributeValues(DefaultSyn.Attribute[i], CurHighlightElement);
      end
      else
        for j := 0 to PreviewSyn.AttrCount - 1 do
          if PreviewSyn.Attribute[j].Name = DefaultSyn.Attribute[i].Name then
            CopyHiLightAttributeValues(DefaultSyn.Attribute[i],
              PreviewSyn.Attribute[j]);
    end;
    if OnlySelected then
      SetSingleColor(CurSingleElement, Scheme.Single[CurSingleElement])
    else
      for s := Low(TSingleColorAttribute) to High(TSingleColorAttribute) do
        SetSingleColor(s, Scheme.Single[s])
  finally
    DefaultSyn.Free;
  end;
  ShowCurAttribute;
  InvalidatePreviews;
end;

function TEditorColorOptionsFrame.GetCurColorScheme(const LanguageName: String): String;
begin
  if FColorSchemes = nil then
    Result := ''
  else
    Result := FColorSchemes.Values[LanguageName];
  if Result = '' then
    Result := EditorOpts.ReadColorScheme(LanguageName);
end;

procedure TEditorColorOptionsFrame.SetCurColorScheme(const LanguageName,
  ColorScheme: String);
begin
  if FColorSchemes = nil then
    FColorSchemes := TStringList.Create;
  FColorSchemes.Values[LanguageName] := ColorScheme;
end;

function TEditorColorOptionsFrame.GetHighlighter(SynClass: TCustomSynClass;
  const ColorScheme: String; CreateIfNotExists: Boolean): TSrcIDEHighlighter;
var
  i: Integer;
begin
  if FHighlighterList = nil then
    FHighlighterList := TStringList.Create;
  for i := 0 to FHighlighterList.Count - 1 do
    if (FHighlighterList[i] = ColorScheme) and
      (TCustomSynClass(TSrcIDEHighlighter(fHighlighterList.Objects[i]).ClassType) =
      SynClass) then
    begin
      Result := TSrcIDEHighlighter(FHighlighterList.Objects[i]);
      exit;
    end;
  if CreateIfNotExists then
  begin
    Result := SynClass.Create(nil);
    EditorOpts.AddSpecialHilightAttribsToHighlighter(Result);
    FHighlighterList.AddObject(ColorScheme, Result);
    EditorOpts.ReadHighlighterSettings(Result, ColorScheme);
  end;
end;

procedure TEditorColorOptionsFrame.ClearHighlighters;
var
  i: Integer;
begin
  if FHighlighterList = nil then
    Exit;
  for i := 0 to FHighlighterList.Count - 1 do
    TSrcIDEHighlighter(FHighlighterList.Objects[i]).Free;
  FHighlighterList.Free;
end;

procedure TEditorColorOptionsFrame.InvalidatePreviews;

  procedure SetSingleColors(AEditor: TPreviewEditor);
  var
    s: TSingleColorAttribute;
  begin
    for s := Low(TSingleColorAttribute) to High(TSingleColorAttribute) do
      SetSingleColor(AEditor, s, GetSingleColor(s));
  end;

var
  a: Integer;
begin
  with GeneralPage do
    for a := Low(PreviewEdits) to High(PreviewEdits) do
      if PreviewEdits[a] <> nil then
      begin
        EditorOpts.SetMarkupColors(PreviewEdits[a].Highlighter, PreviewEdits[a]);
        SetSingleColors(PreviewEdits[a]);
        PreviewEdits[a].Invalidate;
      end;
end;

procedure TEditorColorOptionsFrame.SetPreviewSynInAllPreviews;
var
  a: Integer;
begin
  with GeneralPage do
    for a := Low(PreviewEdits) to High(PreviewEdits) do
      if PreviewEdits[a] <> nil then
        if UseSyntaxHighlightCheckBox.Checked then
          PreviewEdits[a].Highlighter := PreviewSyn
        else
          PreviewEdits[a].Highlighter := nil;
end;

function TEditorColorOptionsFrame.GetSingleColor(AElement: TSingleColorAttribute): TColor;
begin
  case AElement of
    scaGutter: Result := ColorPreview.Gutter.Color;
    scaRightMargin: Result := ColorPreview.RightEdgeColor;
  end;
end;

procedure TEditorColorOptionsFrame.SetSingleColor(
  AEditor: TPreviewEditor; AElement: TSingleColorAttribute; AColor: TColor);
begin
  case AElement of
    scaGutter: AEditor.Gutter.Color := AColor;
    scaRightMargin: AEditor.RightEdgeColor := AColor;
  end;
end;

procedure TEditorColorOptionsFrame.SetSingleColor(
  AElement: TSingleColorAttribute; AColor: TColor);
begin
  SetSingleColor(ColorPreview, AElement, AColor);
end;

function TEditorColorOptionsFrame.GeneralPage: TEditorGeneralOptionsFrame; inline;
begin
  Result := TEditorGeneralOptionsFrame(FDialog.FindEditor(TEditorGeneralOptionsFrame));
end;

destructor TEditorColorOptionsFrame.Destroy;
begin
  FFileExtensions.Free;
  ClearHighlighters;
  FColorSchemes.Free;
  inherited Destroy;
end;

function TEditorColorOptionsFrame.GetTitle: String;
begin
  Result := dlgEdColor;
end;

procedure TEditorColorOptionsFrame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  FDialog := ADialog;
  UpdatingColor := False;
  CurHighlightElement := nil;
  CurSingleElement := Low(TSingleColorAttribute);
  CurExtraElement := Low(TAdditionalHilightAttribute);
  CurHighlightElementIsExtra := False;
  CurHighlightElementIsSingle := False;

  UseSyntaxHighlightCheckBox.Caption := dlgUseSyntaxHighlight;
  LanguageLabel.Caption := dlgLang;
  ColorSchemeLabel.Caption := dlgClrScheme;

  with ColorSchemeComboBox do
  begin
    ColorSchemeFactory.GetRegisteredSchemes(Items);
    Text := DEFAULT_COLOR_SCHEME.Name;
  end;

  FileExtensionsLabel.Caption := dlgFileExts;
  SetAttributeToDefaultButton.Caption := dlgSetElementDefault;
  SetAllAttributesToDefaultButton.Caption := dlgSetAllElementDefault;
  ForeGroundLabel.Caption := dlgForecolor;
  ForeGroundUseDefaultCheckBox.Caption := dlgEdUseDefColor;
  BackGroundLabel.Caption := dlgBackColor;
  BackGroundUseDefaultCheckBox.Caption := dlgEdUseDefColor;
  FrameColorLabel.Caption := dlgFrameColor;
  FrameColorUseDefaultCheckBox.Caption := dlgEdUseDefColor;
  ElementAttributesGroupBox.Caption := dlgElementAttributes;

  TextBoldCheckBox.Caption := dlgEdBold;
  TextBoldRadioOn.Caption := dlgEdOn;
  TextBoldRadioOff.Caption := dlgEdOff;
  TextBoldRadioInvert.Caption := dlgEdInvert;

  TextItalicCheckBox.Caption := dlgEdItal;
  TextItalicRadioOn.Caption := dlgEdOn;
  TextItalicRadioOff.Caption := dlgEdOff;
  TextItalicRadioInvert.Caption := dlgEdInvert;

  TextUnderlineCheckBox.Caption := dlgEdUnder;
  TextUnderlineRadioOn.Caption := dlgEdOn;
  TextUnderlineRadioOff.Caption := dlgEdOff;
  TextUnderlineRadioInvert.Caption := dlgEdInvert;

  BracketLabel.Caption := dlgBracketHighlight;
  BracketCombo.Items.Add(dlgNoBracketHighlight);
  BracketCombo.Items.Add(dlgHighlightLeftOfCursor);
  BracketCombo.Items.Add(dlgHighlightRightOfCursor);
  BracketCombo.Items.Add(gldHighlightBothSidesOfCursor);

  with GeneralPage do
    AddPreviewEdit(ColorPreview);
end;

procedure TEditorColorOptionsFrame.ReadSettings(AOptions: TAbstractIDEOptions);
var
  i: integer;
begin
  // here we are sure that Setup has been called for every frame =>
  // we can assign events to every registered preview control

  with GeneralPage do
    for i := Low(PreviewEdits) to High(PreviewEdits) do
    begin
      PreviewEdits[i].OnStatusChange := @OnStatusChange;
      PreviewEdits[i].OnSpecialLineMarkup := @OnSpecialLineMarkup;
    end;

  with AOptions as TEditorOptions do
  begin
    UseSyntaxHighlightCheckBox.Checked := UseSyntaxHighlight;
    if eoBracketHighlight in SynEditOptions then
      BracketCombo.ItemIndex := Ord(BracketHighlightStyle) + 1
    else
      BracketCombo.ItemIndex := 0;

    with LanguageComboBox do
      with Items do
      begin
        BeginUpdate;
        for i := 0 to EditorOpts.HighlighterList.Count - 1 do
          Add(HighlighterList[i].SynClass.GetLanguageName);
        EndUpdate;
      end;

    with FileExtensionsComboBox, GeneralPage do
      if CurLanguageID >= 0 then
        SetComboBoxText(FileExtensionsComboBox,
          HighlighterList[CurLanguageID].FileExtensions);

    PreviewSyn := GetHighlighter(TPreviewPasSyn, GetCurColorScheme(TPreviewPasSyn.GetLanguageName), True);
    CurLanguageID := HighlighterList.FindByClass(TCustomSynClass(PreviewSyn.ClassType));

    with GeneralPage do
      for i := Low(PreviewEdits) to High(PreviewEdits) do
        if PreviewEdits[i] <> nil then
          with PreviewEdits[i] do
          begin
            if UseSyntaxHighlight then
              Highlighter := PreviewSyn
            else
              Highlighter := nil;
            Lines.Text := HighlighterList[CurLanguageID].SampleSource;
            CaretXY := HighlighterList[CurLanguageID].CaretXY;
            TopLine := 1;
            LeftChar := 1;
          end;

    LanguageComboBox.Text := PreviewSyn.LanguageName;
    SetComboBoxText(LanguageComboBox, LanguageComboBox.Text);
    ColorSchemeComboBox.Text := GetCurColorScheme(PreviewSyn.LanguageName);
    SetComboBoxText(ColorSchemeComboBox, ColorSchemeComboBox.Text);

    FillColorElementListBox;
    FindCurHighlightElement;
    ShowCurAttribute;
    InvalidatePreviews;
  end;
end;

procedure TEditorColorOptionsFrame.WriteSettings(AOptions: TAbstractIDEOptions);

  procedure WriteSingleColor(s: TSingleColorAttribute; AColor: TColor);
  begin
    case s of
      scaGutter: TEditorOptions(AOptions).GutterColor := AColor;
      scaRightMargin: TEditorOptions(AOptions).RightMarginColor := AColor;
    end;
  end;

var
  i, j: Integer;
  Syn: TSrcIDEHighlighter;
  s: TSingleColorAttribute;
begin
  with AOptions as TEditorOptions do
  begin
    UseSyntaxHighlight := UseSyntaxHighlightCheckBox.Checked;

    if BracketCombo.ItemIndex = 0 then
      SynEditOptions := SynEditOptions - [eoBracketHighlight]
    else
    begin
      SynEditOptions := SynEditOptions + [eoBracketHighlight];
      BracketHighlightStyle := TSynEditBracketHighlightStyle(BracketCombo.ItemIndex - 1);
    end;

    if FFileExtensions <> nil then
    begin
      for i := 0 to FFileExtensions.Count - 1 do
      begin
        j := HighlighterList.FindByName(FFileExtensions.Names[i]);
        if j >= 0 then
          HighlighterList[j].FileExtensions := FFileExtensions.ValueFromIndex[i];
      end;
    end;

    if FColorSchemes <> nil then
    begin
      for i := 0 to FColorSchemes.Count - 1 do
         WriteColorScheme(FColorSchemes.Names[i],
           FColorSchemes.Values[FColorSchemes.Names[i]]);
    end;

    if FHighlighterList <> nil then
    begin
      for i := 0 to FHighlighterList.Count - 1 do
      begin
        Syn := TSrcIDEHighlighter(FHighlighterList.Objects[i]);
        WriteHighlighterSettings(Syn, FHighlighterList[i]);
      end;
    end;

    // write single colors
    for s := Low(TSingleColorAttribute) to High(TSingleColorAttribute) do
      WriteSingleColor(s, GetSingleColor(s));
  end;
end;

class function TEditorColorOptionsFrame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TEditorOptions;
end;

procedure TEditorColorOptionsFrame.ComboBoxOnChange(Sender: TObject);
var
  ComboBox: TComboBox absolute Sender;
begin
  if ComboBox.Items.IndexOf(ComboBox.Text) >= 0 then
    ComboBoxOnExit(Sender);
end;

procedure TEditorColorOptionsFrame.ComboBoxOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_S) then
    ComboBoxOnExit(Sender);
end;

function TEditorColorOptionsFrame.GetCurFileExtensions(const LanguageName: String): String;
var
  i: Integer;
begin
  if FFileExtensions = nil then
    Result := ''
  else
    Result := FFileExtensions.Values[LanguageName];
  if Result = '' then
  begin
    i := EditorOpts.HighlighterList.FindByName(LanguageName);
    if i >= 0 then
      Result := EditorOpts.HighlighterList[i].FileExtensions;
  end;
end;

procedure TEditorColorOptionsFrame.SetCurFileExtensions(const LanguageName, FileExtensions: String);
begin
  if FFileExtensions = nil then
    FFileExtensions := TStringList.Create;
  FFileExtensions.Values[LanguageName] := FileExtensions;
end;

procedure TEditorColorOptionsFrame.OnSpecialLineMarkup(Sender: TObject;
  Line: Integer; var Special: boolean; aMarkup: TSynSelectedColor);
var
  e: TSynHighlightElement;
  AddAttr: TAdditionalHilightAttribute;
  i: Integer;
begin
  if CurLanguageID >= 0 then
  begin
    AddAttr := EditorOpts.HighlighterList[CurLanguageID].SampleLineToAddAttr(Line);
    if AddAttr <> ahaNone then
    begin
      i := PreviewSyn.AttrCount - 1;
      while (i >= 0) do
      begin
        e := PreviewSyn.Attribute[i];
        if e.Name = '' then
          continue;
        if e.Name = AdditionalHighlightAttributes[AddAttr] then
        begin
          Special := True;
          EditorOpts.SetMarkupColor(PreviewSyn, AddAttr, aMarkup);
          exit;
        end;
        dec(i);
      end;
    end;
  end;
end;

type
  // This is only needed until SynEdit does the ScrollWindowEx in Paint, instead of SetTopline
  TSynEditAccess = class(TSynEdit);
procedure TEditorColorOptionsFrame.OnStatusChange(Sender : TObject; Changes : TSynStatusChanges);
var
  Syn: TSynEditAccess;
  p: TPoint;
  tl, lc: Integer;
begin
  p := EditorOpts.HighlighterList[CurLanguageID].CaretXY;
  Syn := TSynEditAccess(Pointer(Sender as TSynEdit));
  if p.y > Syn.Lines.Count then exit;
  if (Syn.CaretX = p.x) and (Syn.Carety = p.y) then exit;
  try
    Syn.IncPaintLock;
    tl := Syn.TopLine;
    lc := Syn.LeftChar;
    Syn.CaretXY:= p;
    Syn.TopLine := tl;
    Syn.LeftChar := lc;
  finally
    Syn.DecPaintLock;
  end;
end;

initialization
  {$I editor_color_options.lrs}
  RegisterIDEOptionsEditor(GroupEditor, TEditorColorOptionsFrame, EdtOptionsColors);
end.
