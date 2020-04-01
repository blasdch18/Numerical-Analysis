unit Matrices;

{$mode objfpc}{$H+}

interface
 uses
     Classes, SysUtils, StrMat, ArrStr;
 type
    m_Matriz = array of array of real;
    //m_ArrReal = array of real;

 type TMatrices = class
    public
      A :m_Matriz;
      Constructor Create(const n,m:Integer);
      procedure setMatriz();
      procedure setMatriz(i,j :Integer;numSet :Real );
      procedure printM();
      function get_element(i,j: Integer): Real;    //fila, columna
      function get_columnas() : Integer;
      function get_filas() : Integer;
      function toStr(matReal :TMatrices):TStrMatriz;

  end;

implementation

Constructor TMatrices.Create(const n,m:Integer);
begin
      SetLength(A,n,m);
end;


procedure TMatrices.setMatriz();
Var
   m,n,j,i:Integer;
   numSet :Real;
begin
      m:=Length(A);
      n:=Length(A[0]);
      for j:=0 to m-1 do begin
          WriteLn('Fila ',j);
          for i:=0 to n-1 do begin
                Read (numSet);
                A[j,i]:= numSet;
          end;
      end;
      WriteLn(' ');
end;

procedure TMatrices.setMatriz(i,j :Integer;numSet :Real );
begin
    A[j,i]:= numSet;
end;

procedure TMatrices.printM();
Var
     m,n,j,i:Integer;
begin
     m:=Length(A);
     n:=Length(A[0]);
     for j:=0 to m-1 do begin
         Write('[ ');
         for i:=0 to n-1 do begin
             Write(A[j,i] :0:2,' , ');
         end;
         WriteLn(' ]');
     end;
     ReadLn;
     WriteLn(' ');
end;

function TMatrices.get_element(i,j: Integer): Real;
begin
     get_element:=A[i,j];
end;

function TMatrices.get_filas() : Integer;
begin
     get_filas := Length(A);
end;

function TMatrices.get_columnas() : Integer;
begin
     get_columnas:=Length(A[0]);
end;

function TMatrices.toStr(matReal :TMatrices):TStrMatriz;
var
   matStr : TStrMatriz;
   i,j :Integer ;
   arrStr : TArrString;
begin
   matStr := TStrMatriz.Create;
   for i:=0 to get_filas()-1 do begin
       arrStr := TArrString.Create();
       for j:=0 to get_columnas()-1 do begin
           arrStr.push( FloatToStr(get_element(i,j)) );
       end;
       matStr.push(arrStr);
   end;
   toStr := matStr;
end;

end.

