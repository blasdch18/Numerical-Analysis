        program BISECCION;

uses math,crt,sysutils;

var
  a:double;
  b:double;
  tolerancia:double;
  xr:double;
  function f(x:real):real;
  var
    valor:real;
    formato:string;
    begin
      FormatFloat('0.###',valor);
      valor:=exp(-1*x)-cos(3*x) -0.5;   {f(x)}
      formato:=FloatToStr(valor);
      {valor:=FormatFloat('0.####',formato);}

    end;
  function tabula(a,b:double):double;
  var
    puntos:integer;
    intervalos:integer;
    Xn:double;
    i:integer;
    fx:real ;
begin
 { fx:=FormatFloat('0.###',f(a));}
  intervalos:=10;
  puntos:=intervalos+1;
  Xn:=(b-a)/intervalos;
  writeln('              x               |                  f(x)');
  for i:=0 to puntos do
  begin
    write('    ');write(a);write('     ');write(f(a));writeln;
    a:=a+Xn;
  end;

end;
     begin
       writeln('Intervalo [a,b]:');
       write('a=');read(a);
       write('b=');read(b);
       tabula(a,b);
       if(f(a)*f(b)>0)then
       begin
         writeln('No puede aplicar el metodo de la biseccion');
         write('por tener f(');write(a);write(') y f(');write(b);write(') tiene el mismo signo');
       end
       else
       begin
         write('tolerancia=');read(tolerancia);
         writeln('   a           b           f(a)              f(b)             f(x)       ' );
         while true do
         begin
           xr:=(a+b)/2.0;
           write(a);
           write('       ');
           write(b);
           write('       ');
           write(xr);
           write('       ');
           write(f(a));
           write('       ');
           write(f(b));
           write('       ');
           write(xr);
           writeln;
           if(abs(f(xr))<=tolerancia)  then
           begin
             write('Para una tolerancia de');
             write(tolerancia);
             write('la raiz de f es');
             write(xr);
             writeln;
             end
             else
             begin
               if  (f(xr)*f(a)>0)then
               begin
               a:=xr;
               end
               else
               begin
                 if(f(xr)*f(b)>0)then
                 begin
                   b:=xr;
                   end;
               end;
         end;
             readkey();
             end;




     end;
     readkey();
     end.

