unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  StdActns, StdCtrls, Menus, ComCtrls, ExtCtrls,
  SpkToolbar, spkt_Buttons, spkt_Checkboxes, spkt_Pane, spkt_Tab, spkt_Appearance;

type

  { TForm1 }

  TForm1 = class(TForm)
    AcOpen: TAction;
    AcClassicalGUI: TAction;
    AcRibbonGUI: TAction;
    AcSave: TAction;
    AcQuit: TAction;
    AcAutoSave: TAction;
    AcSaveNow: TAction;
    AcBold: TAction;
    AcItalic: TAction;
    AcLeftJustify: TAction;
    AcCenter: TAction;
    AcRightJustify: TAction;
    AcAbout: TAction;
    AcUnderline: TAction;
    ActionList: TActionList;
    AcEditCopy: TEditCopy;
    AcEditCut: TEditCut;
    AcEditPaste: TEditPaste;
    ImageList: TImageList;
    Label1: TLabel;
    LargeImageList: TImageList;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    SpkLargeButton4: TSpkLargeButton;
    SpkPane2: TSpkPane;
    SpkPane4: TSpkPane;
    SpkSmallButton10: TSpkSmallButton;
    SpkSmallButton11: TSpkSmallButton;
    SpkSmallButton4: TSpkSmallButton;
    SpkSmallButton6: TSpkSmallButton;
    SpkSmallButton8: TSpkSmallButton;
    SpkSmallButton9: TSpkSmallButton;
    SpkTab4: TSpkTab;
    SpkTab5: TSpkTab;
    StyleMenu: TPopupMenu;
    SpkCheckbox1: TSpkCheckbox;
    SpkLargeButton1: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane3: TSpkPane;
    SpkPane5: TSpkPane;
    SpkPane6: TSpkPane;
    SpkRadioButton1: TSpkRadioButton;
    SpkRadioButton2: TSpkRadioButton;
    SpkSmallButton1: TSpkSmallButton;
    SpkSmallButton2: TSpkSmallButton;
    SpkSmallButton3: TSpkSmallButton;
    SpkSmallButton5: TSpkSmallButton;
    SpkSmallButton7: TSpkSmallButton;
    SpkTab1: TSpkTab;
    SpkTab2: TSpkTab;
    SpkTab3: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure AcAboutExecute(Sender: TObject);
    procedure AcAutoSaveExecute(Sender: TObject);
    procedure AcBoldExecute(Sender: TObject);
    procedure AcCenterExecute(Sender: TObject);
    procedure AcClassicalGUIExecute(Sender: TObject);
    procedure AcEditCopyExecute(Sender: TObject);
    procedure AcEditCutExecute(Sender: TObject);
    procedure AcEditPasteExecute(Sender: TObject);
    procedure AcItalicExecute(Sender: TObject);
    procedure AcLeftJustifyExecute(Sender: TObject);
    procedure AcOpenExecute(Sender: TObject);
    procedure AcQuitExecute(Sender: TObject);
    procedure AcRibbonGUIExecute(Sender: TObject);
    procedure AcRightJustifyExecute(Sender: TObject);
    procedure AcSaveExecute(Sender: TObject);
    procedure AcSaveNowExecute(Sender: TObject);
    procedure AcUnderlineExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure StyleMenuClick(Sender: TObject);
  private
    { private declarations }
    procedure LoadFromIni;
    procedure SaveToIni;
    procedure SetStyle(AStyle: TSpkStyle);
    procedure SetUserInterface(Ribbon:boolean);
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  inifiles, unit2;


{ TForm1 }

procedure TForm1.AcClassicalGUIExecute(Sender: TObject);
begin
  SetUserInterface(false);
end;

procedure TForm1.AcAboutExecute(Sender: TObject);
var
  F: TAboutForm;
begin
  F := TAboutForm.Create(nil);
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;

procedure TForm1.AcAutoSaveExecute(Sender: TObject);
begin
  //  Checked is handled by "AutoCheck". Need this method to have the action enabled.
end;

procedure TForm1.AcBoldExecute(Sender: TObject);
begin
  Label1.Caption := '"Bold" clicked';
end;

procedure TForm1.AcCenterExecute(Sender: TObject);
begin
  Label1.Caption := '"Center" clicked';
end;

procedure TForm1.AcEditCopyExecute(Sender: TObject);
begin
  Label1.Caption := '"Copy" clicked';
end;

procedure TForm1.AcEditCutExecute(Sender: TObject);
begin
  Label1.Caption := '"Cut" clicked';
end;

procedure TForm1.AcEditPasteExecute(Sender: TObject);
begin
  Label1.Caption := '"Paste" clicked';
end;

procedure TForm1.AcItalicExecute(Sender: TObject);
begin
  Label1.Caption := '"Italic" clicked';
end;

procedure TForm1.AcLeftJustifyExecute(Sender: TObject);
begin
  Label1.Caption := '"Left-justify" clicked';
end;

procedure TForm1.AcOpenExecute(Sender: TObject);
begin
  Label1.Caption := '"Open" clicked';
end;

procedure TForm1.AcQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.AcRibbonGUIExecute(Sender: TObject);
begin
  SetUserInterface(true);
end;

procedure TForm1.AcRightJustifyExecute(Sender: TObject);
begin
  Label1.Caption := '"Right-justify" clicked';
end;

procedure TForm1.AcSaveExecute(Sender: TObject);
begin
  Label1.Caption := '"Save" clicked';
end;

procedure TForm1.AcSaveNowExecute(Sender: TObject);
begin
  SaveToIni;
end;

procedure TForm1.AcUnderlineExecute(Sender: TObject);
begin
  Label1.Caption := '"Underline" clicked';
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if CanClose then
    if MessageDlg('Do you really want to close this application?', mtConfirmation,
      [mbYes, mbNo], 0) <> mrYes
    then
      CanClose := false;
  if CanClose then
    if AcAutoSave.Checked then
      SaveToIni;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetUserInterface(true);
  Label1.Caption := '';
  LoadFromIni;
end;

procedure TForm1.LoadFromIni;
var
  ini: TCustomIniFile;
begin
  ini := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    SetUserInterface(ini.ReadBool('MainForm', 'RibbonInterface', AcRibbonGUI.Checked));
    SpkToolbar1.Style := TSpkStyle(ini.ReadInteger('MainForm', 'RibbonStyle', 0));
    SetStyle(SpkToolbar1.Style);
  finally
    ini.Free;
  end;
end;

procedure TForm1.StyleMenuClick(Sender: TObject);
var
  i: Integer;
begin
//  SpkToolbar1.Style := TSpkStyle((Sender as TMenuItem).Tag);
  for i:=0 to StyleMenu.Items.Count-1 do
    StyleMenu.Items[i].Checked := StyleMenu.Items[i] = TMenuItem(Sender);
  SetStyle(TSpkStyle((Sender as TMenuItem).Tag));
end;

procedure TForm1.SetStyle(AStyle: TSpkStyle);
begin
  SpkToolbar1.Style := AStyle;
  case SpkToolbar1.Style of
    spkOffice2007Blue            : SpkToolbar1.Color := clSkyBlue;
    spkOffice2007Silver          : SpkToolbar1.Color := clWhite;
    spkOffice2007SilverTurquoise : SpkToolbar1.Color := clWhite;
    spkMetroLight                : SpkToolbar1.Color := clSilver;
    spkMetroDark                 : SpkToolbar1.Color := $080808;
  end;
end;

procedure TForm1.SaveToIni;
var
  ini: TCustomIniFile;
begin
  ini := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    ini.WriteBool('MainForm', 'RibbonInterface', AcRibbonGUI.Checked);
    ini.WriteInteger('MainForm', 'RibbonStyle', ord(SpkToolbar1.Style));
  finally
    ini.Free;
  end;
end;

procedure TForm1.SetUserInterface(Ribbon: boolean);
begin
  if Ribbon then begin
    Menu := nil;
    Toolbar1.Hide;
    SpkToolbar1.Show;
    AcRibbonGUI.Checked := true;
  end else begin
    SpkToolbar1.Hide;
    Menu := MainMenu;
    Toolbar1.Show;
    AcClassicalGUI.Checked := true;
  end;
end;

end.

