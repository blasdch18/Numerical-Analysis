unit class_falsa_pos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crt , Math;
type
  Tfalsa_pos = class
    InitX: double;
    init_a: real;
    init_b: real;
    Error: double;
    h:     double;
    table: TStringList;
    table_a: TStringList;
    table_b: TStringList;
    table_sgn: TStringList;

    tablerror: TSTringList;
    xn: real;
    charformatnumber: string;

    public
      function fx(x :Real ) : Real ;
      procedure fx_continua(a_, b_: real) ;

      function execute : real;
      function displaytable : string;

      constructor create();
      destructor Destroy; override;
  end;

  const
    MAX_STEPS = 100;
implementation
constructor Tfalsa_pos.create;
begin
  Initx := 0;
  Error :=  10000;
  h := 0;
  init_a :=0;
  init_b :=0;
  table:= TStringList.Create;
  table_a:= TStringList.Create;
  table_b:= TStringList.Create;
  table_sgn:= TStringList.Create;
  tablerror:= TStringList.Create;
end;

destructor Tfalsa_pos.destroy;
begin
  table.Destroy;
  table_a.Destroy;
  table_b.Destroy;
  table_sgn.Destroy;
  Tablerror.Destroy;
end;

function Tfalsa_pos.fx( x: real ): real ;
begin
  //result:= power(x,2)-(power(2.71828183,x));
  result:= (x/Ln(x)) + (power(2.71828183,x-1) -10);
  //result:= power (x,2) - 1 ;
  end;

procedure Tfalsa_pos.fx_continua(a_ ,b_:real) ;
begin
  while( a_ = b_ ) do
  begin
    try
      if ( fx(a_)= - Infinity ) or ( fx(b_)= Infinity )then
      break;
      a_:= a_+1;
    finally
    end;
  end;
end;

function Tfalsa_pos.execute: real;
var xant: real;
    i: integer;
    stop: boolean;
    actualerror: real;
    a ,b: real ;
    fa ,fb: real;
    sgn : real;

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
  //xn:= initx;
  a:= init_a;
  b:= init_b;
  charformatnumber:= charformat;

  fa:= fx(a);
  fb:= fx(b);
  xn:= 0;
  if fa=0 then
  begin
    xn:= a;
    exit;
  end;
  if fb=0 then
  begin
    xn:= b;
    exit;
  end;
  repeat

    xn:= a-( (fx(a)*(b-a))/(fx(b)-fx(a)) );;

    sgn:=Sign( fx(a)*fx(xn) );
    i:= i +1;
    xant:= xn;
    stop:= ( i >= MAX_STEPS ) or ( actualerror <= error) or (xn=0) or ( fx(a)*fx(b) < 0 ) ;
    actualerror := abs(xn - xant);

    if not stop then begin

      table.add( formatFloat( CharFormatNumber, xn ));
      if sgn < 0 then
      begin
         table_b.add( formatFloat( CharFormatNumber, xn ));
         table_a.add( formatFloat( CharFormatNumber, a ));
         b:= xn;
      end
    else
      begin
         table_a.add( formatFloat( CharFormatNumber, xn ));
         table_b.add( formatFloat( CharFormatNumber, b ));
         a:= xn;
      end;

      tablerror.add( FormatFloat( CharFormatNumber , Actualerror ));
     // table_sgn.add( FormatFloat( CharFormatNumber , sgn ));

    end;



  until stop ;
  result:= xn;
end;

function Tfalsa_pos.displaytable: string;
var i: integer;
    body: string;
    begin
      result:= '<header> <h1>Metodo de falsa posicion <br> function power(x,2)-(power(2.71828183,x) <br></h1>' +
               'init value a ' + floattostr( init_a ) + '<br>' +
               'init value b ' + floattostr( init_b) + '<br>' +
               'error: ' + floattostr( error ) + '<br>' +
               'n: ' + inttostr( table.Count ) + '<br><br></header>' ;
      result:= result + '<table border="1" Cellpadding="1" cellspacing="1"> <body>';
      result:= result + '<tr>' +
                             '<th>n</th>' +
                             '<th>a</th>' +
                             '<th>b</th>' +
                             //'<th>Sgn</th>' +
                             '<th>Xn</th>' +
                             '<th>error</th>' +
                        '</tr>' +
                        '<tr>' +
                             '<td>0</td>' +
                             //'<td>' + formatfloat(charformatnumber, initx ) + '</td>' +
                             '<td>' + formatfloat(charformatnumber, init_a ) + '</td>' +
                             '<td>' + formatfloat(charformatnumber, init_b ) + '</td>' +
                             '<td>' + formatfloat(charformatnumber, xn) + '</td>' +
                             //'<td> - </td>' +
                             '<td> - </td>' +
                        '</td>';
      body:= '';

      for i:= 0 to table.Count - 1 do begin
        body:= body + '<tr>' +
                              '<td>' + inttostr( i +1 ) + '</td>' +

                              '<td>' + table_a[ i ] + '</td>' +
                              '<td>' + table_b[ i ] + '</td>' +
                              '<td>' + table[ i ] + '</td>' +
                              '<td>' +tablerror[ i ] + '</td>' +
                       '</tr>';

        end;
      result:= result + body + '</body></table> <br><br>';
      result:= result + floattostr( xn );
      end;




end.



