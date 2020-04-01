unit class_newton;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crt , Math;
type
  TNewton = class
    InitX: double;
    Error: double;
    h:     double;
    table: TStringList;
    tablerror: TSTringList;
    xn: real;
    charformatnumber: string;

    public
      function f(x :Real ) : Real ;
      function df(x :real ) : real ;
      function dx1(x :real ) : real;    // derivada manual
      function execute : real;
      function displaytable : string;


      constructor create();
      destructor Destroy; override;
  end;

  const
    MAX_STEPS = 100;
implementation
constructor TNewton.create;
begin
  Initx := 0;
  Error :=  10000;
  h := 0;
  table:= TStringList.Create;
  tablerror:= TStringList.Create;
end;

destructor TNewton.destroy;
begin
  table.Destroy;
  Tablerror.Destroy;
end;

function TNewton.f( x: real ): real ;
begin
  result:= ( (Ln(x))/x )
        + ( (exp(x))/( power(2,x) ))
        + ( (power(2,x))/x )
        - ( (power(3,x))/(x-1) )
        - power(x,4) + 3*power(x,3) ;
  end;

function TNewton.df( x: real ): real ;
begin
  result:= ( f( x+ h) - f( x - h ))/( 2 * h );
end;

function TNewton.dx1(x :real ) : real;
begin
  result:=2*x;   //derivada de x^2-4
end;

function TNewton.execute: real;
var xant: real;
    i: integer;
    stop: boolean;
    actualerror: real;
    derivada: real;

    function charformat: string;
    var j , long : integer;
        begin
          long:= length( FloatToStr( Error ) ) - 2 ;
          for j:=0 to long do
              result:= result + '0';
          result:= '0.' + result;
        end;
begin
  h:= error /10;
  i:=0;
  actualerror:= 1000;
  xn:= initx;
  charformatnumber:= charformat;
  derivada:= dx1( xn );
  if ( derivada = 0 )then
  begin
    result:= 0.00 ;
    exit;
  end;

  repeat
    xant:= xn;
    xn:= xn - f( xn )/dx1( xn );
    i:= i +1;
    stop:= ( i >= MAX_STEPS ) or ( actualerror <= error) ;
    actualerror := abs(xn - xant);
    if not stop then begin
      table.add( formatFloat( CharFormatNumber, xn ));
      tablerror.add( FormatFloat( CharFormatNumber , Actualerror ));
    end;
  until stop ;
  result:= xn;
end;

function TNewton.displaytable: string;
var i: integer;
    body: string;
    begin
      result:= '<header> <h1>Metodo de Newton <br> function x^2-4 <br></h1>' +
               'init value ' + floattostr( initx ) + '<br>' +
               'error: ' + floattostr( error ) + '<br>' +
               'n: ' + inttostr( table.Count ) + '<br><br></header>' ;
      result:= result + '<table border="1" Cellpadding="1" cellspacing="1"> <body>';
      result:= result + '<tr>' +
                             '<th>n</th>' +
                             '<th>xn</th>' +
                             '<th>error</th>' +
                        '</tr>' +
                        '<tr>' +
                             '<td>0</td>' +
                             '<td>' + formatfloat(charformatnumber, initx ) + '</td>' +
                             '<td> - </td>' +
                        '</td>';
      body:= '';

      for i:= 0 to table.Count - 1 do begin
        body:= body + '<tr>' +
                              '<td>' + inttostr( i +1 ) + '</td>' +
                              '<td>' + table[ i ] + '</td>' +
                              '<td>' +tablerror[ i ] + '</td>' +
                       '</tr>';

        end;
      result:= result + body + '</body></table> <br><br>';
      result:= result + floattostr( xn );
      end;




end.








