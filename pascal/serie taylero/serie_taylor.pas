unit serie_taylor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils ,Math;

type
  TSerie_Taylor = class
    public
      n: Integer;
      //x: Integer;
      xn: Real;
      error: Real ;
      errorA: Real;
      errorR: Real;
      errorP: Real;
      errores : TStringList;

      function serie() : string;

      function serie_exp(x: Double) : string;
      function serie_sen(x: Double) : string;
      function serie_cos(x: Double) : string;
      function serie_ln(x: Double) : string;
      function serie_sinh(x: Double) : string;


      function factorial(xi:Integer):Double;
      function pow(x:Double;y:Integer ):Double;
      function GradtoRad(x:Double):Double;
      function abs(xi:Double ):Double;
      function Eabsoluto(x,xa:Double):Double;
      function Erelativo(x,xa:Double):Double;


      constructor create () ;
      destructor Destroy; override;

    private
  end;

implementation

constructor TSerie_Taylor.create();
begin
  Self.n:= 0;
//  Self.x:= 0;
  Self.xn:= 0;
  Self.error:= 0.0001;                          {<----------error}
  Self.errorA:= 50;
  Self.errorR:= 50;
  Self.errorP:= 0;
  errores:= TStringList.Create;
end;

destructor TSerie_Taylor.Destroy;
begin
  errores.Destroy;
end;

function TSerie_Taylor.serie() : string;
var i: Integer ;
begin
  writeln( '             -----> SERIES DE TAYLOR  <-----                   ' );
  writeln;
  writeln( '| n |    xn     |   error_abs   |   error_rel   |   error_%   |' );

  Result:= '---------------------------------------------------------------';
end;

function TSerie_Taylor.pow(x:Double;y:Integer ):Double;
var i: Integer;
  sum: Double;
begin
  sum:=1;
  for i:=1 to y do
  begin
    sum:= sum*x;
  end;

  Result:=sum;

end;
function TSerie_Taylor.GradtoRad(x:Double):Double;
begin
  GradtoRad:= x*3.14159265/180;
end;


function TSerie_Taylor.serie_exp(x: Double) : string;
var
  sum: double ;
  valor : Real;
  i: Integer;
  myTab: string;
  xn_: string;
  ea: real;
  er: real;
  ep: real;

begin
  {e**x}
  myTab:='   |   ';
  sum:= 0.0;
  i:= 0;

  {exp }
  sum:= sum+(pow(x,i)/factorial(i));

  i:= 0;
  errorR:= sum;

  xn_:= FormatFloat ( '0.00000' , sum );

  writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
  + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' )  ;

  while errorR>=error do
  begin
    i:= i+1;
    {exp}
   sum:= sum+(pow(x,i)/factorial(i));

    writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
    + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' );

    errorR:=  Eabsoluto(errorA,sum);
    errorA:=  sum;

  end;
  Result:= '';
end;

function TSerie_Taylor.serie_sen(x: Double) : string;
var
  sum: double ;
  valor : Real;
  i: Integer;
  myTab: string;
  xn_: string;
  ea: real;
  er: real;
  ep: real;
begin
   myTab:='   |   ';
   sum:= 0.0;
   i:= 0;

   {sen(x)  }

   x:= GradtoRad(x);
   sum:= sum+ ( pow(-1,i)/ factorial( 2*i+1 ) )* pow(x,2*i+1);
   i:= 0;
   errorR:= sum;
   xn_:= FormatFloat ( '0.00000' , sum );

   writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
            + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' )  ;
   while errorR>=error do
   begin
        i:= i+1;

        {sen(x)}
        //x:= GradtoRad(x);
        sum:= sum+(pow(-1,i)/factorial(2*i+1))*pow(x,2*i+1);

        writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
                 + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' );

        errorR:=  Eabsoluto(errorA,sum);
        errorA:=  sum;
   end;
end;

function TSerie_Taylor.serie_cos(x: Double) : string;
var
  sum: double ;
  valor : Real;
  i: Integer;
  myTab: string;
  xn_: string;
  ea: real;
  er: real;
  ep: real;
begin
  myTab:='   |   ';
  sum:= 0.0;
  i:= 0;

    {cos(x)}
    x:= GradtoRad(x);
    sum:= sum+(power(-1,i)*power(x,2*i))/factorial(2*i);
    i:= 0;
    errorR:= sum;
    xn_:= FormatFloat ( '0.00000' , sum );


    writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
            + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' )  ;
   while errorR>=error do
   begin
        i:= i+1;
        {cos(x)}
        sum:= sum+(power(-1,i)*power(x,2*i))/factorial(2*i);

        writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
                 + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' );

        errorR:=  Eabsoluto(errorA,sum);
        errorA:=  sum;
   end;
end;

function TSerie_Taylor.serie_ln(x: Double) : string;
var
  sum: double ;
  valor : Real;
  i: Integer;
  myTab: string;
  xn_: string;
  ea: real;
  er: real;
  ep: real;
begin
  myTab:='   |   ';
  sum:= x-1;
  i:= 2;

    if not((x>(-1)) and (x<=1))then
     begin
         writeln('Error : valores entre  -1 y 1');
          exit;
     end;
    {ln (x+1)}
    //x:= GradtoRad(x);
    sum:= sum + power( -1, i+1 )* (power( (x-1), i )/ i );

    i:= 2;
    errorR:= sum;
    xn_:= FormatFloat ( '0.00000' , sum );

    writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
            + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' )  ;
   while errorR>=error do
   begin


        {ln (x+1)}
        //x:= GradtoRad(x);
        sum:= sum + power( -1, i+1 )* (power( (x-1), i )/ i );

        writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000' ,sum) + mytab + FormatFloat('0.00000' ,Eabsoluto(errorA,sum))
                 + mytab + FormatFloat('0.00000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' );

        errorR:=  Eabsoluto(errorA,sum);
        errorA:=  sum;
        i:= i+1;
   end;
end;

function TSerie_Taylor.serie_sinh(x: Double) : string;
var
  sum: double ;
  valor : Real;
  i: Integer;
  myTab: string;
  xn_: string;
  ea: real;
  er: real;
  ep: real;
begin

    myTab:='   |   ';
    sum:= 0;
    i:= 0;

    x:= GradtoRad(x);
    sum:= sum+ power( x, 2*i +1 )/ factorial (2*i +1);
    i:= 0;
    xn_:= FormatFloat ( '0.00000000' , sum );

    writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000000' ,sum) + mytab + FormatFloat('0.00000000' ,Eabsoluto(errorA,sum))
            + mytab + FormatFloat('0.00000000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' )  ;

   errorR:= sum;
   while errorR>=error do
   begin
        i:= i+1;
        sum:= sum+ power( x, 2*i +1 )/ factorial (2*i +1);

        writeln( '| ' + IntToStr(i) + ' | ' + formatfloat('0.00000000' ,sum) + mytab + FormatFloat('0.00000000' ,Eabsoluto(errorA,sum))
                 + mytab + FormatFloat('0.00000000' ,Erelativo(errorA,sum)) + mytab + Formatfloat('0.00000000' , Erelativo(errorA,sum)*100) + '  |' );

        errorR:=  Eabsoluto(errorA,sum);
        errorA:=  sum;


   end;
end;



function TSerie_Taylor.factorial(xi:Integer):Double;
var i:Integer;
  sum:Double;
begin
  sum:=1;
  for i:=2 to xi do
  begin
    sum:=sum*i;
  end;
  factorial:=sum;
end;

function TSerie_Taylor.abs(xi:Double ):Double;
var i: Integer;
  sum: Double;
begin
 if xi<0 then abs:=xi*(-1)
 else
     abs:=xi;
end;

function TSerie_Taylor.Eabsoluto(x,xa:Double):Double;
var
  error_: Double;
begin
  error_:= abs(x-xa);
  Eabsoluto:=error_;
end;

function TSerie_Taylor.Erelativo(x,xa:Double):Double;
var
  error_:Double;
begin
  error_:=abs((x-xa)/x);
  Erelativo:=error_;
end;
end.

