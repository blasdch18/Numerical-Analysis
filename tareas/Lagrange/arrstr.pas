unit ArrStr;
{ Lista de Strings }

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type TArrString = class
    public
      lista:TList;
      Constructor Create();
      procedure push(val : String);
      function get(i : Integer): String;
      function get(): String;
      function size_arr():Integer;
      procedure clear();

end;

implementation

Constructor TArrString.Create();
begin
      lista:=TList.Create;

end;

procedure TArrString.push(val: String);
var
   pStr:^String;
begin
   new(pStr);
   pStr^:=val;
   lista.Add(pStr);
   //Writeln('el novo sub-tamanho e', lista.Count);
end;


function TArrString.get(i : Integer): String;
var
   ptop : ^String;
begin
   ptop := lista.Items[i];
   //WriteLn(ptop^);
   //ReadLn;
   get := ptop^;
end;



function TArrString.get(): String;  //imprime desde la base al top
var
   contenido : String;
   ptr_str : ^String;
   i : Integer;
begin
   new (ptr_str);
   for i:=0 to lista.Count-1 do
   begin
     ptr_str:=lista.Items[i];
     //contenido := ptr_str^+ contenido;
     contenido := contenido + ptr_str^;
   end;
   get :=contenido;
end;


function TArrString.size_arr():Integer;
begin
         size_arr:= lista.Count;

end;

procedure TArrString.clear();
begin
    lista.Clear;
end;

end.

