unit Pila;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TPila=class
    private
      lista:TList;
    public
      constructor create;
      procedure push(num: Char);
      procedure pop();
      function top():Char;
      function empty():Boolean;
  end;

implementation

constructor TPila.create;
begin
  lista:=TList.Create;
end;

procedure TPila.push(num:Char);
var
  p:^Char;
begin
  new(p);
  p^:=num;
  lista.Add(p);
end;

procedure TPila.pop();
var
  p:^Char;
begin
  if not empty() then
  begin
     p:=lista.Items[lista.Count-1];
     lista.Remove(p);
  end
end;

function TPila.top():Char;
var
  p:^Char;
begin
  if not empty() then
  begin
     p:=lista.Items[lista.Count-1];
     top:=p^;
     lista.Remove(p);
  end
  else
     top:='-';
end;

function TPila.empty():Boolean;
begin
  Result:=Lista.Count=0;
end;

(*
var
  pilita: TPila;
  i: Integer;
begin
  pilita:=Tpila.create;
  for i:=1 to 10 do
  begin
       pilita.push(i);
  end;

end; *)


end.

