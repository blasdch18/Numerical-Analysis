unit mFuncImp;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, math, mMatrix;

// Básicas : +, -, *, /, ^, negación.
function fsum(constref args : array of TMatrix) : TMatrix;
function fsub(constref args : array of TMatrix) : TMatrix;
function fmul(constref args : array of TMatrix) : TMatrix;
function fdiv(constref args : array of TMatrix) : TMatrix;
function fpow(constref args : array of TMatrix) : TMatrix;
function fneg(constref args : array of TMatrix) : TMatrix;

// ln, exp, log(base, número)
function fln(constref args : array of TMatrix) : TMatrix;
function fexp(constref args : array of TMatrix) : TMatrix;
function flog(constref args : array of TMatrix) : TMatrix;

// trigonométricas sin, cos, tan, cot, sec, csc
function fsin(constref args : array of TMatrix) : TMatrix;
function fcos(constref args : array of TMatrix) : TMatrix;
function ftan(constref args : array of TMatrix) : TMatrix;
function fctg(constref args : array of TMatrix) : TMatrix;
function fsec(constref args : array of TMatrix) : TMatrix;
function fcsc(constref args : array of TMatrix) : TMatrix;

// trigonométricas inversas: arcoseno, arcocoseno, arcotangente
function fasin(constref args : array of TMatrix) : TMatrix;
function facos(constref args : array of TMatrix) : TMatrix;
function fatan(constref args : array of TMatrix) : TMatrix;

// funciones hiperbólicas: sinh, cosh, tanh
function fsinh(constref args : array of TMatrix) : TMatrix;
function fcosh(constref args : array of TMatrix) : TMatrix;
function ftanh(constref args : array of TMatrix) : TMatrix;

// inversas de funciones hiperbólicas: asinh, acosh, atanh
function fasinh(constref args : array of TMatrix) : TMatrix;
function facosh(constref args : array of TMatrix) : TMatrix;
function fatanh(constref args : array of TMatrix) : TMatrix;

function ffact(constref args : array of TMatrix) : TMatrix;
function fabs(constref args : array of TMatrix) : TMatrix;
function ffloor(constref args : array of TMatrix) : TMatrix;
function fceil(constref args : array of TMatrix) : TMatrix;
function fsqrt(constref args : array of TMatrix) : TMatrix;

//funciones solo aplicables a matrices
function ftranspose(constref args : array of TMatrix) : TMatrix;
function finverse(constref args : array of TMatrix) : TMatrix;
function fdet(constref args : array of TMatrix) : TMatrix;

//Función especial para constrefruir matrices:
function mbuildMat(constref args : array of TMatrix) : TMatrix;

implementation

function fsum(constref args : array of TMatrix) : TMatrix;
var
   matTmp : TMatrix;
   i, j, rows, cols : integer;
begin
   if (not isSingle(args[0])) or (not isSingle(args[1])) then
   begin
      rows := min(countRows(args[0]), countRows(args[1]));
      cols := min(countCols(args[0]), countCols(args[1]));
      setLength(matTmp, rows, cols);

      for i := 0 to rows - 1 do
      begin
         for j := 0 to cols - 1 do
            matTmp[i][j] := args[0][i][j] + args[1][i][j];
      end;
      Result := matTmp;
   end
   else
      Result := createMatrix(args[0][0][0] + args[1][0][0]);
end;

function fsub(constref args : array of TMatrix) : TMatrix;
var
   matTmp : TMatrix;
   i, j, rows, cols : integer;
begin
   if (not isSingle(args[0])) or (not isSingle(args[1])) then
   begin
      rows := min(countRows(args[0]), countRows(args[1]));
      cols := min(countCols(args[0]), countCols(args[1]));
      setLength(matTmp, rows, cols);
      for i := 0 to rows - 1 do
      begin
         for j := 0 to cols - 1 do
            matTmp[i][j] := args[0][i][j] - args[1][i][j];
      end;
      Result := matTmp;
   end
   else
      Result := createMatrix(args[0][0][0] - args[1][0][0]);
end;

function fmul(constref args : array of TMatrix) : TMatrix;
var
   rows, cols, same : integer;
   i, j, k : integer;
   tmp : real;
   res : TMatrix;
begin
   if (not isSingle(args[0])) and (not isSingle(args[1])) then
   begin
      rows := countRows(args[0]);
      cols := countCols(args[1]);
      same := min(countCols(args[0]), countRows(args[1])); // TODO: error si cols != rows
      setLength(res, rows, cols);

      for i := 0 to rows - 1 do
      begin
         for j := 0 to cols - 1 do
         begin
            tmp := 0;
            for k := 0 to same - 1 do
               tmp := tmp + args[0][i][k] * args[1][k][j];
            res[i][j] := tmp;
         end;
      end;
      Result := res;
   end
   else if isSingle(args[0]) and isSingle(args[1]) then
      Result := createMatrix(args[0][0][0] * args[1][0][0])
   else // Matriz * escalar
   begin
      if isSingle(args[0]) then
      begin
         rows := countRows(args[1]);
         cols := countCols(args[1]);
         setLength(res, rows, cols);

         for i := 0 to rows - 1 do
         begin
            for j := 0 to cols - 1 do
               res[i][j] := args[1][i][j] * args[0][0][0];
         end;
         Result := res;
      end
      else
      begin
         rows := countRows(args[0]);
         cols := countCols(args[0]);
         setLength(res, rows, cols);

         for i := 0 to rows - 1 do
         begin
            for j := 0 to cols - 1 do
               res[i][j] := args[0][i][j] * args[1][0][0];
         end;
         Result := res;
      end;
   end;
end;

function fdiv(constref args : array of TMatrix) : TMatrix;
var
   rows, cols : integer;
   i, j: integer;
   res: TMatrix;
begin
   if (not isSingle(args[0])) and isSingle(args[1]) then
   begin
      rows := countRows(args[0]);
      cols := countCols(args[0]);
      setLength(res, rows, cols);

      for i := 0 to rows - 1 do
      begin
         for j := 0 to cols - 1 do
            res[i][j] := args[0][i][j] / args[1][0][0];
      end;
      Result := res;
   end
   else
      Result := createMatrix(args[0][0][0] / args[1][0][0]);
end;

function fpow(constref args : array of TMatrix) : TMatrix;
var
   base, matTmp : TMatrix;
   i, j, k, p, rows, cols, powerValue : integer;
   tmp : real;
begin
   powerValue := round(args[1][0][0]); // TODO!!! IMPORTANTE!!! : y si quiero hacer algo^0.5??

   rows := countRows(args[0]);
   cols := countCols(args[0]);

   if (not isSingle(args[0])) and (cols = rows) then
   begin
      setLength(matTmp, rows, cols);
      matTmp := args[0];
      for p := 1 to powerValue - 1 do
         matTmp := fmul([matTmp, args[0]]);
      Result := matTmp;
   end
   else // Cuando es un real
      Result := createMatrix(power(args[0][0][0], args[1][0][0]));
end;

function fneg(constref args : array of TMatrix) : TMatrix;
var
   matTmp : TMatrix;
   i, j, rows, cols : integer;
begin
   rows := countRows(args[0]);
   cols := countCols(args[0]);
   setLength(matTmp, rows, cols);

   for i := 0 to rows - 1 do
   begin
      for j := 0 to cols - 1 do
         matTmp[i][j] := -1 * args[0][i][j];
   end;
   Result := matTmp;
end;

function fln(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(ln(args[0][0][0]));
end;

function fexp(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(exp(args[0][0][0]));
end;

function flog(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(logn(args[0][0][0],args[1][0][0]));
end;

function fsin(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(sin(args[0][0][0]));
end;

function fcos(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(cos(args[0][0][0]));
end;

function ftan(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(tan(args[0][0][0]));
end;

function fctg(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(cotan(args[0][0][0]));
end;

function fsec(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(sec(args[0][0][0]));
end;

function fcsc(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(cosecant(args[0][0][0]));
end;

function fasin(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(arcsin(args[0][0][0]));
end;

function facos(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(arccos(args[0][0][0]));
end;

function fatan(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(arctan(args[0][0][0]));
end;

function fsinh(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(sinh(args[0][0][0]));
end;

function fcosh(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(cosh(args[0][0][0]));
end;

function ftanh(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(tanh(args[0][0][0]));
end;

function fasinh(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(arcsinh(args[0][0][0]));
end;

function facosh(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(arccosh(args[0][0][0]));
end;

function fatanh(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(arctanh(args[0][0][0]));
end;

function ffact(constref args : array of TMatrix) : TMatrix;
var
   i : integer;
   times : integer;
   res : real;
begin
   res := 1;
   times := floor(args[0][0][0]);
   for i := 1 to times do
      res := res * i;
   Result := createMatrix(res);
end;

function fabs(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(abs(args[0][0][0]));
end;

function ffloor(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(floor(args[0][0][0]));
end;

function fceil(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(ceil(args[0][0][0]));
end;

function fsqrt(constref args : array of TMatrix) : TMatrix;
begin
   Result := createMatrix(sqrt(args[0][0][0]));
end;

function ftranspose(constref args : array of TMatrix) : TMatrix;
var
   transposeMat : TMatrix;
   i, j, rows, cols : integer;
begin
   rows := countRows(args[0]);
   cols := countCols(args[0]);
   setLength(transposeMat, cols, rows);

   for i := 0 to rows - 1 do
   begin
      for j := 0 to cols - 1 do
         transposeMat[j][i] := args[0][i][j];
   end;

   Result := transposeMat;
end;

function finverse(constref args : array of TMatrix) : TMatrix;
var
   inverseMat, detAdjMat, transposed, tDet: TMatrix;
   setAdjMatrix : array of array of TMatrix;
   i, a, b, j, k, l, rows, cols  : integer;
   det, auxReal : real;
begin
   rows := countRows(args[0]);
   cols := countCols(args[0]);
   setLength(inverseMat, cols, rows);

   if rows = cols then // TODO:IMPORTANTE!!!!!!! Falta un Result!!! si no se cumple esta condición!
   begin
      if rows = 2 then
      begin
         det :=  fdet(args[0])[0][0];
         if det = 0 then exit(createMatrix(Nan));
         inverseMat[0][0] := args[0][1][1] / det;
         inverseMat[0][1] := -1 * args[0][0][1] / det;
         inverseMat[1][0] := -1 * args[0][1][0] / det;
         inverseMat[1][1] := args[0][0][0] / det;
      end
      else
      begin
         setLength(setAdjMatrix, rows, cols, rows-1, cols-1);
         for a := 0 to rows - 1 do              //set matriz adjunta
         begin
            for b := 0 to rows - 1 do
            begin
               k := 0;
               l := 0;
               for i := 0 to rows - 1 do
               begin
                  for j := 0 to rows - 1 do
                  begin
                     if (i <> a) and (j<>b) then
                     begin
                        setAdjMatrix[a][b][k][l] := args[0][i][j];
                        l := l + 1;
                        if l = cols - 1 then
                        begin
                           k := k + 1;
                           l := l mod (cols - 1);
                        end;
                     end;
                  end;
               end;
            end;
         end;

         setLength(detAdjMat, rows, cols);
         for a := 0 to rows - 1 do  //set determinantes matriz adjunta
         begin
            for b := 0 to rows - 1 do
            begin
               auxReal := fdet(setAdjMatrix[a][b])[0][0];
               detAdjMat[a][b] := auxReal * power(-1, a + b);
            end;
         end;

         transposed := ftranspose(detAdjMat);
         det := fdet(args[0])[0][0];
         if det = 0 then exit(createMatrix(Nan)); // TODO :si el det = 0 no existe la inversa
         det := 1 / det;
         tDet := createMatrix(det);
         inverseMat := fmul([tDet, transposed]);
      end;
      Result := inverseMat;
   end;
end;

function fdet(constref args : array of TMatrix) : TMatrix;
var
   i, j, k, a, b, cols : integer;
   det : real;
   auxMat :TMatrix;
begin
   cols := countCols(args[0]);

   if cols = 2 then
   begin
      det := (args[0][0][0] * args[0][1][1]) - (args[0][0][1] * args[0][1][0]);
      exit(createMatrix(det));
   end;

   det := 0;
   for i := 0 to cols - 1 do
   begin
      setLength(auxMat, cols - 1, cols - 1);
      j := 0;
      k := 0;
      for a := 0 to cols - 1 do
      begin
         for b := 0 to cols - 1 do
         begin
            if (a <> 0) and (b <> i) then
            begin
               auxMat[j][k] := args[0][a][b];
               k := k + 1;
               if k = cols - 1 then
               begin
                  j := j + 1;
                  k := k mod (cols - 1);
               end;
            end;
         end;
      end;
      det := det + args[0][0][i] * fdet(auxMat)[0][0] * power(-1, i);
   end;
   Result := createMatrix(det);
end;

function mbuildMat(constref args : array of TMatrix) : TMatrix;
var
   n, cols, rows : integer;
   i : integer;
   auxArr : array of real;
   size : integer;
begin
   size := length(args);
   rows := floor(args[size - 2][0][0]);
   cols := floor(args[size - 1][0][0]);
   n :=  rows * cols;
   setLength(auxArr, n);
   for i := 0 to n - 1 do
   begin
      auxArr[i] := args[i][0][0];
   end;

   Result := createMatrix(rows, cols, auxArr);
end;

end.
