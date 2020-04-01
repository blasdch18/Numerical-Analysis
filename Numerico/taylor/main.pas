unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Grids, StdCtrls, class_taylor;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
const
 col_pos = 0;
 col_suc = 1;
 col_err1 = 2;
 col_err2 = 3;
 col_err3 = 4;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var Taylor: TTaylor;
begin
  Taylor:= TTaylor.create;
  Taylor.TaylorType:= RadioGroup1.ItemIndex;
  Taylor.x:= StrToFloat( Edit1.Text );
  Taylor.Error:= StrToFloat( Edit2.Text );
  Label1.Caption:= RadioGroup1.Items[ RadioGroup1.ItemIndex ] +
                   '( ' + Edit1.Text + ' ) = ' +
                   FloatToStr(  Taylor.execute );
  StringGrid1.Cols[ col_suc ].Assign( Taylor.Lxn );
  Taylor.Destroy;

end;

end.

