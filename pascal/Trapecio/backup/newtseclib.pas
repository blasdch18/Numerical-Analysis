unit newtseclib;
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, crt, ParseMath, ArrStr,  StrMat;
type
    TRaizNewtSec = Class
    public
      MboxAnswer : TStrMatriz;
      Euler:Double;
      raizValor :Double;
      pf_derivada : Double;
      //derPar : TDerivParc;
      my_function : String;
      my_derivative_function : String;

      procedure set_funct(func :String);
      procedure set_Deriv_funct(func :String);
      function Mf_x(x:double):Double;
      function Mf_x( variab:String; valor : Double ):Double;
      function Mdf_x(x:Double):Double;
      function MDf_x( variab:String; valor : Double ):Double;
      function MNewton(x_n, errorI : Double):Double;
      //function MSecante(x_n, errorI : Double):Double;    //Un TIPO DE NEWTOM
      function MSecante2(x_n, errorI : Double):Double;

      ///Punto fijo
      function MPuntoFijo1(x_n, errorI : Double):Double;
      constructor Create;

    end;



implementation


constructor TRaizNewtSec.Create;
begin
    MboxAnswer := TStrMatriz.Create();
    Euler:=2.71828182846;
    //derPar := TDerivParc.Create;
end;

procedure TRaizNewtSec.set_funct(func :String);
begin
    my_function := func;
end;

procedure TRaizNewtSec.set_Deriv_funct(func :String);
begin
    my_derivative_function:=func;
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
       //Mf_x:=ln(power(x,2))-0.7;               //A=0.5 , B=2
       //f_x:=x-sqrt(18);                         //A=4, B=5
       //f_x:= power(x,4)-8*power(x,3)-35*power(x,2)+450*x-1001; //A=4.5, B=6
       //f_x:=-2*power(x,6)-1.5*power(x,4)+10*x+2;                 //A=0, B=1
       //f_x:=pi*power(x,2)*(9-x)-90;                                //A=1  B=2.9
       //f_x:= (power(x,5)/5)-(8*power(x,4)/4)-(35*power(x,3)/3)+(450*power(x,2)/2)-1001*x;
       //Mf_x:=power(Euler,x)-(1/x);
       //Mf_x:=30*sin(x);                                               //A=pi/2
      // Mf_x := power(2.7182818285,x)-(1/x);
       //Mf_x := arctan(x)-0.3;                                           //A = 3
       //Mf_x := ln(power(x,2)+1)-power(2.718281,(x/2))*cos(pi*x);                 //A= 0.6
       //Mf_x := cos(3*x)-x;
      //Mf_x:=ln(power(x,2)+1)-power(Euler,x/2)*cos(pi*x);
       //Mf_x:=power(x,2)-4;
       //Mf_x:= power(Euler,x)-(1/x);                                     //A= 0.5
       Mf_x:=power(x,2)-4;                                            //A=0
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
  Mf_x := funaux.Evaluate();
end;


function TRaizNewtSec.MDf_x(x:double):Double;
begin
     try

       //Mdf_x := 1/(1+power(x,2));                                           //A = 3
       //Mdf_x := (power(Euler,x/2)/2)*cos(pi*x)-(power(Euler,x/2)*sin(pi*x)*pi);
       Mdf_x:=2*x;
       //Mdf_x:= power(Euler,x)+(1/power(x,2));
     except
        on E: EDivByZero  do begin
          writeln( 'Error: '+ E.Message );
          readKey;
        end;
     end;
end;


function TRaizNewtSec.MDf_x( variab:String;  valor : Double ):Double;
var
  funaux:TParseMath;
begin
  funaux := TParseMath.create();
  funaux.Expression:=my_derivative_function;
  funaux.AddVariable(variab, valor);
  MDf_x := funaux.Evaluate();
end;


function TRaizNewtSec.MNewton(x_n, errorI : Double):Double;
var
  x_nRight1, f_dervi,errorO : Double;
  i : Integer;
  arrStrAux : TArrString;
begin
  errorO:= 50;
  i := 0;
 // WriteLn(' n  |   x_n   |   Error Abs.  |   error Relativo  |   error %  |');
  //WriteLn('X',i,'  |   ', x_n,'   |    -   |   -   |   -   |');
   arrStrAux := TArrString.Create();
     arrStrAux.push('i');
     arrStrAux.push('X_n');
     arrStrAux.push('Error Abs.');
     arrStrAux.push('error Relativo');
     arrStrAux.push('error %');

     MboxAnswer.push(arrStrAux);
     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(x_n));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);

  while (errorO > errorI)  do
  begin
       arrStrAux := TArrString.Create();
       try

          i := i+1;
          if (Mdf_x('x',x_n)=0)then begin
             //WriteLn('AQI');
             //ReadLn;
             x_n := x_n-errorI;
          end;


          x_nRight1:= x_n - (Mf_x('x',x_n)/MDf_x('x',x_n));
          errorO:= abs(x_nRight1 - x_n);
          x_n:= x_nRight1;
          //WriteLn('X',i,'  |   ', x_n,'   |    ', errorO , '   |   -   |   -   |');
          arrStrAux.push('X'+IntToStr(i));
          arrStrAux.push(FloatToStr(x_n));
          arrStrAux.push(FloatToStr(errorO));
          arrStrAux.push('-');
          arrStrAux.push('-');

          MboxAnswer.push(arrStrAux);

          //WriteLn(errorI,'<',er);
          //ReadKey;

       Except
          on E: EDivByZero  do begin
          writeln( 'Error: '+ E.Message );
          readKey;
          end;
        end;

  end;
  //MboxAnswer.print();
  MNewton := x_n;
end;


function TRaizNewtSec.MSecante2(x_n, errorI : Double):Double;
var
  x_nRight1, h, errorO : Double;
  i : Integer;
  arrStrAux : TArrString;
begin
  arrStrAux := TArrString.Create();
  errorO:= 50;
  h := errorI/10;
  i := 0;
 // WriteLn(' n  |   x_n   |   Error Abs.  |   error Relativo  |   error %  |');
  //WriteLn('X',i,'  |   ', x_n,'   |    -   |   -   |   -   |');
  arrStrAux := TArrString.Create();
  arrStrAux.push('i');
  arrStrAux.push('X_n');
  arrStrAux.push('Error Abs.');
  arrStrAux.push('error Relativo');
  arrStrAux.push('error %');

  MboxAnswer.push(arrStrAux);
  arrStrAux := TArrString.Create();

  arrStrAux.push('X0');
  arrStrAux.push(FloatToStr(x_n));
  arrStrAux.push('-');
  arrStrAux.push('-');
  arrStrAux.push('-');
  MboxAnswer.push(arrStrAux);

  while (errorO > errorI)  do
  begin
      arrStrAux := TArrString.Create();
       try
          i := i+1;
          if (Mdf_x(x_n)=0)then begin
             //WriteLn('PERTURBACIOM');
             //ReadLn;
             x_n := x_n-errorI;
          end;

          x_nRight1:= x_n - ((2*h*Mf_x('x',x_n))/(Mf_x('x',x_n+h)-Mf_x('x',x_n-h)));
          errorO:= abs(x_nRight1 - x_n);
          x_n:= x_nRight1;

          //WriteLn('X',i,'  |   ', x_n,'   |    ', errorO , '   |   -   |   -   |');
          arrStrAux.push('X'+IntToStr(i));
          arrStrAux.push(FloatToStr(x_n));
          arrStrAux.push(FloatToStr(errorO));
          arrStrAux.push('-');
          arrStrAux.push('-');

          MboxAnswer.push(arrStrAux);
          //WriteLn(errorI,'<',er);
          //ReadKey;

       Except
          on E: EDivByZero  do begin
          writeln( 'Error: '+ E.Message );
          readKey;
          end;
        end;

  end;
  //MboxAnswer.print();
  MSecante2 := x_n;
end;




//Punto fijo

function ErrorAbs(xn,x:Double):Double;
begin
  ErrorAbs:=abs(xn-x);
end;

function g(x:Double):Double;
begin
  try
     g:= cos(x);
     //g:= sqrt(2*x+3);
  except
    writeln('error en aqui');
    exit;
  end;
end;

{function dg1(x:Double):Double;
var
  dgp:Double;
begin
    try
       //dg1:=1/(sqrt(2*x+1));
       dg1 := abs(sin(x));
    except
       on E: EDivByZero  do begin
          writeln( 'Error en derivacion: '+ E.Message );
          exit;
          readKey;
        end;

    end;
end;

function dg2(x:Double):Double;
var
  d:Double;
begin
    try
       dg2:=1/(sqrt(2*x+1));
    except
      writeln('error en derivacion');
      exit;
    end;
end;
        }
function dg(x:Double):Double;
begin
  //Result := 1/(power(2*x+3,0.5));
  dg := abs(sin(x));
end;

function TRaizNewtSec.MPuntoFijo1(x_n, errorI : Double ):Double;
var
  ErrorO, x_nLeft:Double;
  verif:Double;
  i:Integer;
begin

  ErrorO:=50;
  i:=0;
  verif:=abs(dg(x_n));
  if g(x_n)=x_n then
   begin
     writeln('x0 inicial es la raiz'+FloatToStr(x_n));
     exit;
   end;
  if verif>1 then
     begin
     writeln('este punto diverge'+FloatToStr(x_n));
     exit;
     end

  else
  begin
     WriteLn(' n  |   x_n   |   Error Abs.  |   error Relativo  |   error %  |');
     WriteLn('X',i,'  |   ', x_n,'   |    -   |   -   |   -   |');
     while (ErrorO>errorI) do
     begin
        if (i<>0) then
        begin
            errorO:=ErrorAbs(x_n,x_nLeft);
        end;

        x_nLeft:=x_n;
        x_n:=g(x_nLeft);
        verif:=abs(dg(x_n));

        if (verif>1)then
        begin
             writeln('la funcion diverge en este punto'+FloatToStr(x_n));
             exit;
        end;
        i:=i+1;
        writeln('X',i,'  |   ', x_n,'   |  ', errorO:0:5,'  | ',(errorO/x_n):0:5, ' | ',(errorO/x_n*100):0:2,'%');

     end;
  end;
  MPuntoFijo1 := x_n;
end;

end.

