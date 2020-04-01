unit Unit2;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, math;
Type
  TMetodos = Class
    public
      //Funcion : string;
      //Funcion_derivada : string;
      function f(x:Extended):Extended;
      function d(x:Extended):Extended;
      function Punto_Fijo(ValorA,ValorErrorUser:Extended):TStringList;
      constructor create();
      destructor Destroy; override;
  end;

implementation
constructor TMetodos.create();
begin
end;
destructor TMetodos.Destroy;
begin
end;
function TMetodos.f(x:Extended):Extended;
begin
 //result:=( power(2*(x)+3,1/2) );
 //result:=( cos(x) );
 //result:=(ln(x));
 //result:=(exp(x));
   result:=(power(x,2)-4);
end;
function TMetodos.d(x:Extended):Extended;
begin
 //result:=( 1/(power(2*(x)+3,1/2)) );
 //result:=( -sin(x) );
 //result:=(1/x);
 //result:=(exp(x));
   result:=(2*x);
end;
function TMetodos.Punto_Fijo(ValorA,ValorErrorUser:Extended):TStringList;
var
   ErrorRR:Real = 1;
   i: integer = 0;
   PuntoInicioR,ErrorAbsolut,Temporal,Xn_next: Extended;
begin
   Result:=TStringList.Create;
   PuntoInicioR:=ValorA;
   Try
       Temporal:=StrToFloat(formatfloat('0.0000000000',(Abs(d(PuntoInicioR)))));
       if ((Temporal<0) or (Temporal>1)) then
          begin
            Result.add('|G´(x)| NO ES SE ENCUENTRA ENTRE [0-1]');
            Exit;
          end
       else
           begin
           Result.add(IntToStr(i));
           Result.add(formatfloat('0.0000000',PuntoInicioR));
           while ErrorRR>ValorErrorUser do
             begin
                Xn_next:=(f(PuntoInicioR));
                ErrorAbsolut:=abs(PuntoInicioR - Xn_next);
                ErrorRR:=ErrorAbsolut;
                PuntoInicioR:=Xn_next;
                i:=i+1;
                Result.add(IntToStr(i));
                Result.add(formatfloat('0.0000000',PuntoInicioR));
                Result.add(formatfloat('0.0000000',ErrorAbsolut));
             end;
           Exit;
           end;
   Except
       begin
          Result.add('NO ES POSIBLE DAR SOLUCION');
          Exit;
       end;
   end;
end;


end.
