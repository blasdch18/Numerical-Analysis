unit unit_newton;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls, Spin, Types,
  Grids, StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure BotonClicked(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

  f_x, g_x, derivada, error1, error2, Xn, Xn_1, x, h, eval : double;
  i :     integer;


implementation

{$R *.lfm}

{ TForm1 }
function fx(x: double): double;
var
  f:     string;
begin
     {funcion}
  //f_x:=power(x,2) - 2*x - 3;
  //f_x:=ln(x)*sin(x);        //newton
  //f_x:=ln(((power(x,2))+1)*(power(((2*x)+1),0.5 )));
  //f_x:=power(x,3) - 2*x + 2;        //newton
  //f_x:=x*sin (x);
  f_x:=-(power (25-x , 0.5 ));
  //f_x:=power(x,2) - 2*x -3;      // punto fijo

  fx:= f_x;
end;
function gx(x: double): double;
begin
  //g_x:= fx(x) + x;
  //g_x:={function}
  g_x:=power( (2*x + 3) , 0.5 );
  gx:=g_x;
end;
function dx1(x: double): double;
var
  h: double;
begin
  h:=error1/10;
  dx1:=abs (fx(x+h)-fx(x))/h;
end;
function dx1_manual(x: double): double;
begin
  {funcion= power(x,3) - 3*x + 2 }
//  dx1_manual:=3*(x*x) - 2;
  {funcion= Ln(x) * Sen (x)}
  //dx1_manual:=( (sin(x)/x) + ( ln(x)*cos(x) ) );
  dx1_manual:=-1/(2*(power ( 25-x ,0.5)));
  {derivadas para punto fijo }
  //dx1_manual:= 1/( power( 2*x + 3 , 0.5 ) );
  //dx1_manual:= sin(x) + x*sin(x);
end;
function dx2(x: double): double;
var
  h: double;
begin
  h:=error1/10;
  dx2:=(fx(x+h)-fx(x-h))/(2*h);
end;
function dx3(x: double): double;
var
  h: double;
begin
  h:=error1/10;
  dx3:=(gx(x+h)-gx(x)/h);
end;
function evaluar_dx(x: double): boolean;
var
  tmp: double;
begin
  //tmp:=dx1(x);
  //if tmp=0 then exit;
  evaluar_dx:= (dx1(x)=0);
end;
function newton(x: double): double;
begin
  derivada:=dx1_manual( x );
  //ShowMessage(FloatToStr(derivada));
  if (derivada=0) then
     begin
       ShowMessage('No converge') ;
       exit;
     end;

     //exit;
  Xn_1:= x -( fx( x )/dx1_manual( x ) );
  newton:=Xn_1;
end;
function secante(x: double): double;
begin
  Xn_1:=x-(fx(x))/(dx2(x));
  secante:=Xn_1;
end;
function evaluar_dx_gx(x : double): boolean;
var
  tmp1, tmp2 , uno ,zero:  double;
begin
//  tmp1:= dx1_manual(x);
  derivada:= dx1_manual(x);
  tmp2:=fx(derivada);

  showmessage(FloatToStr(tmp2));
  uno:=1;
  zero:=0;
  evaluar_dx_gx:= (derivada >zero) and (derivada <uno);
end;
function punto_fijo( x: double ): double;
begin
  if (evaluar_dx_gx( x )) then
     begin
      punto_fijo := gx( x )
     end
  else
      begin
           showMessage('g(x) !E [0,1]');
           exit;
      end;
end;
procedure TForm1.Edit1Change(Sender: TObject);
begin

end;
procedure TForm1.BotonClicked(Sender: TObject);
var
  fgx: double;
  e_tmp: double;
begin
  Xn:= StrToFloat(Edit1.TExt);
  error1:= StrToFloat(Edit2.Text);
  i:= 1;
  error2:=50;
  Xn_1:=0;
  e_tmp:=0;
  Try
     while (error2>error1) do
     begin
         if Radiobutton1.Checked then
             xn_1:= newton ( xn )

         else
             if Radiobutton2.Checked then
                xn_1:= secante ( xn )
             else
                if Radiobutton3.checked then
                   xn_1:=punto_fijo ( xn );

         StringGrid2.RowCount:=i+1  ;
         StringGrid2.Cells[0,i]:=FloatToStr(derivada);
         StringGrid1.RowCount:= i+1;
         StringGrid1.Cells[0,i]:=FloatToStr(i-1);
         StringGrid1.Cells[1,i]:=FormatFloat('0.00000',xn);
         StringGrid1.Cells[2,i]:=FormatFloat('0.00000',xn_1);
         if i=0 then
            error2:=50
         else
            error2:= abs ( Xn_1 - Xn );
         StringGrid1.Cells[3,i]:=FormatFloat('0.00000',error2);
         i:=i+1;
         Xn:=Xn_1;
     end;
   Except
         //ShowMessage('NO ES CONTINUA');
end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
  //EditB.Clear;
end;
end.
