unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, math, ParseMath,
  StdCtrls, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonRK4: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    RKy0: TEdit;
    RKx0: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    StringGrid2: TStringGrid;
    procedure ButtonRK4Click(Sender: TObject);
    procedure ButtonRK3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function evaluar(valorX : float ; valorY: float;  funcion : String ) : float;
var
   MiParse : TParseMath;
begin
  Miparse := TParseMath.create();
  MiParse.AddVariable('x',valorX);
  MiParse.AddVariable('y',valorY);
  MiParse.Expression:=funcion;
  evaluar := MiParse.Evaluate();
end;

{ TForm1 }







procedure TForm1.ButtonRK4Click(Sender: TObject);
var
   fun : String;
   x_0 ,y_0 ,h ,k1 ,k2 ,k3 ,k4 ,y_1: float;
   i,i1,j : Integer;
begin
   StringGrid2.RowCount := 2;
   fun := Edit5.Text;
   x_0 := StrToFloat(RKx0.Text);
   y_0 := StrToFloat(RKy0.Text);
   h := StrToFloat(Edit6.Text);
   i1 := Round((StrToFloat(Edit7.Text) - x_0)/h);
   StringGrid2.RowCount := i1+2;

   StringGrid2.Cells[0,1] := FloatToStr(0);
   StringGrid2.Cells[1,1] := FloatToStr(x_0);
   StringGrid2.Cells[6,1] := FloatToStr(y_0);

 for i := 2 to  i1 +1do
 begin
     k1 := evaluar(x_0,y_0,fun)*h;
     k2 := evaluar(x_0 + (h/2), y_0 + (k1/2),fun)*h;
     k3 := evaluar(x_0 + (h/2), y_0 + (k2/2),fun)*h;
     k4 := evaluar(x_0 + h , y_0 + k3,fun)*h;
     y_1 := y_0 + (k1 + 2*k2 + 2*k3 +k4)/6;

     x_0 := x_0 + h;
     y_0 := y_1;

     { LLenado de String Grid }
         StringGrid2.Cells[0,i] := FloatToStr(i-1);
         StringGrid2.Cells[1,i] := FloatToStr(x_0);
         StringGrid2.Cells[2,i] := formatfloat('0.00000000',k1);
         StringGrid2.Cells[3,i] := formatfloat('0.00000000',k2);
         StringGrid2.Cells[4,i] := formatfloat('0.00000000',k3);
         StringGrid2.Cells[5,i] := formatfloat('0.00000000',k4);
         StringGrid2.Cells[6,i] := formatfloat('0.00000000',y_1);
     { End LLenado de String Grid }



 end;

end;

procedure TForm1.ButtonRK3Click(Sender: TObject);
var
   fun : String;
   x_0 ,y_0 ,h ,k1 ,k2 ,k3 ,y_1: float;
   i,i1,j : Integer;
begin
   StringGrid2.RowCount := 2;
   ShowMessage('h');
   fun := Edit5.Text;
   x_0 := StrToFloat(RKx0.Text);
   y_0 := StrToFloat(RKy0.Text);
   h := StrToFloat(Edit6.Text);
   i1 := Round((StrToFloat(Edit7.Text) - x_0)/h);
   StringGrid2.RowCount := i1+2;

   StringGrid2.Cells[0,1] := FloatToStr(0);
   StringGrid2.Cells[1,1] := FloatToStr(x_0);
   StringGrid2.Cells[6,1] := FloatToStr(y_0);

 for i := 2 to  i1+1 do
 begin
     k1 := h*evaluar(x_0,y_0,fun);
     k2 := h*evaluar(x_0 + (h/2), y_0 + (k1/2),fun);
     k3 := h*evaluar(x_0 + h, y_0 - k1 +2*k2 ,fun);
     y_1 := y_0 + (k1 + 4*k2 + k3)/6;

     x_0 := x_0 + h;
     y_0 := y_1;
     { LLenado de String Grid }
         StringGrid2.Cells[0, i] := FloatToStr(i);
         StringGrid2.Cells[1,i] := FloatToStr(x_0);
         StringGrid2.Cells[2,i] := FloatToStr(k1);
         StringGrid2.Cells[3,i] := FloatToStr(k2);
         StringGrid2.Cells[4,i] := FloatToStr(k3);
         StringGrid2.Cells[6,i] := FloatToStr(y_1);
     { End LLenado de String Grid }



 end;

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

end.

