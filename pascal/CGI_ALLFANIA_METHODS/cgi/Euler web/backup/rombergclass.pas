unit Rombergclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math, Matrices,ParseMath;

type TRomberg = class
  public
   function solver(x : Real; func : String): Real;
   function romberg(func: String; xi,xf :Real):Real;
  end;

implementation


function TRomberg.solver(x : Real; func : String): Real;
var
  parse : TParseMath;
begin
  parse := TParseMath.create();
  parse.AddVariable('x',x);
  parse.Expression:=func;
  solver := parse.Evaluate();
end;

function TRomberg.romberg(func: String; xi,xf :Real):Real;
var
  h,i : Real;
  T : TMatrices;
  a,w ,i2: Integer;
begin

 T := TMatrices.Create(1,4);
 T.setMatriz(0,0,0);

 a := 0;
 w := 0;
 WriteLn('h comienza en 1 y termina en .125');
 h:=1;
 while h>=0.125 do begin
   i:= xi;
   while i<=xf do begin
     if (i=xi) or (i=xf)then begin
        T.setMatriz(a,0,T.get_element(0,a)+(solver(i,func))*(h/2));
        //WriteLn( T.get_element(0,a));
     end
     else begin
        T.setMatriz(a,0,T.get_element(0,a)+(solver(i,func))*(h));
        //WriteLn(T.get_element(0,a));
     end;
     i:=i+h;
   end;
  h := h/2;
  a := a+1;
 end;




 i:=3;
 while i>0 do begin
     a := 0;
     while a<i do begin
     T.setMatriz(a,0,((power(4,(a+1))*T.get_element(0,a+1))-T.get_element(0,a))/(power(4,(a+1))-1)) ;
     a := a+1;
     end;
     i := i-1;
 end;

 romberg:= T.get_element(0,a-1);



end;

end.
