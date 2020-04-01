unit Jacobiana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ParseMath1,Dialogs;
type
   matriz= array[0..100, 0..100] of Real;
   matriztext= array[0..100, 0..100] of String;
  TJacobiana = Class

  Private
      Jvariables:matriztext;
      Jfunciones:matriztext;
      Jvalores:matriz;
      Jelementos:integer;
      function derivadaParcial(fun:TParseMath;x:string;valor:real): real;

  Public
      function Evaluate(): matriz;
      constructor create(A,B:matriztext;C:matriz;n:integer);
      destructor destroy;

  end;



implementation
constructor TJacobiana.create(A,B:matriztext;C:matriz;n:integer);
begin
   Jvariables:=A;
   Jfunciones:=B;
   Jvalores:=C;
   Jelementos:=n;
   //Evaluate();

   //FParser.Identifiers.AddFloatVariable( 'x', 0);
end;

destructor TJacobiana.destroy;
begin
end;

function TJacobiana.Evaluate(): matriz;
var
  m_function:TParseMath;
  help:matriz;
  i,j:integer;
begin
  m_function:=TParseMath.create();
  for i:=0 to Jelementos-1  do
      begin
        m_function.AddVariable(Jvariables[0,i],Jvalores[0,i]);

      end;
  for i:=0 to Jelementos-1  do
      begin
        m_function.Expression:=Jfunciones[0,i];
        for j:=0 to Jelementos-1  do
          begin


            help[j,i]:=derivadaParcial(m_function,Jvariables[0,j],Jvalores[0,j]);

          end;

      end;
  Evaluate:=help;


end;
function TJacobiana.derivadaParcial(fun:TParseMath;x:string;valor:real): real;
var
  h,a,b,v:real;
  funaux:TParseMath;
begin
  h:=0.0001;
  v:=valor;
  funaux:=fun;
  funaux.NewValue(x,v);
  b:=funaux.Evaluate();
  funaux.NewValue(x,v+h);
  a:=funaux.Evaluate();
  derivadaParcial:=(a-b)/h;


end;


end.



