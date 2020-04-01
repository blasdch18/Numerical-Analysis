unit NewtSec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, crt, ParseMath;
type
    TRaizNewtSec = Class
    public
      raizValor :Double;
      Parse: TParseMath;
      my_function : String;
      procedure set_MyFunction(func :String);
      function Mf_x(x:double):Double;
      function Mf_x( variab:String;  valor : Double):Double;
      function MNewton(errorI,x_n : Double):Double;

    end;

implementation

procedure TRaizNewtSec.set_MyFunction(func :String);
begin
  my_function:= 'power(2.7182818285,power(x,2))+x-power(x,3)-5*ln(x)-5';
end;

function TRaizNewtSec.Mf_x(x:double):Double;
begin
     try
       //f_x:=power(2.7182818285,power(x,2))+x-power(x,3)-5*ln(x)-5;
       //f_x:=sin(x)+(power(x,2)/(x-1))+3;
       //f_x:= power(x,2) + 3*x -4;
       //F_x:=ln(power(x,2)+1)-(power(E,x/2)*cos(PI*x));        //A=0.1, B=0.5
       //f_x:=7*sin(x)*power(E,-x)-1 ;                            //A= -1, B = 1
       //f_x:=power(x,3)-7*power(x,2)+14*x-6;                       //A=3.2, B=4
       //f_x:= 5*power(x,3)-5*power(x,2)+6*x-2;
       Mf_x:=ln(power(x,2))-0.7;               //A=0.5 , B=2
       //f_x:=x-sqrt(18);                         //A=4, B=5
       //f_x:= power(x,4)-8*power(x,3)-35*power(x,2)+450*x-1001; //A=4.5, B=6
       //f_x:=-2*power(x,6)-1.5*power(x,4)+10*x+2;                 //A=0, B=1
       //f_x:=pi*power(x,2)*(9-x)-90;                                //A=1  B=2.9
       //f_x:= (power(x,5)/5)-(8*power(x,4)/4)-(35*power(x,3)/3)+(450*power(x,2)/2)-1001*x;
       if(Mf_x=0)then
       begin
            raizValor:=x;
       end;
     except
        on E: EDivByZero  do begin
          writeln( 'Error: '+ E.Message );
          readKey;
        end;
     end;
end;

function TRaizNewtSec.Mf_x( variab:String;  valor : Double ):Double;
var
  funaux:TParseMath;
begin
  funaux := TParseMath.create();
  funaux.Expression:=my_function;
  funaux.AddVariable(variab, valor);
  f_x := funaux.Evaluate();
end;

function TRaizNewtSec.MNewton(errorI,x_n : Double):Double;
var
  h, i, f_deriv, x_nLeft1, x_nRight1,errorO : Double;
begin
  h:= errorI/100;

  // Diferenciable
  try
      f_deriv := (Mf_x(x_n+h) - Mf_x(x_n))/h;
      WriteLn('es difereciable ' + FloatToStr(f_deriv));
  Except
      WriteLn('No es difereciable');
  end;

  x_nLeft1 := x_n-(h*10); //Um # proximo a x_n
  x_nRight1:= x_n-(( Mf_x(x_n)*(x_n-x_nLeft1) ) /(Mf_x(x_n)-Mf_x(x_nLeft1) ) );
  i:=0;
  WriteLn(' n  |   x_n   |   Error Abs.  |   error Relativo  |   error %  |');

  while( errorO > errorI) do
  begin
       x_nLeft1:=x_n;
       x_n := x_nRight1;
       x_nRight1:= x_n-(( Mf_x(x_n)*(x_n-x_nLeft1) ) /(Mf_x(x_n)-Mf_x(x_nLeft1) ) );
       errorO := abs(x_n-x_nRight1);
       i:=i+1;
       writeln('X',i,'  |   ', x_n:0:2,'   |  ', errorO:0:5,'  | ',(errorO/x_nLeft1):0:5, ' | ',(errorO/x_nLeft1*100):0:2,'%');
  end;

end;

end.

