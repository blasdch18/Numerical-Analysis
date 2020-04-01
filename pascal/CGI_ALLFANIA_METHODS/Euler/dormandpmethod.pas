unit DormandPMethod;

{$mode objfpc}{$H+}

interface

uses
   math, mCalculator, mFuncImp, mMatrix, BaseMethod, ParseMath;

type
   TDormandPrinceMethod = class(TBaseMethod)
   public
      function solve() : TArrxy; override;
      function evaluar(valorX, valorY : Real ; f_x : String ) : Real;
   end;

implementation

function TDormandPrinceMethod.solve() : TArrxy;
var
   xyValues : TArrxy;
   k1, k2, k3, k4, k5, k6 ,k7 : real;
   xi, yi, ytmp, ztmp : real;
   i : integer;
   s, eps : real; // s y epsilon
begin
   eps := 0.0001;
   _h := 0.1;
   setLength(xyValues, 2, 1); // 2 x N;
   xyValues[0][0] := _x0;
   xyValues[1][0] := _y0;
   i := 0;
   while (xyValues[0][i] < _xf) do
   begin
      xi := xyValues[0][i];
      yi := xyValues[1][i];
      {*
      k1 := _h * _function.solveSavedExpression(['x', 'y'],[xi, yi])[0][0];
      k2 := _h * _function.solveSavedExpression(
         ['x', 'y'],[xi + 1/5*_h ,
                     yi + 1/5*k1])[0][0];
      k3 := _h * _function.solveSavedExpression(
         ['x', 'y'],[xi + 3/10*_h ,
                     yi + 3/40*k1 + 9/40*k2])[0][0];
      k4 := _h * _function.solveSavedExpression(
         ['x', 'y'],[xi + 4/5*_h ,
                     yi + 44/45*k1 - 56/15*k2 + 32/9*k3])[0][0];
      k5 := _h * _function.solveSavedExpression(
         ['x', 'y'],[xi + 8/9*_h ,
                     yi + 19372/6561*k1 - 25360/2187*k2
                     + 64448/6561*k3 - 212/729*k4])[0][0];
      k6 := _h * _function.solveSavedExpression(
         ['x', 'y'],[xi + _h ,
                     yi + 9017/3168*k1 - 355/33*k2 + 46732/5247*k3
                     + 49/172*k4 - 5103/18656*k5])[0][0];
      k7 := _h * _function.solveSavedExpression(
         ['x', 'y'],[xi + _h ,
                     yi + 35/384*k1 + 500/1113*k3 + 125/192*k4
                     - 2187/6784*k5 + 11/84*k6])[0][0];
      *}
      k1 := _h * evaluar(xi,yi,_f);
      k2 := _h * evaluar(xi + 1/5*_h , yi + 1/5*k1,_f);
      k3 := _h * evaluar(xi + 3/10*_h , yi + 3/40*k1 + 9/40*k2,_f);
      k4 := _h * evaluar(xi + 4/5*_h ,
                     yi + 44/45*k1 - 56/15*k2 + 32/9*k3,_f);
      k5 := _h * evaluar(xi + 8/9*_h ,
                     yi + 19372/6561*k1 - 25360/2187*k2
                     + 64448/6561*k3 - 212/729*k4,_f);
      k6 := _h * evaluar(xi + _h ,
                     yi + 9017/3168*k1 - 355/33*k2 + 46732/5247*k3
                     + 49/172*k4 - 5103/18656*k5,_f);
      k7 := _h * evaluar(xi + _h ,
                     yi + 35/384*k1 + 500/1113*k3 + 125/192*k4
                     - 2187/6784*k5 + 11/84*k6,_f);

      ytmp :=
         yi + 35/384*k1 + 500/1113*k3 + 125/192*k4 - 2187/6784*k5 + 11/84*k6;
      ztmp := yi + 5179/57600*k1 + 7571/16695*k3 + 393/640*k4 - 92097/339200*k5
         + 187/2100*k6 + 1/40*k7;

      // para calcular s :
      s := power(_h*eps/(2*(_xf - _x0)*abs(ytmp - ztmp)), 1/4);
      if s >= 2 then
      begin
         setLength(xyValues, 2, length(xyValues[0]) + 1);
         xyValues[0][i + 1] := xi + _h;
         xyValues[1][i + 1] := ytmp;
         i := i + 1;
         _h := _h * 2;
      end
      else if s >= 1 then
      begin
         setLength(xyValues, 2, length(xyValues[0]) + 1);
         xyValues[0][i + 1] := xi + _h;
         xyValues[1][i + 1] := ytmp;
         i := i + 1;
      end
      else
         _h := _h / 2;

      if (xyValues[0][i] + _h > _xf) then
         _h := _xf - xyValues[0][i];
   end;
   Result := xyValues;
end;

function TDormandPrinceMethod.evaluar(valorX, valorY : Real ; f_x : String ) : Real;
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

