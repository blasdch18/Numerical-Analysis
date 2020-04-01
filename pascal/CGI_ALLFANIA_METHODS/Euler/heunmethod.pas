unit HeunMethod;

{$mode objfpc}{$H+}

interface

uses
   math, mCalculator, mFuncImp, BaseMethod;

type
   THeunMethod = class(TBaseMethod)
   public
      function solve() : TArrxy; override;
   end;

implementation
function THeunMethod.solve() : TArrxy;
var
   xyValues : TArrxy;
   i : integer;
   xi, yi : real;
   m, yT, fT : real;
begin
   setLength(xyValues, 2, 1); // 2 x N;
   xyValues[0][0] := _x0;
   xyValues[1][0] := _y0;
   i := 0;
   while (xyValues[0][i] + _h <= _xf) do
   begin
      xi := xyValues[0][i];
      yi := xyValues[1][i];

      fT := _function.solveSavedExpression(['x', 'y'],[xi, yi])[0][0];
      yT := yi + _h * fT;
      m := fT + _function.solveSavedExpression(['x', 'y'],[xi + _h, yT])[0][0]; // NOTA: x + h == x(n+1)
      m := m / 2;

      setLength(xyValues, 2, length(xyValues[0]) + 1);
      xyValues[1][i + 1] := yi + _h * m;
      xyValues[0][i + 1] := xi + _h;

      i := i + 1;
   end;
   Result := xyValues;
end;

end.
