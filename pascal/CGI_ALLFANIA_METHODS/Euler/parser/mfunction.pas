unit mFunction;

{$mode objfpc}{$H+}

interface

uses
   Classes, mMatrix;

type
   functionType = function(constref args : array of TMatrix) : TMatrix;

   TFunc = class
   protected
      _numOp : integer;
      _func : functionType;
   public
      constructor create(ffunction : functionType; numOp : integer);

      function numOp : integer;
      function solve(constref args : array of TMatrix) : TMatrix;
   end;

implementation

constructor TFunc.create(ffunction : functionType; numOp : integer);
begin
   self._func := ffunction;
   self._numOp := numOp;
end;

function TFunc.numOp : integer;
begin
   Result := self._numOp;
end;

function TFunc.solve(constref args : array of TMatrix) : TMatrix;
begin
   // NOTA: es necesario comprobar que la cantidad de parámetros
   // ingresados sea igual a la de _numOp ?
   // lenght(args) = _numOp;
   Result := self._func(args);
end;

end.
