unit Inversa;

{$mode objfpc}{$H+}

interface


type
   matriz= array[0..100, 0..100] of Real;
   matriztext= array[0..100, 0..100] of String;
   TInversa = Class

  Private
      Imatini:matriz;
      Imatfin:matriz;
      Imatide:matriz;
      Imatbloque:matriz;
      Ielementos:integer;
      function Bloque(): matriz;
      function Partir():matriz;
  Public
      function Evaluate(): matriz;
      function Identidad(): matriz;
      constructor create(A:matriz;n:integer);
      destructor destroy;

  end;



implementation
uses
  Classes, SysUtils,ParseMath,Dialogs;

constructor TInversa.create(A:matriz;n:integer);
begin
   Imatini:=A;
   Ielementos:=n;
   Imatide:=Identidad();
end;

destructor TInversa.destroy;
begin
end;
function Tinversa.partir(): matriz;
var
  i,j,k:integer;
  A:matriz;
begin
  k:=0;
   for i:=Ielementos to 2*Ielementos-1 do
     begin
      for j:=0 to Ielementos-1  do
       begin
           A[k,j]:=Imatfin[i,j];
       end;
      k:=k+1;
     end;
  partir:=A;
end;
function TInversa.Identidad(): matriz;
var
  i,j:integer;
  A:matriz;
begin
   for i:=0 to Ielementos-1 do
     begin
      for j:=0 to Ielementos-1  do
       begin
            if i=j then A[i,j]:=1
            else        A[i,j]:=0;

       end;
     end;
  Identidad:=A;
end;

function TInversa.Bloque(): matriz;
var
  i,j:integer;
  A:matriz;
begin
   for i:=0 to Ielementos-1 do
     begin
      for j:=0 to Ielementos-1  do
       begin
            A[i,j]:=Imatini[i,j];

       end;
     end;
   for i:=Ielementos to 2*Ielementos-1 do
     begin
      for j:=0 to Ielementos-1  do
       begin
            if Ielementos+j=i then A[i,j]:=1
            else        A[i,j]:=0;

       end;
     end;
  BLoque:=A;
end;



function TInversa.Evaluate(): matriz;
const
    error=0.00000001;
  var
    paso,c1,c2,new: Integer;
    PivCorrect,det: Boolean;
    pivote,aux: Real;
  begin{0}
    Imatfin:=Bloque();
   // ShowMessage('Me evaluo');

    new:=Ielementos*2;
    for paso:=0 to (new shr 1 -1) do
      begin{1}
          //ShowMessage('Paso : '+IntToStr((Ielementos*2) shr 1 -1));
          PivCorrect := False;
          c1:= paso;
          while (not PivCorrect) and (c1< new shr 1 ) do
            If abs(Imatfin[paso,c1])>error then
              PivCorrect:=true
            else
              c1:=c1+1;

          If PivCorrect then
          begin{3}
            pivote:=Imatfin[paso,c1];
            for c2:=paso to (new-1) do
              if c1<>paso then begin
                aux:=Imatfin[c2,paso];
                Imatfin[c2,paso]:=Imatfin[c2,c1]/pivote;
                Imatfin[c2,c1]:=aux
              end else
                Imatfin[c2,c1]:=Imatfin[c2,c1]/pivote;
            {Hasta aquí ha sido solo preparar el pivote para hacer ceros por debajo
            el pivote en estos momentos es 1}
          end;{3}

          for c1:=(paso+1) to (new  shr 1 - 1) do
          begin
             aux:=Imatfin[paso,c1];
             for c2:=paso to (new-1) do
               Imatfin[c2,c1]:=Imatfin[c2,c1]-aux*Imatfin[c2,paso]
          end;
     end;{1}
    {Aqui la matriz ya esta escalonada (se imprime en pantalla). Se comprueba que el sistema sea determinado}
    det:=true;
    for c1:=0 to (new shr 1 -1) do
      if abs( Imatfin[c1,c1] )<error then
        det:=false;


    if det then
    begin
      //ShowMessage('La matriz tiene inversa');
      for paso:=(new shr 1 -1 ) downto 0 do
      begin
        pivote:=Imatfin[paso,paso];
        Imatfin[paso,paso]:=1;

        for c2:=(new shr 1 ) to (new-1) do
          Imatfin[c2,paso] := Imatfin[c2,paso]/pivote;

        for c1:=(paso-1) downto 0 do
        begin
          aux:=Imatfin[paso,c1];
          for c2:=paso to (new-1) do
            Imatfin[c2,c1]:=Imatfin[c2,c1]-Imatfin[c2,paso]*aux
        end
      end;
    (*
    ShowMessage(
    FloatToStr(Imatfin[0,0])+'   '+FloatToStr(Imatfin[0,1])+'  '+FloatToStr(Imatfin[1,0]) +' '+FloatToStr(Imatfin[1,1])+ '   / n     ' +
    FloatToStr(Imatfin[2,0])+'   '+FloatToStr(Imatfin[2,1])+'  '+FloatToStr(Imatfin[3,0]) +' '+FloatToStr(Imatfin[3,1]));
    *)
     // mat.tomar_media_matriz();
      //mat.redondear_vals(5);
      //mat.print_matriz(grid);
    end
    else
      ShowMessage('La matriz no tiene inversa');

    Evaluate:=partir();

  end;

end.



