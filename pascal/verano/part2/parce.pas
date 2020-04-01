unit Parce;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Pila,PilaReal,Math;
type
  TParce=class
    private
      stack :TPila;
      pilar :TPilaR;
    public
      constructor create;
      function prioridad(op:Char):Integer;
      function convertir(n:String):String;
      function evaluar(p: String):Real;
  end;

implementation

constructor TParce.create;
begin
  stack := TPila.create;
  pilar := TPilaR.create;
end;

Function IsDigit( ch:Char ): Boolean;
Begin
  Result := ch In ['0'..'9'];
End;
function TParce.prioridad(op:Char):Integer;
begin
  case op of
  '^': result:=3;
  '*': ;
  '/': result:=2;
  '+': ;
  '-': result:=1;
  ')': result:=-1;
  else result:=0;
  end;
end;

function TParce.convertir(n : String):String;
var
  pos: String;
  i:Integer;
begin
  pos:='';
  i:=0;
  while i < Length(n) do
  begin
    //case
    case n[i] of
    '(': begin stack.push('('); break; end;
    '*': ;
    '/': ;
    '+': ;
    '-': ;
    ')': begin
      while not(stack.empty()) and not(stack.top()='(') do
      begin
        pos:=pos + stack.top()+' ';
        stack.pop();
      end;
    end;

    '^': begin
      while not(stack.empty()) and (prioridad(n[i])<=prioridad(stack.top())) do
      begin
        pos:=pos + stack.top()+' ';
        stack.pop();
      end;
      stack.push(n[i]);
      break;
    end;
    else begin
      while (IsDigit(n[i])=true) or (n[i]='.') do
      begin
        pos:=pos + n[i];
        i:=i+1;
      end;
      pos:=pos + ' ';
      i:=i-1;
    end;
    end;
    //case fin
    i:=i+1;
  end;

  while not(stack.empty()) do
  begin
    pos:=pos+ stack.top() + ' ';
    stack.pop();
  end;

  result:=pos;
end;

function TParce.evaluar(p: String):Real;
var
  a,b: Real;
  aux : String;
  i:Integer;
begin
  i:=0;
  while i<Length(p) do
  begin
    case p[i] of
      '^':
      begin
      a:=pilar.top(); pilar.pop();
      b:=pilar.top(); pilar.pop();
      pilar.push(power(a,b));
      break;
      end;

      '/':
      begin
      a:=pilar.top(); pilar.pop();
      b:=pilar.top(); pilar.pop();
      pilar.push(a/b);
      break;
      end;

      '+':
      begin
      a:=pilar.top();pilar.pop();
      b:=pilar.top();pilar.pop();
      pilar.push(a+b);
      break;
      end;

      '-':
      begin
      a:=pilar.top();pilar.pop();
      b:=pilar.top();pilar.pop();
      pilar.push(a-b);
      break;
      end;

      '*':
      begin
      a:=pilar.top();pilar.pop();
      b:=pilar.top();pilar.pop();
      pilar.push(a*b);
      break;
      end;

      else
      begin
      aux:='';
      while not (p[i]=' ') do
      begin
         aux:=aux+ p[i];
         i:=i+1;
      end;
      pilar.push(StrToFloat(aux));
      i:=i-1;
      end;
    end;
    i:=i+2;
  end;


end;


end.

