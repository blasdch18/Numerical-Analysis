unit Lagrangeclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math, Matrices, ParseMath, ArrStr, StrMat;
type TLagrange = Class
     public

      vect_xy : TMatrices;
      parse : TParseMath;
      polinom : String;
      Constructor Create(const m:Integer);
      procedure setMatriz(i,j :Integer;numSet :Real);
      function getPolinomio() : String ;
      procedure set_Polinom(polinomI : String);
      function evaluar_function(x : Real ): Real;

    end;


implementation

Constructor TLagrange.Create(const m:Integer);
begin
      parse := TParseMath.create();
      parse.AddVariable('x',1);
      vect_xy := TMatrices.Create(2,m);
      //vect_xy.setMatriz();
      //vect_xy.printM();
      //ReadLn;
end;

procedure TLagrange.set_Polinom(polinomI : String);
begin
      polinom:= polinomI;
end;

procedure TLagrange.setMatriz(i,j :Integer;numSet :Real);
begin
      vect_xy.setMatriz(j,i,numSet);
end;

function TLagrange.getPolinomio() : String ;
var
   lagrang, division,igual :float;
   i,j,n :Integer;

   polinomio:String;

begin
  //StringGrid1.RowCount:=2;
  n:=vect_xy.get_columnas();
  polinomio:='';
  division := 1;
   for i:=0 to n-1 do begin
//     lagrang:=StrToFloat(StringGrid1.Cells[i,1]);
       lagrang:= vect_xy.get_element(1,i);
       for j:=0 to n-1 do
        begin
          if i=j then
             igual:=i;

          if i<>j then
          begin
             //l:=(l*(z-StrToFloat(StringGrid1.Cells[j,0]))/(StrToFloat(StringGrid1.Cells[i,0])-StrToFloat(StringGrid1.Cells[j,0])));
             division:= division * (vect_xy.get_element(0,i)-vect_xy.get_element(0,j));
             polinomio:=polinomio+'('+'x-'+FloatToStr(vect_xy.get_element(0,j))+')*';

          end;
        end;
        polinomio:=polinomio+FloatToStr(lagrang)+'/'+FloatToStr(division)+'+';
        //writeln(polinomio);
        division := 1;
   end;
   polinomio := copy(polinomio,1,Length(polinomio)-1);
   //WriteLn(polinomio);
   //Writeln('____________________________');
   set_Polinom(polinomio);
   evaluar_function(3);
   getPolinomio:= polinomio;


end;

function TLagrange.evaluar_function(x : Real ) : Real;
begin
   //if polinom ='' then evaluar_function:=-1.9999999999999999999999999999; exit ;

   parse.NewValue('x',x);
   parse.Expression:=polinom;
   evaluar_function := parse.Evaluate();
end;

end.


