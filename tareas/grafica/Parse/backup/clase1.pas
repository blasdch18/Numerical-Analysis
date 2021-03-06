unit clase1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,math,t_pila2, t_Pila1, Dialogs;


type
  TparseMath = class
  private
     display : string;
     inf,posf : TStringlist;

    function InfijaToPostfija(Infija : TStringlist): TStringlist;
    function PrioridadPila (c: string): Integer;
    function PrioridadInfija(c: string): Integer;
    function Evalua(Op1:real; Operador:String; Op2:real): real;
    function EvaluaFuncion(Op2: Double; Operador:String): Double;
    function EvaluaPostfija(ExpPostfija: TStringlist): Double;
    function IsNumeric(s: String): Boolean;
    function EsOperador(Op:String): Boolean;
    function EsFunction(Ope:String): Boolean;
    function InserLista(cad:String): TStringlist;

  public
    constructor create;
    destructor destroy;

    function Eval():real;
    procedure AddVariable( c: char; valor: real );
    procedure setFormula( ca: String );



  end;
implementation
constructor TparseMath.create;
begin
     display:='';
     inf:=TStringlist.Create;
     posf:=TStringlist.Create;
end;
destructor TparseMath.destroy;
begin
     inf.Destroy;
     posf.Destroy;
end;

procedure TparseMath.setFormula( ca: String);
begin
     display:= LowerCase( ca );
end;

procedure TparseMath.AddVariable(c:char;valor:real);
var
   v: string;
   i: integer;

begin

     v:= floatTostr( valor );
     for i:=1 to length( display ) do
         if ( display[ i ] = c) then begin
            delete( display, i, 1 );
            insert( v, display, i );

         end;

end;

function TparseMath.Eval():real;
begin
     inf:=InserLista(display);
     posf:=InfijaToPostfija(Inf);
     eval:=EvaluaPostfija (posf);

end;

function TparseMath.InserLista(cad:String):TStringlist;
var
   i: integer;
   g, simbolo: string;
   infini: TStringlist;

begin
    infini:=TStringlist.Create;
    for i:=1 to length(cad) do  begin
        if (i=1) and ( cad[ i ] = '-') then
           g:= g + cad[ i ]
       else begin
            if (cad[ i ] in [ '0'..'9' ] ) or ( cad[ i ] ='.' ) then  begin
               g:=g + cad[ i ];
               simbolo:='';

            end else begin
                if (g <> '') and (g <> '-') then begin
                   infini.Add( g );
                   g:='';

                end;

            simbolo:=simbolo+cad[i];

       if ( EsOperador( cad[ i + 1 ] ) ) and ( cad[ i + 1] <> '(') and (cad[i]<>')' )  then  begin
            infini.Add(simbolo);
            g:= g + cad[i + 1];
            simbolo:= simbolo + cad[ i + 1 ];

       end  else begin
            if ((EsOperador(simbolo)) or (EsFunction(simbolo)) or (simbolo='(') or (simbolo=')')) then begin
               infini.Add(simbolo);
               simbolo:='';
            end

       end;
     end;
    end;
    end;

  if g<>'' then
     infini.Add(g);

  if simbolo<>'' then
     infini.Add(simbolo);

  InserLista:=infini;

end;

FUNCTION TparseMath.IsNumeric(s: STRING): boolean;
VAR
 i: integer;
BEGIN
//TODO:Replace ',' with Systemdelemiter
if ((length(s) = 1 )) and ((Char(s[1])='+') or (Char(s[1])='-') or (Char(s[1])='.')) then
begin
Result:=False;
end
else
begin
 Result := (length(s) > 0);
 FOR i := 1 TO length(s) DO
   IF NOT ((Char(s[i]) IN ['0'..'9']) or (Char(s[1])='+') or (Char(s[1])='-') or (Char(s[i]) = DecimalSeparator)) THEN
     BEGIN
       Result := False;
       exit;
     END;
 end;
end;
function TparseMath.EsOperador( Op: String ): Boolean;
begin

     EsOperador:= ( Op='^') or (Op='*') or (Op='%') or (Op='sen') or (Op='sin') or
                  ( Op='sqrt') or (Op='/') or (Op='+') or (Op='-') or
                  ( Op='(') or (Op='cos') or (Op='tan') or (Op='cot') or
                  ( Op='log') or (Op='ln')

end;
function TparseMath.EsFunction(Ope:String):Boolean;
begin

 EsFunction := (Ope='sin') or(Ope='cos') or (Ope='sqrt') or (Ope='tan') or (Ope='cot') or (Ope='log') or (Ope='ln') or (Ope='sen');

end;
function TparseMath.Evalua(Op1:real; Operador:String; Op2:real):real;
begin
Case Operador of
     '^': Evalua:= power(Op1,Op2);
     '%': Evalua:= (Op1*Op2)/100;
     '*': Evalua:= Op1*Op2;
     '/': Evalua:= Op1/Op2;
     '+': Evalua:= Op1+Op2;
     '-': Evalua:= Op1-Op2;
end
end;
function TparseMath.EvaluaFuncion(Op2: Double; Operador: String ):Double;
var
   rad, deg, grad: Double;
begin
//poner si es radianes
  deg:=op2;
  grad:=op2;
  rad:=op2;

Case Operador of
     'log': EvaluaFuncion:=log10(Op2);
     'sqrt': EvaluaFuncion:=System.sqrt(Op2);
     'ln': EvaluaFuncion:=ln(op2);
     'sin': EvaluaFuncion:=sin(Op2);
     'sen': EvaluaFuncion:=sin(Op2);
     'cos': EvaluaFuncion:=cos(op2);
     'tan': EvaluaFuncion:=tan(op2);
     'cot': EvaluaFuncion:=cot(op2);
end

end;


function TparseMath.PrioridadInfija (c:String): integer;
begin
Case c of
     'log': PrioridadInfija:=4;
     'ln': PrioridadInfija:=4;
     'sqrt': PrioridadInfija:=4;
     'cot': PrioridadInfija:=4;
     'tan': PrioridadInfija:=4;
     'cos': PrioridadInfija:=4;
     'sen': PrioridadInfija:=4;
     'sin': PrioridadInfija:=4;
     '%': PrioridadInfija:=4;
     '^': PrioridadInfija:=4;
     '*': PrioridadInfija:=2;
     '/': PrioridadInfija:=2;
     '+': PrioridadInfija:=1;
     '-': PrioridadInfija:=1;
     '(': PrioridadInfija:=5;
// La prioridad para el paréntesis derecho no está definida
end
end;

function TparseMath.PrioridadPila (c:String): integer;
begin
Case c of
     'log': PrioridadPila:= 3;
     'ln': PrioridadPila:= 3;
     'sqrt': PrioridadPila:= 3;
     'cot': PrioridadPila:= 3;
     'tan': PrioridadPila:= 3;
     'cos': PrioridadPila:= 3;
     'sin': PrioridadPila:= 3;
     'sen': PrioridadPila:= 3;
     '%': PrioridadPila:= 3;
     '^': PrioridadPila:= 3;
     '*': PrioridadPila:= 2;
     '/': PrioridadPila:= 2;
     '+': PrioridadPila:= 1;
     '-': PrioridadPila:= 1;
     '(': PrioridadPila:= 0;
// La prioridad para el paréntesis derecho no está definida
end
end;

function TparseMath.InfijaToPostfija(Infija:TStringlist): TStringlist;
//uses TADPila; // Usamos una pila de carácteres
var
   Postfija: TStringlist;
   P : tpila2;
   aux: string;
   i: integer;
   salir:boolean;
begin
     Postfija:=TStringlist.Create;
     P:=t_pila2.tpila2.Create;
     p.vacia();
     for i:=0 to Infija.Count-1 do begin
         // Recorremos la expresión infija
         // Un operando se pasa a la expresión postfija
         if isNumeric( Infija[ i ] ) then
            Postfija.Add(Infija[i])

         else if EsOperador(Infija[i]) then begin
// Si es un operador
            salir:=false;
            while not salir do begin
               aux:=p.cimas(); // Comparamos la prioridad del operador de la expresion con ultimo guardado
               if (p.EsPilaVacia()) or (PrioridadInfija(Infija[i])>PrioridadPila(aux)) then begin
                  p.push( Infija[ i ] );
                  salir:=true; // se mete el operador en la pila

               end else begin // Si es < o = se saca el operador de la pila a la expresión
                 aux:=p.cimas();
                 p.pop();
                 Postfija.Add(aux);
               end
            end
         end else if Infija[i] =')' then // Si encontramos un paréntesis dch se sacan
             repeat // operadores de la pila hasta encontrar un
               aux:=p.cimas();
               p.pop();

               if (aux <> '(') then  // paréntesis izqdo que se elimina.
                 Postfija.Add(aux);

             until (aux='(');
      end;
// Cuando se acaba la expresión infija se vacía la pila en la expresión postfija
   while not p.EsPilaVacia() do begin
      aux:=p.cimas();
      p.pop();
      Postfija.Add(aux);
      //Postfija:=Postfija + aux;
   end;
   InfijaToPostfija:=Postfija;

end;


function TparseMath.EvaluaPostfija (ExpPostfija: TStringlist): Double;
var
P: tpila;
Op1, Op2, Z: real;
i: integer;
begin
p:=tpila.Create;
p.vacia();
for i:=0 to ExpPostFija.Count-1 do  begin          // Recorremos la expresion postfija
    if isNumeric(ExpPostfija[i]) then // Si es un operando lo metemos en la pila
       p.push(StrToFloat(ExpPostfija[i]))
    else begin  // Si es un operador sacamos los dos primeros elementos
      if EsFunction(ExpPostfija[i]) then begin
         Op2:=p.cimas();
         p.pop();
         Z:=EvaluaFuncion(Op2,ExpPostfija[i]);
         p.push(Z);
      end else begin
          Op2:=p.cimas();
          p.pop(); // de la pila y realizamos la operación indicada con
          Op1:=p.cimas();
          p.pop(); // ellos. El resultado lo volvemos a meter en la pila
          Z:=Evalua(Op1, ExpPostfija[i], Op2);
          p.push(Z);
      end
    end
end;

// Al final la pila queda con un único elemento que es el resultado de la evaluación
EvaluaPostfija:=p.Cimas();
end;

end.

