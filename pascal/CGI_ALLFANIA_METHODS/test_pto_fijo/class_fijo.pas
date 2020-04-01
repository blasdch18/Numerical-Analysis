unit class_fijo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crt , Math;
type
  TPunto_fijo = class
    InitX: double;
    Error: double;
    h:     double;
    table: TStringList;
    tablerror: TSTringList;
    xn: real;
    charformatnumber: string;

    public
      function f(x :Real ) : Real ;
      function gx( x :real ) : real ;
      function df(x :real ) : real ;
      function dx1( x :real ) : real ;
      function eval_df_gx(x :real ) : boolean ;

      function execute : real;
      function displaytable : string;

      constructor create();
      destructor Destroy; override;
  end;

  const
    MAX_STEPS = 100;
implementation
constructor TPunto_fijo.create;
begin
  Initx := 0;
  Error :=  10000;
  h := 0;
  table:= TStringList.Create;
  tablerror:= TStringList.Create;
end;

destructor TPunto_fijo.destroy;
begin
  table.Destroy;
  Tablerror.Destroy;
end;

function TPunto_fijo.f( x: real ): real ;
begin
  result:= power( x,2 ) - 2*x + 3  ;
  end;

function TPunto_fijo.df( x: real ): real ;
begin
  result:= ( f( x+ h) - f( x - h ))/( 2 * h );
end;

function TPunto_fijo.dx1( x : real ) : real ;
begin
  result:= 1/( power(2*x +3 , 0.5 ) );    // gx = power (2*x + 3 , 0.5) ;
end;

function TPunto_fijo.gx( x :real ) : real ;
begin
  result:= power (2*x + 3 , 0.5) ;
end;

function TPunto_fijo.eval_df_gx( x :real ) : boolean ;
var derivada : real;

begin
    derivada := dx1( x );
    result:=(derivada > 0) and (derivada < 1);

  end;

function TPunto_fijo.execute: real;
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

  repeat
  if( eval_df_gx( xn ) ) then
  begin
    xant:= xn;
    xn:= gx( xn );
    i:= i +1;
    stop:= ( i >= MAX_STEPS ) or ( actualerror <= error) ;
    actualerror := abs(xn - xant);
    if not stop then begin
      table.add( formatFloat( CharFormatNumber, xn ));
      tablerror.add( FormatFloat( CharFormatNumber , Actualerror ));
    end;
   end
  else
  begin
    xn:=0;
  end;
  until stop ;
  result:= xn;

end;

function TPunto_fijo.displaytable: string;
var i: integer;
    body: string;
    begin
      result:= '<header> <h1>Metodo del Punto fijo <br>  function : power( x,2 ) - 2*x + 3  <br></h1>' +
               'init value ' + floattostr( initx ) + '<br>' +
               'error: ' + floattostr( error ) + '<br>' +
               'n: ' + inttostr( table.Count ) + '<br><br></header>' ;
      result:= result + '<table border="1" Cellpadding="1" cellspacing="1"> <body>';
      result:= result + '<tr>' +
                             '<td>n</td>' +
                             '<td>xn</td>' +
                             '<td>error</td>' +
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



