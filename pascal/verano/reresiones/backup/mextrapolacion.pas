unit MExtrapolacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs,math,ParseMath;
 type
  t_matrix= array of array of real;

type
TMextrapolacion = class
public
      rEx,rLi,rLOG:real;
      funtion:String;

    constructor Create(matri:t_matrix;cant:Integer);
    function progresion_lineal():string;
    function exponencial():String;
    function evaluar(x:Real):Real;
 private
    datos:t_matrix;
    cantidad:Integer;
    //funtion:String;
   // rEx:real;

  end;

implementation
constructor TMextrapolacion.Create(matri:t_matrix;cant:Integer);
 var
  // matri:t_matrix;
   i:Integer;
begin
  datos:=matri;
  cantidad:=cant;
end;

function TMextrapolacion.progresion_lineal():string;
 var
   sumX,sumY,x_p,y_p,pendiente,difY,difX,bias,sumRY,sumyy,tmp:Real;
   i:Integer;
   tmp_datos:t_matrix;
   fun:string;
   parse:TParseMath;
 begin
   parse:=TParseMath.create();
   parse.AddVariable('x',0.0);
   //seteando valor de tmp_datos
   SetLength(tmp_datos,cantidad,2);
  { for i:=0 to cantidad-1 do begin
     tmp_datos[i][0]:=datos[i][0];
     tmp_datos[i][1]:=datos[i][1];
    end;         }
   //sumatoria de datos
   sumX:=0;sumY:=0;
   for i:=0 to cantidad-1 do begin
     sumX:=sumX+datos[i][0];
     sumY:=sumY+datos[i][1];
   end;
   // ShowMessage('sumatoriax:'+FloatToStr(sumX)+'    sumatoriay:'+FloatToStr(sumY));
   //valores promedios
   x_p:=sumX/cantidad;
   y_p:=sumY/cantidad;
   //hallando los xi -  promedio
   difX:=0;
   difY:=0;
   // sumyy:=0;
   for i:=0 to cantidad-1 do begin
     difY:=difY+(datos[i][0]-x_p)*(datos[i][1]-y_p);
     difX:=difX+power((datos[i][0]-x_p),2);
   end;

   pendiente:=difY/difX;
   bias:=y_p-pendiente*x_p;
   fun:=FloatToStr(pendiente)+'*x+'+FloatToStr(bias);
   //hallando r al cuadrado
   parse.Expression:=fun;
   sumRY:=0;
   for i:=0 to cantidad-1 do begin
     parse.NewValue('x',datos[i][0]);
     tmp:=parse.Evaluate();
     sumRY:=sumRY+power((tmp-y_p),2);
     //ShowMessage('(y*-yprom) : '+FloatToStr(power((tmp-y_p),2)));
   end;
   sumyy:=0;
   for i:=0 to cantidad-1 do begin
      sumyy:=sumyy+power((datos[i][1]-y_p),2);
    end;
   // ShowMessage('sumatoria(y*-yprom)^2 : '+FloatToStr(sumRY));
   ///ShowMessage('r*r:  '+FloatToStr(sumRY/sumyy));
   rLi:=sqrt(sumRY/sumyy);
   Result:=fun;
 end;

function TMextrapolacion.exponencial():String;
var
  sumX, sumY,
  x_p, y_p,
  pendiente,
  difY, difX,
  bias,
  sumRY, sumyy, tmp: Real;
  aproxY, aproxY_yp: Real;

  i, j: Integer;
  xi_xp, tmp_datos, xx_yy: t_matrix;
  fun: string;
  parse: TParseMath;
begin
  parse:=TParseMath.create();
  parse.AddVariable('x',0.0);
  //seteando valor de y
  SetLength(tmp_datos,cantidad,2);
   for i:=0 to cantidad-1 do begin
    tmp_datos[i][0]:=datos[i][0];
    if (datos[i][1]=0) or (datos[i][1]<0) then begin
        tmp_datos[i][1]:=ln(0.001);
        end
    else begin
         tmp_datos[i][1]:=ln(datos[i][1]); end;
   end;
  //sumatoria de datos
  sumX:=0;sumY:=0;
  for i:=0 to cantidad-1 do begin
    sumX:=sumX+tmp_datos[i][0];
    sumY:=sumY+tmp_datos[i][1];
  end;
  // ShowMessage('sumatoriax:'+FloatToStr(sumX)+'    sumatoriay:'+FloatToStr(sumY));
  //valores promedios
  x_p:=sumX/cantidad;
  y_p:=sumY/cantidad;
  //hallando los xi -  promedio
  SetLength(xi_xp,cantidad,2);
  for i:=0 to cantidad-1 do begin
    xi_xp[i][0]:=tmp_datos[i][0]-x_p;
    xi_xp[i][1]:=tmp_datos[i][1]-y_p;
  end;
  //los valores elevado al cuadrado
  SetLength(xx_yy,cantidad,2);
  for i:=0 to cantidad-1 do begin
    xx_yy[i][0]:=power(xi_xp[i][0],2);
    xx_yy[i][1]:=power(xi_xp[i][1],2);
  end;
  difX:=0;difY:=0;// sumyy:=0;
  for i:=0 to cantidad-1 do begin
    difY:=difY+(tmp_datos[i][0]-x_p)*(tmp_datos[i][1]-y_p);
    difX:=difX+power((tmp_datos[i][0]-x_p),2);
  end;

  pendiente:=difY/difX;
  bias:=y_p-pendiente*x_p;
  fun:='exp('+FloatToStr(bias)+')*'+'exp('+FloatToStr(pendiente)+'*x)';
  //hallando ral cuadrado
  parse.Expression:=fun;
  sumRY:=0;
  for i:=0 to cantidad-1 do begin          //errrrrrrrrrr
    parse.NewValue('x',tmp_datos[i][0]);
    tmp:=parse.Evaluate();
    aproxY:=  pendiente* tmp_datos[i][0] + bias ;
    aproxY_yp:= aproxY- y_p;
    sumRY:=sumRY+power((aproxY_yp),2);
    //ShowMessage('(y*-yprom) : '+ floattostr(sumRY) +'  aproxY_yp '+FloatToStr(power((aproxY_yp),2)));
  end;
  sumyy:=0;
  for i:=0 to cantidad-1 do begin
     sumyy:=sumyy + xx_yy[i][1];
   end;
  rEx:=sqrt(sumRY/sumyy); // aqui le pongo a r
        Result:=fun;

end;

function TMextrapolacion.evaluar(x:Real):Real;
var
  parse:TParseMath;
begin
  if funtion='' then
      exit;
   parse:=TParseMath.create();
   parse.Expression:=funtion;
   parse.NewValue('x',x);
   Result:=parse.Evaluate();
end;

end.

