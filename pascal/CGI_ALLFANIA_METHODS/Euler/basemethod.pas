unit BaseMethod;

{$mode objfpc}{$H+}

interface

uses
   math, mCalculator, mFuncImp, mMatrix,
   Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, CheckLst, Menus;

type
   TArrxy = array of array of real;

   TBaseMethod = class
   protected
      _function : TCalculator;
      _x0 : real;
      _y0 : real;
      _xf : real;
      _h : real;
      _f : String;
   public
      constructor create();
      destructor destroy(); override;

      procedure setData(func : string; x0, y0, xf : real);
      function solve() : TArrxy; virtual; abstract;
   end;

implementation

constructor TBaseMethod.create();
begin
   _function := TCalculator.create();
end;

destructor TBaseMethod.destroy();
begin
   _function.destroy();
end;

procedure TBaseMethod.setData(func : string; x0, y0, xf : real);
begin
   _f := func;
   _function.solveExpression(func);
   _x0 := x0;
   _y0 := y0;
   _xf := xf;
   _h := 0.1;
   //_h := abs(_x0-_y0)/13;
   //_h := 0.3;
   //ShowMessage(FloatToStr(_h));
end;

end.
