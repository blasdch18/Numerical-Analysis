unit lagrange;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs;
type
  matriz= array[0..100, 0..100] of Real;
  TLagrange =Class
    Private
      Lelementos:integer;
      LarrayXY:matriz;
      LX:Real;

    Public
      Larraya:matriz;
      Polinomio:String;
      function Evaluate():Real;
      constructor create(XY:matriz;n:integer;x0:Real);
      destructor destroy;

  end;

implementation
constructor TLagrange.create(XY:matriz;n:integer;x0:Real);
begin
  Lelementos:=n;
  LarrayXY:=XY;
  LX:=x0;
  Larraya:=LarrayXY;
end;

destructor TLagrange.destroy;
begin
end;

function TLagrange.Evaluate():Real;
var
   l, valor:Double;
   i,j:Integer;
   s:String;
begin

  valor:=0;
   s:=' ';
   for i:=0 to Lelementos-1 do
        begin
        l:=LarrayXY[i,1];
        for j:=0 to Lelementos-1 do
             begin
              if i<>j then
                 begin
                   l:=(l* (LX-LarrayXY[j,0]) / (LarrayXY[i,0]-LarrayXY[j,0]) );
                   s:=s+'((x-'+ FloatToStr(LarrayXY[j,0])+')/'+ FloatToStr(LarrayXY[i,0]-LarrayXY[j,0])+') ';
                 end;
             end;
             if i<>Lelementos-1 then s:=s+'+ ';
             valor:=valor+l;
        end;
   ShowMessage(s);
   Polinomio:=s;
   Evaluate:=valor;


end;

end.



