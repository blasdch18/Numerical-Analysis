unit TaylorExpo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,crt,Math,ArrStr,  StrMat;
type
    TTaylorExpo = Class

      public
            MboxAnswer : TStrMatriz;
            Constructor Create();
            function abso (xi:Double ):Double;
            function gradToRadian(x:Double):double;
            function factorial(xi:Integer):Double;
            function pow(x:Double;y:Integer ):Real;
            function Eabsoluto(x1,xa:Double):Double;
            function ERelativo(x1,xa:Double):Double;

            //Series
            function taylorsen(x : Double; errorI: Double):real;
            function taylorcos(x : Double; errorI: Double):real;
            function taylorarctgh(x : Double; errorI: Double):real;
            function taylorlog(x: Double; errorI: Double):real;
            function taylorexpo(x:Double ; errorI : Double):real;

    end;


implementation
Constructor TTaylorExpo.Create();
begin
  MboxAnswer := TStrMatriz.Create();
end;

function TTaylorExpo.abso(xi:Double ):Double;
var i:Integer;
    sum:Double;
begin
     if xi<0 then abso:=xi*(-1)
     else
         abso:=xi;
end;

function TTaylorExpo.gradToRadian(x:Double):double;
BEGIn
     gradToRadian := X*pi/180;
end;

function TTaylorExpo.factorial(xi:Integer):Double;
var i:Integer;
  sum:Double;
begin
  sum:=1;
  for i:=2 to xi do
  begin
    sum:=sum*i;
  end;
  factorial:=sum;
end;

function TTaylorExpo.pow(x:Double;y:Integer ):Real;
var
   i:Integer;
  sum:Double;
begin
  sum:=1;
  for i:=1 to y do
  begin
    sum:=sum*x;
  end;
  pow:=sum;
end;

function TTaylorExpo.Eabsoluto(x1,xa:Double):Double;
begin
  Eabsoluto:=abso(x1-xa);
end;

function TTaylorExpo.ERelativo(x1,xa:Double):Double;
begin
  try
  ERelativo:= x1/xa;
  except
    on E: EDivByZero  do begin
          write( 'Error: '+ E.Message );readKey;
    end;
  end;

end;

  //SERIES

function TTaylorExpo.taylorsen(x : double; errorI: Double):real;
var
       errorO,errorprev,sum:Double;
       error1: Double;
       i:Integer;
       arrStrAux, arrStrAux2   : TArrString;
begin
     arrStrAux := TArrString.Create();
     x:=trunc(x) mod (180);
     x:=gradToRadian(x);
     errorO:=50;
     i:=0;
     sum:=x;
//     sum:= (power(-1,i)*power(x,2*i+1)/factorial(2*i+1));
     //arrStrAux.clear();

     arrStrAux.push('Xn');
     arrStrAux.push('Resultado');
     arrStrAux.push('Err. Absol.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcent.');

     MboxAnswer.push(arrStrAux);
     //arrStrAux.clear();
     //write('      |       Resultado       |     Err. Absol.       |    Err. Relativo   |      Err. Porcent.    |');
     arrStrAux := TArrString.Create();




     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(sum));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);
     //arrStrAux.clear();


     //write('X',i,'  |  ',sum:0:3,'  |          -         |       -       |       -       |');
     i:=1;
     error1:=sum;

     while(errorO>errorI)and (error1<>0) do
     begin
          arrStrAux2 := TArrString.Create();
          sum := sum+(power(-1,i)*power(x,2*i+1)/factorial(2*i+1));
          errorprev:=errorO;
          errorO := Eabsoluto(error1,sum);

          if (errorprev<errorO)then
          begin
              write('E.A no converge ');
            write(errorO,'>',errorprev);
             exit;
          end;

          //write('X',i,'  |  ',sum,'  |  ' ,(errorO) ,'   |   ',(errorO/error1):0:2,'  |  ',(errorO/error1*100):0:2,'  |');
          //readkey;
          arrStrAux2.push('X'+IntToStr(i));
          arrStrAux2.push(FloatToStr(sum));
          arrStrAux2.push(FloatToStr(errorO));
          arrStrAux2.push(FloatToStr((errorO/error1)));
          arrStrAux2.push(FloatToStr((errorO/error1*100)));

          MboxAnswer.push(arrStrAux2);

          error1:=sum;
          i:=i+1;
     end;

     //MboxAnswer.print();

     taylorsen:=sum;
end;

function TTaylorExpo.taylorcos(x : Double; errorI: Double):real;
var
       errorO,errorprev,sum:Double;
       error1: Double;
       i:Integer;
       arrStrAux, arrStrAux2   : TArrString;
begin
     arrStrAux := TArrString.Create();
     x:=trunc(x) mod (180);
     x:=gradToRadian(x);
     errorO:=50;
     //sum:= (power(-1,i)/factorial(2*i))*power(x,2*i);
     sum:=1;

    // write('     |       Resultado       |     Err. Absol.       |    Err. Relativo   |      Err. Porcent.    |');
     //write('X0  |  ',sum,'  |          -         |       -       |       -       |');
     arrStrAux.push('Xn');
     arrStrAux.push('Resultado');
     arrStrAux.push('Err. Absol.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcent.');

     MboxAnswer.push(arrStrAux);

     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(sum));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);


     i:=1;
     error1:=sum;        //SI FALLA QUIZA HAYA Q SACAR ERROR1<>0
     while(errorO>errorI) and (error1<>0) do
     begin
          arrStrAux2 := TArrString.Create();
          sum:= sum+(power(-1,i)*power(x,2*i))/factorial(2*i);
          errorprev:=errorO;
          errorO:=Eabsoluto(error1,sum);
          if (errorprev<errorO)then
          begin
              write('E.A. no converge  ');
              write(errorO,'>',errorprev);
              taylorcos := error1;
             exit;
          end;
          //write('X',i,'  |  ',sum,'  |  ' ,(errorO) ,'   |   ',(errorO/error1):0:2,'  |  ',(errorO/error1*100):0:2,'  |');
          //readkey;
          arrStrAux2.push('X'+IntToStr(i));
          arrStrAux2.push(FloatToStr(sum));
          arrStrAux2.push(FloatToStr(errorO));
          arrStrAux2.push(FloatToStr((errorO/error1)));
          arrStrAux2.push(FloatToStr((errorO/error1*100)));

          MboxAnswer.push(arrStrAux2);
          error1:=sum;
          i:=i+1;
     end;
         taylorcos:=sum;
end;

function TTaylorExpo.taylorarctgh(x : Double; errorI: Double):real;
var
       errorO,sum:Double;
       error1: Double;
       i:Integer;
       arrStrAux, arrStrAux2   : TArrString;
begin
     arrStrAux := TArrString.Create();
     x:=gradToRadian(x);
     write('x en radianes: ',x);
     if (abso(x)>=(1/2.7182818285))then
     begin
         write(' Error : Ingresar valores menores a  1/e =0.367879 ');
         taylorarctgh := -1;
         exit;
     end;

     //x:=gradToRadian(x);
     errorO:=50;
     sum:=x;
     i:=1;
     //write('     |       Resultado       |     Err. Absol.       |    Err. Relativo   |      Err. Porcent.    |');
     //write('X0  |  ',sum,'  |          -         |       -       |       -       |');
     arrStrAux.push('Xn');
     arrStrAux.push('Resultado');
     arrStrAux.push('Err. Absol.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcent.');

     MboxAnswer.push(arrStrAux);

     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(sum));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);

     error1:=sum;
     while(errorO>errorI)and (error1<>0) do
     begin
          arrStrAux2 := TArrString.Create();
          sum:= sum+(1/(2*i+1))*power(x,2*i+1);
          errorO:=Eabsoluto(error1,sum);
          //write('X',i,'  |  ',sum,'  |  ' ,(errorO) ,'   |   ',(errorO/error1):0:2,'  |  ',(errorO/error1*100):0:2,'  |');
          arrStrAux2.push('X'+IntToStr(i));
          arrStrAux2.push(FloatToStr(sum));
          arrStrAux2.push(FloatToStr(errorO));
          arrStrAux2.push(FloatToStr((errorO/error1)));
          arrStrAux2.push(FloatToStr((errorO/error1*100)));

          MboxAnswer.push(arrStrAux2);
          error1:=sum;
          i:=i+1;
     end;
         taylorarctgh:=sum;
end;

function TTaylorExpo.taylorlog(x: Double; errorI: Double):real;
var
   errorO, sum:Double;
   count:Integer;
   error1: Double;
   arrStrAux, arrStrAux2   : TArrString;
begin
     arrStrAux := TArrString.Create();
     if not((x>(-1)) and (x<=1))then
     begin
         write(' Error : Ingresar valores mayores a  -1 y <= 1 ');
         taylorlog := -1;
         exit;
     end;

     errorO:=50;
     //sum := sum + power(-1, count + 1) * (power((x-1),count)/count);
     sum:=x-1;
     //write('    |       Resultado       |     Err. Absol.       |    Err. Relativo   |      Err. Porcent.    |');
     //write(' X0  |  ',sum,'  |       -       |       -       |       -       |');
     arrStrAux.push('Xn');
     arrStrAux.push('Resultado');
     arrStrAux.push('Err. Absol.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcent.');

     MboxAnswer.push(arrStrAux);

     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(sum));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);

     count:=2;
     error1:=sum;
     while(errorO>errorI)and (error1<>0)do
     begin
          arrStrAux2 := TArrString.Create();
          sum := sum + power(-1, count + 1) * (power((x-1),count)/count);
          errorO:=Eabsoluto(error1,sum);
          //write(' X',count-1,'  |  ',sum,'  |  ' ,(errorO):0:3 ,'   |   ',ERelativo(errorO,error1):0:2,'  |  ',(errorO/error1*100):0:2,'  |');
          arrStrAux2.push('X'+IntToStr(count-1));
          arrStrAux2.push(FloatToStr(sum));
          arrStrAux2.push(FloatToStr(errorO));
          arrStrAux2.push(FloatToStr((errorO/error1)));
          arrStrAux2.push(FloatToStr((errorO/error1*100)));

          MboxAnswer.push(arrStrAux2);

          error1:=sum;
          count:=count+1;
     end;
     readkey;
     taylorlog := sum;
end;

function TTaylorExpo.taylorexpo(x:Double ;errorI : Double):real;
var errorO,sum:Double;
    error1: Double;
    i:Integer;
    arrStrAux, arrStrAux2   : TArrString;
begin
     arrStrAux := TArrString.Create();
     errorO:=50;
     sum:=1;
     //write('    |       Resultado       |     Err. Absol.       |    Err. Relativo   |      Err. Porcent.    |');
     //write('X0  |  ',sum,'  |       -       |       -       |       -       |');
     arrStrAux.push('Xn');
     arrStrAux.push('Resultado');
     arrStrAux.push('Err. Absol.');
     arrStrAux.push('Err. Relativo');
     arrStrAux.push('Err. Porcent.');

     MboxAnswer.push(arrStrAux);

     arrStrAux := TArrString.Create();

     arrStrAux.push('X0');
     arrStrAux.push(FloatToStr(sum));
     arrStrAux.push('-');
     arrStrAux.push('-');
     arrStrAux.push('-');
     MboxAnswer.push(arrStrAux);

     i:=1;
     error1:=sum;
     while(errorO>errorI)and(error1<>0) do
     begin
          arrStrAux2 := TArrString.Create();
          sum := sum + (power(x,i)/factorial(i));
          errorO:=Eabsoluto(error1,sum);
          //writeln('X',i,'  |  ',sum,'  |  ' ,(errorO):0:3 ,'   |   ',ERelativo(errorO,error1):0:2,'  |  ',(errorO/error1*100):0:2,'  |');
          arrStrAux2.push('X'+IntToStr(i));
          arrStrAux2.push(FloatToStr(sum));
          arrStrAux2.push(FloatToStr(errorO));
          arrStrAux2.push(FloatToStr((errorO/error1)));
          arrStrAux2.push(FloatToStr((errorO/error1*100)));

          MboxAnswer.push(arrStrAux2);
          error1:=sum;
          i:=i+1;
     end;
     taylorexpo:=sum;
end;


end.

