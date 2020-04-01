unit liblistptrlist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,math,Dialogs,Grids, ListaptrFloat;

type
    TListptrList= class
    private
      lista:TList;

    public
      fil :Integer;
      col :Integer;
      constructor create;
      procedure push_list( list_rec : TListptrFloat );
      function sub_list( i : Integer):TListptrFloat;
end;

implementation

constructor TListptrList.create;
begin
    lista :=TList.Create;
end;

procedure TListptrList.push_list( list_rec : TListptrFloat );
var
  plist : ^TListptrFloat;
begin
     new(plist);
     plist^:=list_rec;
     lista.Add(plist);
end;

function TListptrList.sub_list( i : Integer ): TListptrFloat;
var
   plist : ^TListptrFloat;
begin
   new(plist);
   plist:=lista.Items[i];
   sub_list:= plist^;
end;





end.

