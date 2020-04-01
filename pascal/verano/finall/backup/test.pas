unit test;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Parsematematico;
type
  Ttest=class
    a, b:Real;
    funcion: String;
    function execute   : real;
    private
           function f(x : Real;s: String):real;
    public
    constructor create;
    destructor Destroy; override;
  end;


implementation

function Ttest.f(x : Real;s: String):Real;
var MiParse: TParseMath;
begin
  //MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  //check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    //ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    //check:=true;
    end;
  end;

  MiParse.destroy;
end;
function Ttest.execute :real ;
begin
  result:=f(a,funcion)*f(b,funcion);
end;

end.

