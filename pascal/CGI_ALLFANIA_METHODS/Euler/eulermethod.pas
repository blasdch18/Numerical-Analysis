unit EulerMethod;

{$mode objfpc}{$H+}

interface

uses
   math, mCalculator, mFuncImp, mMatrix, BaseMethod;

type
   TEulerMethod = class(TBaseMethod)
   public
      function solve() : TArrxy; override;
   end;

implementation
function TEulerMethod.solve() : TArrxy;
var
   xyValues : TArrxy;
   i : integer;
   xi, yi : real;
begin
   setLength(xyValues, 2, 1); // 2 x N;
   xyValues[0][0] := _x0;
   xyValues[1][0] := _y0;
   i := 0;
   while (xyValues[0][i] + _h <= _xf) do
   begin
      xi := xyValues[0][i];
      yi := xyValues[1][i];
      setLength(xyValues, 2, length(xyValues[0]) + 1);
      xyValues[1][i + 1] := yi + _h * _function.solveSavedExpression(['x', 'y'],[xi, yi])[0][0];
      xyValues[0][i + 1] := xi + _h;

      i := i + 1;
   end;

   Result := xyValues;

end;

end.
