unit Unit2;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, math;
Type
  TMetodos = Class
    public
      function Polinomio_Lagrange(Base_XY:TStringList):TStringList;
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
function TMetodos.Polinomio_Lagrange(Base_XY:TStringList):TStringList;
var
   iterador: Integer = 0;
   iterador2: Integer;
   PolinomioLG:String ='';
   Numerador:String;
   Denominador:String;
begin
   Result:=TStringList.Create;
   Result:= '<h1>Polinomio de Lagrange</h1>' +Result;
   Try
          while iterador < Base_XY.Count do begin
                iterador2:= 0;
                Numerador:= '';
                Denominador:= '1';
                while iterador2 < Base_XY.Count do
                begin
                      if not (iterador = iterador2) then
                         begin
                         Numerador:= Numerador+ '*(x-'+ '(' + Base_XY[ iterador2] + ')' +')';
                         Denominador:= FloatToStr( StrToFloat( Denominador) *( StrToFloat( Base_XY[ iterador] )
                                       - StrToFloat( Base_XY[ iterador2] )) );
                         end;
                      iterador2:=iterador2+2;
                end;
                PolinomioLG:=PolinomioLG+'+'+'('+Base_XY[iterador+1]+')'+Numerador+'*(1/'+'('+Denominador+')'+')';
                iterador:=iterador+2;
          end;
          Result.add(PolinomioLG);
   Except
       begin
          Result.add('No Hay posible Solucion');
          Exit;
       end;
   end;

end;


end.