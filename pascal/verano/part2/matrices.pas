unit Matrices;

{$mode objfpc}{$H+}

interface
 uses
     Classes, SysUtils, Graphics,
  FileUtil, Forms, Controls, ExtCtrls,  Grids;
 type
    m_Matriz = array of array of real;

 type TMatrices = class
    A,Identidad :m_Matriz;
    Constructor Create(const n,m:Integer);
    Function MSuma(B:TMatrices) : TMatrices;
    Function MResta(B:TMatrices) : TMatrices;
    Function MMultiplicacion(C:TMatrices;B:TMatrices) : TMatrices;
    Function MMultEscalar(B:TMatrices;n:Real) : TMatrices;
    Function MTranspuesta(B:TMatrices) : TMatrices;
    Function MSubMatriz(B:TMatrices;i:Integer;j:Integer): TMatrices;
    Function MDeterminante(B:TMatrices) : Real;
    Function MAdjunta(B:TMatrices) : TMatrices;
    Function MInversa(B:TMatrices) : TMatrices;
    procedure GrillToMatrix(ma : TStringGrid);
  end;

implementation

Constructor TMatrices.Create(const n,m:Integer);
    begin
      SetLength(A,n,m);
    end;

    Function TMatrices.MSuma(B:TMatrices) : TMatrices;
    var i,j,ma,na,mb,nb:integer ;
      res:TMatrices;
    begin
         ma:=Length(A);na:=Length(A[0]);
         mb:=Length(B.A);nb:=Length(B.A[0]);
         res:=TMatrices.Create(ma,na);
         if not ((ma=mb) and (na=nb))
         then
         begin
           //ShowMessage('no se puede sumar matrices de dimensiones diferentes');
           exit;
         end;
         for i:=0 to ma-1 do
             for j:=0 to na-1 do
                 begin
                   res.A[i,j]:=(A[i,j]+B.A[i,j]);
                 end;
         Result:=res;
    end;

    Function TMatrices.MResta(B:TMatrices) : TMatrices;
    var i,j,ma,na,mb,nb:integer ;
      res:TMatrices;
    begin
         ma:=Length(A);na:=Length(A[0]);
         mb:=Length(B.A);nb:=Length(B.A[0]);
         res:=TMatrices.Create(ma,na);

         if not ((ma=mb) and (na=nb))then exit;
         for i:=0 to ma-1 do
             for j:=0 to na-1 do
                 begin
                   res.A[i,j]:=(A[i,j]-B.A[i,j]);
                 end;
         Result:=res;
    end;

    Function TMatrices.MMultiplicacion(C:TMatrices;B:TMatrices) : TMatrices;
    var i,j,h,ma,na,mb,nb:integer ;
      res:TMatrices;
    begin
         ma:=Length(C.A);na:=Length(C.A[0]);
         mb:=Length(B.A);nb:=Length(B.A[0]);
         res:=TMatrices.Create(ma,nb);
         if not (na=mb)then exit;
         for i:=0 to ma-1 do
             for j:=0 to nb-1 do
             begin
                 res.A[i,j]:=0;
                 for h:=0 to na-1 do
                 begin
                   res.A[i,j]:=res.A[i,j]+(C.A[i,h]*B.A[h,j]);
                 end;
             end;
         Result:=res;
    end;

    Function TMatrices.MMultEscalar(B:TMatrices;n:Real) : TMatrices;
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
    Function TMatrices.MTranspuesta(B:TMatrices) : TMatrices;
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
    Function TMatrices.MSubMatriz(B:TMatrices;i:Integer;j:Integer): TMatrices;
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
    Function TMatrices.MDeterminante(B:TMatrices) : Real;
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
                   result:=result+s*B.A[0,k]*MDeterminante(MSubmatriz(B,0,k));
                   s:=s*-1;
              end;
         end;
    end;
    Function TMatrices.MAdjunta(B:TMatrices) : TMatrices;
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
                  temp:=MSubMatriz(B,i,j);;
                  res.A[i,j]:=s*MDeterminante(temp);
                  s:=s*(-1);
             end;
             s1:=s1*(-1);
         end;
         Result:=res;
    end;
    Function TMatrices.MInversa(B:TMatrices) : TMatrices;
    var   ma,na:Integer ;
          det:Real;
          adj,res:TMatrices;
    begin
         ma:=Length(B.A);na:=Length(B.A[0]);
         if not (ma=na)then exit;
         adj:=TMatrices.Create(ma,na);
         res:=TMatrices.Create(ma,na);
         adj:=MAdjunta(B);
         det:=MDeterminante(B);
         if det=0 then exit;

         adj:=MTranspuesta(adj);
         det:=1/det;
         res:=MMultEscalar(adj,det);
         Result:=res;
    end;

procedure TMatrices.GrillToMatrix(ma : TStringGrid);
var
  m,n,j,i:Integer;
begin
  m:=Length(A);n:=Length(A[0]);
  for j:=0 to m-1 do
    for i:=0 to n-1 do
      A[j,i]:=StrToFloat(ma.Cells[i,j]);
  //Result:=res;
end;

end.

