unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Go: TButton;
    edix: TEdit;
    sen: TRadioButton;
    coseno: TRadioButton;
    exp: TRadioButton;
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    procedure senChange(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
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

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin

end;

procedure TForm1.senChange(Sender: TObject);
begin

end;

end.

