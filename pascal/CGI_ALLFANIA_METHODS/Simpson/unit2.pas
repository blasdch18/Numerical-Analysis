unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crt, Math;

type
  TSimpson = class
    resultados : TStringList;
    resp : string;
    public
      function fx( x : Real ) :real;
     // function h( n :real ) :real;

      function simp13( a :real; b :real; n: integer ) :real;

      function display :string ;

      constructor create();
      destructor Destroy; override;
  end;

implementation

constructor TSimpson.create;
begin
  resultados := TStringList.create;
  end;

destructor TSimpson.destroy;
begin
  resultados.Destroy;
  end;



function fx( x:real ): real;
begin
  result:= 0.2*x+25*x-200*x*x+675*x*x*x-900*x*x*x*x+400*x*x*x*x*x;
  end;

function simp13( a :real; b :real; n :integer ) :real;
var
  i : integer;
  fa, fb, h, sum :real;
  //resp: string;

 { function charformat :string
  var j , long : integer;
    begin
      long:= length( FloatToStr (
    end;   }

begin
  sum:=0;
  if n mod 2 = 1 then
  begin
    n:= n+1;
    end;

  h:= (b-a)/n;
  //fa:= fx(a);
  //fb:= fx(b);

  i:= 1;
  while i<n do
  begin
  sum:= sum + 4*fx(a+i*h);
  i:= i+2;

  end;

  i:= 2;
  while i<n do
  begin
  sum:= sum + 2*fx(a+i*h);
  i:= i+2;

  end;
  resp:= FloatToSTr(sum*h/3);
  //resultados.add(resp);

  result:= sum*h/3;

  end;

function display :string ;
begin
  end;

end.

