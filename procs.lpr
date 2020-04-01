program procs;
uses crt;

procedure menu;
begin
  writeln('***************************************');
  writeln('********** 1. Suma  *******************');
  writeln('********** 2. Resta  ******************');
  writeln('********** 3. Multiplicacion  *********');
  writeln('********** 4. Division  ***************');
  writeln('***************************************');
  writeln('***************************************');
  writeln('Escoge una opcion');
     end;
function suma( a,b :real) :real;
var
  extra:real;
begin
  extra:=5;
  suma:=a+b+extra;
end;
var
  resultado:real;


begin
  menu;
  writeln();
  resultado:=suma(5,3);
  writeln(resultado);



  readkey;
end.

