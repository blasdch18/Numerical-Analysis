unit mCalculator;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, mMaps, mParser,
   mtree, mFunction, mFuncImp, mMatrix;

type

   TCalculator = class
   private
      functions : TFunctionMap;
      constants : TVarMap;
      variables : TVarMap;

      syntaxTree : TTree;
      parser : TParser;

      procedure setFunctions();
      procedure setConstants();
   public
      constructor create;
      destructor destroy; override;

      function solveExpression(expression : string) : TMatrix;
      function solveSavedExpression(vars : array of string; values : array of real) : TMatrix;
   end;

implementation

constructor TCalculator.create;
begin
   functions := TFunctionMap.create;
   constants := TVarMap.create;
   variables := TVarMap.create;
   self.setFunctions();
   self.setConstants();

   parser := TParser.create(@functions, @constants);    // (el parser no recibe variables)-
   //--porque?- no puede trabajar con los atributos de MCalculator
   syntaxTree := TTree.create(@functions, @constants, @variables);
end;

destructor TCalculator.destroy;
begin
   parser.destroy;
   syntaxTree.destroy;
   functions.destroy;
   constants.destroy;
   variables.destroy;
end;

function TCalculator.solveExpression(expression : string) : TMatrix;
begin
   syntaxTree.clearRoot();
   parser.strIntoST(expression, @syntaxTree);
   Result:= syntaxTree.solve();
end;

function TCalculator.solveSavedExpression(vars : array of string; values : array of real) : TMatrix;
var
   i : integer;
begin
   for i := 0 to length(vars) - 1 do
      variables[vars[i]] := createMatrix(values[i]);
   Result:= syntaxTree.solve();
end;

procedure TCalculator.setFunctions();
begin
   functions['fsum'] := TFunc.create(@fsum, 2);
   functions['fsub'] := TFunc.create(@fsub, 2);
   functions['fmul'] := TFunc.create(@fmul, 2);
   functions['fdiv'] := TFunc.create(@fdiv, 2);
   functions['fpow'] := TFunc.create(@fpow, 2);
   functions['fneg'] := TFunc.create(@fneg, 1);
   functions['fln']  := TFunc.create(@fln, 1);
   functions['fexp'] := TFunc.create(@fexp, 1);
   functions['flog'] := TFunc.create(@flog, 2);
   functions['fsin'] := TFunc.create(@fsin, 1);
   functions['fcos'] := TFunc.create(@fcos, 1);
   functions['ftan'] := TFunc.create(@ftan, 1);
   functions['fctg'] := TFunc.create(@fctg, 1);
   functions['fsec'] := TFunc.create(@fsec, 1);
   functions['fcsc'] := TFunc.create(@fcsc, 1);
   functions['fasin'] := TFunc.create(@fasin, 1);
   functions['facos'] := TFunc.create(@facos, 1);
   functions['fatan'] := TFunc.create(@fatan, 1);
   functions['fsinh'] := TFunc.create(@fsinh, 1);
   functions['fcosh'] := TFunc.create(@fcosh, 1);
   functions['ftanh'] := TFunc.create(@ftanh, 1);
   functions['fasinh'] := TFunc.create(@fasinh, 1);
   functions['facosh'] := TFunc.create(@facosh, 1);
   functions['fatanh'] := TFunc.create(@fatanh, 1);
   functions['ffact'] := TFunc.create(@ffact, 1);
   functions['fabs'] := TFunc.create(@fabs, 1);
   functions['ffloor'] := TFunc.create(@ffloor, 1);
   functions['fceil'] := TFunc.create(@fceil, 1);
   functions['fsqrt'] := TFunc.create(@fsqrt, 1);
   functions['ftranspose'] := TFunc.create(@ftranspose, 1);
   functions['finverse'] := TFunc.create(@finverse, 1);
   functions['fdet'] := TFunc.create(@fdet, 1);
   //Función especial!!!:
   functions['fbuildMat'] := TFunc.create(@mbuildMat, 0);
end;

procedure TCalculator.setConstants();
begin
   constants['cpi'] := createMatrix(pi);
end;

end.
