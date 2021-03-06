unit metodosabiertos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, ParseMatematico, Dialogs;
type
  TMetodosAbiertos = class
  casotype : integer;
  x0: double;
  error1, error2 : real;
  funcion : String;
  check: boolean;
  function execute : real ;


  public
    Lxn: TStringList;
    Lerr: TStringList;
    constructor create() ;

//    function fx(x: double): double;
    function gx(x: double): double;
    function dx1(x: double): double;
    function dx1_manual(x: double): double;
    function dx2(x: double): double;
    function dx3(x: double): double;
    function evaluar_dx(x: double): boolean;
    function evaluar_dx_gx(x: double): boolean;

    function punto_fijo( x: double ): double;

  private
    function f(x : Real;s: String):Real;
    function newton(): double;
    function secante(): double;

end;

const
  M_NEW = 2;
  M_SEC = 3;

implementation

constructor TMetodosAbiertos.create();
begin
  Lxn:= TStringList.Create; Lxn.Add('');
  Lerr:= TStringList.Create; Lerr.Add('');
end;

function TMetodosAbiertos.execute : real;
begin
  case casotype of
  M_NEW: result:= newton();
  M_SEC: result:= secante();

  end;
end;

function TMetodosAbiertos.f(x : Real;s: String):Real;
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
    ShowMessage('La funcion no es derivable '+FloatToStr(x));
    check:=true;
    end;
  end;

  MiParse.destroy;
end;
                                      {
function TMetodosAbiertos.fx(x: double): double;
var
  fn:     string;
  f_x:   double;
begin
     {funcion}
  //f_x:=power(x,2) - 2*x - 3;
  f_x:=ln(x)*sin(x);                                           //newton1
  //f_x:=ln(((power(x,2))+1)*(power(((2*x)+1),0.5 )));
  //f_x:=power(x,3) - 2*x + 2;        //newton
  //f_x:=x*sin (x);
  //f_x:= -(power (25-x , 0.5 ));

// f_x:=power(x,2) - 2*x -3;      // punto fijo

 //f_x:= Ln( power(x,2)+1 ) - exp(x/2)*(cos(3.1416*x));
  // f_x:= cos(3*x) - x;

  {f_x:= ( (Ln(x))/x )
        + ( (exp(x))/( power(2,x) ))
        + ( (power(2,x))/x )
        - ( (power(3,x))/(x-1) )
        - power(x,4) + 3*power(x,3) ;
   }

  Result:= f_x;
end;                                 }

function TMetodosAbiertos.dx1_manual(x: double): double;
begin
  {funcion= power(x,3) - 3*x + 2 }
//  dx1_manual:=3*(x*x) - 2;
  {funcion= Ln(x) * Sen (x)}
  dx1_manual:=( (sin(x)/x) + ( ln(x)*cos(x) ) );                 //newton1
  //dx1_manual:=-1/(2*(power ( 25-x ,0.5)));
                             {derivadas para punto fijo }
//  dx1_manual:= 1/( power( 2*x + 3 , 0.5 ) );

  //dx1_manual:= 1/ (1+power(x,2));
  //dx1_manual:= sin(x) + x*sin(x);
  //dx1_manual:= 2*x/(power(x,2)+1)  - (exp(x/2)*0.5) *((-sin(3.1416*x)*3.1416));

  //dx1_manual:= 2*x;
end;

function TMetodosAbiertos.gx(x: double): double;
var
  g_x:   double;
begin
  //g_x:= fx(x) + x;
  //g_x:={function}
  g_x:=power( (2*x + 3) , 0.5 );
  Result:=g_x;
end;

function TMetodosAbiertos.dx1(x: double): double;
var
  h: double;
  //error1: double;
begin
  error1:= 0.01;
  h:=error1/10;
  dx1:=abs ( f( x+h,funcion )- f( x,funcion ))/h;
end;


function TMetodosAbiertos.dx2(x: double): double;
var
  h: double;
  //error1: double;
  begin
    error1:= 0.0001;
  h:=error1/10;                                                                                                                                                                        x:= x + 0.1;
  dx2:=( f(x+h,funcion)- f(x-h,funcion))/(2*h);
  if dx2=0 then
     writeln('fx`(x) Esta en el extremo');
     exit;
end;

function TMetodosAbiertos.dx3(x: double): double;
var
  h: double;
  //error1: double;
  begin
    error1:= 0.01;
  h:=error1/10;
  dx3:=(gx(x+h)-gx(x)/h);
end;

function TMetodosAbiertos.evaluar_dx(x: double): boolean;
var
  tmp: double;
begin
  //tmp:=dx1(x);
  //if tmp=0 then exit;
  evaluar_dx:= (dx1(x)=0);
end;

function TMetodosAbiertos.newton(): double;
var
  derivada, xn_1: double;
  i: integer;
begin
  i:= 0;
  derivada:=dx1_manual( x0 );

  if (derivada=0) then
     begin
       writeln('No converge') ;
       exit;
     end;
  try
    while (error2 > error1) do
    begin
         Lxn.Add( FormatFloat ('0.000000',X0));
         Xn_1:= x0 -( f( x0 , funcion )/dx1_manual( x0 ) );
         Lerr.Add ( FormatFloat ('0.000000',error2) );

         if i=0 then
            error2:=50
         else
            error2:=abs(Xn_1 - x0);
         i:= i+1;
         X0:= Xn_1;
    end;
  finally
  end;

  Result:= Xn_1;
end;

function TMetodosAbiertos.secante(): double;
var
  xn_1: double;
  i: integer;
begin
  i:= 0;

  try
    while (error2 > error1) do
    begin
         Xn_1:=x0-(f(x0,funcion))/(dx2(x0));

         if i=0 then
            error2:=50
         else
            error2:= abs(Xn_1 - x0);
         i:= i+1;
         X0:= Xn_1;
    end;
  finally
  end;
  secante:=Xn_1;
end;

function TMetodosAbiertos.evaluar_dx_gx(x : double): boolean;
var
  tmp1, derivada, tmp2 , uno ,zero:  double;
begin
//  tmp1:= dx1_manual(x);
  derivada:= dx2(x);
  tmp2:=f(derivada,funcion);

  //writeln(FloatToStr(tmp2));
  uno:=1;
  zero:=0;
  evaluar_dx_gx:= (derivada >zero) and (derivada <uno);
end;

function TMetodosAbiertos.punto_fijo( x: double ): double;
begin
  if (evaluar_dx_gx( x )) then
     begin
      punto_fijo := gx( x )
     end
  else
      begin
           writeln('g(x) !E [0,1]');
           exit;
      end;
end;


end.

