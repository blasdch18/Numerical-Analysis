unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,ParseMath,
  Dialogs, StdCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    FunPlot: TLineSeries;
    EjeY: TConstantLine;
    EjeX: TConstantLine;
    DerF: TComboBox;
    Label10: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StringGrid1: TStringGrid;
    Xo: TEdit;
    Yo: TEdit;
    Fx: TEdit;
    h: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure GraficarFuncionConPloteo();
    function Df(x1,y:Double;def:String):Double;
  private
    { private declarations }
    Parse:TParseMath;
    cont:Integer;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Parse:=TParseMath.create();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  def:string;
  xn,yn,h1,ynM,fx1,pendiente,ynAst,k1,k2,k3,k4,k5,k6,k7,Z_Y:Double;
  i:Integer;
begin
  def:=DerF.Text;
  xn:=StrToFloat(Xo.Text);
  yn:=StrToFloat(Yo.Text);
  //h1:=StrToFloat(h.Text);
  h1:=(fx1-xn)/100;
  fx1:=StrToFloat(Fx.Text);   //este es el punto final
  i:=0;
  if fx1<0 then begin
      while xn>=fx1 do begin
             k1:=0;k2:=0;k3:=0;k4:=0;
             k1:=h1*Df(xn,Yn,def);
             k2:=h1*Df(xn+h1/5,yn+k1*h1/5,def);
             k3:=h1*Df(Xn+3*h1/10,yn+3/40*k1+k2*9/40,def);
             k4:=h1*Df(xn+4/5*h1,yn+44/45*k1-56/15*k2+32/9*k3,def);
             k5:=h1*Df(xn+8/9*h1,yn+19372/6561*k1-25360/2187*k2+64448/6561*k3-212/729*k4,def);
             k6:=h1*Df(xn+h1,yn+9017/3168*k1-355/33*k2-46732/5247*k3+49/176*k4-5103/18656*k5,def);
             k7:=h1*Df(xn+h1,yn+35/384*k1+500/1113*k3+125/192*k4-2187/6784*k5+11/84*k6,def);
             pendiente:=35/384*k1+500/1113*k3+125/192*k4-2187/6784*k5+11/84*k6;
             Z_Y:=yn +5179/57600*k1 +7571/16695*k3 +393/640*k4-92097/339200*k5 +187/2100*k6 +1/40*k7;
             StringGrid1.Cells[0,i]:=IntToStr(i);
             StringGrid1.Cells[1,i]:=FloatToStr(xn);
             StringGrid1.Cells[2,i]:=FloatToStr(yn);
             StringGrid1.Cells[3,i]:=FloatToStr(k1);
             StringGrid1.Cells[4,i]:=FloatToStr(k2);
             StringGrid1.Cells[5,i]:=FloatToStr(k3);
             StringGrid1.Cells[6,i]:=FloatToStr(k4);
             StringGrid1.Cells[7,i]:=FloatToStr(k5);
             StringGrid1.Cells[8,i]:=FloatToStr(k6);
             StringGrid1.Cells[9,i]:=FloatToStr(k7);
             StringGrid1.Cells[10,i]:=FloatToStr(pendiente);
             StringGrid1.Cells[11,i]:=FloatToStr(Z_Y);
             yn:=yn+pendiente;
             xn:=xn-h1;
             i:=i+1;
             StringGrid1.RowCount:=StringGrid1.RowCount+1;
             cont:=cont+1;
          end;
  end
  else begin
        while xn<=fx1 do begin
             k1:=h1*Df(xn,Yn,def);
             k2:=h1*Df(xn+h1/5,yn+k1*h1/5,def);
             k3:=h1*Df(Xn+3*h1/10,yn+3/40*k1+k2*9/40,def);
             k4:=h1*Df(xn+4/5*h1,yn+44/45*k1-56/15*k2+32/9*k3,def);
             k5:=h1*Df(xn+8/9*h1,yn+19372/6561*k1-25360/2187*k2+64448/6561*k3-212/729*k4,def);
             k6:=h1*Df(xn+h1,yn+9017/3168*k1-355/33*k2-46732/5247*k3+49/176*k4-5103/18656*k5,def);
             k7:=h1*Df(xn+h1,yn+35/384*k1+500/1113*k3+125/192*k4-2187/6784*k5+11/84*k6,def);
             //pendiente:=35/384*k1+500/1113*k3+125/192*k4-2187/6784*k5+11/84*k6;
           pendiente:=35/384*k1+500/1113*k3+125/192*k4-2187/6784*k5+11/84*k6;
           Z_Y:=yn +5179/57600*k1 +7571/16695*k3 +393/640*k4-92097/339200*k5 +187/2100*k6 +1/40*k7;
           StringGrid1.Cells[0,i]:=IntToStr(i);
           StringGrid1.Cells[1,i]:=FloatToStr(xn);
           StringGrid1.Cells[2,i]:=FloatToStr(yn);
           StringGrid1.Cells[3,i]:=FloatToStr(k1);
           StringGrid1.Cells[4,i]:=FloatToStr(k2);
           StringGrid1.Cells[5,i]:=FloatToStr(k3);
           StringGrid1.Cells[6,i]:=FloatToStr(k4);
           StringGrid1.Cells[7,i]:=FloatToStr(k5);
           StringGrid1.Cells[8,i]:=FloatToStr(k6);
           StringGrid1.Cells[9,i]:=FloatToStr(k7);
           StringGrid1.Cells[10,i]:=FloatToStr(pendiente);
           StringGrid1.Cells[11,i]:=FloatToStr(Z_Y);
           yn:=yn+pendiente;
           xn:=xn+h1;
           i:=i+1;
           StringGrid1.RowCount:=StringGrid1.RowCount+1;
           cont:=cont+1;
        end;
  end;
  GraficarFuncionConPloteo();
  FunPlot.Active:=true;
end;

Procedure TForm1.GraficarFuncionConPloteo();
var i: Integer;
    Max, Min, h1, NewX: Real;

begin

    FunPlot.Clear;
    Max:= StrToFloat(Fx.Text);
    Min:=  StrToFloat(Xo.Text);
    NewX:= StrToFloat(Xo.Text);
    h1:=StrToFloat(h.Text);
     for i:=0 to cont-1 do  begin
        FunPlot.AddXY( StrToFloat(StringGrid1.Cells[1,i]),StrToFloat(StringGrid1.Cells[2,i]));
     end;
end;
function TForm1.Df(x1,y:Double;def:String):Double;
var
  resp:Double;
  evaluador:TParseMath;
begin
     try
     evaluador:=TParseMath.create();
     evaluador.AddVariable('x',x1);
     evaluador.AddVariable('y',y);
     evaluador.Expression:=def;
     resp:=evaluador.Evaluate();
     Df:=resp;
     Except
       Df:=0;
       Exit;
     end;
end;

end.

