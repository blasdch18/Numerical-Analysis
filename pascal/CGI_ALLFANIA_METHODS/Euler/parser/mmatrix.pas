unit mMatrix;

{$mode objfpc}{$H+}

interface

type
   TMatrix =  array of array of real;

   // NOTA: El constref es para pasarlo por referencia
   function countCols(constref matrix : TMatrix) : integer;
   function countRows(constref matrix : TMatrix) : integer;
   // Retorna True si la matriz contiene un solo valor:
   function isSingle(constref matrix : TMatrix) : boolean;

   // Crea una matriz de rows x cols, con los valores de vals:
   function createMatrix(const rows, cols : integer; const vals : array of real): TMatrix; overload;
   // Crea una matriz con el valor val:
   function createMatrix(const val : real) : TMatrix; overload;

implementation

function countCols(constref matrix : TMatrix) : integer;
begin
   Result := length(matrix[0]);
end;

function countRows(constref matrix : TMatrix) : integer;
begin
   Result := length(matrix);
end;

function isSingle(constref matrix : TMatrix) : boolean;
begin
   if (length(matrix) > 1) or (length(matrix[0]) > 1) then
      Result := false
   else
      Result := true;
end;

function createMatrix(const rows, cols : integer; const vals : array of real): TMatrix;
var
   matrix : TMatrix;
   i, j, k : integer;
begin
   setLength(matrix, rows, cols);

   k := 0;
   for i := 0 to rows - 1 do
   begin
      for j := 0 to cols - 1 do
      begin
         matrix[i][j] := vals[k];
         k := k + 1;
      end;
   end;
   Result := matrix;
end;

function createMatrix(const val : real) : TMatrix; overload;
var
   matrix : TMatrix;
begin
   setLength(matrix, 1, 1);
   matrix[0][0] := val;
   Result := matrix;
end;
end.
