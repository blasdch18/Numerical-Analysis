unit DMatrix;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math;

type
  TDMatrix = Class
  Public
    RowCount:Integer;
    ColCount:Integer;
    Matrix: array of array of Extended;
    procedure SetRCLenght(NRow,NCol:Integer);
    function Add(matrixA:TDMatrix):TDMatrix;
    function Substract(matrixA:TDMatrix):TDMatrix;
    function Adjoint():TDMatrix;
    function Determinant(matrixA : TDMatrix = nil):Extended;
    function Inverse():TDMatrix;
    function Multiply(matrixA:TDMatrix):TDMatrix;
    function Tranponse():TDMatrix;
    function Potencia(Num_Potencia: Integer):TDMatrix;
    function Division(matrixA:TDMatrix):TDMatrix;
    constructor Create(IRowCount,IColCount:Integer);
    constructor Create(matrixA:TDMatrix);
    function Cofactor(Row,Col:Integer;FromMatrix:TDMatrix):TDMatrix;
  end;
implementation

procedure TDMatrix.SetRCLenght(NRow,NCol:Integer);
begin
     RowCount:=NRow;
     ColCount:=NCol;
     SetLength(self.Matrix,NRow,NCol);
end;

function TDMatrix.Add(matrixA:TDMatrix):TDMatrix;
var i,j:Integer;
    RMatrix:TDMatrix;
begin
     if not (self.RowCount=matrixA.RowCount) or not (self.ColCount = matrixA.ColCount) then
     begin
         WriteLn('NO TIENE EL MISMO NUMERO DE FILAS Y  COLUMNAS.');
         exit;
     end;
     RMatrix:=TDMatrix.Create(self.RowCount,self.ColCount);
     for i:=0 to RowCount-1 do
         for j:=0 to ColCount-1 do
             RMatrix.Matrix[i][j]:=self.Matrix[i][j]+matrixA.Matrix[i][j];
     result:= RMatrix;
end;
function TDMatrix.Substract(matrixA:TDMatrix):TDMatrix;
var i,j:Integer;
    RMatrix:TDMatrix;
begin
     if not (self.RowCount=matrixA.RowCount) or not (self.ColCount = matrixA.ColCount) then
     begin
         WriteLn('NO TIENE EL MISMO NUMERO DE FILAS Y  COLUMNAS.');
         exit;
     end;
     RMatrix:=TDMatrix.Create(self.RowCount,self.ColCount);
     i:=0;
     j:=0;
     while i < RowCount do begin
         while j < ColCount do  begin
             RMatrix.Matrix[i][j]:=self.Matrix[i][j]-matrixA.Matrix[i][j];
             j:=j+1;
         end;
         j:=0;
         i:=i+1;
     end;
     result:= RMatrix;
end;
function TDMatrix.Multiply(matrixA:TDMatrix):TDMatrix;
var i,j,k:Integer;
    aux:Extended;
    RMatrix:TDMatrix;
begin
     if not self.ColCount = matrixA.RowCount then
     begin
         WriteLn('NO SE PUEDE EJECUTAR LA MULTIPLICACION');
         exit;
     end
     else begin
       aux:=0;
       RMatrix:=TDMatrix.Create(self.RowCount,matrixA.ColCount);
       i:=0;
       j:=0;
       k:=0;
       while i < RowCount do begin
         while j < ColCount do begin
           while k < RowCount do begin
             RMatrix.Matrix[i][j] := RMatrix.Matrix[i][j]+self.Matrix[i][k]*matrixA.Matrix[k][j];
             k:=k+1
           end;
           k:=0;
           j:=j+1;
         end;
         k:=0;
         j:=0;
         i:=i+1;
       end;
     end;
     result:= RMatrix;
end;

function TDMatrix.Determinant(matrixA:TDMatrix):Extended;
var i:Integer;
    res:Extended;
begin
     res:=0;
     if (matrixA = nil) then
     begin
       matrixA:= TDMatrix.Create(self.RowCount,self.ColCount);
       matrixA.Matrix := self.Matrix;
     end;
     if (MatrixA.RowCount = 1) and (MatrixA.ColCount = 1) then
       res:= matrixA.Matrix[0][0];
     if (MatrixA.RowCount = 2) and (MatrixA.ColCount = 2) then
       res:= matrixA.Matrix[0][0]*matrixA.Matrix[1][1]-matrixA.Matrix[0][1]*matrixA.Matrix[1][0];
     if (MatrixA.RowCount > 2) and (MatrixA.ColCount > 2) and (MatrixA.RowCount = MatrixA.ColCount) then
        for i:= 0 to matrixA.RowCount-1 do
            res:=res+power(-1,(i+1)+1)*matrixA.Matrix[0][i]*Determinant(matrixA.Cofactor(0,i,matrixA));
     result:=res;
end;

function TDMatrix.Inverse():TDMatrix;
var i,j:integer;
    det:Extended;
    RMatrix:TDMatrix;
begin
     RMatrix:=TDMatrix.Create(self.ColCount,self.RowCount);
     RMatrix:=self.Adjoint();
     det := self.Determinant();
     for i:=0 to RMatrix.RowCount-1 do
         for j:=0 to RMatrix.ColCount-1 do
             RMatrix.Matrix[i][j]:=RMatrix.Matrix[i][j]/det;
     result:= RMatrix;
end;

function TDMatrix.Tranponse():TDMatrix;
var i,j:Integer;
    RMatrix:TDMatrix;
begin
     RMatrix:=TDMatrix.Create(self.ColCount,self.RowCount);
     for i:=0 to RMatrix.RowCount-1 do
         for j:=0 to RMatrix.ColCount-1 do
             RMatrix.Matrix[i][j]:=self.Matrix[j][i];
     result:= RMatrix;
end;

function TDMatrix.Adjoint():TDMatrix;
var i,j:Integer;
    RMatrix:TDMatrix;
begin
     RMatrix:=TDMatrix.Create(self.RowCount,self.ColCount);
     for i:=0 to RMatrix.RowCount-1 do
         for j:=0 to RMatrix.ColCount-1 do
             RMatrix.Matrix[i][j]:=power(-1,(i+1)+(j+1))*Determinant(Cofactor(i,j,self));
     result:= RMatrix.Tranponse();
end;

function TDMatrix.Cofactor(Row,Col:Integer;FromMatrix:TDMatrix):TDMatrix;
var RMatrix: TDMatrix;
    i,j,p,q : Integer;
begin
     i:=0;
     j:=0;
     p:=0;
     q:=0;
     RMatrix:= TDMatrix.Create(FromMatrix.RowCount-1,FromMatrix.ColCount-1);
     while (i < FromMatrix.RowCount) and (p < FromMatrix.RowCount-1) do
     begin
         j:=0;
         q:=0;
         if(i = Row) then
           i:=i+1;
         while (j < FromMatrix.ColCount) and (q < FromMatrix.ColCount-1)  do
         begin
             if(j = Col) then
               j:=j+1;
             RMatrix.Matrix[p][q]:=FromMatrix.Matrix[i][j];
             j:=j+1;
             q:=q+1;
         end;
         i:=i+1;
         p:=p+1;
     end;
     result:=RMatrix;
end;
function TDMatrix.Potencia(Num_Potencia: Integer):TDMatrix;
var i,j:Integer;
    RMatrix:TDMatrix;
begin
     i:=1;
     RMatrix:=TDMatrix.Create(self.RowCount,self.ColCount);
     RMatrix:=self;
     while(i<Num_Potencia) do
     begin
        RMatrix:=(RMatrix.Multiply(RMatrix));
        i:=i+1;
     end;
     result:= RMatrix;
end;
function TDMatrix.Division(matrixA:TDMatrix):TDMatrix;
var i,j:Integer;
    RMatrix,RMatrix_Inversa:TDMatrix;
begin
     RMatrix_Inversa:=TDMatrix.Create(self.ColCount,self.RowCount);
     RMatrix:=TDMatrix.Create(self.ColCount,self.RowCount);
     RMatrix_Inversa:=matrixA.Inverse();
     RMatrix:=RMatrix_Inversa.Multiply(self);
     result:= RMatrix;
end;

constructor TDMatrix.Create(IRowCount,IColCount:Integer);
var i,j:Integer;
begin
     self.RowCount:=IRowCount;
     self.ColCount:=IColCount;
     SetLength(Matrix,RowCount,ColCount);
     for i:=0 to RowCount-1 do
         for j:=0 to ColCount-1 do
             Matrix[i, j]:= 0;
end;

constructor TDMatrix.Create(matrixA:TDMatrix);
var i,j:Integer;
begin
     self.RowCount:=matrixA.RowCount;
     self.ColCount:=matrixA.ColCount;
     SetLength(self.matrix,matrixA.RowCount,matrixA.ColCount);
     for i:=0 to RowCount-1 do
         for j:=0 to ColCount-1 do
             Matrix[i, j]:= 0;
end;

end.

