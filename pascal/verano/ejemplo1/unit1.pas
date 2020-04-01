unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    execute: TButton;
    Edin: TEdit;
    par: TLabel;
    impar: TLabel;
    lblbutton: TLabel;
    procedure EdinChange(Sender: TObject);
    procedure executeClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.executeClick(Sender: TObject);
var mysum: TsumaN;
begin
  mysum:= TsumaN.Create;
  mysum.n:= StrToInt(edin.Text);
  lblbutton.caption:= IntToStr(mysum.sum());
  par.caption:=IntToStr(mysum.sum_par());
  impar.caption:=IntTostr(mysum.sum_impar());
  mysum.destroy;
end;

procedure TForm1.EdinChange(Sender: TObject);
begin

end;

end.

