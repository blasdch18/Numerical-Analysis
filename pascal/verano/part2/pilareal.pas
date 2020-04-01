unit PilaReal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TPilaR=class
    private
      lista:TList;
    public
      constructor create;
      procedure push(num: Real);
      procedure pop();
      function top():Real;
      function empty():Boolean;
  end;

implementation

constructor TPilaR.create;
begin
  lista:=TList.Create;
end;

procedure TPilaR.push(num:Real);
var
  p:^Real;
begin
  new(p);
  p^:=num;
  lista.Add(p);
end;

procedure TPilaR.pop();
var
  p:^Real;
begin
  if not empty() then
  begin
     p:=lista.Items[lista.Count-1];
     lista.Remove(p);
  end
end;

function TPilaR.top():Real;
var
  p:^Real;
begin
  if not empty() then
  begin
     p:=lista.Items[lista.Count-1];
     top:=p^;
     lista.Remove(p);
  end
  else
     top:=0;
end;

function TPilaR.empty():Boolean;
begin
  Result:=Lista.Count=0;
end;

end.

