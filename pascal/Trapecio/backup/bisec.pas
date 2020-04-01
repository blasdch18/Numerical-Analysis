unit bisec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math,crt , ArrStr,  StrMat, ParseMath;
type
    TBiseccion = Class
    public
         MboxAnswer : TStrMatriz;
         raizBool :Boolean;
         E:Double;
         raizValor :Double;
         my_function : String;
         function abs(x:double):Double;
         procedure set_MyFunction(func :String);
         function f_x(x:double):Double;
         function f_x( variab:String;  valor : Double):Double;
         function bolzano(a,b :Double):Boolean;
         function Str_signo(signo : Boolean ):String;
         function x_i_to_falsa_pos(a,b:Double):Double;
         function bisection(a,b,errorI: Double):Double;
         function falsa_pos(a,b,errorI: Double):Double;
         constructor Create;

    end;


implementation

constructor TBiseccion.Create;
begin
    MboxAnswer := TStrMatriz.Create();
    my_function:= 'power(2.7182818285,power(x,2))+x-power(x,3)-5*ln(x)-5';
    raizBool:=False;
    E:=2.71828182846;
    raizValor:=-1;
end;

function TBiseccion.abs(x:double):Double;
begin
     if x<0 then
        abs:=x*(-1)
     else abs:=x;
end;

procedure TBiseccion.set_MyFunction(func :String);
begin
    my_function:=func;
end;

function TBiseccion.f_x(x:double):Double;
begin
     try
       f_x:=power(2.7182818285,power(x,2))+x-power(x,3)-5*ln(x)-5;
       //f_x:=sin(x)+(power(x,2)/(x-1))+3;
       //f_x:= power(x,2) + 3*x -4;
       //F_x:=ln(power(x,2)+1)-(power(E,x/2)*cos(PI*x));        //A=0.1, B=0.5
       //f_x:=7*sin(x)*power(E,-x)-1 ;                            //A= -1, B = 1
       //f_x:=power(x,3)-7*power(x,2)+14*x-6;                       //A=3.2, B=4
       //f_x:= 5*power(x,3)-5*power(x,2)+6*x-2;
     //f_x:=ln(power(x,2))-0.7;               //A=0.5 , B=2
       //f_x:=x-sqrt(18);                         //A=4, B=5
       //f_x:= power(x,4)-8*power(x,3)-35*power(x,2)+450*x-1001; //A=4.5, B=6
       //f_x:=-2*power(x,6)-1.5*power(x,4)+10*x+2;                 //A=0, B=1
       //f_x:=pi*power(x,2)*(9-x)-90;                                //A=1  B=2.9
       //f_x:= (power(x,5)/5)-(8*power(x,4)/4)-(35*power(x,3)/3)+(450*power(x,2)/2)-1001*x;
       //f_x := ln(sin(x))+1;                                       //A = 8.1  B= 9.3
       //f_x := power(E,x)+x-2;
       //f_x := (0.7*x)*(1-power(E,(-98/x)))-35;                    //A:= 60
       //f_x := ln(power(x,2)+1)-power(E,(x/2))*cos(pi*x);            //A:= 0.1  B:= 0.5
       //f_x := power(x,2)+4;                                                //A = -3 B = -1

       if(f_x=0)then
       begin
            raizBool := True;
            raizValor := x;
       end;
     except
        on E: EDivByZero  do begin
          writeln( 'Error: '+ E.Message );readKey;
        end;
     end;
end;
function TBiseccion.f_x( variab:String;  valor : Double ):Double;
var
  funaux:TParseMath;
begin
  funaux := TParseMath.create();
  funaux.Expression:=my_function;
  funaux.AddVariable(variab, valor);
  f_x := funaux.Evaluate();
end;

function TBiseccion.bolzano(a,b :Double):Boolean;
begin
     if(f_x('x',a)*f_x('x',b)<0) then
     begin
          bolzano:= true;   //-# <0
          //WriteLn('bol: ',f_x(a)*f_x(b));
     end
     else
     begin
       bolzano:= false;     //+# >0
     end;
end;

function TBiseccion.Str_signo(signo : Boolean ):String;
begin
     if signo=False then begin
        Str_signo:= '-';exit;
     end;
     Str_signo:= '+';
end;

function TBiseccion.x_i_to_falsa_pos(a,b:Double):Double;
begin
     try
     x_i_to_falsa_pos:=a-((f_x('x',a)*(b-a))/(f_x('x',b)-f_x('x',a)));
     except
        on E: EDivByZero  do begin
        writeln( 'Error: '+ E.Message );readKey;
     end;
     end;
end;

function TBiseccion.bisection(a,b,errorI: Double):Double;
var
  i:Integer;
  x_i,x_prev,ErrorO:Double;
  signo:Boolean;
  arrStrAux : TArrString;
begin

     ErrorO:=50;
     {if (f_x(a)=0) then
     begin
       bisection:=a;
       exit;
     end;
     if (f_x(b)=0) then
     begin
       bisection:=b;
       exit;
     end; }
     if not(bolzano(a,b)) then
     begin
       bisection:=raizValor;
       writeln('No cumple con Bolzano');
       exit;
     end;

     i:=0;
     x_i:=(a+b)/2;
     signo :=bolzano(a,x_i);
     //writeln('    |     A    |    B     |    X_n   |  Signo  |   Err. Absoluto.   |   Err. Relativo. | Err. Porcentual');
     //writeln('X0  |   ',a:0:2,'   |   ',b:0:2,'   |  ',x_i:0:2,'  |  ', not(signo),'  |       -       |       -       |       -       |');
     arrStrAux := TArrString.Create();
     arrStrAux.push('Xn');
     arrStrAux.push('A');
     arrStrAux.push('B');
     arrStrAux.push('X_n');
     arrStrAux.push('Signo');
     arrStrAux.push('Err. Absoluto.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcentual');

     MboxAnswer.push(arrStrAux);
     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(a));
     arrStrAux.push(FloatToStr(b));
     arrStrAux.push(FloatToStr(x_i));
     arrStrAux.push(Str_signo( not(signo) ));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);


     if (signo) then
     begin
       b:=x_i;
     end
     else
     begin
       a:=x_i;
     end;
     x_prev:=x_i;

     while((ErrorO>errorI) and (bolzano(a,b))) {or (raizBool)}do
     begin
       arrStrAux := TArrString.Create();
       i:=i+1;
       x_i:=(a+b)/2;
       signo := bolzano(a,x_i);
       ErrorO := abs(x_prev - x_i);
       //writeln('X',i,'  |   ',a:0:2,'   |   ',b:0:2,'   |  ',x_i:0:2,'  |  ',not(signo),'  |  ', ErrorO,'  | ',(ErrorO/x_prev):0:2, ' | ',(ErrorO/x_prev*100):0:2,'%');

       arrStrAux.push('X'+IntToStr(i));
       arrStrAux.push(FloatToStr(a));
       arrStrAux.push(FloatToStr(b));
       arrStrAux.push(FloatToStr(x_i));
       arrStrAux.push(Str_signo( not(signo) ));
       arrStrAux.push(FloatToStr(ErrorO));
       arrStrAux.push(FloatToStr((ErrorO/x_prev)));
       arrStrAux.push(FloatToStr((ErrorO/x_prev*100)));

       MboxAnswer.push(arrStrAux);

       if (signo) then
       begin
            b:=x_i;
       end
       else
       begin
            a:=x_i;
       end;
       x_prev:=x_i;
     end;
     //MboxAnswer.print();

     bisection:= x_i;
end;

function TBiseccion.falsa_pos(a,b,errorI: Double):Double;
var
  i:Integer;
  x_i,x_prev,ErrorO:Double;
  signo:Boolean;
  arrStrAux : TArrString;
begin
     ErrorO:=50;
     if not(bolzano(a,b)) then
     begin
       falsa_pos:=-1;
       writeln('No cumple con Bolzano');
       exit;
     end;
     i:=0;
     x_i:=x_i_to_falsa_pos(a,b);

     signo :=bolzano(a,x_i);
     //writeln('    |      A     |    B     |    X_n   |  Signo  |   Err. Absoluto.   |   Err. Relativo. | Err. Porcentual');
     //writeln('X0  |   ',a:0:2,'   |   ',b:0:2,'   |  ',x_i:0:2,'  |  ', not(signo),'  |       -       |       -       |       -       |');
     arrStrAux := TArrString.Create();
     arrStrAux.push('Xn');
     arrStrAux.push('A');
     arrStrAux.push('B');
     arrStrAux.push('X_n');
     arrStrAux.push('Signo');
     arrStrAux.push('Err. Absoluto.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcentual');

     MboxAnswer.push(arrStrAux);
     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(a));
     arrStrAux.push(FloatToStr(b));
     arrStrAux.push(FloatToStr(x_i));
     arrStrAux.push(Str_signo( not(signo) ));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);

     if (signo) then
     begin
       b:=x_i;
     end
     else
     begin
       a:=x_i;
     end;
     x_prev:=x_i;

     while(ErrorO>errorI) and (bolzano(a,b))do
     begin
       arrStrAux := TArrString.Create();
       i:=i+1;
       x_i:=x_i_to_falsa_pos(a,b);
       signo := bolzano(a,x_i);
       ErrorO := abs(x_prev - x_i);
       //writeln('X',i,'  |   ',a:0:2,'   |   ',b:0:2,'   |  ',x_i:0:2,'  |  ',not(signo),'  |  ', ErrorO:0:5,'  | ',(ErrorO/x_prev):0:5, ' | ',(ErrorO/x_prev*100):0:2,'%');
       arrStrAux.push('X'+IntToStr(i));
       arrStrAux.push(FloatToStr(a));
       arrStrAux.push(FloatToStr(b));
       arrStrAux.push(FloatToStr(x_i));
       arrStrAux.push(Str_signo( not(signo) ));
       arrStrAux.push(FloatToStr(ErrorO));
       arrStrAux.push(FloatToStr((ErrorO/x_prev)));
       arrStrAux.push(FloatToStr((ErrorO/x_prev*100)));

       MboxAnswer.push(arrStrAux);

       if (signo) then
       begin
            b:=x_i;
       end
       else
       begin
            a:=x_i;
       end;
       x_prev:=x_i;
     end;
     //MboxAnswer.print();
     falsa_pos:= x_i;
end;

end.

