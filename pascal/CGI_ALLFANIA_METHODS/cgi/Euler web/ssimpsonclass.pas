unit Ssimpsonclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath, math;

type TSimpsonMethods= class
  public
    parse : TParseMath;
    Constructor Create();
    function SimpsonUm3(f_x : String; limit_a, limit_b : Real;  N_numb :  Integer): Real;
    function Simpson38(f_x : String; limit_a, limit_b: Real; N_numb : Integer) : Real;
  end;


implementation

Constructor TSimpsonMethods.Create();
begin
     parse := TParseMath.create();
     parse.AddVariable('x',1);
end;

function TSimpsonMethods.SimpsonUm3(f_x : String; limit_a, limit_b : Real;  N_numb :  Integer ): Real;      // 1/3
var
  h_numb : Real;
  j,i,resp,fa,fb,sump,sumi: Real;
begin
  parse.Expression:= f_x;
   if (N_numb=0)then begin
     N_numb:=100;
     //writeln('ok');
  end;

  h_numb:=(limit_b-limit_a)/power(2,N_numb);

  //h_numb:=(limit_b-limit_a)/(2*N_numb);

  parse.NewValue('x',limit_a);
  fa:=parse.Evaluate();
  parse.NewValue('x',limit_b);
  fb:=parse.Evaluate();
  sump:=0;
  sumi:=0;
  i:=limit_a+h_numb;
  if (i=limit_a)then begin
     h_numb := (limit_b-limit_a)/(2*N_numb);
     i:=limit_a+h_numb;
  end;

  repeat
    parse.NewValue('x',i);
    sumi:=sumi+parse.Evaluate();
    i:=i+2*h_numb;
  until i>=limit_b;

  i:=limit_a+2*h_numb;
  repeat
    parse.NewValue('x',i);
    sump:=sump+parse.Evaluate();
    i:=i+2*h_numb;

  until i>=limit_b-h_numb;

  resp:=(h_numb/3)*(fa+fb)+(2*h_numb/3)*sump+(4*h_numb/3)*sumi;
  SimpsonUm3 := resp;
  //Respuesta.Text:=FloatToStr(resp);
end;

function TSimpsonMethods.Simpson38(f_x : String; limit_a, limit_b: Real; N_numb : Integer): Real;
var
  i,h_numb,resp,fa,fb,sump,sumi,sump2 : Real;

begin
  parse.Expression:=f_x;
  if (N_numb=0)then begin
     N_numb:=100;
     //writeln('ok');
  end;
  h_numb:=(limit_b-limit_a)/(3*N_numb);
  parse.NewValue('x',limit_a);
  fa:=parse.Evaluate();
  parse.NewValue('x',limit_b);
  fb:=parse.Evaluate();
  sump2 :=0;
  sump:=0;
  sumi:=0;

  i := limit_a +h_numb;

  repeat
    parse.NewValue('x',i);
    sumi:=sumi+parse.Evaluate();
    i:=i+3*h_numb;

  until i>limit_b-2*h_numb;

  i:=limit_a+2*h_numb;
  repeat
    parse.NewValue('x',i);
    sump := sump + parse.Evaluate();
    i:=i+3*h_numb;

  until i>limit_b-h_numb;


  if(limit_a +3*h_numb<=limit_b-3*h_numb) then begin
   i:=limit_a+3*h_numb;
   repeat
    parse.NewValue('x',i);
    sump2:=sump2+parse.Evaluate();
    i:=i+3*h_numb;

  until i>limit_b-3*h_numb;
  end;

  resp:=(3*h_numb/8)*(fa+fb)+(9*h_numb/8)*sumi+(9*h_numb/8)*sump+(6*h_numb/8)*sump2;
  Simpson38 := resp;
end;

  {

function TSimpsonMethods.Simpson38(f_x : String; limit_a, limit_b: Real; N_numb : Integer): Real;
  var
    i,h,resp,fa,fb,sump,sumi:Float;
    n:Integer;
begin
  //parse.AddVariable('x',0);
  parse.Expression := f_x;

  n:=N_numb;
  h:=(limit_b-limit_a)/3;
  parse.NewValue('x',limit_a);
  fa:=parse.Evaluate();
  parse.NewValue('x',limit_b);
  fb:=parse.Evaluate();
  sump:=0;
  sumi:=0;

  parse.NewValue('x',limit_a);
  sumi:=sumi+parse.Evaluate();
  i := (2*limit_a+limit_b)/3;
  parse.NewValue('x',i);
  sumi:=sumi+3*parse.Evaluate();
  i := (limit_a+2*limit_b)/3;
  parse.NewValue('x',i);
  sumi:=sumi+3*parse.Evaluate();
  parse.NewValue('x',limit_b);
  sumi:=sumi+parse.Evaluate();

  sumi := sumi*3*h/8;

  Simpson38 := sumi;
  //RespuestaSim.Text:=FloatToStr(resp);
end;


  }


end.

