unit calculadora;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, Buttons, ActnList, main, ParseMath, funciones;

type

  { TfrmCaluladora }

  TfrmCaluladora = class(TForm)
    aclFunciones: TActionList;
    AddText: TAction;
    bbtn10: TBitBtn;
    bbtn11: TBitBtn;
    bbtn12: TBitBtn;
    bbtn13: TBitBtn;
    bbtn14: TBitBtn;
    bbtn15: TBitBtn;
    bbtn16: TBitBtn;
    bbtn17: TBitBtn;
    bbtn20: TBitBtn;
    bbtn21: TBitBtn;
    bbtn22: TBitBtn;
    bbtn3: TBitBtn;
    bbtn6: TBitBtn;
    bbtn7: TBitBtn;
    bbtn8: TBitBtn;
    bbtn9: TBitBtn;
    bbtnPorCentaje: TBitBtn;
    bbtnDividir: TBitBtn;
    bbtnMultiplicacion: TBitBtn;
    bbtnResta: TBitBtn;
    bbtnCero2: TBitBtn;
    bbtn2: TBitBtn;
    bbtn1: TBitBtn;
    bbtnIgual: TBitBtn;
    bbtnCero6: TBitBtn;
    bbtnSuma: TBitBtn;
    bbtn4: TBitBtn;
    bbtn5: TBitBtn;
    mMenu: TMainMenu;
    memDatos: TMemo;
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
    mitemCalculadora: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    pnlTop: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ppupMenu: TPopupMenu;
    sbtnConversiones: TSpeedButton;
    sbtnConversiones1: TSpeedButton;
    procedure AddTextExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mitemCalculadoraClick(Sender: TObject);
    procedure sbtnConversiones1Click(Sender: TObject);
    procedure sbtnConversionesClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCaluladora: TfrmCaluladora;

implementation

{$R *.lfm}

{ TfrmCaluladora }

procedure TfrmCaluladora.sbtnConversionesClick(Sender: TObject);
begin
  ppupMenu.PopUp();
end;

procedure TfrmCaluladora.FormCreate(Sender: TObject);
begin

end;

procedure TfrmCaluladora.AddTextExecute(Sender: TObject);
begin

  if Not ( Sender is TBitBtn ) then
     Exit;

  memDatos.Text:= memDatos.Text + TBitBtn( Sender ).Caption;

end;

procedure TfrmCaluladora.mitemCalculadoraClick(Sender: TObject);
begin
   frmGraficadora.Show;
end;

procedure TfrmCaluladora.sbtnConversiones1Click(Sender: TObject);
begin
  frmFunciones.Show;
end;

end.

