unit Rk4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath, Math,crt;
Type
  TRk4= class
    tablek1: TstringList;
    tablek2: TstringList;
    tablek3: TstringList;
    tablek4: TstringList;
    tab_a: TstringList;
     tab_b: TstringList;
    public
{      function f(x: Real; s: String): Extended;}
      function evaluar(valorX : float ; valorY: float;  funcion : String ) : float;
      function Rk4(fun: string ; a, b, lim: extended): TStringList;
      function displaytable :string;
      constructor create();
      destructor Destroy ; override;
    end;
var
  check: boolean;


implementation

constructor TRk4.create();
begin
  tablek1:= TstringList.create;
  tablek2:= TstringList.create;
  tablek3:= TstringList.create;
  tablek4:= TstringList.create;
  tab_a:= TstringList.create;
  tab_b:= TstringList.create;
  end;

destructor TRk4.Destroy;
begin
  tablek1.Destroy;
  tablek2.Destroy;
  tablek3.Destroy;
  tablek4.Destroy;
  tab_a.destroy;
  tab_b.destroy;
  end;

                       {
function TRk4.f(x : Real;s: String):Extended;
var MiParse: TParseMath;
begin
  MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    //ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    check:=true;
    end;
  end;
  MiParse.destroy;
end;                  }

function TRk4.evaluar(valorX : float ; valorY: float;  funcion : String ) : float;
var
   MiParse : TParseMath;
begin
  Miparse := TParseMath.create();
  MiParse.AddVariable('x',valorX);
  MiParse.AddVariable('y',valorY);
  MiParse.Expression:=funcion;
  evaluar := MiParse.Evaluate();
end;

function TRk4.Rk4(fun: string ; a, b, lim: extended): TStringList;
var
  h : Extended ;
  k1 ,k2 ,k3 ,k4 ,y1 ,y2 : Real ;
  i , i1, j : Integer ;
  tmp :string;
  begin
    h:= 0.1;
    i1:=Round((lim-a)/h);
    for i:=2 to i1+1 do
    begin

         tab_a.add(formatfloat('0.000000',a));
         tab_b.add(formatfloat('0.000000',b));
         k1 := evaluar(a,b,fun)*h;
         tablek1.add(formatfloat('0.000000',k1));
         k2 := evaluar(a + (h/2), b + (k1/2),fun)*h;
         tablek2.add(formatfloat('0.000000',k2));
         k3 := evaluar(a + (h/2), b + (k2/2),fun)*h;
         tablek3.add(formatfloat('0.000000',k3));
         k4 := evaluar(a + h , b + k3,fun)*h;
         tablek4.add(formatfloat('0.000000',k4));
         y1 := b + (k1 + 2*k2 + 2*k3 +k4)/6;

         a := a + h;
         y2 := y1;
    end;
    result.add(formatfloat('0.000000',y1));
  end;

function Trk4 .displaytable: string;
 var i: integer;
    body: string;
    begin
      result:= '<h1>Metodo Rk4 </h1>' ;
               {'init value ' + floattostr( initx ) + '<br>' +
               'error: ' + floattostr( error ) + '<br>' +
               'n: ' + inttostr( table.Count ) + '<br><br></header>' ; }
      result:= result + '<table border="1" Cellpadding="1" cellspacing="1"> <body>';
      result:= result + '<tr>' +
                             '<td>n</td>' +
                             '<td>Xn</td>' +
                             '<td>Yn</td>' +
                             '<td>k1</td>' +
                             '<td>k2</td>' +
                             '<td>k3</td>' +
                             '<td>k4</td>' +
                        '</tr>' +
                        '<tr>' +
                             '<td>0</td>' +
                             '<td>' + inttostr( i ) + '</td>' +
                             '<td> - </td>' +
                        '</td>';
      body:= '';

      for i:= 0 to tablek1.Count - 1 do begin
        body:= body + '<tr>' +
                              '<td>' + inttostr( i +1 ) + '</td>' +
                              '<td>' + tab_a[ i ] + '</td>' +
                              '<td>' + tab_b[ i ] + '</td>' +
                              '<td>' +tablek1[ i ] + '</td>' +
                              '<td>' +tablek2[ i ] + '</td>' +
                              '<td>' +tablek3[ i ] + '</td>' +
                              '<td>' +tablek4[ i ] + '</td>' +
                       '</tr>';

        end;
      result:= result + body + '</body></table> <br><br>';
      //result:= result + floattostr( Yn );
      end;


end.

