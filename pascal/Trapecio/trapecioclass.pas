unit Trapecioclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath;
type TTrapecio = class
  public
    function Trapecio(func :String; limit_a,limit_b: Real; N_trapezium : Integer): Real;


  end;

implementation


function TTrapecio.Trapecio(func :String; limit_a,limit_b: Real; N_trapezium : Integer): Real;
var
  m_function :TParseMath;
  i,h, resp,fa,fb,sum :Real;
  j :Integer;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);

  m_function.Expression := func;
  h:=(limit_b-limit_a)/N_trapezium;

  m_function.NewValue('x',limit_a);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',limit_b);
  fb:=m_function.Evaluate();
  sum:=0;

  i:=limit_a+h;
  repeat
    m_function.NewValue('x',i);
    sum:=sum+m_function.Evaluate();
    i:=i+h;
    //ShowMessage('hola!!');
  until i>=limit_b;
  resp:=0.5*h*(fa+fb)+h*sum;
  Trapecio := resp;

end;


end.

