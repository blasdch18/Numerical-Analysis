unit metodoscerrados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;
type
  TMetodosCerrados = class
    public
      //a, b:                    double;
      //error1, error2:          double;


      constructor Create();
      function fx(x: double): double ;
      function Xn_biseccion(): string ;
      function Xn_falsa_posicion(): string ;
      procedure f_continua(a, b: double) ;




  end;

implementation
constructor TMetodosCerrados.Create();
begin
  //Self.error1:= 0.001;
  //self.i:= 1;
  //self.error2:= 50;
  //self.Xn_1:= 0;
  //self.fa:=0 ;



  end;



procedure TMetodosCerrados.f_continua(a, b: double);
var
  tmp:    double;
  //i_:      boolean;
begin

     //for i:= a to b do//
     while(a=b) do
     begin
          try
             //i:= isInfinite(fx(a));
             if  (fx(a)= -Infinity) or (fx(b)= Infinity) then
                 writeln('No Continua');
                 break;
                 a:= a+1;

          finally

          end;


     end
end;

function TMetodosCerrados.fx(x: double): double ;
var
  f_x: double;
begin
  //f_x:= power(x,2)-(ln(x))*(power(2.71828183,x));
  f_x:= Ln( power(x,2)+1 ) - exp(x/2)*(cos(3.1416*x));

  Result:= f_x;
end;

function TMetodosCerrados.Xn_biseccion(): string ;
var
  a, b: double;
  mytab: string;

  error1, error2:          double;

  Xn_1:                    double;
  Xn, sgn:                 double;
  fa, fb:                  double;

  i, j:                    integer;
  num, zero:               integer;
begin
  writeln('              Biseccion           ');
  write('a = ');
  read( a );
  write('b = ');
  read( b );
  //write('error = ');
  //read(error1);
  error1:= 0.01;

  mytab:= '   |   ';
  xn:= 0;

  //i:=1;
  error2:=50;
  f_continua(a,b);

  //Xn_1:= 0;
  fa := fx(a);
  fb := fx(b);

  writeln(' ------------------------------------------------------------------- ');
  writeln('| n |      a      |      b      |   sgn   |     Xn     |     Er*    |');
  writeln(' ------------------------------------------------------------------- ');

  if fa= 0 then
      begin
         write(' 0 '+ mytab + FormatFloat('0.00000',a) + mytab + FormatFloat('0.00000',b) +
         mytab + '  ' + mytab + FormatFloat('0.00000',a));
         exit;
      end;

  if fb= 0 then
      begin
         write(' 0 '+ mytab + FormatFloat('0.00000',a) + mytab + FormatFloat('0.00000',b) +
         mytab + '  ' + mytab + FormatFloat('0.00000',a) );
         exit;
      end;
  if(fx(a)*fx(b)<0) then
   begin
       while (Xn=0) or ( error2 > error1 ) do
             begin
             Xn:=(b+a)/2;

             sgn:= Sign( fx(a)*fx(Xn) );
             writeln('| '+ IntToSTr(i) +' |   ' + FormatFloat('0.00000',a) + mytab + FormatFloat('0.00000',b)
                        + mytab + FloatToStr(sgn) + mytab + FormatFloat('0.00000',Xn) +
                        mytab + FormatFloat('0.00000',error2) +'  |');
             if sgn < 0 then
                b:= Xn
             else
                a:= Xn;

             if i=1 then
                error2:=50
             else
                error2:=abs(( Xn_1 - Xn)/ Xn);
                xn_1:= xn;

             if (error2=0) or (IsInfinite(error2))  then
                error2:= error1-0.1;
                i:= i+1;

             end;
       end
   else
       begin
            writeln('MessageError : No Cumple Teorema de Bolzano');
       end;
   Result:='';

end;

function TMetodosCerrados.Xn_falsa_posicion(): string ;
   var
     a, b: double;
     mytab: string;

     error1, error2:          double;

     Xn_1:                    double;
     Xn, sgn:                 double;
     fa, fb:                  double;

     i, j:                    integer;
     num, zero:               integer;
   begin
     writeln('             falsa posicion           ');
     write('a = ');
     read( a );
     write('b = ');
     read( b );
     //write('error = ');
     //read(error1);
     error1:= 0.01;

     mytab:= '   |   ';
     xn:= 0;

     i:=0;
     error2:=50;
     f_continua(a,b);

     //Xn_1:= 0;
     fa := fx(a);
     fb := fx(b);

     writeln(' ------------------------------------------------------------------- ');
     writeln('| n |      a      |      b      |   sgn   |     Xn     |     Er*    |');
     writeln(' ------------------------------------------------------------------- ');

     if fa= 0 then
         begin
            write(' 0 '+ mytab + FormatFloat('0.00000',a) + mytab + FormatFloat('0.00000',b) +
            mytab + '  ' + mytab + FormatFloat('0.00000',a));
            exit;
         end;

     if fb= 0 then
         begin
            write(' 0 '+ mytab + FormatFloat('0.00000',a) + mytab + FormatFloat('0.00000',b) +
            mytab + '  ' + mytab + FormatFloat('0.00000',a) );
            exit;
         end;
     if(fx(a)*fx(b)<0) then
      begin
          while (Xn=0) or ( error2 > error1 ) do
                begin
                Xn:= a-( (fx(a)*(b-a))/(fx(b)-fx(a)) );

                sgn:= Sign( fx(a)*fx(Xn) );
                writeln('| '+ IntToSTr(i) +' |   ' + FormatFloat('0.00000',a) + mytab + FormatFloat('0.00000',b)
                           + mytab + FloatToStr(sgn) + mytab + FormatFloat('0.00000',Xn) +
                           mytab + FormatFloat('0.00000',error2) +'  |');
                if sgn < 0 then
                   b:= Xn
                else
                   a:= Xn;

                if i=1 then
                   error2:=50
                else
                   error2:=abs(( Xn_1 - Xn)/ Xn);
                   xn_1:= xn;

                if (error2=0) or (IsInfinite(error2))  then
                   error2:= error1-0.1;
                   i:= i+1;

                end;
          end
      else
          begin
               writeln('MessageError : No Cumple Teorema de Bolzano');
          end;
      Result:='';


end;




end.

