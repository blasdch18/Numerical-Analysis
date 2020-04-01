unit Unit2;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, math, DMatrix;
Type
  TMetodos = Class
    public
      function Polinomio_Newton(Base_XY:TDMatrix;NDatos:Integer):TStringList;
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
function TMetodos.Polinomio_Newton(Base_XY:TDMatrix;NDatos:Integer):TStringList;
var
   iterador: Integer = 0;
   DiagonalFilaCol: Integer = 2;
   Temporal: Integer ;
   PolinomioNW:String ='';
   TemporalMultiplicaciones:String ='';
   Numerador:String;
   Denominador:String;
   RowCount,ColCount:Integer;
   Base_XY_2:TDMatrix;
begin
   Result:=TStringList.Create;
   Base_XY_2 := TDMatrix.Create(NDatos+1,NDatos); ///COLUMNAS , FILAS
   ColCount:=Base_XY_2.RowCount;
   RowCount:=Base_XY_2.ColCount;
   Try
        While iterador < RowCount do begin
            Base_XY_2.Matrix[0][iterador]:=Base_XY.Matrix[iterador][0];
            Base_XY_2.Matrix[1][iterador]:=Base_XY.Matrix[iterador][1];
            iterador:=iterador+1;
        end;
        PolinomioNW:='('+FloatToStr(Base_XY_2.Matrix[DiagonalFilaCol][DiagonalFilaCol])+')';
        While DiagonalFilaCol < ColCount do begin
             Temporal:=DiagonalFilaCol-1;
             while Temporal < RowCount do begin
                  Numerador:='';
                  Denominador:='';
                  Numerador:=FloatToStr((Base_XY_2.Matrix[DiagonalFilaCol-1][Temporal])-(Base_XY_2.Matrix[DiagonalFilaCol-1][Temporal-1]));
                  Denominador:=FloatToStr((Base_XY_2.Matrix[0][Temporal])-(Base_XY_2.Matrix[0][(Temporal-(DiagonalFilaCol-1))]));
                  Base_XY_2.Matrix[DiagonalFilaCol][Temporal]:=(StrToFloat(Numerador)/StrToFloat(Denominador));
                  Temporal:=Temporal+1;
             end;
             TemporalMultiplicaciones:=TemporalMultiplicaciones+'*(x-'+'('+FloatToStr(Base_XY_2.Matrix[0][DiagonalFilaCol-2])+')'+')';
             PolinomioNW:=PolinomioNW+'+'+'('+FloatToStr(Base_XY_2.Matrix[DiagonalFilaCol][DiagonalFilaCol-1])+')'+TemporalMultiplicaciones;
             DiagonalFilaCol:=DiagonalFilaCol+1;
        end;
        Result.add(PolinomioNW);
   Except
       begin
          Result.add('NO ES POSIBLE DAR SOLUCION');
          Exit;
       end;
   end;

end;


end.
