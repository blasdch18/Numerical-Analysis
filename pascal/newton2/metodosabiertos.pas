unit metodosabiertos;
{$mode objfpc}{$H+}

interface

uses
  Classes, Math, SysUtils, crt;
type
  TMetodosAbiertos = class
  public

    //error1: double;
    //error2: double;
    //xn: double;
//    xn_1   :double;
    //derivada: double;

    constructor create() ;

    function fx(x: double): double;
    function gx(x: double): double;
    function dx1(x: double): double;
    function dx1_manual(x: double): double;
    function dx2(x: double): double;
    function dx3(x: double): double;
    function evaluar_dx(x: double): boolean;
    function evaluar_dx_gx(x: double): boolean;
    function newton(x: double): double;
    function secante(x: double): double;
    function punto_fijo( x: double ): double;
    function desarrollo_metodos() :string ;

  private

end;


implementation

constructor TMetodosAbiertos.create();
begin
  //self.error1:= 0.01;
  //self.xn:= 0;
  //self.error2:= 50;
  //self.derivada:=0;
end;

function TMetodosAbiertos.fx(x: double): double;
var
  f:     string;
  f_x:   double;
begin
     {funcion}
  //f_x:=power(x,2) - 2*x - 3;
  //f_x:=ln(x)*sin(x);                                           //newton1
  //f_x:=ln(((power(x,2))+1)*(power(((2*x)+1),0.5 )));
  //f_x:=power(x,3) - 2*x + 2;        //newton
  //f_x:=x*sin (x);
  //f_x:= -(power (25-x , 0.5 ));

// f_x:=power(x,2) - 2*x -3;      // punto fijo

 //f_x:= Ln( power(x,2)+1 ) - exp(x/2)*(cos(3.1416*x));
  // f_x:= cos(3*x) - x;

  f_x:= ( (Ln(x))/x )
        + ( (exp(x))/( power(2,x) ))
        + ( (power(2,x))/x )
        - ( (power(3,x))/(x-1) )
        - power(x,4) + 3*power(x,3) ;


  Result:= f_x;
end;

function TMetodosAbiertos.dx1_manual(x: double): double;
begin
  {funcion= power(x,3) - 3*x + 2 }
//  dx1_manual:=3*(x*x) - 2;
  {funcion= Ln(x) * Sen (x)}
  //dx1_manual:=( (sin(x)/x) + ( ln(x)*cos(x) ) );                 //newton1
  //dx1_manual:=-1/(2*(power ( 25-x ,0.5)));
                             {derivadas para punto fijo }
//  dx1_manual:= 1/( power( 2*x + 3 , 0.5 ) );

  //dx1_manual:= 1/ (1+power(x,2));
  //dx1_manual:= sin(x) + x*sin(x);
  //dx1_manual:= 2*x/(power(x,2)+1)  - (exp(x/2)*0.5) *((-sin(3.1416*x)*3.1416));

  dx1_manual:= 2*x;
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
  error1: double;
begin
  error1:= 0.01;
  h:=error1/10;
  dx1:=abs (fx(x+h)-fx(x))/h;
end;



function TMetodosAbiertos.dx2(x: double): double;
var
  h: double;
  error1: double;
  begin
    error1:= 0.0001;
  h:=error1/10;                                                                                                                                                                        x:= x + 0.1;
  dx2:=(fx(x+h)-fx(x-h))/(2*h);
  if dx2=0 then
     writeln('fx`(x) Esta en el extremo');
     exit;
end;

function TMetodosAbiertos.dx3(x: double): double;
var
  h: double;
  error1: double;
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

function TMetodosAbiertos.newton(x: double): double;
var
  derivada, xn_1: double;
begin
  derivada:=dx2( x );

  if (derivada=0) then
     begin
       writeln('No converge') ;
       exit;
     end;

  Xn_1:= x -( fx( x )/dx2( x ) );
  Result:= Xn_1;
end;

function TMetodosAbiertos.secante(x: double): double;
var
  xn_1: double;
begin
  Xn_1:=x-(fx(x))/(dx2(x));
  secante:=Xn_1;
end;

function TMetodosAbiertos.evaluar_dx_gx(x : double): boolean;
var
  tmp1, derivada, tmp2 , uno ,zero:  double;
begin
//  tmp1:= dx1_manual(x);
  derivada:= dx2(x);
  tmp2:=fx(derivada);

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

function TMetodosAbiertos.desarrollo_metodos() :string ;
var
  fgx: double;
  e_tmp: double;
  opc: integer;
  mytab: string;
  i: integer;
  xn: double;
  xn_1: double;
  error1, error2:          double;
begin
  writeln('                        METODOS ABIERTOS                          ');
  Writeln(' 1 .-Newton ' );
  Writeln(' 2 .-Secante ' );
  Writeln(' 3 .-Punto Fijo ' );
  writeln;
  Write(' Opcion = ' );
  read( opc );
  Write(' Xo = ' );
  read( Xn );

  mytab:= '  |  ';
  error1:= 0.00001;                        //   <------------- error
  i:= 1;
  error2:=50;
  Xn_1:=0;
  e_tmp:=0;
  writeln(' ----------------------------------');
  writeln('| n |     Xn     |     error       |');
  writeln(' ----------------------------------');
  try
    while  (error2 > error1) do
    begin
         case opc of
              1: Xn_1:= newton ( xn );
              2: Xn_1:= secante ( xn );
              3: Xn_1:= punto_fijo ( xn );
         else
              writeln('Better luck next time Punk!') ;
              exit;
         end ;

         writeln('| '+ inttostr(i-1) + ' |'+ mytab + formatFloat('0.00000000',xn) +
                      mytab + formatFloat('0.00000000',error2) + '  |' );
         if i=0 then
            error2:= 50
         else
            error2:= abs( Xn_1 - Xn);

         i:= i+1;
         Xn:= Xn_1;

    end;

  Except
    writeln('MessageError: No es Continua Punk! ');
  end;
 result:='';
end;












end.
