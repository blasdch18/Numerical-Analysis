unit Conversor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs;
type
  matriz= array[0..100, 0..100] of Real;
  matriztext= array[0..100, 0..100] of String;
  TConversor =Class
    Private
      Tn:integer;
      Tm:integer;
    Public
      function CadenaAMatriz(Mat:String):matriz;
      function CadenaAMatrizText(Mat:String):matriztext;
      function MatrizACadena(A:matriz;n,m:integer):String;
      function MatrizTextACadena(A:matriztext;n,m:integer):String;
      function CadenaACadena(Mat:String):Real;
      function Filas(A:string):Integer;
      function Columnas(A:string):Integer;

      constructor create;
      destructor destroy;

  end;

implementation
constructor TConversor.create;
begin

end;

destructor TConversor.destroy;
begin
end;

function TConversor.CadenaAMatriz(Mat:String):matriz;
var
  A:matriz;
  num:Real;
  caracter:string;
  i,n,m: integer;
begin
  caracter:='';
  m:=0;
  n:=0;

  for i:=2 to Length(Mat) do
  begin
   if Mat[i]=' ' then
        begin
             A[n,m]:=StrToFloat(caracter);
             caracter:='';
             n:=n+1;
        end
   else if Mat[i]=';' then
        begin
             n:=0;
             m:=m+1;
        end
   else
       caracter:= caracter+Mat[i];

  //  MiString[i] indica en cada momento el caracter correspondiente
  end;
  Tn:=n;
  Tm:=m+1;

  CadenaAMatriz:=A;
end;
function TConversor.CadenaAMatrizText(Mat:String):matriztext;
var
  A:matriztext;
  num:Real;
  caracter:string;
  i,n,m: integer;
begin
  caracter:='';
  m:=0;
  n:=0;

  for i:=2 to Length(Mat) do
  begin
   if Mat[i]=' ' then
        begin
             A[n,m]:=caracter;
             caracter:='';
             n:=n+1;
        end
   else if Mat[i]=';' then
        begin
             n:=0;
             m:=m+1;
        end
   else
       caracter:= caracter+Mat[i];

  //  MiString[i] indica en cada momento el caracter correspondiente
  end;
  Tn:=n;
  Tm:=m+1;

  CadenaAMatrizText:=A;
end;

function TConversor.CadenaACadena(Mat:String):Real;
var
  A:matriz;
  num:Real;
  caracter,cadena:string;
  i,n,m: integer;
begin
  caracter:='';
  cadena:='';
  m:=0;
  n:=0;

  for i:=2 to Length(Mat) do
  begin
   if Mat[i]=' ' then
        begin
             A[n,m]:=StrToFloat(caracter);
             cadena:= cadena+'  '+caracter;
             caracter:='';
             n:=n+1;
        end
   else if Mat[i]=';' then
        begin
             n:=0;
             m:=m+1;
             cadena:= cadena+' // ';
        end
   else
        begin
          caracter:= caracter+Mat[i];
        end;



  //  MiString[i] indica en cada momento el caracter correspondiente
  end;
  Tn:=n;
  Tm:=m+1;
  ShowMessage('filas: '+IntToStr(Tm)+' columnas: '+IntToStr(Tn) );
  ShowMessage('this: '+cadena);
  CadenaACadena:=num;
end;

function TConversor.MatrizACadena(A:matriz;n,m:integer):String;
  var
  i,j : integer;
  C:string;
  begin
  C:='[' ;
  for i:=0 to n-1 do
     begin
      for j:=0 to m-1  do
       begin
           C:=C+FloatToStr(A[j,i])+' ';//col
       end;
      if i <> n-1 then  C:=C+';';
     end;
  C:=C+']';
  MatrizACadena:=C;
  end;

function TConversor.MatrizTextACadena(A:matriztext;n,m:integer):String;
  var
  i,j : integer;
  C:string;
  begin
  C:='[' ;
  for i:=0 to n-1 do
     begin
      for j:=0 to m-1  do
       begin
           C:=C+A[j,i]+' ';//col
       end;
      if i <> n-1 then  C:=C+';';
     end;
  C:=C+']';
  MatrizTextACadena:=C;
  end;

function TConversor.Filas(A:string):Integer;
begin
   Filas:=Tm;
end;

function TConversor.Columnas(A:string):Integer;
begin
   Columnas:=Tn;
end;

end.



