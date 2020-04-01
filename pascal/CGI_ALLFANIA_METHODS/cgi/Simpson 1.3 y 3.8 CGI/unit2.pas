unit Unit2;

{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, math, ParseMath;
Type
  TMetodos = Class
    public
      function f(x:Real;s: String):Extended;
      function Metodo_Simpson13(Funcion:string;a,b :Extended;NumInter:Integer):string;
      function Metodo_Simpson38(Funcion:string;a,b :Extended;NumInter:Integer):string;
      constructor create();
      destructor Destroy; override;
  end;
var
  check: Boolean;
implementation
constructor TMetodos.create();
begin
end;
destructor TMetodos.Destroy;
begin
end;
function TMetodos.f(x : Real;s: String):Extended;
var MiParse: TParseMath;
begin
  MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    //ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    check:=true;
    end;
  end;
  MiParse.destroy;
end;
function TMetodos.Metodo_Simpson13(Funcion:string;a,b :Extended;NumInter:Integer):string;
var
  SumaImpares : Extended = 0;
  SumaPares   : Extended = 0;
  Iterador    : Integer  = 1;
  Rpta,xn,Temporal,H,PreH:Extended;
begin
   Try
      H:=( (b -a)/( 2 * NumInter ) ) / 3;
      PreH :=( (b -a)/( 2 * NumInter ) );
      Temporal:=(f(a,Funcion)+f(b ,Funcion));
        while Iterador < (2*NumInter) do begin
             xn:= a + (PreH * Iterador);
                  if( Iterador mod 2 = 0) then
                     begin
                      SumaImpares := SumaImpares + f( xn,Funcion );
                     end
                  else
                      begin
                       SumaPares := SumaPares + f( xn,Funcion );
                      end;
            Iterador:=Iterador+1;
        end;
        Rpta:=( H * ( Temporal + (2 * (SumaImpares)) + (4 * (SumaPares))));
        Result:=formatfloat('0.00000',Rpta);
   Except
       begin
          Result:='NO ES POSIBLE DAR SOLUCION';
          Exit;
       end;
   end;
end;
function TMetodos.Metodo_Simpson38(Funcion:string;a,b :Extended;NumInter:Integer):string;
var
  PreH,H,Temporal,Rpta,xn: Extended;
  Suma1       : Extended = 0;
  Suma2       : Extended = 0;
  Suma3       : Extended = 0;
  Iterador1   : Integer  = 1;
  Iterador2   : Integer  = 2;
  Iterador3   : Integer  = 3;
begin
   Try
      H:=( (b -a)/( NumInter ) ) * ( 3 / 8 );
      PreH :=( (b -a)/( NumInter ) );
      Temporal:=(f(a,Funcion)+f(b ,Funcion));
      if( NumInter mod 3 = 0) then
          begin
               while Iterador1 <= (NumInter-2) do begin
                     xn:= a + (PreH * Iterador1);
                     Suma1 := Suma1 +  f( xn,Funcion );
                     Iterador1:=Iterador1+3;
                end;
                while Iterador2 <= (NumInter-1) do begin
                     xn:= a + (PreH * Iterador2);
                     Suma2 := Suma2 +  f( xn,Funcion );
                     Iterador2:=Iterador2+3;
                end;
                while Iterador3 <= (NumInter-3) do begin
                     xn:= a + (PreH * Iterador3);
                     Suma3 := Suma3 +  f( xn,Funcion ) ;
                     Iterador3:=Iterador3+3;
                end;
                Rpta:=( H * ( Temporal + (3 * (Suma1)) + (3 * (Suma2)) + (2 * (Suma3))));
                Result:=formatfloat('0.00000',Rpta);
          end
      else
          begin
               Result:='N NO ES MULTIPLO DE 3';
          end;
   Except
       begin
          Result:='NO ES POSIBLE DAR SOLUCION';
          Exit;
       end;
   end;
end;
end.

