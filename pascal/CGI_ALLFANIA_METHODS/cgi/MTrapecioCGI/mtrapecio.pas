unit MTrapecio;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, ParseMath, Math;
Type
  TMetodos = Class
    public
      function f(x: Real; s: String):Extended;
      function Metodo_Trapecio(Funcion:string; a, b, n: Extended):TStringList;
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
function TMetodos.Metodo_Trapecio(Funcion:string; a,b ,n: Extended):TStringList;
var
  H : Real;
  Temporal : Real;
  Suma : Real = 0;
  Iterador : Integer = 0;
  Rpta : Real;
  xn : real;
begin
  Result:=TStringList.Create;
   Try
      H:=( (b -a)/(n) );
      xn:= a + H;
      Temporal:=( (f (a, Funcion)+ f (b, Funcion) )/2 );
      while Iterador < n do begin
        Suma:= Suma+ (f ( xn, Funcion));
        xn := xn + H ;
        Iterador:=Iterador+1;
      end;
      Rpta:=( H*(Temporal + Suma));
      Result.add(formatfloat('0.0000000000',Rpta));
   Except
       begin
          Result.add('No hay posible solucion');
          Exit;
       end;
   end;
end;


end.
