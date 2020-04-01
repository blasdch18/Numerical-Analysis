unit NewtonG;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ParseMath1,Dialogs,Jacobiana,Inversa,cmatriz,math;
type
   matriz= array[0..100, 0..100] of Real;
   matriztext= array[0..100, 0..100] of String;
   matmat=array[0..100,0..100] of matriz;

  TNewtonG = Class

  Private
      Nvariables:matriztext;
      Nfunciones:matriztext;
      Nvalores:matriz;
      Nelementos:integer;
      Nerror:real;

  Public
      Niteraciones:integer;
      Nxn:matmat;
      Nmul:matmat;
      Nerr:matriz;
      Nxntext:matriztext;
      Nmultext:matriztext;
      Expresion:String;

      function EvaluarFuncion(): matriz;
      function Evalua(fun:TParseMath;x:string;valor:real): real;
      function Evaluate(): matriz;
      constructor create(A,B:matriztext;C:matriz;n:integer;e:real);
      destructor destroy;

  end;



implementation

constructor TNewtonG.create(A,B:matriztext;C:matriz;n:integer;e:real);
begin
   Nvariables:=A;
   Nfunciones:=B;
   Nvalores:=C;
   Nelementos:=n;
   Nerror:=e;
   //Evaluate();

   //FParser.Identifiers.AddFloatVariable( 'x', 0);
end;

destructor TNewtonG.destroy;
begin
end;

function TNewtonG.EvaluarFuncion(): matriz;
var
  m_function:TParseMath;
  help:matriz;
  i:integer;
begin
  m_function:=TParseMath.create();
  for i:=0 to Nelementos-1  do
      begin
        m_function.AddVariable(Nvariables[0,i],Nvalores[0,i]);
        //ShowMessage(Jvariables[0,i]);
      end;
  for i:=0 to Nelementos-1  do
      begin
         m_function.Expression:=Nfunciones[0,i];
         help[0,i]:=Evalua(m_function,Nvariables[0,i],Nvalores[0,i]);
         //ShowMessage(' LOOK: '+FloatToStr(help[0,i]));
      end;
  EvaluarFuncion:=help;
end;
function TNewtonG.Evalua(fun:TParseMath;x:string;valor:real): real;
var

  a,v:real;
  funaux:TParseMath;
begin
  //ShowMessage(x+'  '+FloatToStr(valor)+' expresion'+fun.Expression);
  v:=valor;
  funaux:=fun;
  funaux.NewValue(x,v);
  a:=funaux.Evaluate();
  Evalua:=a;
end;



function TNewtonG.Evaluate(): matriz;
var
  resul:TJacobiana;
  jacobiana:matriz;
  resul2:TInversa;
  Inversa:matriz;
  resul3:TMatriz;
  multiplicacion:matriz;
  resta:matriz;
  x:real;
  i,a,b:integer;
  multi,resti:string;

begin
  x:=50000000;
  a:=0;
  b:=-1;
  Niteraciones:=0;
  multi:=' ';
  resti:=' ';
  Nxn[0,a]:=Nvalores;
  for i:=0 to Nelementos-1 do
    multi:=multi+FloatToStr(Nvalores[0,i]) +'   ';
  Nxntext[0,a]:=multi;
  while x>=Nerror do
  begin
    multi:=' ';
    resti:=' ';
    a:=a+1;
    b:=b+1;
    Niteraciones:=Niteraciones+1;
    resul:=TJacobiana.create(Nvariables,Nfunciones,Nvalores,Nelementos);                    //Escribir(resul.Evaluate(),SpinEdit1.Value,SpinEdit1.Value,StringGrid2);
    jacobiana:=resul.Evaluate();

    resul2:=TInversa.create(resul.Evaluate(),Nelementos);                                   //Escribira(resul2.Evaluate(),1,1,SpinEdit1.Value,SpinEdit1.Value,StringGrid2);
    inversa:=resul2.Evaluate();

    resul3:=TMatriz.create();

    multiplicacion:=resul3.Mult(inversa,EvaluarFuncion(),Nelementos,Nelementos,1);

    resta:=resul3.Resta(Nvalores,multiplicacion,Nelementos,1);
    for i:=0 to Nelementos-1 do
      begin
        multi:=multi+FloatToStr(RoundTo(multiplicacion[0,i],-4))+'  ';
        resti:=resti+FloatToStr(RoundTo(resta[0,i],-4))+'    ';
      end;
    //ShowMessage('Jf(Xn)f(Xn): '+FloatToStr(multiplicacion[0,0])+'   '+FloatToStr(multiplicacion[0,1]));
    //ShowMessage('Xn:          '+FloatToStr(resta[0,0])+'   '+FloatToStr(resta[0,1]));

    x:=abs(multiplicacion[0,0]);
    for i:=0 to Nelementos-1  do
      begin
        //ShowMessage('iteracion'+IntToStr(i)+'--->'+FloatToStr(multiplicacion[0,i]));
        if abs(multiplicacion[0,i])>x then
        begin
          x:=abs(multiplicacion[0,i]);
          //ShowMessage(FloatToStr(x));
        end;
      end;
    Nxntext[0,a]:=resti;
    Nmultext[0,b]:=multi;


    Nxn[0,a]:=resta;
    Nmul[0,b]:=multiplicacion;
    Nerr[0,a]:=x;

    for i:=0 to Nelementos-1  do
      begin
        Nvalores[0,i]:=resta[0,i];
      end;
  end;
  Evaluate:=Nvalores;
end;

end.



