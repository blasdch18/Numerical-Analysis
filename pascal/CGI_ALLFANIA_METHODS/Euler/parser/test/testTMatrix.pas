program TestTMatrix;

{$mode objfpc}{$H+}

uses
   mMatrix;

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
   val2, val3 : TMatrix;
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

   val2 := createMatrix(3, 3, arr1);
   val3 := createMatrix(100);

   printMat(val2);
   printMat(val3);

   writeln(countCols(val2), ' ', countCols(val3));
   writeln(countRows(val2), ' ', countRows(val3));

   writeln(isSingle(val2), ' ', isSingle(val3));
end.
