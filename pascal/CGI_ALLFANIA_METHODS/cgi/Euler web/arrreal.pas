unit ArrReal;
// Arreglo de Reales o Doubles
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type TArrReal = class
    public
      lista:TList;
      Constructor Create();
      procedure push(val : Real);
      function get(i : Integer): Real;
      procedure setArr(i_pos: Integer ;r : Real);
      function get(): String;
      procedure print(Nro :Integer);
      function tam() : Integer;

end;


implementation
Constructor TArrReal.Create();
begin
      lista:=TList.Create;
end;

procedure TArrReal.push(val: Real);
var
   pInt:^Real;
begin
   new(pInt);
   pInt^:=val;
   lista.Add(pInt);
end;

function TArrReal.get(i : Integer): Real;
var
   ptop : ^Real;
begin
   ptop := lista.Items[i];
   get := ptop^;
end;


function TArrReal.get(): String;  //imprime desde la base al top
var
   contenido : String;
   ptr_str : ^Real;
   i : Integer;
begin
   new (ptr_str);
   for i:=0 to lista.Count-1 do
   begin
     ptr_str:=lista.Items[i];
     //contenido := ptr_str^+ contenido;
     contenido := contenido +' , '+ FloatToStr(ptr_str^) ;
   end;
   get :=contenido;
end;

procedure TArrReal.print(Nro :Integer);  //imprime desde la base al top
var
   ptr_str : ^Real;
   i,j : Integer;
begin
   new (ptr_str);
   for i:=0 to lista.Count-1 do begin
       ptr_str:=lista.Items[i];
       WriteLn( FloatToStr(ptr_str^)) ;
   end;
   write(' -----');


end;


procedure TArrReal.setArr(i_pos: Integer; r : Real);
var
   ptop : ^Real;
begin
   ptop := lista.Items[i_pos];
   ptop^ := r;

end;

function TArrReal.tam(): Integer;  //tamanho
begin
   tam :=lista.Count;
end;


end.


