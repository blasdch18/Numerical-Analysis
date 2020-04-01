unit Integral;

{$mode objfpc}{$H+}

interface


type
  TIntegral=Class
  private
    Ifuncion:String;
    Ia:Real;
    Ib:Real;
    Ino:Integer;

  public
    Expresion:String;
    function TrapecioEvaluateIntegral():Real;
    function TrapecioEvaluateArea():Real;
    function SimpsonEvaluate():Real;
    function SimpsonEvaluateArea():Real;
    function Simpson38Evaluate():Real;
    function Simpson38EvaluateArea():Real;
    function Simpson38CompuestoEvaluate():Real;
    function Simpson38CompuestoEvaluateArea():Real;
    constructor create(fun:String;a,b:Real;n:Integer);
    destructor destroy;

  end;

implementation
uses
  Classes, SysUtils, ParseMath,math,Dialogs;
constructor TIntegral.create(fun:String;a,b:Real;n:integer);
begin
  Ifuncion:=fun;
  Ia:=a;
  Ib:=b;
  Ino:=n;
end;

destructor TIntegral.destroy;
begin
end;

function TIntegral.TrapecioEvaluateIntegral():Real;
var
fa,fb,h,sum,i:Real;
m_function:TParseMath;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',Ib);
  fb:=m_function.Evaluate();

  h:=(Ib-Ia)/(Ino*100000);
  //ShowMessage(FloatToStr(Ib)+' - '+FloatToStr(Ia)+' / '+FloatToStr(Ino)+' = '+FloatToStr(h));
  sum:=0;
  i:=Ia+h;
  //ShowMessage(FloatToStr(Ia)+' + '+FloatToStr(h)+ '='+ FloatToStr(i));
  repeat
    m_function.NewValue('x',i);
    sum:=sum+m_function.Evaluate();
    i:=i+h;
    //ShowMessage('i= '+FloatToStr(i));
  until i>=Ib;
  TrapecioEvaluateIntegral:=RoundTo(0.5*h*(fa+fb)+h*sum,-6);
end;

function TIntegral.TrapecioEvaluateArea():Real;
var
fa,fb,h,sum,i:Real;
m_function:TParseMath;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',Ib);
  fb:=m_function.Evaluate();

  h:=(Ib-Ia)/(Ino*100000);
  sum:=0;
  i:=Ia+h;
  repeat
    m_function.NewValue('x',i);
    sum:=sum+abs(m_function.Evaluate());
    i:=i+h;
  until i>=Ib;
  TrapecioEvaluateArea:=RoundTo(h*( (abs(fa)+abs(fb))/2 +sum ),-6);
end;

function TIntegral.SimpsonEvaluate():Real;
var
fa,fb,h,sum,sum2,i:Real;
m_function:TParseMath;
begin

  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',Ib);
  fb:=m_function.Evaluate();

  h:=(Ib-Ia)/Ino;
  sum:=0;
  sum2:=0;
  i:=Ia+h;
  repeat
    m_function.NewValue('x',i);
    sum:=sum+m_function.Evaluate();
    i:=i+2*h;
  until i>=Ib;

  i:=Ia+2*h;
  repeat
    m_function.NewValue('x',i);
    sum2:=sum2+m_function.Evaluate();
    i:=i+2*h;
  until i>=Ib-h;                                // Pares// Impares
  SimpsonEvaluate:=RoundTo( (h/3) * ((fa+fb) + 2*sum2 + 4 * sum),-6);
end;
function TIntegral.SimpsonEvaluateArea():Real;
var
fa,fb,h,sum,sum2,i:Real;
m_function:TParseMath;
begin

  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=abs(m_function.Evaluate());
  m_function.NewValue('x',Ib);
  fb:=abs(m_function.Evaluate());

  h:=(Ib-Ia)/Ino;
  sum:=0;
  sum2:=0;
  i:=Ia+h;
  repeat
    m_function.NewValue('x',i);
    sum:=sum+abs(m_function.Evaluate());
    i:=i+2*h;
  until i>=Ib;

  i:=Ia+2*h;
  repeat
    m_function.NewValue('x',i);
    sum2:=sum2+abs(m_function.Evaluate());
    i:=i+2*h;
  until i>=Ib-h;                                // Pares// Impares
  SimpsonEvaluateArea:=RoundTo( (h/3) * ((abs(fa)+abs(fb)) + 2*sum2 + 4 * sum),-6);
end;
function TIntegral.Simpson38Evaluate():Real;
var
fa,fb,h,M,M2,i:Real;
m_function:TParseMath;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',Ib);
  fb:=m_function.Evaluate();

  m_function.NewValue('x',(2*Ia+Ib)/3);
  M:=m_function.Evaluate();
  m_function.NewValue('x',(Ia+2*Ib)/3);
  M2:=m_function.Evaluate();

  h:=(Ib-Ia)/3;
  Simpson38Evaluate:=RoundTo( (3*h/8) * ((fa+fb) + 3*M + 3*M2),-6);
end;
function TIntegral.Simpson38EvaluateArea():Real;
var
fa,fb,h,M,M2,i:Real;
m_function:TParseMath;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=abs(m_function.Evaluate());
  m_function.NewValue('x',Ib);
  fb:=abs(m_function.Evaluate());

  m_function.NewValue('x',(2*Ia+Ib)/3);
  M:=abs(m_function.Evaluate());
  m_function.NewValue('x',(Ia+2*Ib)/3);
  M2:=abs(m_function.Evaluate());

  h:=(Ib-Ia)/3;
  Simpson38EvaluateArea:=RoundTo( (3*h/8) * ((abs(fa)+abs(fb)) + 3*M + 3*M2),-6);
end;
function TIntegral.Simpson38CompuestoEvaluate():Real;
var
fa,fb,h,sum,sum2,sum3,i:Real;
m_function:TParseMath;
begin

  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',Ib);
  fb:=m_function.Evaluate();

  h:=(Ib-Ia)/Ino;
  sum:=0;
  sum2:=0;
  sum3:=0;
  i:=Ia+h;
  repeat
    m_function.NewValue('x',i);
    sum:=sum+m_function.Evaluate();
    i:=i+3*h;
  until i>Ib-2*h;

  i:=Ia+2*h;
  repeat
    m_function.NewValue('x',i);
    sum2:=sum2+m_function.Evaluate();
    i:=i+3*h;
  until i>Ib-h;                                // Pares// Impares

  i:=Ia+3*h;
  repeat
    m_function.NewValue('x',i);
    sum3:=sum3+m_function.Evaluate();
    i:=i+3*h;
  until i>Ib-3*h;
  Simpson38CompuestoEvaluate:=RoundTo( (3*h/8) * ((fa+fb) + 3*sum + 3*sum2 + 2*sum3),-6);
end;
function TIntegral.Simpson38CompuestoEvaluateArea():Real;
var
fa,fb,h,sum,sum2,sum3,i:Real;
m_function:TParseMath;
begin

  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.Expression:=Ifuncion;
  m_function.NewValue('x',Ia);
  fa:=abs(m_function.Evaluate());
  m_function.NewValue('x',Ib);
  fb:=abs(m_function.Evaluate());

  h:=(Ib-Ia)/Ino;
  sum:=0;
  sum2:=0;
  sum3:=0;
  i:=Ia+h;
  repeat
    m_function.NewValue('x',i);
    sum:=sum+abs(m_function.Evaluate());
    i:=i+3*h;
  until i>Ib-2*h;

  i:=Ia+2*h;
  repeat
    m_function.NewValue('x',i);
    sum2:=sum2+abs(m_function.Evaluate());
    i:=i+3*h;
  until i>Ib-h;                                // Pares// Impares

  i:=Ia+3*h;
  repeat
    m_function.NewValue('x',i);
    sum3:=sum3+abs(m_function.Evaluate());
    i:=i+3*h;
  until i>Ib-3*h;
  Simpson38CompuestoEvaluateArea:=RoundTo( (3*h/8) * ((abs(fa)+abs(fb)) + 3*sum + 3*sum2 + 2*sum3),-6);
end;
end.

