unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;
type
  TSerieTaylor=class
    public
    xn: real;
    Xn_1: real;
    error: real;                           {
    function errorAA():real;
    function errorAR():real;
    function errorAP():real;
    function errorA():real;
    function errorR():real;
    function errorP():real;               }
    function GradToRad(x : real):real;
    function sen():real;
    function cos():real;
    function exp():real;


  end;
CONST
  error= 0.00001;
implementation
                                         {
    function TSerieTaylor.errorAA():real;
    begin
      result:=
    end;

    function TSerieTaylor.errorAR():real;
    function TSerieTaylor.errorAP():real;
    function TSerieTaylor.errorA():real;
    function TSerieTaylor.errorR():real;
    function TSerieTaylor.errorP():real;}
    function TSerieTaylo.GradToRad(x: real) : real;
    begin
      result:=x*3.14159265/180;
    end;

    function TSerieTaylor.sen():real;
    var
      sum: real;
      i: integer;
      x: real;
      ea: real;
      er: real;
      ep: real;
      errorR: real;
    begin
      sum:=0;
      x:= GradtoRad(x);
      sum:= sum+ ( pow(-1,i)/ factorial( 2*i+1 ) )* pow(x,2*i+1);
      i:=0;
      errorR:= sum;
      while errorR >= error do
      begin
        i:= i+1;
        sum:= sum+ ( pow(-1,i)/ factorial( 2*i+1 ) )* pow(x,2*i+1);
      end;





    end;

    function TSerieTaylor.cos():real;
    function TSerieTaylor.exp():real;


end.

