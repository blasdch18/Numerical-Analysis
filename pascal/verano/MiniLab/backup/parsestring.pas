unit parsestring;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math, fpexprpars,ParseMath,cmatriz, FileUtil, uCmdBox, TAGraph, Forms, Controls, Graphics,
Dialogs, ComCtrls, Grids, ValEdit, ExtCtrls, ShellCtrls, EditBtn, Menus,
StdCtrls, spktoolbar, spkt_Tab, spkt_Pane, spkt_Buttons, spkt_Checkboxes;




type
  matrix=array[65..122] of Tmatriz;
  //se tiene un array donde su indice es el numero ascci de las letras
  //asi se redireciona mas rapido


type
  TParseMathString = Class

  Public

      MiParse: TParseMath;
      //clase intermedia que recibe todos string y como vea por conveniente
      //lo pone a float
      Expression: string;
      m:matrix;

      procedure serExpression( Expression1: string );
      function NewValue( Variable:string; Value: Double ): Double;
      function NewValuestring( Variable:string; Value: String ): String;
      procedure AddVariable( Variable: string; Value: Double );
      procedure AddVariableString( Variable: string; Value: String );
      function Evaluates(): String;
      constructor create();
      destructor destroy;

  end;

implementation


constructor TParseMathString.create;
begin
   MiParse:= TParseMath.create();



end;

destructor TParseMathString.destroy;
begin
     MiParse.destroy;


end;


procedure TParseMathString.serExpression( Expression1: string );
begin

     Expression:=Expression1;

    MiParse.Expression:= Expression1;//cboFuncion.Text;
end;

function TParseMathString.NewValue( Variable: string; Value: Double ): Double;
begin
    MiParse.NewValue( Variable,Value );


end;

function TParseMathString.NewValuestring( Variable: string; Value: String ): String;
begin
    MiParse.NewValuestring( Variable,Value );


end;

function TParseMathString.Evaluates(): String;
var
  FinalLine,inicio,temp,tempa,tempb: string;
  A,rpta:Tmatriz;
  i,j,start,k,aa,b:Integer;
  fin:Double;

  //det :Boolean;

begin
    //ShowMessage(Expression);

    FinalLine:=Expression;
    //se va evaluadno caso por caso en el caso de las matrices
    //y operaciones que devuelvan string

     if Pos( '=', FinalLine ) > 0 then
     begin

      if FinalLine[Pos( '=', FinalLine )+1]='[' then
         begin

          A:=Tmatriz.Create;


          A.f:=1;
          A.c:=1;
          i:=Pos( '=', FinalLine )+2;

          while i< length(FinalLine)-1 do
          begin
            if FinalLine[i]= ',' then
             begin
              A.f:=A.f +1;
                i:=i+1;
                A.c:=1;
              //  ShowMessage('fila'+IntToStr(A.f))

             end
            else
            begin
             start:=i;
            while FinalLine[i]<> ' ' do
                begin
                i:=i+1;
                end;

             inicio:=Copy(FinalLine,start,i-start);
             A.matrix[A.f,A.c]:=StrToFloat(inicio);
             A.c:=A.c +1;
            end;
            i:=i+1;

          end;
           temp:= FinalLine[ Pos( '=', FinalLine ) - 1];
        m[Ord( FinalLine[ Pos( '=', FinalLine ) - 1])]:=A;




         end;



     end
     else
     begin



      temp:=Copy(FinalLine,1,4);
      //ShowMessage(temp);

      if temp='suma' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,6,1);//buscarlo en el array de matrices

        tempb:=Copy(FinalLine,Pos(',', FinalLine )+1,1);//buscarlo en el array de matrices
         rpta:=m[Ord(tempa[1])].suma(m[Ord(tempb[1])]);
          rpta.f:=m[Ord(tempa[1])].f;
         rpta.c:=m[Ord(tempa[1])].c-1;
         Result:=(rpta.generar_smatriz);

       end
      else
      begin



      temp:=Copy(FinalLine,1,5);

      if temp='resta' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,7,1);//buscarlo en el array de matrices

        tempb:=Copy(FinalLine,Pos(',', FinalLine )+1,1);//buscarlo en el array de matrices
      {  for  fin:=0 to ListVar.Count-1 do
         begin
         ShowMessage(ListVar.Names[ fin ]+IntToStr(fin));
         ShowMessage(tempa);
         ShowMessage(tempb);
         if ListVar.Names[ fin ]=tempa then
            aa:=fin;
         if ListVar.Names[ fin ]=tempb then
            b:=fin;
         end;
         ShowMessage(IntToStr(aa)+' '+IntToStr(b));   }


         rpta:=m[Ord(tempa[1])].resta(m[Ord(tempb[1])]);
          rpta.f:=m[Ord(tempa[1])].f;
         rpta.c:=m[Ord(tempa[1])].c-1;


    //     memCMD.Lines.Add(rpta.generar_smatriz)
         Result:=(rpta.generar_smatriz);
       end
      else
      begin



      temp:=Copy(FinalLine,1,11);

      if temp='multescalar' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,13,1);//buscarlo en el array de matrices

        tempb:=Copy(FinalLine,Pos(',', FinalLine )+1,Length(FinalLine)-Pos(',', FinalLine )-1);//buscarlo en el array de matrices

         rpta:=m[Ord(tempa[1])].mult_escalar(StrToFloat(tempb));
          rpta.f:=m[Ord(tempa[1])].f;
         rpta.c:=m[Ord(tempa[1])].c-1;



         Result:=(rpta.generar_smatriz);
       end
      else
      begin



      temp:=Copy(FinalLine,1,5);

      if temp='traza' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,7,1);//buscarlo en el array de matrices

         fin:=m[Ord(tempa[1])].traza;


         Result:=FloatToStr(fin);
       end
      else
      begin
       temp:=Copy(FinalLine,1,10);

      if temp='multmatriz' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,12,1);//buscarlo en el array de matrices

        tempb:=Copy(FinalLine,Pos(',', FinalLine )+1,1);//buscarlo en el array de matrices

         rpta:=m[Ord(tempa[1])].mult_matriz(m[Ord(tempb[1])]);
          rpta.f:=m[Ord(tempa[1])].f;
         rpta.c:=m[Ord(tempb[1])].c-1;


          Result:=rpta.generar_smatriz;
       end
      else
      begin


       temp:=Copy(FinalLine,1,3);

      if temp='det' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,5,1);//buscarlo en el array de matrices

        tempb:=Copy(FinalLine,Pos(',', FinalLine )+1,1);//buscarlo en el array de matrices
  ShowMessage(FloatToStr( rpta.f));
         fin:=m[Ord(tempa[1])].determinante(m[Ord(tempa[1])],m[Ord(tempa[1])].f);

         Result:=FloatToStr(fin);

         end
         else
         begin

       temp:=Copy(FinalLine,1,3);

      if temp='inv' then
       begin

        rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,5,1);//buscarlo en el array de matrices


          for i:=0 to m[Ord(tempa[1])].f-1 do
          begin
          for j:=0 to m[Ord(tempa[1])].c-1 do
          begin


          rpta.matrix[i+1,j+1]:=(m[Ord(tempa[1])].matrix[i+1,j+1]);

              end;
               end;

    for i:=m[Ord(tempa[1])].f to m[Ord(tempa[1])].f+2 do
       rpta.matrix[i+1-m[Ord(tempa[1])].f,i+1]:=1;

    rpta:=m[Ord(tempa[1])].gauss(rpta,m[Ord(tempa[1])].f*2,True);

    rpta.f:=m[Ord(tempa[1])].f;
    rpta.c:=m[Ord(tempa[1])].c*2-2;


          Result:=rpta.generar_smatriz;



       end
       else
       begin


       temp:=Copy(FinalLine,1,3);

      if (temp='heu') or(temp='EDO')  then
       begin


         Result:= MiParse.EvaluateString();
       end
      else
       begin
       temp:=Copy(FinalLine,1,5);

      if (temp='euler') or (temp='runge') or (temp='gnewt')  then
       begin


         Result:= MiParse.EvaluateString();
       end
       else
       begin
       temp:=Copy(FinalLine,1,8);

      if (temp='lagrange')  then
       begin

        {NGen('[x ;y ]','[power(x,2)+x*y-10 ;y+3*x*power(y,2)-57 ]','[2.036 ;2.845 ]',0.001)}


       rpta:=Tmatriz.Create;
        tempa:=Copy(FinalLine,10,1);//buscarlo en el array de matrices

         tempb:=Copy(FinalLine,Pos(',', FinalLine )+1,Length(FinalLine)-Pos(',', FinalLine )-1);//buscarlo en el array de matrices
         Result:=m[Ord(tempa[1])].lagrange(StrToFloat(tempb))+'  valor : '+FloatToStr(m[Ord(tempa[1])].lagra);



       end

      else
       begin

        Result:= FloatToStr(MiParse.Evaluate());

     end;

       end;


      end;

      end;

      end;

      end;

      end;

     end;



end;



     end;

end;


end;





procedure TParseMathString.AddVariableString( Variable: string; Value: String );
var Len: Integer;
begin
   MiParse.AddVariableString( Variable, Value);

end;



procedure TParseMathString.AddVariable( Variable: string; Value: Double );
begin

   MiParse.AddVariable( Variable, Value);



end;

end.

