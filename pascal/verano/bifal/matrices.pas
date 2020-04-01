unit Matrices;

{$mode objfpc}{$H+}

interface
 uses
     Classes, SysUtils, ParseMath, ArrStr, ArrReal;
 type
    m_Matriz = array of array of real;
    //m_ArrReal = array of real;

 type TMatrices = class
    public
      A :m_Matriz;
      Constructor Create(const n,m:Integer);
      procedure setMatriz();
      procedure printM();

      //+,-,*, k.A, A^-1
      Function Suma(B:TMatrices) : TMatrices;      // n=m
      Function Resta(B:TMatrices) : TMatrices;     // n=m
      Function Multiplicacion(C:TMatrices;B:TMatrices) : TMatrices;
      Function MultEscalar(B:TMatrices;n:Real) : TMatrices;
      Function Transpuesta(B:TMatrices) : TMatrices;
      function Potencia(B:TMatrices; pot : Integer) : TMatrices;

      Function SubMatriz(B:TMatrices;i:Integer;j:Integer): TMatrices;
      Function Determinante(B:TMatrices) : Real;
      Function Adjunta(B:TMatrices) : TMatrices;
      Function Inversa(B:TMatrices) : TMatrices;
      procedure Identidad(B:TMatrices);


  end;

implementation

Constructor TMatrices.Create(const n,m:Integer);
begin
      SetLength(,n,m);
end;

    Function TMatrices.Suma(B:TMatrices) : TMatrices;
    var i,j,ma,na,mb,nb:integer ;
      res:TMatrices;
    begin
         ma:=Length(A);na:=Length(A[0]);
         mb:=Length(B.A);nb:=Length(B.A[0]);
         res:=TMatrices.Create(ma,na);
         if not ((ma=mb) and (na=nb))
         then
         begin
           writeln('E :Matrices de dimensiones diferentes');
           exit;
         end;
         for i:=0 to ma-1 do
             for j:=0 to na-1 do
                 begin
                   res.A[i,j]:=(A[i,j]+B.A[i,j]);
                 end;
         Result:=res;
    end;

    Function TMatrices.Resta(B:TMatrices) : TMatrices;
    var i,j,ma,na,mb,nb:integer ;
      res:TMatrices;
    begin
         ma:=Length(A);na:=Length(A[0]);
         mb:=Length(B.A);nb:=Length(B.A[0]);
         res:=TMatrices.Create(ma,na);

         if not ((ma=mb) and (na=nb))then
         begin
           writeln('E :Matrices de dimensiones diferentes');
           exit;
         end;
         for i:=0 to ma-1 do
             for j:=0 to na-1 do
                 begin
                   res.A[i,j]:=(A[i,j]-B.A[i,j]);
                 end;
         Result:=res;
    end;

    Function TMatrices.Multiplicacion(C:TMatrices;B:TMatrices) : TMatrices;
    var i,j,h,ma,na,mb,nb:Integer ;
      res:TMatrices;
    begin
         ma:=Length(C.A);na:=Length(C.A[0]);
         mb:=Length(B.A);nb:=Length(B.A[0]);
         res:=TMatrices.Create(ma,nb);
         if not (na=mb)
         then
         begin
           writeln('E :Matrices de dimensiones diferentes');
           exit;
         end;
         for i:=0 to ma-1 do
             //WriteLn('*',ma-1);
             for j:=0 to nb-1 do
             begin
                 //WriteLn('*',nb-1);
                 //res.A[i,j]:=0;
                 for h:=0 to na-1 do
                 begin
                   res.A[i,j]:=res.A[i,j]+(C.A[i,h]*B.A[h,j]);
                   //WriteLn(res.A[i,j]);
                 end;
             end;
         Result:=res;
    end;

    Function TMatrices.MultEscalar(B:TMatrices;n:Real) : TMatrices;
    var i,j,ma,na:integer ;
      res:TMatrices;
    begin
         ma:=Length(B.A);na:=Length(B.A[0]);
         res:=TMatrices.Create(ma,na);
         for i:=0 to ma-1 do
             for j:=0 to na-1 do
             begin
                  res.A[i,j]:=B.A[i,j]*n;
             end;
         Result:=res;
    end;

    Function TMatrices.Transpuesta(B:TMatrices) : TMatrices;
    var i,j,ma,na:integer ;
      res:TMatrices;
    begin
         ma:=Length(B.A);na:=Length(B.A[0]);
         res:=TMatrices.Create(na,ma);
         for i:=0 to ma-1 do
             for j:=0 to na-1 do
             begin
                  res.A[j,i]:=B.A[i,j];
             end;
         Result:=res;
    end;

    Function TMatrices.SubMatriz(B:TMatrices;i:Integer;j:Integer): TMatrices;
     var x,y,w,z,ma,na:integer;
       res:TMatrices;
     begin
         ma:=Length(B.A);na:=Length(B.A[0]);
         res:=TMatrices.Create(ma-1,na-1);
         w:=0;z:=0;
         for x:=0 to ma-1 do
         begin
           if(x<>i)then
           begin
              for y:=0 to na-1 do
                  if((x<>i)and(y<>j))then
                  begin
                       res.A[w,z]:=B.A[x,y];
                       z:=z+1
                  end;
              w:=w+1;
              z:=0;
           end;
         end;
         Result:=res;
     end;

    Function TMatrices.Determinante(B:TMatrices) : Real;
    var s,k,ma,na:integer ;
    begin
         result:=0.0;
         ma:=Length(B.A);
         if ma>1 then na:=Length(B.A[0])
         else
             begin
               result:=B.A[0,0];
               exit;
             end;
         if not (ma=na)then exit;

         if(ma=2) then result:=B.A[0,0]*B.A[1,1]-B.A[0,1]*B.A[1,0]
         else if ma=3 then
              result:=B.A[0,0]*B.A[1,1]*B.A[2,2]+B.A[2,0]*B.A[0,1]*B.A[1,2]+B.A[1,0]*B.A[2,1]*B.A[0,2]-
                      B.A[2,0]*B.A[1,1]*B.A[0,2]-B.A[1,0]*B.A[0,1]*B.A[2,2]-B.A[0,0]*B.A[2,1]*B.A[1,2]
         else
         begin
              s:=1;
              for k:=0 to na-1 do
              begin
                   result:=result+s*B.A[0,k]*Determinante(Submatriz(B,0,k));
                   s:=s*-1;
              end;
         end;
    end;

    Function TMatrices.Adjunta(B:TMatrices) : TMatrices;
    var i,j,s,s1,ma,na:integer;
      res,temp:TMatrices;
    begin
         ma:=Length(B.A);na:=Length(B.A[0]);
         if not (ma=na)then exit;
         res:=TMatrices.Create(ma,na);
         temp:=TMatrices.Create(ma-1,na-1);
         s1:=1;
         for i:=0 to ma-1 do
         begin
             s:=s1;
             for j:=0 to na-1 do
             begin
                  temp:=SubMatriz(B,i,j);;
                  res.A[i,j]:=s*Determinante(temp);
                  s:=s*(-1);
             end;
             s1:=s1*(-1);
         end;
         Result:=res;
    end;

    Function TMatrices.Inversa(B:TMatrices) : TMatrices;
    var   ma,na:Integer ;
          det:Real;
          adj,res:TMatrices;
    begin
         ma:=Length(B.A);na:=Length(B.A[0]);
         if not (ma=na)then exit;
         adj:=TMatrices.Create(ma,na);
         res:=TMatrices.Create(ma,na);
         adj:=Adjunta(B);
         det:=Determinante(B);
         if det=0 then begin
            WriteLn('matriz no invertivble, derterminante es 0');
           exit;
         end;
         adj:=Transpuesta(adj);
         det:=1/det;
         res:=MultEscalar(adj,det);
         Result:=res;
    end;

    procedure TMatrices.setMatriz();
    Var
      m,n,j,i:Integer;
      numSet :Real;
    begin
      m:=Length(A);
      n:=Length(A[0]);
      for j:=0 to m-1 do begin
          WriteLn('Fila ',j);
          for i:=0 to n-1 do begin
                Read (numSet);
                A[j,i]:= numSet;
          end;
      end;
      WriteLn(' ');
    end;

    procedure TMatrices.printM();
    Var
      m,n,j,i:Integer;
    begin
      m:=Length(A);
      n:=Length(A[0]);
      for j:=0 to m-1 do begin
          Write('[ ');
          for i:=0 to n-1 do begin
                Write(A[j,i] :0:2,' , ');
          end;
          WriteLn(' ]');
      end;
      WriteLn(' ');
    end;
{
procedure TMatrices.GrillToMatrix(ma : TStringGrid);
var
  m,n,j,i:Integer;
begin
  m:=Length(A);n:=Length(A[0]);
  for j:=0 to m-1 do
    for i:=0 to n-1 do
      A[j,i]:=StrToFloat(ma.Cells[i,j]);
  //Result:=res;
end;   }

procedure TMatrices.Identidad(B:TMatrices);
var
   i,m, n,j : Integer;

begin
  m:=Length(B.A);     //columnas
  n:=Length(B.A[0]);  //filas
  i:=0;
  //C := TMatrices.Create(m,n);
  if(m=n)then
  begin
    for i:=0 to m-1 do begin
        for j := 0 to m-1 do begin
             //WriteLn('COL ',j);
             if i=j then
             begin
               B.A[i,j] := 1;
             end
             else
             begin
               B.A[i,j] := 0;
             end;
        end;
    end;
  //  Identidad := A;
  end
  else
  begin
     writeln('matriz no cuadrada');
//     Identidad := A;
  end;
end;

function TMatrices.Potencia(B:TMatrices; pot : Integer) : TMatrices;
var
  m,n, i : Integer;
  C : TMatrices ;
begin
  m:=Length(B.A);     //columnas
  n:=Length(B.A[0]);  //filas
  i:=1;
  C := TMatrices.Create(m,m);
  C.A := B.A;
  if(m=n)then
  begin
       if (pot =0)then
       begin
           B.Identidad(B);
       end
       ELSE
       begin
         while(i<pot)do
         begin
           C:= Multiplicacion(C, B);
           i:= i+1;
         end;
       end;
  end;
  B := C;
  Potencia := B;

end;



end.

