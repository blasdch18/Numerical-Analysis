unit MetodosCErrados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, Dialogs, ParseMatematico;
type
  TMetodosCerrados = class
    a, b, error1: real;
    funcion : String;
    check: boolean;
    casotype: integer;
    function execute: real;

  private
      function f(x : Real;s: String):real;
      function fx(x: double): real ;
      function Xn_biseccion(): real ;
      function Xn_falsa_posicion(): real ;
      //procedure f_continua(a, b: double) ;

  public
      Lxn: TStringList;
      La: TStringList;
      Li: TStringList;
      Lb: TStringList;
      Lsgn: TStringList;
      Lfa: TStringList;
      Lfb: TStringList;
      Lerr: TStringList;

      constructor create;
      destructor Destroy; override;

  end;

const
  M_BIS = 0;
  M_FAL = 1;

implementation
const
  MaxIteration = 10000;


  constructor TMetodosCerrados.create;
  begin
    Lxn:= TStringList.Create; Lxn.Add('');
    Li:= TStringList.Create; Li.Add('');
    La:= TStringList.Create; La.Add('');
    Lb:= TStringList.Create; Lb.Add('');
    Lsgn:= TStringList.Create; Lsgn.Add('');
    Lerr:= TStringList.Create; Lerr.Add('');
  end;
  destructor TMetodosCerrados.Destroy;
  begin
   Lxn.Destroy;
   Li.Destroy;
   La.Destroy;
   Lb.Destroy;
   Lsgn.Destroy;
   Lerr.Destroy;
  end;

function TMetodosCerrados.execute: Real ;
begin
 case casotype of
      M_BIS: result:= Xn_Biseccion();
      M_FAL: result:= Xn_falsa_posicion();
 end;
end;

function TMetodosCerrados.f(x : Real;s: String):Real;
var MiParse: TParseMath;
begin
  //MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    check:=true;
    end;
  end;

  MiParse.destroy;
end;

function TMetodosCerrados.fx(x: double): real ;
var
  f_x: double;
begin
     //f_x:= power(x,2)-(ln(x))*(power(2.71828183,x));
     //f_x:= Ln( power(x,2)+1 ) - exp(x/2)*(cos(3.1416*x));
    //f_x:=power(x,2);
     //f_x:=x*sin(x-pi/2);
     f_x:= (exp(x)/x) + x -power(x,2) - 4;

  Result:= f_x;
end;

function TMetodosCerrados.Xn_biseccion(): real ;
var
  Xn, Xn_1, sgn, fa, fb, error2 : real;
  i, j: integer;
begin
  //Xn:= 0;
  error2:= 50;
  fa:= f(a,funcion);
  fb:= f(b,funcion);
  {fa:= fx(a;);
  fb:= fx(b);}
  i:=0;

  if fa=0 then
  begin
    result:= a;
  end;
  if fb=0 then
  begin
    result:= b;
  end;

  //if ( fx(a)* fx(b)< 0 ) then
  if f(a,funcion)*f(b,funcion)< 0 then
  begin
    while (Xn=0) or ( error2 > error1 ) do
    begin
      Li.Add ( IntToStr (i) );
      La.Add ( FormatFloat ('0.000000',a) );
      Lb.Add ( FormatFloat ('0.000000',b) );

      Xn:= (b+a)/2;
      Lxn.Add( FormatFloat ('0.000000',Xn));

      //sgn:= Sign( fx(a)*fx(Xn) );
      sgn:= Sign( f(a,funcion)*f(Xn,funcion) );
      Lsgn.Add ( FloatToSTr (sgn) );
      Lerr.Add ( FormatFloat ('0.000000',error2) );

      if sgn<0 then
          b:= Xn
      else
          a:= Xn;

      if i=1 then
         error2:= 20
      else
         error2:= abs( (Xn_1 - Xn)/ Xn );
         Xn_1:= Xn;
      if (error2=0) or (IsInfinite(error2)) then
         error2:= error1-0.1;
         i:= i+1;
    end;
  end
  else
  begin
    ShowMessage('NO Cumple BOlzano');
    end;
  result:= Xn;
end;

function TMetodosCerrados.Xn_falsa_posicion(): real ;
var
  Xn, Xn_1, sgn, fa, fb : real;
  i, j: integer;
begin
  Xn:= 0;
  error2:= 50;
  fa:= fx(a);
  fb:= fx(b);
  i:=0;

  if fa=0 then
  begin
    result:= a;
  end;
  if fb=0 then
  begin
    result:= b;
  end;

  if ( fx(a)* fx(b)< 0 ) then
  begin
    while (Xn=0) or ( error2 > error1 ) do
    begin
      Li.Add ( IntToStr (i) );
      La.Add ( FormatFloat ('0.000000',a) );
      Lb.Add ( FormatFloat ('0.000000',b) );


      Xn:= a-( (fx(a)*(b-a))/(fx(b)-fx(a)) );
      Lxn.Add( FormatFloat ('0.000000',Xn));

      sgn:= Sign( fx(a)*fx(Xn) );
      Lsgn.Add ( FloatToSTr (sgn) );
      Lerr.Add ( FormatFloat ('0.000000',error2) );

      if sgn<0 then
          b:= Xn
      else
          a:= Xn;

      if i=1 then
         error2:= 20
      else
         error2:= abs( (Xn_1 - Xn)/ Xn );
         Xn_1:= Xn;
      if (error2=0) or (IsInfinite(error2)) then
         error2:= error1-0.1;
         i:= i+1;
    end;
  end
  else
  begin
    //ShowMessage('NO Cumple BOlzano');
    end;
  result:= Xn;
end;




end.


