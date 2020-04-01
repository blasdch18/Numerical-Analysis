unit EDO;

{$mode objfpc}{$H+}

interface

uses
  matrizX,math;

type
  TEDO=Class
    public
    f:String;
    x0,xf,y0:Real;
    n:Integer;
    matrizXY : TMatriz;

    function Euler():String;
    function Heun():String;
    function RungeKutta3():String;
    function RungeKutta4():String;
    constructor create(fun:String;a,b,y:Real;n_:Integer);
    destructor destroy;

  end;
implementation
uses
  Classes, SysUtils, ParseMath,Dialogs;

constructor TEDO.create(fun:String; a, b ,y :Real; n_:integer);
begin
  f:=fun;
  x0:=a;
  xf:=b;
  y0:=y;
  n:=n_;
  matrizXY := TMatriz.create;
end;

destructor TEDO.destroy;
begin
end;
              ///funciones

Function funcion2(x,y:Double;f:String):Double;
begin
  try
     MiParse:= TParseMath.create();
     MiParse.AddVariable( 'x', x );
     MiParse.AddVariable( 'y', y );
     MiParse.Expression:= f;//cboFuncion.Text;
     funct:=MiParse.Evaluate();
   //  ShowMessage('x '+FloatToStr(x));
    //ShowMessage('x '+FloatToStr(funct));
    funcion2:=funct;
    except

  //   ShowMessage('NO HAY RAIZ EN ESE INTERVALO');
     funcion2:=0;
     Exit;

  end;




end;


function TEDO.Euler():String;
var
  m_function:TParseMath;
  res:String;
  yn1,h,y,x,aprox,pendiente:Double;

begin

   h:=(xf-x0)/n;
 // if xf < x0 then
   //  h := h*(-1);
  //ShowMessage('h' + FloatToStr(h));

   matrizXY.def_matriz(n+1,2); // defino matriz de 2 columnas x , y
    ShowMessage('f(x,y) = '+ f+' , x0 = '+ FloatToStr(x0)+' , y0 = '+ FloatToStr(y0));
   for i:=0 to n  do
   begin
        matrizXY.set_element(i,0,x0);
        matrizXY.set_element(i,1,y0);
        res :=res+'['+FloatToStr(x0)+',';
        res:=res+FloatToStr(y0)+'] ; '+#13#10;

        yn1:=y0 +h*funcion2(x0,y0,f);
//        ShowMessage('f(x,y) = '+ f+' , x0 = '+ FloatToStr(x0)+' , y0 = '+ FloatToStr(y0));

        x:= x0 + h;
        y0:=yn1;
        x0:=x;
   end;

 Result:=(res);

end;


function TEDO.Heun():String;
var
  m_function:TParseMath;
  res:String;
  yn1,h,y,x,aprox,pendiente:Double;

begin

   //ShowMessage(FloatToStr(xf));
   //ShowMessage(FloatToStr(x0));
   //ShowMessage(FloatToStr(n));

   h:=(xf-x0)/n;
   matrizXY.def_matriz(n+1,2); // defino matriz de 2 columnas x , y

   //res:=res+'['+FloatToStr(x0)+',';
   //res:=res+FloatToStr(y0)+'] ; '+#13#10;

   for i:=1 to n  do
   begin
     res:=res+'['+FloatToStr(x0)+',';
     res:=res+FloatToStr(y0)+'] ; '+#13#10;

     matrizXY.set_element(i,0,x0);
     matrizXY.set_element(i,1,y0);

     yn1:=y0 +h*((funcion2(x0,y0,f)+funcion2(x0+h,y0+h*funcion2(x0,y0,f),f))/2);
     x:= x0 + h;
     y0:=yn1;
     x0:=x;
   end;
   //ShowMessage(res);

  Result:=(res);
end;

function TEDO.RungeKutta3():String;
var
  m_function:TParseMath;
  res:String;
  k1,k2,k3,k4,h,y,x,temp,pendiente:Double;

begin

    h:=(xf-x0)/n;
    matrizXY.def_matriz(n+1,2); // defino matriz de 2 columnas x , y

    for i:=0 to n  do
    begin
       matrizXY.set_element(i,0,x0);
       matrizXY.set_element(i,1,y0);

       res:=res+'['+FloatToStr(x0)+',';
       res:=res+FloatToStr(y0)+'] '+#13#10;

       x:= x0 + h;
       k1 := h * funcion2(x0, y0,f);
       k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
       k3 := h * funcion2(x0 + (h), y0 -k1+ (2*k2),f);

       pendiente := (k1 + 4*k2+ k3)/6;
       y := y0 + pendiente;
       x0:=x;
       y0:=y;

   end;

   //ShowMessage(res);

  Result:=(res);
end;

function TEDO.RungeKutta4():String;
var
  m_function:TParseMath;
  res:String;
  k1,k2,k3,k4,h,y,x,temp,pendiente:Double;

begin

     //h:=(xf-x0)/n;
     h:=0.01;
     matrizXY.def_matriz(n+1,2); // defino matriz de 2 columnas x , y
     while x0<=xf  do
//     for i:=0 to n  do
     begin
          matrizXY.set_element(i,0,x0);
          matrizXY.set_element(i,1,y0);

          res:=res+'['+FloatToStr(x0)+',';
          res:=res+FloatToStr(y0)+'] '+#13#10;

          x:= x0 + h;
          k1 := h * funcion2(x0, y0,f);
          k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
          k3 := h * funcion2(x0 + (h/2), y0 + (k2/2),f);
          k4 := h * funcion2(x0 + h, y0 + k3,f);
          pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
          y := y0 + pendiente;

          x0:=x+h;
          y0:=y;

   end;

  //ShowMessage(res);

  Result:=(res);
end;





end.

