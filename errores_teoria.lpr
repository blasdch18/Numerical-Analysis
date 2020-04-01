program errores_teoria;
uses math,crt, forms_pascal_clase1;



var
  {tabla de errores}
  n:array[0..4] of double;
  st:array[0..4] of double;
  Ea:array[0..4] of double;
  Er:array[0..4] of double;
  Erp:array[0..4] of double;

  resultado1:integer;
  resultado2:double;

  i:integer;

  {funciones}
function factorial ( valor :integer) :integer;
  var
    factor,i:integer;
  begin
    factor:=1;

    for i:=1 to valor do
    begin
      factor:=factor*i;
      end;
  end;
function seno ( valor :double):double;
var
  subSuma,base,potencia:double;
  i,posicion,j,n:integer;
  fact:integer;
  begin
    base:=(-1);
    n:=4;

    posicion:=(n*2)+1;
    for  i:=0 to posicion do
    begin
      subSuma:=power(base,i);
      potencia:=power(valor,((2*i)-1));
      fact:=factorial((2*i)-1);
      writeln(fact);
      st[i]:=st[i]+((subSuma/fact)*potencia);
    end;
  end;
{function expo( valor :double):double;
var
  subSuma:double;
 }
begin
  resultado1:=factorial(5);
  writeln(resultado1);
  writeln;
  write('seno=');
  resultado2:=seno(3.14);
  writeln(resultado2:3:2);
  writeln(' ___________________________________________________________________________________________________________ ');
  writeln('|  n  |     st     |      Ea      |      Er      |      Ep      |      Ea*      |     Er*     |     Ep*     |');
  writeln(' -----------------------------------------------------------------------------------------------------------');
  for i:=0 to 4 do
  begin
  write('|  ');write(i);write('  |  ');write(st[i]:3:2);write('      |              |              |              |               |             |             |');
  writeln;
  end;
  writeln(' -----------------------------------------------------------------------------------------------------------');

  readkey;
end.

