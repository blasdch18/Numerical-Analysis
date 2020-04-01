unit ParseMath;

{$mode objfpc}{$H+}

interface

uses
  Classes,conversor,newtong, SysUtils, math, fpexprpars,cmatriz, FileUtil, uCmdBox, TAGraph, Forms, Controls, Graphics,
Dialogs, ComCtrls, Grids, ValEdit, ExtCtrls, ShellCtrls, EditBtn, Menus, matrizX,
StdCtrls, spktoolbar, spkt_Tab, spkt_Pane, spkt_Buttons,edo,integral, spkt_Checkboxes;



type
  matrix=array[1..20] of Tmatriz;



type
  TParseMath = Class

  Private
      FParser: TFPExpressionParser;
      identifier: array of TFPExprIdentifierDef;
      Procedure AddFunctions();


  Public

      Expression: string;
      respuesta:String;
      function NewValue( Variable:string; Value: Double ): Double;
      function NewValuestring( Variable: string; Value: String ): String;
      procedure AddVariable( Variable: string; Value: Double );
      function Evaluate(): Double;
      procedure AddVariableString( Variable: string; Value: String );
      constructor create();
      function EvaluateString(): String;

      destructor destroy;

  end;


var
  matPloteoXY : TMatriz;
  A, B,
  Error, error2,
  anterior, funct,
  x, xn_0, xn_1,
  signo: Double;
  i,j,tam:Integer;
  number, zero : Integer;
  MiParse: TParseMath;
  f,d:String;


implementation

Function funcion(x:Double;f:String):Double;
begin
  try
     MiParse:= TParseMath.create();
     MiParse.AddVariable( 'x', x );
     MiParse.Expression:= f; //cboFuncion.Text;
     funct:=MiParse.Evaluate();
     funcion:=funct;
    except
       funcion:=0;
     Exit;
  end;
end;

Function funcion2(x,y:Double;f:String):Double;
begin
  try
     MiParse:= TParseMath.create();
     MiParse.AddVariable( 'x', x );
     MiParse.AddVariable( 'y', y );
     MiParse.Expression:= f;//cboFuncion.Text;
     funct:=MiParse.Evaluate();

    funcion2:=funct;
    except
       funcion2:=0;
     Exit;
  end;
end;

Function falsa_posicion(A:Double;B:Double;f:String):Double;
begin
  x:=A-((funcion(A,f)*(B-A))/(funcion(B,f)-funcion(A,f)));
  falsa_posicion:=x;
end;

function derivada(x:Double;f:String):Double;
var
  h:Float;
Begin
  h:=0.01;
  derivada:=(funcion(x+h,f)-funcion(x,f))/h;

end;

function derivada1(x:Double;f:String;e:Double):Double;
var
  h:Float;
Begin
  h:=e/10;
  derivada1:=x-(h*funcion(x,f))/(funcion(x+h,f)-funcion(x,f));

end;

function derivada2(x:Double;f:String;e:Double;x0:Double):Double;
var
  h:Float;
Begin
  h:=e/10;
  derivada2:=x-(funcion(x,f)*(x-x0))/(funcion(x,f)-funcion(x0,f));

end;

function derivada3(x:Double;f:String;e:Double):Double;
var
  h:Float;
Begin
  h:=e/10;
  derivada3:=x-(2*h*funcion(x,f))/(funcion(x+h,f)-funcion(x-h,f));
end;

Function newton(x:Double;f:String;d:String):Double;
begin
  x:=x-(funcion(x,f)/derivada(x,d));
  newton:=x;
end;

Function biyeccion(A:Double;B:Double):Double;
begin
  x:=(A+B)/2;
  biyeccion:=x;
end;

Procedure ExprTrapecio( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  MiParse:TParseMath;
  la,i,h,lb,resp,fa,fb,sum:Double;
  n:Float;
  f:String;
begin

  f:=Args[0].ResString;
  MiParse:= TParseMath.create();
   MiParse.AddVariable( 'x', 0 );
   MiParse.Expression:= f;
   la:=ArgToFloat( Args[ 1 ] );
   lb:=ArgToFloat( Args[ 2 ] );
   n:=ArgToFloat( Args[ 3 ] );
   h:=(lb-la)/n;
    MiParse.NewValue('x',la);
  fa:=MiParse.Evaluate();
  MiParse.NewValue('x',lb);
  fb:=MiParse.Evaluate();
  sum:=0;

  i:=la+h;
  repeat
    MiParse.NewValue('x',i);
    sum:=sum+MiParse.Evaluate();
    i:=i+h;

  until i>=lb;
  resp:=RoundTo(0.5*h*(fa+fb)+h*sum,-6);

  Result.resFloat := resp;
   MiParse.destroy;

end;

Procedure ExprSimpsonSimple( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  m_function:TParseMath;
  la,i,h,lb,resp,fa,fb,sump,sumi:Float;
  n:float;
begin
  f:=Args[0].ResString;
  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;
   la:=ArgToFloat( Args[ 1 ] );
   lb:=ArgToFloat( Args[ 2 ] );
   n:=ArgToFloat( Args[ 3 ] );


  h:=(lb-la)/3;
  m_function.NewValue('x',la);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',lb);
  fb:=m_function.Evaluate();
  sump:=0;
  sumi:=0;



  sump:=(2*la+lb)/3;
  m_function.NewValue('x',sump);
    sump:=m_function.Evaluate();

  sumi:=(la+2*lb)/3;
    m_function.NewValue('x',sumi);
    sumi:=m_function.Evaluate();
  resp:=RoundTo((3*h/8)*(fa+fb)+(9*h/8)*sump+(9*h/8)*sumi,-6);
  Result.ResFloat:=(resp);

end;




Procedure ExprSimpson13( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  m_function:TParseMath;
  la,i,h,lb,resp,fa,fb,sump,sumi:Float;
  n:float;

begin
  //enviar codigo y binario hasta el domingo
   f:=Args[0].ResString;
   m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;
   la:=ArgToFloat( Args[ 1 ] );
   lb:=ArgToFloat( Args[ 2 ] );
   n:=ArgToFloat( Args[ 3 ] );

   h:=(lb-la)/n;
   m_function.NewValue('x',la);
   fa:=m_function.Evaluate();
   m_function.NewValue('x',lb);
   fb:=m_function.Evaluate();
   sump:=0;
   sumi:=0;

   i:=la+h;
   repeat
         m_function.NewValue('x',i);
         sumi:=sumi+m_function.Evaluate();
         i:=i+2*h;
   until i>=lb;

   i:=la+2*h;
   repeat
         m_function.NewValue('x',i);
         sump:=sump+m_function.Evaluate();
         i:=i+2*h;
   until i>=lb-h;

  resp:=RoundTo((h/3)*(fa+fb)+(2*h/3)*sump+(4*h/3)*sumi,-6);
  Result.ResFloat:=(resp);




end;

Procedure ExprEuler( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  m_function:TParseMath;
  f,res:String;
  yn1,x0,y0,h,y,x,xf,aprox,pendiente:Double;
  n:float;
begin
  res:='';

   f:=Args[0].ResString;
  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;
   x0:=ArgToFloat( Args[ 1 ] );
   xf:=ArgToFloat( Args[ 2 ] );
   y0:=ArgToFloat(Args[3]);
   n:=ArgToFloat( Args[4 ] );
   h:=(xf-x0)/n;


   while x0<=xf  do
   begin
   yn1:=y0 +h*funcion2(x0,y0,f);
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(yn1)+'] ; ';


   x:= x0 + h;
   y0:=yn1;
   x0:=x;

   end;



   MiParse.respuesta:=res;

   Result.ResString:=(res);
end;

Procedure ExprHeun( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  m_function:TParseMath;
  f,res:String;
  yn1,x0,y0,h,y,x,xf,aprox,pendiente:Double;
  n:float;
begin

 res:='';
   f:=Args[0].ResString;
  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;
   x0:=ArgToFloat( Args[ 1 ] );
   xf:=ArgToFloat( Args[ 2 ] );
   y0:=ArgToFloat(Args[3]);
   n:=ArgToFloat( Args[4 ] );
   h:=(xf-x0)/n;
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';



  // x0:= x0 + h;


   while x0+h<=xf  do
   begin



   yn1:=y0 +h*((funcion2(x0,y0,f)+funcion2(x0+h,y0+h*funcion2(x0,y0,f),f))/2);

   x:= x0 + h;
   y0:=yn1;
   x0:=x;
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';

   end;

   if x0<xf then
   begin
   yn1:=y0 +h*((funcion2(x0,y0,f)+funcion2(x0+h,y0+h*funcion2(x0,y0,f),f))/2);

   y0:=yn1;
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';


   end;




  Result.ResString:=(res);
end;

Procedure ExprRungeKutta3( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  m_function:TParseMath;
  f,res:String;
  k1,k2,k3,k4,x0,y0,h,y,x,temp,xf,pendiente:Double;
  n:float;
begin

  res:='';

   f:=Args[0].ResString;
   x0:=ArgToFloat( Args[1] );
   xf:=ArgToFloat(Args[2]);
   y0:=ArgToFloat( Args[3] );
   n:=ArgToFloat( Args[4] );

   m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;

     h:=(xf-x0)/n;

   while x0+h<=xf  do
   begin
     res:=res+'['+FloatToStr(x0)+',';
     res:=res+FloatToStr(y0)+'] ; ';

     x:= x0 + h;
     k1 := h * funcion2(x0, y0,f);
     k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
     k3 := h * funcion2(x0 + (h), y0 -k1+ (2*k2),f);

   pendiente := (k1 + 4*k2+ k3)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

      if x0<xf  then
   begin
      res := res + '['+FloatToStr(x0)+',';
      res := res + FloatToStr(y0)+'] ; ';

      x:= x0 + h;
      k1 := h * funcion2(x0, y0,f);
      k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
      k3 := h * funcion2(x0 + (h), y0 -k1+ (2*k2),f);

      pendiente := (k1 + 4*k2+ k3)/6;
      y := y0 + pendiente;

      x0:=x;
      y0:=y;

   end;




  Result.ResString:=(res);
end;

Procedure ExprRungeKutta4( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  m_function:TParseMath;
  f,res:String;
  k1,k2,k3,k4,x0,y0,h,y,x,temp,xf,pendiente:Double;
  n:float;
begin
  res:='';

   f:=Args[0].ResString;
  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;


    n:=ArgToFloat( Args[ 4 ] );
   x0:=ArgToFloat( Args[ 1 ] );
   y0:=ArgToFloat( Args[ 3 ] );
   xf:=ArgToFloat(Args[2]);
     h:=0.01;

   while (x0+h<=xf)   do
   begin
     res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';



   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
   k3 := h * funcion2(x0 + (h/2), y0 + (k2/2),f);
   k4 := h * funcion2(x0 + h, y0 + k3,f);
   pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

    if (x0<xf)  then
   begin
     res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';

   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
   k3 := h * funcion2(x0 + (h/2), y0 + (k2/2),f);
   k4 := h * funcion2(x0 + h, y0 + k3,f);
   pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

  Result.ResString:=(res);
end;

Procedure ExprDormandPrice( var Result: TFPExpressionResult; Const ARgs: TExprParameterArray);
var
  m_function:TParseMath;
  f,res:String;
  k1,k2,k3,k4,k5,k6,k7,x0,y0,h,y,x,temp,xf,pendiente:Double;
  n:float;
begin
  res:='';

   f:=Args[0].ResString;
  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;


    n:=ArgToFloat( Args[ 4 ] );
   x0:=ArgToFloat( Args[ 1 ] );
   y0:=ArgToFloat( Args[ 3 ] );
   xf:=ArgToFloat(Args[2]);
     h:=(xf-x0)/n;

   while (x0+h<=xf)   do
   begin
     res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';



   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h*1/5), y0 + (k1*1/5), f);
   k3 := h * funcion2(x0 + (h*3/10), y0 + (k1*3/40) + (k2*9/40), f);
   k4 := h * funcion2(x0 + (h*4/5), y0 + (k1*44/45) + (k2*56/15) + (k3*32/9), f);
   k5 := h * funcion2(x0 + (h*8/9), y0 + (k1*19372/6561) - (k2*25360/2187) + (k3*64448/6561) - (k4*212/729), f);
   k6 := h * funcion2(x0 + h, y0 + (k1*9017/3168) - (k2*355/33) + (k3*46732/5247) + (k4*49/172) - (k5*5103/18656) , f);
   k6 := h * funcion2(x0 + h, y0 + (k1*35/384) + (k3*500/1113) + (k4*125/192) - (k5*2187/6784) + (k6*11/84) , f);

   pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

    if (x0<xf)  then
   begin
     res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';

   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h*1/5), y0 + (k1*1/5), f);
   k3 := h * funcion2(x0 + (h*3/10), y0 + (k1*3/40) + (k2*9/40), f);
   k4 := h * funcion2(x0 + (h*4/5), y0 + (k1*44/45) + (k2*56/15) + (k3*32/9), f);
   k5 := h * funcion2(x0 + (h*8/9), y0 + (k1*19372/6561) - (k2*25360/2187) + (k3*64448/6561) - (k4*212/729), f);
   k6 := h * funcion2(x0 + h, y0 + (k1*9017/3168) - (k2*355/33) + (k3*46732/5247) + (k4*49/172) - (k5*5103/18656) , f);
   k6 := h * funcion2(x0 + h, y0 + (k1*35/384) + (k3*500/1113) + (k4*125/192) - (k5*2187/6784) + (k6*11/84) , f);

   pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

  Result.ResString:=(res);
end;

constructor TParseMath.create;
begin

   FParser:= TFPExpressionParser.Create( nil );
   FParser.Builtins := [bcMath];
   AddFunctions();
   //matPloteoXY := TMatriz.create;
   //FParser.Identifiers.AddFloatVariable( 'x', 0);
end;

destructor TParseMath.destroy;
begin
    FParser.Destroy;
end;

function TParseMath.NewValue( Variable: string; Value: Double ): Double;
begin
    FParser.IdentifierByName(Variable).AsFloat:= Value;

end;

function TParseMath.NewValuestring( Variable: string; Value: String ): String;
begin
    FParser.IdentifierByName(Variable).AsString:= Value;

end;


Procedure ExprBiy( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
begin
     A:=ArgToFloat( Args[ 1 ] );
     B:=ArgToFloat(Args[2]);
     Error:=ArgToFloat( Args[ 3 ] );
     tam:=Length(FloatToStr(Error))-2;
     f:=Args[0].ResString;
     i:=1;

     error2:=20;
     signo:=-1;
     anterior:=0;

  while (error2>Error) do
  begin

  try

   if funcion(A,f)=0 then
    begin
    Result.resFloat := A;

      Exit;
    end;
  if funcion(B,f)=0 then
    begin
      Result.resFloat := B;

     Exit;
    end;
  except
   Result.resFloat := NaN;
     Exit;
  end;
      x:=RoundTo(biyeccion(A,B),-tam);

  signo:=RoundTo(funcion(A,f)*funcion(x,f),-tam);
  error2:=RoundTo( abs(anterior-x),-tam);
  anterior:=x;

  i:=i+1;
  if signo =0 then
   begin
    Result.resFloat := x;
   Break;
   Exit;
   end;
  if signo<0 then
    B:=x
  else
    A:=x;
  end;
end;
Procedure ExprFP( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
begin
     A:=ArgToFloat( Args[ 1 ] );
     B:=ArgToFloat(Args[2]);
     Error:=ArgToFloat( Args[ 3 ] );
     tam:=Length(FloatToStr(Error))-2;
     f:=Args[0].ResString;
  i:=1;
  error2:=20;
      signo:=-1;
      anterior:=0;

  while (error2>Error) do
  begin

  try

   if funcion(A,f)=0 then
    begin
    Result.resFloat := A;

      Exit;
    end;
  if funcion(B,f)=0 then
    begin
      Result.resFloat := B;

     Exit;
    end;
  except
   Result.resFloat := NaN;
     Exit;
  end;
   //   x:=RoundTo(biyeccion(A,B),-tam);

    x:=RoundTo(falsa_posicion(A,B,f),-tam);

  signo:=RoundTo(funcion(A,f)*funcion(x,f),-tam);
  error2:=RoundTo( abs(anterior-x),-tam);
  anterior:=x;

  i:=i+1;
  if signo =0 then
   begin
    Result.resFloat := x;
   Break;
   Exit;
   end;
  if signo<0 then
    B:=x
  else
    A:=x;
  end;
end;
Procedure ExprSecante( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
begin

     B:=( Args[ 1 ].ResInteger );
     A:=ArgToFloat(Args[2]);
     Error:=ArgToFloat( Args[ 3 ] );
     tam:=Length(FloatToStr(Error))-2;
     f:=Args[0].ResString;
     x:=A;
      xn_0:=x-0.1;
    // Error:=0;

      i:=1;
  error2:=20;

    while (error2>Error) do
    begin

      if funcion(x,f)=0 then
       begin
       Result.resFloat := x;

         Exit;
       end;
     if derivada(x,f)=0 then
       begin
         Result.resFloat := NaN;

        Exit;
       end;


     if B=1 then
       xn_1:=RoundTo(derivada1(x,f,Error),-tam);
     if B=3 then
       xn_1:=RoundTo(derivada3(x,f,Error),-tam);
     if B=2 then
       begin
        xn_1:=RoundTo(derivada2(x,f,Error,xn_0),-tam);
        error2:=RoundTo( abs(x-xn_1),-tam);
       end
     else
     begin
          error2:=RoundTo( abs(x-xn_1),-tam);
     end;
     xn_0:=x;
     x:=xn_1;
     i:=i+1;

   end;
       Result.resFloat := x;
end;
Procedure ExprNewton( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
begin

     A:=ArgToFloat( Args[ 2 ] );
     Error:=ArgToFloat( Args[ 3 ] );
     tam:=Length(FloatToStr(Error))-2;
     f:=Args[0].ResString;
    d:=Args[1].ResString;
     i:=1;
      error2:=20;
      signo:=-1;
      anterior:=0;

      x:=A;
     // Error:=0;

     while (error2>Error) do
      begin
       if funcion(x,f)=0 then
        begin
         Result.resFloat := x;

          Exit;
        end;
      if derivada(x,f)=0 then
        begin
         Result.resFloat := NaN;

         Exit;
        end;
      xn_1:=RoundTo(newton(x,f,d),-tam);
      ////////ingresar la funcion derivada
      error2:=RoundTo( abs(x-xn_1),-tam);
      x:=xn_1;
      i:=i+1;

    end;
     Result.resFloat := x;


end;

function TParseMath.Evaluate(): double;
begin
     FParser.Expression:= Expression;

     Result:= FParser.Evaluate.ResFloat;
end;

function TParseMath.EvaluateString(): String;
begin
     FParser.Expression:= Expression;

     Result:= (FParser.Evaluate.ResString);
end;

function IsNumber(AValue: TExprFloat): Boolean;
begin
  result := not (IsNaN(AValue) or IsInfinite(AValue) or IsInfinite(-AValue));
end;

Procedure ExprTan( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
   x := ArgToFloat( Args[ 0 ] );
   if IsNumber(x) and ((frac(x - 0.5) / pi) <> 0.0) then
      Result.resFloat := tan(x)

   else
     Result.resFloat := NaN;
end;

Procedure ExprSin( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
   x := ArgToFloat( Args[ 0 ] );
   Result.resFloat := sin(x)

end;

Procedure ExprCos( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
   x := ArgToFloat( Args[ 0 ] );
   Result.resFloat := cos(x)

end;

Procedure ExprLn( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
    x := ArgToFloat( Args[ 0 ] );
   if IsNumber(x) and (x > 0) then
      Result.resFloat := ln(x)

   else
     Result.resFloat := NaN;

end;

Procedure ExprLog( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
    x := ArgToFloat( Args[ 0 ] );
   if IsNumber(x) and (x > 0) then
      Result.resFloat := ln(x) / ln(10)

   else
     Result.resFloat := NaN;

end;

Procedure ExprSQRT( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
    x := ArgToFloat( Args[ 0 ] );
   if IsNumber(x) and (x > 0) then
      Result.resFloat := sqrt(x)

   else
     Result.resFloat := NaN;

end;

Procedure ExprPower( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x,y: Double;
begin
    x := ArgToFloat( Args[ 0 ] );
    y := ArgToFloat( Args[ 1 ] );


     Result.resFloat := power(x,y);

end;

Procedure ExprNewtonGen( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  variables,funciones,valores,resp: string;
  a,b: matriztext;
  c: matriz;
  y:Real;
  n,m,o: integer;
  conv: TConversor;
  resul:TNewtonG;
begin

    variables := Args[ 0 ].resString;
    funciones := Args[ 1 ].resString;
    valores   := Args[ 2 ].resString;
    y := ArgToFloat( Args[ 3 ] );
    conv:=TConversor.create();
    a := conv.CadenaAMatrizText(variables);
    b := conv.CadenaAMatrizText(funciones);
    c := conv.CadenaAMatriz(valores);
    n := conv.Filas(valores);
    resul:=TNewtonG.create(a,b,c,n,y);
    resul.Evaluate();

    resp:=' Xn: '+ conv.MatrizTextACadena(resul.Nxntext,n,1)+#13#10
    +'J: '+ conv.MatrizTextACadena(resul.Nmultext,n,1)+#13#10
    +'Error: '+ conv.MatrizACadena(resul.Nerr,n,1)+#13#10
    +'Rpta: '+conv.MatrizACadena(resul.Evaluate(),n,1);
    ShowMessage( resp);
    Result.ResString:=  resp;
    //Result.ResFloat:=1;
end;




Procedure ExprEDO( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  f,ok,res:String;
  x0,xf,y0: Float;
  n,tipo:Integer;
  resul:TEDO;

begin
    matPloteoXY := TMatriz.create;

    f:=Args[0].ResString;
    x0 := ArgToFloat( Args[ 1 ] );
    xf := ArgToFloat( Args[ 2 ] );
    y0:= ArgToFloat( Args[ 3 ] );       // PARA LA OPCION 5 EN VEZ DE y0 SE INGRESARA yf
    n:= Args[4].ResInteger;
    tipo:= Args[5].ResInteger;
    resul:=TEDO.create(f,x0,xf,y0,n);
    //ShowMessage('1->Euler');
    //ShowMessage('2->Heun');
    //ShowMessage('3->RungeKutta3');
    //ShowMessage('4->RungeKutta4');
    //Result.resFloat := resul.RK4Evaluate();
    Case tipo  of
    1 : res:=resul.Euler();
    2 : res:=resul.Heun();
    3 : res:=resul.RungeKutta3();
    4 : res:=resul.RungeKutta4();
    else ShowMessage('Error , ingrese un tipo correcto ');



    end;

    matPloteoXY.asignar(resul.matrizXY);

    Result.ResString:=res;

end;



Procedure ExprIntegral( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  fun:String;
  x,y,temporal: Float;
  i,tipo:Integer;
  resul:TIntegral;
  b:Boolean;

begin
    fun:=Args[0].ResString;
    x := ArgToFloat( Args[ 1 ] );
    y := ArgToFloat( Args[ 2 ] );
    i:= Args[3].ResInteger;
    tipo:= Args[4].ResInteger;
    b:=Args[5].ResBoolean;
    resul:=TIntegral.create(fun,x,y,i);
    temporal:=0;
    //ShowMessage('1->Trapecio'+#13+' 2->Simpson 1/3    3->Simpson 3/8');
    //ShowMessage('4->Simpson compuesto');
    Case tipo  of
    1 : begin

        if b=True then  temporal:=resul.TrapecioEvaluateArea()
                  else temporal:=resul.TrapecioEvaluateIntegral() ;
        end;
    2 : begin

        if b=True then  temporal:=resul.SimpsonEvaluateArea()
                  else temporal:=resul.SimpsonEvaluate() ;
        end;
    3 : begin

        if b=True then  temporal:=resul.Simpson38EvaluateArea()
                  else temporal:=resul.Simpson38Evaluate() ;
        end;
    4 : begin

        if b=True then  temporal:=resul.Simpson38CompuestoEvaluateArea()
                  else temporal:=resul.Simpson38CompuestoEvaluate() ;
        end
    else ShowMessage('Error');
    end;
    Result.ResFloat:= temporal;
end;


Procedure TParseMath.AddFunctions();
begin
   with FParser.Identifiers do begin
       AddFunction('tan', 'F', 'F', @ExprTan);
       AddFunction('sin', 'F', 'F', @ExprSin);
       AddFunction('sen', 'F', 'F', @ExprSin);
       AddFunction('cos', 'F', 'F', @ExprCos);
       AddFunction('ln', 'F', 'F', @ExprLn);
       AddFunction('log', 'F', 'F', @ExprLog);
       AddFunction('sqrt', 'F', 'F', @ExprSQRT);
       {Metodos}
       AddFunction('biseccion', 'F', 'SFFF', @ExprBiy);
       AddFunction('fposicion', 'F', 'SFFF', @ExprFP);
       AddFunction('newton', 'F', 'SSFF', @ExprNewton);
       AddFunction('secante', 'F', 'SIFF', @ExprSecante);
       AddFunction('power', 'F', 'FF', @ExprPower);
       AddFunction('gnewton', 'S', 'SSSF', @ExprNewtonGen);
       {Integral & Areas}
       AddFunction('integral','F','SFFIIB', @ExprIntegral);
       AddFunction('trapecio', 'F', 'SFFF', @ExprTrapecio);
       AddFunction('simpson13', 'F', 'SFFF', @ExprSimpson13);
       {EDOs}
       AddFunction('euler', 'S', 'SFFFF', @ExprEuler);
       AddFunction('heun', 'S', 'SFFFF', @ExprHeun);
       AddFunction('rungekutta4', 'S', 'SFFFF', @ExprRungeKutta4);
       AddFunction('dormandPrice', 'S', 'SFFFF', @ExprDormandPrice);
       AddFunction('EDO', 'S', 'SFFFFI', @ExprEDO);



   end

end;

procedure TParseMath.AddVariable( Variable: string; Value: Double );
var Len: Integer;
begin
   Len:= length( identifier ) + 1;
   SetLength( identifier, Len ) ;
   identifier[ Len - 1 ]:= FParser.Identifiers.AddFloatVariable( Variable, Value);


end;




procedure TParseMath.AddVariableString( Variable: string; Value: String );
var Len: Integer;
begin
   Len:= length( identifier ) + 1;
   SetLength( identifier, Len ) ;
   identifier[ Len - 1 ]:= FParser.Identifiers.AddStringVariable( Variable, Value);


end;
end.
