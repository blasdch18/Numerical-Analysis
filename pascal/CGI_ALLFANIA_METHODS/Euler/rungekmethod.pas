unit RungeKMethod;

{$mode objfpc}{$H+}

interface

uses
   math, mCalculator, mFuncImp, BaseMethod,ParseMath;

type
   TRungeKuttaMethod = class(TBaseMethod)
   public
      function solve() : TArrxy; override;
      function evaluar(valorX, valorY : Real ; f_x : String ) : Real;
   end;

// (sin(power(2.718281,x*y)))/(2*y-x*cos(power(2.718281,x*y)))
// f(-0.7) = 0.49

implementation


function TRungeKuttaMethod.solve() : TArrxy;
var
   xyValues : TArrxy;
   i : integer;
   xi, yi : real;
   h_2, k1, k2, k3 , k4, m : real;
begin
   setLength(xyValues, 2, 1); // 2 x N;
   xyValues[0][0] := _x0;
   xyValues[1][0] := _y0;
   i := 0;
   h_2 := _h / 2;
   while (xyValues[0][i]+_h <= _xf) do
   begin
      xi := xyValues[0][i];
      yi := xyValues[1][i];

      //k1 := _function.solveSavedExpression(['x', 'y'],[xi, yi])[0][0];
      k1 := evaluar(xi,yi,_f);
      //k2 := _function.solveSavedExpression(['x', 'y'],[xi + h_2, yi + k1 * h_2])[0][0];
      k2 := evaluar(xi +h_2 , yi + k1 * h_2,_f);
      //k3 := _function.solveSavedExpression(['x', 'y'],[xi + h_2, yi + k2 * h_2])[0][0];
      k3 := evaluar(xi +h_2 , yi + k2 * h_2 ,_f);
      //k4 := _function.solveSavedExpression(['x', 'y'],[xi + _h, yi + k3 * _h])[0][0];
      k4 := evaluar(xi +_h , yi + k3 * _h ,_f);
      m := (k1 + 2*k2 + 2*k3 + k4) / 6;

      setLength(xyValues, 2, length(xyValues[0]) + 1);
      xyValues[1][i + 1] := yi + _h * m;
      xyValues[0][i + 1] := xi + _h;

      i := i + 1;
   end;
   Result := xyValues;
end;

function TRungeKuttaMethod.evaluar(valorX, valorY : Real ; f_x : String ) : Real;
var
   MiParse : TParseMath;
begin
  try
  Miparse := TParseMath.create();
  MiParse.AddVariable('x',valorX);
  MiParse.AddVariable('y',valorY);
  MiParse.Expression:= f_x;
  evaluar := MiParse.Evaluate();
  except
     evaluar:=0.0;
     Exit;
  end;
end;
end.
