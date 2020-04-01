unit StrMat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ArrStr;

type TStrMatriz = class
    public
      lista:TList;
     // arrStr : TArrString;
      Constructor Create();
      procedure push(arrStr : TArrString);
      function get(i,j : Integer) : String;
      procedure print();

end;

implementation

Constructor TStrMatriz.Create();
begin
   lista :=TList.Create;
end;

procedure TStrMatriz.push(arrStr : TArrString);
var
   plist : ^ TArrString;
   ptrList : ^TList;
begin
   new(plist);
   plist^:=arrStr;
   lista.Add(plist);

   {new(ptrList);
   ptrList^:=arrStr.lista;
   lista.AddList(ptrList^);
   writeln('meu tamanho ', lista.Count);
   arrStr.get();
   ReadLn;}
  // Writeln('el novo tamanho e', lista.Count);

end;

function TStrMatriz.get(i,j : Integer) : String;
var
   ptrArrStr : ^TArrString;
begin
   new(ptrArrStr);
   ptrArrStr := lista.Items[i];
   get := ptrArrStr^.get(j);

end;

procedure TStrMatriz.print();
var
   i,j : Integer;
   ptrArrStr : ^TArrString;
   plist : ^ TArrString;
begin
   new(ptrArrStr);
   for i:=0 to lista.Count-1 do begin
     ptrArrStr := lista.Items[i];
     for j:=0 to ptrArrStr^.lista.Count-1 do begin
        //write('i',i,' j',j);
        write(get(i,j));
        //ReadLn;
     end;
     writeln('');
   end;
end;

end.

