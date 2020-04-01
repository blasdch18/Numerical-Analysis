unit cmatriz;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil,Math, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids;


const
  filas=100;
  columnas=100;
type
    mtr = array of array of real;
    matriz= array[0..100, 0..100] of Real;
type
    Tmatriz=class

    matrix:array[1..filas,1..columnas] of Real;
   // resul:array[1..filas,1..columnas] of Real;


    f:Integer;
    c:Integer;
    lagra:Double;

  function suma(m1:Tmatriz):Tmatriz;
  function resta(m1:Tmatriz):Tmatriz;
  function mult_matriz(m1:Tmatriz):Tmatriz;
  function mult_escalar(m1:Double):Tmatriz;
  function inversa(m1:Tmatriz):Tmatriz;
  function generar_matriz(grid: TStringGrid):Boolean;
  function generar_smatriz:String;
  function traza:Double;
 // function adjunta(Orden: Integer; M: Tmatriz);
 function gauss(mat:Tmatriz;dim:Integer;det: Boolean ):Tmatriz;
  function determinante(A:Tmatriz;filas:Integer):Double;
  function lagrange(z:Double):String;
   function Suma(A,B : matriz; n,m:integer):matriz;
    function Resta(A,B : matriz; n,m:integer):matriz;
    function MultEsc(A: matriz;esc:Real;n,m:integer):matriz;
    function Mult(A,B: matriz;n,m,o:integer):matriz;
    function Transpuesta(A: matriz;n,m:integer):matriz;
    function Traza(A: matriz;n,m:integer):real;
    function Determinante(A: matriz;filas,col:integer):real;




end;

implementation

function Tmatriz.generar_smatriz():String;
var
  i,j:Integer;
  res:String;
begin
  res:='[';
  //res:=res+FloatToStr(Self.matrix[1,1])+' ';
for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
        res:=res+FloatToStr(Self.matrix[i,j])+' ';
       // Self.matrix[i,j]:=StrToFloat(grid.Cells[j-1,i-1]);
      end;
      res:=res+', '
    end;
res:=res+']';
Result:=res;
end;

function Tmatriz.generar_matriz(grid: TStringGrid):Boolean;
var
  i,j:Integer;
begin


for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
        Self.matrix[i,j]:=StrToFloat(grid.Cells[j-1,i-1]);

      end;
    end;
Result:=True;
end;

//hacer lagrange

function Tmatriz.suma(m1:Tmatriz):Tmatriz;
var
  i,j:Integer;
  m3:Tmatriz;

begin
     m3:=Tmatriz.Create;

  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
         m3.matrix[i,j]:=m1.matrix[i,j]+Self.matrix[i,j];
      end;
    end;


  Result:=m3;

end;


function Tmatriz.resta(m1:Tmatriz):Tmatriz;
var
  i,j:Integer;
  m3:Tmatriz;
begin
  m3:=Tmatriz.Create;
  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
           m3.matrix[i,j]:=Self.matrix[i,j]-m1.matrix[i,j];
      end;
    end;

  Result:=m3;

end;


function Tmatriz.mult_escalar(m1:Double):Tmatriz;
var
  i,j:Integer;
  m3:Tmatriz;

begin
  m3:=Tmatriz.Create;
  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
           m3.matrix[i,j]:=m1*Self.matrix[i,j];
      end;
    end;

  Result:=m3;

end;


function Tmatriz.inversa(m1:Tmatriz):Tmatriz;
var
  i,j:Integer;
  m3:Tmatriz;
begin
  ///verificar sitienes determinante !=0 sino no hay
  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
           m3.matrix[i,j]:=m1.matrix[i,j]+Self.matrix[i,j];
      end;
    end;

  Result:=m3;

end;


function Tmatriz.traza:double;
var
  i,j:Integer;
  m3:Double;

begin
  m3:=0;
  for i:= 1 to Self.f do
    begin
      m3:=m3+Self.matrix[i,i];
    end;

  Result:=m3;

end;


function Tmatriz.lagrange(z:Double):String;
var
  i,j:Integer;
  m3:Tmatriz;
  l, valor:Double;
  n,igual:Integer;
  polinomio:String;
begin


    valor:=0;
    polinomio:='';
  m3:=Tmatriz.Create;

  for i:= 1 to Self.f+1 do
    begin
      l:=Self.matrix[2,i];
      for j:=1 to Self.c+1 do
      begin

        if i=j then
           igual:=i;

        if i<>j then
             begin
             l:=(l*(z-(Self.matrix[1,j]))/(Self.matrix[1,i]-Self.matrix[1,j]));
             polinomio:=polinomio+'(('+'x-'+FloatToStr(Self.matrix[1,j])+')/('+FloatToStr(Self.matrix[1,i]-Self.matrix[1,j])+'))';

             end;
          // m3.matrix[i,j]:=Self.matrix[i,j]-m1.matrix[i,j];
      end;
       polinomio:=polinomio+'+';
       valor:=valor+l;
    end;
  Self.lagra:=valor;
  ShowMessage('aquiiiiiiii '+FloatToStr(valor));

  Result:=polinomio;



end;




function Tmatriz.mult_matriz(m1:Tmatriz):Tmatriz;
var
  i,j,k:Integer;
  m3:Tmatriz;
  w:Double;
begin
  m3:=Tmatriz.Create;
    w:=0;
  //falta ponerle las restricciones de 2x3 .. 3x4 ... 2x4
    for i:= 1 to m1.c do     //filas del primero
    begin
      for j:=1 to Self.f do  //columnas del segundo
      begin
        w:=0;


        for k:=1 to Self.f do  //columnas del primero
         begin
              w:=w+(Self.matrix[j,k]*m1.matrix[k,i]);
           {   ShowMessage('i: '+IntToStr(i)+' j: '+IntToStr(j)+' k : '+IntToStr(k)+' '+FloatToStr(Self.matrix[j,k])+' '+FloatToStr(m1.matrix[k,i]));
              ShowMessage(FloatToStr(Self.matrix[j,k]*m1.matrix[k,i]));
         }end;

        m3.matrix[j,i]:=w;
      end;

    end;

   { for i:= 1 to Self.f do
    begin
      for j:=1 to  m1.c  do
      begin

           ShowMessage(FloatToStr(m3.matrix[i,j]));
      end;
    end;
          }

    //hacer  todo XD

  Result:=m3;

end;


function Tmatriz.gauss(mat:Tmatriz;Dim:Integer;det: Boolean):Tmatriz;
const
    error=0.00000001;{Valor por debajo del cual el programa considerara 0}
  var
    paso,c1,c2: Integer;
    PivCorrect: Boolean;
    pivote,aux: Double;
  begin{0}
 ShowMessage(IntToStr((Dim+1) div 2+1 ));
 ShowMessage(IntToStr(Dim));
    for paso:=1 to (Dim+1 div 2 +1 ) do begin{1}
      ShowMessage(IntToStr(paso));
      PivCorrect := False;
      c1:= paso;
      while (not PivCorrect) and (c1< Dim+1 shr 1 ) do
        If abs(mat.matrix[c1,paso])>error then
          PivCorrect:=true
        else
          c1:=c1+1;
      If PivCorrect then begin{3}
        pivote:=mat.matrix[c1,paso];
        for c2:=paso to ((Dim)) do
          if c1<>paso then begin
            aux:=mat.matrix[paso,c2];
            mat.matrix[paso,c2]:= mat.matrix[c1,c2]/pivote;
            mat.matrix[c1,c2]:=aux
          end else
            mat.matrix[c1,c2]:=mat.matrix[c1,c2]/pivote;

          //por defecto el programa pasando de los 10 digitos lo redondea a 0
        {Hasta aquí ha sido solo preparar el pivote para hacer ceros por debajo
        el pivote en estos momentos es 1}
      end;{3}
     for c1:=(paso+1) to ((Dim+1) div 2 ) do begin
       aux:=mat.matrix[c1,paso];
       for c2:=paso to ((Dim)) do
         mat.matrix[c1,c2]:=mat.matrix[c1,c2]-aux*mat.matrix[paso,c2]
     end;
    end;{1}
    {Aqui la matriz ya esta escalonada (se imprime en pantalla). Se comprueba que el sistema sea determinado}
  det:=true;
 {   for c1:=1 to (Dim+1 shr 1 -1) do
      if abs( mat.matrix[c1,c1] )<error then
        det:=false;
                       }
    if det then begin
      for paso:=(Dim shr 1 ) downto 1 do begin
        pivote:=mat.matrix[paso,paso];
        mat.matrix[paso,paso]:=1;
        for c2:=(Dim shr 1) to (Dim) do
          mat.matrix[paso,c2]:= mat.matrix[paso,c2]/pivote ;
        for c1:=(paso-1) downto 1 do begin
          aux:=mat.matrix[c1,paso];
          for c2:=paso to (Dim) do
            mat.matrix[c1,c2]:= mat.matrix[c1,c2]-mat.matrix[paso,c2]*aux
        end
      end;

    end
    else
      ShowMessage('La matriz no tiene inversa');

    Result:=mat;
  end;{0}




function Tmatriz.determinante(A:Tmatriz;filas:Integer):Double;
var
  i,j,n:Integer;
  factor,det:Real;
  B:Tmatriz;

begin
  B:=Tmatriz.Create;
     if filas=2 then  { determinante de dos por dos, caso base }
        det:= A.matrix[1,1] * A.matrix[2,2] - A.matrix[1,2] * A.matrix[2,1]
     else
     begin
          det:= 0;
          for n:= 1 to filas do
          begin
               for i:= 2 to filas do
               begin
                    for j:= 1 to n-1 do
                        B.matrix[i-1,j]:= A.matrix[i,j];
                    for j:= n+1 to filas do
                        B.matrix[i-1,j-1]:= A.matrix[i,j];
               end;
               if (1+n) mod 2=0 then i:=1 //Signo
                  else i:= -1;
               det:= det + i * A.matrix[1,n] * Self.determinante(B,filas-1);
          end;

     end;
     Result:= det;


  {
   for i:=1 to filas-1 do
    begin

      for j:=i+1 to columnas do
      begin
           factor:= Self.matrix[j,i]/Self.matrix[i,i];

           for k:=i to columnas  do
            begin
                 Self.matrix[j,k]:=Self.matrix[j,k]-factor*Self.matrix[i,k];
            end;

      end;
    end;
   //CAlculando determinante
    det:=1;
    for i:= 1 to filas do
    begin
         det:=det*Self.matrix[i][i];

    end;


  Result:=det;
          }



end;




 function TMatriz.Suma(A,B : matriz; n,m:integer):matriz;
  var
  i,j : integer;
  C_:matriz;
  begin
  for i:=0 to m-1 do
     begin
      for j:=0 to n-1  do
       begin
           C_[i,j]:=A[i,j]+B[i,j];//col
       end;
     end;

  Suma:=C_;
  end;



  function TMatriz.Resta(A,B : matriz; n,m:integer):matriz;
  var
  i,j : integer;
  C_:matriz;
  begin
  for i:=0 to m-1 do
     begin
      for j:=0 to n-1  do
       begin
           C_[i,j]:=A[i,j]-B[i,j];//col
       end;
     end;
  Resta:=C_;
  end;

  function TMatriz.MultEsc(A: matriz;esc:real;n,m:integer):matriz;
  var
  i,j : integer;
  C_:matriz;
  begin
  for i:=0 to m-1 do
     begin
      for j:=0 to n-1  do
       begin
           C_[i,j]:=A[i,j]*esc;//col
       end;
     end;
  MultEsc:=C_;
  end;

  function TMatriz.Mult(A,B: matriz;n,m,o:integer):matriz;
  var
  //Determinanate por triangullarizacion
  //Inversa Gauss
  //Simpsons
  //Lagrange simple
  i,j,k : integer;
  temp:Real;
  C_:matriz;
  begin
  for i:=0 to n-1 do
     begin
      for j:=0 to o-1 do
         begin
         C_[j,i]:=0;
          for k:=0 to m-1  do
           begin
            //ShowMessage(FloatToStr(C[j,i])+' + '+FloatToStr(B[k,i])+' * '+FloatToStr(A[j,k]) );
            C_[j,i]:=C_[j,i]+(A[k,i]*B[j,k]);//col
            //ShowMessage(IntToStr(k)+' '+IntToStr(i)+' = '+ FloatToStr(temp));
           end;
          end;
      end;

  Mult:=C_;
  end;
  function TMatriz.Transpuesta(A: matriz;n,m:integer):matriz;
  var
  i,j,i1,j1: integer;
  C_:matriz;
  begin
  //ShowMessage(IntToStr(n));//2 i
  //ShowMessage(IntToStr(m));//3 j
  j1:=0;
  for i:=0 to n-1 do
      begin
      i1:=0;
      for j:=0 to m-1 do
         begin

          C_[j1,i1]:=A[j,i];
         // ShowMessage('this is i1: '+IntToStr(i1)+' this j1 : '+ IntToStr(j1)+'  ' +FloatToStr(C[i1,j1]));
          i1:=i1+1;
          end;
          j1:=j1+1;
      end;
  Transpuesta:=C_;
  end;

  function TMatriz.Traza(A: matriz;n,m:integer):Real;
  var
  i,j : integer;
  C_:real;
  begin
  for i:=0 to m-1 do
     begin
       C_:=A[i,i]+C_;//col
     end;
  Traza:=C_;
  end;
  function TMatriz.Determinante(A: matriz;filas,col:integer):Real;
  var
  i,j,n:Integer;
  factor,det:Real;
  B:matriz;

  begin

     if filas=2 then  { determinante de dos por dos, caso base }
        det:= A[0,0] * A[1,1] - A[0,1] * A[1,0]
     else
     begin
          det:= 0;
          for n:= 0 to filas-1 do
          begin
               for i:= 1 to filas-1 do
               begin
                    for j:= 0 to n-1 do
                        B[i-1,j]:= A[i,j];
                    for j:= n+1 to filas-1 do
                        B[i-1,j-1]:= A[i,j];
               end;
               if (n+2) mod 2=0 then i:=1 //Signo
                  else i:= -1;
               det:= det + i * A[0,n] * Determinante(B,filas-1,col);
          end;

     end;
     Determinante:= det;
  end;


end.


