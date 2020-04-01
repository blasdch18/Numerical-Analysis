unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Grids, StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BotonClick: TButton;
    Edit1: TEdit;
    EditA: TEdit;
    EditB: TEdit;
    lb1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
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

  a, b:                    double;
  error1, error2:          double;
  Xn_1:                    double;
  f_x, Xn, sgn:            double;
  fa, fb:                  double;

  i, j:                    integer;
  num, zero:               integer;

implementation

{$R *.lfm}

{ TForm1 }
function fx(x: double): double;
begin
                {funcion x^2-ln(x)*e^x}
  //f_x:=power(x,2)-(ln(x))*(power(2.71828183,x));
  //f_x:=x*x-(ln(x))*(power(2.718281828459045235360,x));
  //f_x:=ln( x );
  f_x:= x/((power(x,2))-1);

  //f_x:=x/(power(x,2)-1);

  fx:= f_x;
end;
function Contar_0s(x: double): double;
{var
  tmp:   string;
  tam:   integer;
begin
  tmp:= FloatToStr(x);
  for
          }
//end;

function Xn_biseccion(a,b :double): double;
begin
  Xn:=(b+a)/2;

  Xn_biseccion:=Xn;
end;

function Xn_falsa_posicion(a,b :double): double;
begin
  Xn:= a-( (fx(a)*(b-a))/(fx(b)-fx(a)) );

  Xn_falsa_posicion:= Xn;
end;
procedure f_continua(a,b :double);
var
  tmp:    double;
  i:      boolean;
begin

     //for i:= a to b do//
     while(a=b) do
     begin
          try
             //i:= isInfinite(fx(a));
             if  (fx(a)= -Infinity) or (fx(b)= Infinity) then
                 ShowMessage('No Continua');
                 break;
                 a:= a+1;

          finally

          end;


     end ;
end;

procedure TForm1.BotonClicked(Sender: TObject);
var
  tmp:    double;

begin

  a:= StrToFloat( EditA.Text );
  b:= StrToFloat( EditB.Text );
  error1:= StrToFloat( Edit1.Text );
  i:=1;
  error2:=50;
  f_continua(a,b);

  Xn_1:= 0;
  fa:= fx(a);
  fb:= fx(b);
  if fa=0 then
      begin
         StringGrid1.Cells[1,i]:=FloatToStr(a);
         StringGrid1.Cells[2,i]:=FloatToStr(b);
         StringGrid1.Cells[6,i]:=FloatToStr(a);
         end;
  if fb=0 then
      begin
         StringGrid1.Cells[1,i]:=FloatToStr(a);
         StringGrid1.Cells[2,i]:=FloatToStr(b);
         StringGrid1.Cells[6,i]:=FloatToStr(b);
         end;

  if(fx(a)*fx(b)<0) then
  begin
       while (Xn=0) or ( error2 > error1 ) do
             begin

             if RadioButton1.Checked then
                 Xn:= Xn_Biseccion( a, b )
             else
                 Xn:= Xn_falsa_posicion( a, b );
             sgn:= Sign( fx(a)*fx(Xn) );

             StringGrid1.RowCount:= i+1;
             StringGrid1.Cells[0,i]:=FloatToStr(i-1);
             StringGrid1.Cells[1,i]:=FloatToStr(a);
             StringGrid1.Cells[2,i]:=FloatToStr(b);
             StringGrid1.Cells[6,i]:=FloatToStr(Xn);
             StringGrid1.Cells[3,i]:=FloatToStr(fx(a));
             StringGrid1.Cells[4,i]:=FloatToStr(fx(Xn));
             StringGrid1.Cells[5,i]:=FloatToStr(sgn);

             if sgn < 0 then
                b:= Xn
             else
                a:= Xn;

             if i=1 then
                error2:=50
             else
                error2:=abs(( Xn_1 - Xn)/ Xn);

             StringGrid1.Cells[7,i]:=FloatToStr( error2 );
                Xn_1:= Xn;

             if (error2=0) or (IsInfinite(error2))  then
                error2:=error1-0.1;
                i:= i+1;

             end;
       end

  else
      begin
           ShowMessage('No Cumple el Teorema de Bolzano');
      end;

  end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
  EditA.Clear;
  EditB.Clear;
end;


end.

