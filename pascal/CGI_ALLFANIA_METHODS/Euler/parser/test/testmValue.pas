program TestmValue;

{$mode objfpc}{$H+}

uses
   mValue;
procedure printMat(x : TMatrix);
var
   i, j : integer;
begin
   for i := 0 to length(x) - 1 do
   begin
      for j := 0 to length(x[0]) - 1 do
         write(x[i,j]:0:0, ' ');
      writeln();
   end;
   writeln();
end;

var
   mat1 : TMatrix;
   arr1 : array of real;
   val1, val2, val3 : TValue;
   rows, cols, size : integer;
   i, j, k : integer;
begin
   rows := 3;
   cols := 4;
   setLength(mat1, rows, cols);

   k := 0;
   for i := 0 to rows - 1 do
   begin
      for j := 0 to cols - 1 do
      begin
         mat1[i][j] := k;
         k := k + 1;
      end;
   end;

   printMat(mat1);

   size := 9;
   setLength(arr1, size);
   for i := 0 to size - 1 do
   begin
      k := k + 1;
      arr1[i] := k;
   end;

   for i := 0 to size - 1 do
       write(arr1[i]:0:0, ' ');
   writeln(); writeln();

   val1 := TValue.create(mat1);
   val2 := TValue.create(3, 3, arr1);
   val3 := TValue.create(100);

   writeln('tipo: ', val1.getType, '  Filas: ', val1.rows, '  Columnas: ', val1.cols);
   printMat(val1.getVal);
   writeln('tipo: ', val2.getType, '  Filas: ', val2.rows, '  Columnas: ', val2.cols);
   printMat(val2.getVal);
   writeln('tipo: ', val3.getType, '  Filas: ', val3.rows, '  Columnas: ', val3.cols);
   printMat(val3.getVal);

   val3.setVal(mat1);
   writeln('tipo: ', val3.getType, '  Filas: ', val3.rows, '  Columnas: ', val3.cols);
   printMat(val3.getVal);

   val3.setval(3,3,arr1);
   writeln('tipo: ', val3.getType, '  Filas: ', val3.rows, '  Columnas: ', val3.cols);
   printMat(val3.getVal);

end.

