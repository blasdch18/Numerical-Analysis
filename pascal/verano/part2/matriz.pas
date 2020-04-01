unit Matriz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids, Dialogs, Math,
  FileUtil, Forms, Controls, ComCtrls,StdCtrls, ExtCtrls, Spin, Types;

type
    TMatriz=class
    det : Real;
    public
      Constructor Create();
      procedure suma(ma: TStringGrid;mb: TStringGrid; res:TStringGrid);
      procedure resta(ma: TStringGrid;mb: TStringGrid; res:TStringGrid);
      procedure escalar(ma: TStringGrid; x:Real; res:TStringGrid);
      procedure multiplicar(ma: TStringGrid;mb: TStringGrid; res:TStringGrid);
      procedure transpuesta(ma: TStringGrid; res:TStringGrid);
      function determinante(ma: TStringGrid):Real;
      procedure determinant(ma: TStringGrid;text:TStaticText);
      function determinante2(Mat: TStringGrid):Real;
      procedure swapm(ma: TStringGrid;i:Integer; j:Integer);
      function lmc(x:Real; y:Real):Real;
      //function determinante1(ma: TStringGrid;orden: Integer):Real;
      procedure inversa(ma: TStringGrid; res:TStringGrid);

    end;

implementation
Constructor  TMatriz.Create();
begin
  det := 0;
end;

procedure TMatriz.suma(ma: TStringGrid;mb: TStringGrid; res:TStringGrid);
var
  i,j:Integer;
begin
  if (ma.RowCount=mb.RowCount) and (ma.ColCount=mb.ColCount) then
  begin
    res.RowCount:=ma.RowCount;
    res.ColCount:=ma.ColCount;
    for j:=0 to res.RowCount-1 do
    begin
      for i:=0 to res.ColCount-1 do
      begin
          res.Cells[i,j]:=FloatToStr(StrToFloat(ma.Cells[i,j])+StrToFloat(mb.Cells[i,j]));
      end;
    end;
    Exit;
  end;
  ShowMessage('Las matrices no son de igual tamaño');
end;

procedure TMatriz.resta(ma: TStringGrid;mb: TStringGrid; res:TStringGrid);
var
  i,j:Integer;
begin
  if (ma.RowCount=mb.RowCount) and (ma.ColCount=mb.ColCount) then
  begin
    res.RowCount:=ma.RowCount;
    res.ColCount:=ma.ColCount;
    for j:=0 to res.RowCount-1 do
    begin
      for i:=0 to res.ColCount-1 do
      begin
          res.Cells[i,j]:=FloatToStr(StrToFloat(ma.Cells[i,j])-StrToFloat(mb.Cells[i,j]));
      end;
    end;
    Exit;
  end;
  ShowMessage('Las matrices no son de igual tamaño');
end;

procedure TMatriz.multiplicar(ma: TStringGrid;mb: TStringGrid; res:TStringGrid);
var
  i,j,l:Integer;
begin
  if (ma.ColCount=mb.RowCount) then
  begin
    res.RowCount:=ma.RowCount;
    res.ColCount:=mb.ColCount;
    for i:=0 to res.RowCount-1 do
    begin
      for j:=0 to res.ColCount-1 do
      begin
        res.Cells[j,i]:=FloatToStr(0);
        for l:=0 to ma.ColCount-1 do
        begin
            res.Cells[j,i]:=FloatToStr(StrToFloat(res.Cells[j,i])+(StrToFloat(ma.Cells[l,i])*StrToFloat(mb.Cells[j,l])));
        end;
      end;
    end;
    Exit;
  end;
  ShowMessage('Las matrices no se pueden multiplicar');
end;

procedure TMatriz.escalar(ma: TStringGrid;x: Real; res:TStringGrid);
var
  i,j:Integer;
begin
  res.RowCount:=ma.RowCount;
  res.ColCount:=ma.ColCount;
  for j:=0 to res.RowCount-1 do
  begin
      for i:=0 to res.ColCount-1 do
      begin
          res.Cells[i,j]:=FloatToStr(StrToFloat(ma.Cells[i,j])*x);
      end;
  end;

end;

procedure TMatriz.transpuesta(ma: TStringGrid; res:TStringGrid);
var
  i,j:Integer;
begin
  res.RowCount:=ma.ColCount;
  res.ColCount:=ma.RowCount;
  for j:=0 to res.RowCount-1 do
  begin
      for i:=0 to res.ColCount-1 do
      begin
          res.Cells[i,j]:=ma.Cells[j,i];
      end;
  end;

end;

function TMatriz.determinante(ma: TStringGrid):Real;
var
  i,j,k,l:Integer;
  dete:Real;
  x: TStringGrid;
begin
  x:=ma;
//  x.ColCount:=ma.ColCount;
//  x.RowCount:=ma.RowCount;
  if x.RowCount=x.ColCount then
  begin
    if((x.RowCount mod 2) = 0)then
    begin
      result:=(StrToFloat(ma.Cells[0,0])*StrToFloat(ma.Cells[1,1]))-(StrToFloat(ma.Cells[1,0])*StrToFloat(ma.Cells[0,1]));
      exit;
    end;
    dete:=StrToFloat(x.Cells[0,0]);
    for k:=0 to x.RowCount-2 do
    begin
       l:=k+1;
       for i:=l to x.RowCount-1 do
         for j:=l to x.RowCount-1 do
            x.Cells[j,i]:=FloatToStr((StrToFloat(x.Cells[k,k])*StrToFloat(x.Cells[j,i])-StrToFloat(x.Cells[j,k])*StrToFloat(x.Cells[k,i]))/StrToFloat(x.Cells[k,k]));
       dete:=dete*StrToFloat(x.Cells[k+1,k+1]);
    end;
    Result:=dete;
    Exit;
  end;
  ShowMessage('Las matriz no es cuadrada');
  Result:=0;
end;

procedure TMatriz.swapm(ma: TStringGrid;i:Integer; j:Integer);
var
  n,c:Integer;
  valor:String;
begin
  n:=ma.RowCount;
  for c:=0 to n-1 do
  begin
     valor:=ma.Cells[c,i];
     ma.Cells[c,i]:=ma.Cells[c,j];
     ma.Cells[c,j]:=valor;
  end;

end;

function TMatriz.lmc(x:Real; y:Real):Real;
var
  t:Real;
begin
  while y<>0 do
  begin
   t:=y;
   y:=x-(y*(x/y));
   x:=t;
  end;
  Result:=x;
end;

procedure TMatriz.determinant(ma: TStringGrid; text:TStaticText);
var
  i,j,k,l,n,c,p:Integer;//l
  d1,d2:Real;
  res,del:Real;
  valor:String;
  b:Boolean;
begin
  n:=ma.RowCount;
  if ma.RowCount=ma.ColCount then
  begin
    (*for i:=0 to n-1 do
    begin
       for j:=i+1 to n do
       begin
          l:=lmc(StrToFloat(ma.Cells[i,i]),StrToFloat(ma.Cells[i,j]));
          if (l<>0) and (ma.Cells[i,i]<>'0') and (ma.Cells[i,j]<>'0') then
          begin
            l:=StrToFloat(ma.Cells[i,i])*StrToFloat(ma.Cells[i,j])/1;
            d1:=1/StrToFloat(ma.Cells[i,i]);
            d2:=1/StrToFloat(ma.Cells[i,j]);
            ma.Cells[i,j]:='0';
            for k:=i+1 to n do
                ma.Cells[k,j]:=FloatToStr((d2*StrToFloat(ma.Cells[k,j]))-(d1*StrToFloat(ma.Cells[k,i])));

          end;

       end;
    end; *)  /////  anterior
    for i:=0 to n-1 do
    begin
       b:=False;
       for j:=i to n-1 do
         if (ma.Cells[i,j]='0') then
         begin
              for c:=0 to n-1 do
              begin
                 valor:=ma.Cells[c,i];
                 ShowMessage('Vengo a cambiar filas'+valor+'con'+ma.Cells[c,j+1]);
                 ma.Cells[c,i]:=ma.Cells[c,j+1];
                 ma.Cells[c,j+1]:=valor;
              end;
             b:=True;
             Break;

         end;

       if not b then
       begin
         text.Caption:='0';
         Exit;
       end;

       for l:=i+1 to n-1 do
       begin
          while True do
          begin
          del:= StrToFloat(ma.Cells[i,l])/StrToFloat(ma.Cells[i,i]);
          for k:=i to n-1 do
              ma.Cells[k,l]:=FloatToStr(StrToFloat(ma.Cells[k,l])-(del*StrToFloat(ma.Cells[k,i])));
          if ma.Cells[i,l]='0' then Break
          else
              for c:=0 to n-1 do
              begin
                 valor:=ma.Cells[c,i];
                 ma.Cells[c,i]:=ma.Cells[c,l+1];
                 ma.Cells[c,l+1]:=valor;
              end;
          end;
       end;
    end;

    res:=1;
    for i:=0 to n-1 do
        res:=res*StrToFloat(ma.Cells[i,i]);
    text.Caption:=FloatToStr(abs(res));
    Exit;
  end;
  ShowMessage('Las matriz no es cuadrada');
end;

function TMatriz.determinante2(Mat: TStringGrid):Real;
var
   aux : Real;
   ii, jj, k, l, c : Integer;
   B : TStringGrid;
begin
   ii:= mat.RowCount;
   if((ii mod 2) = 0)then
     begin
       result:=(StrToFloat(Mat.Cells[0,0])*StrToFloat(Mat.Cells[1,1]))-(StrToFloat(Mat.Cells[1,0])*StrToFloat(Mat.Cells[0,1]));
       exit;
     end
   else
   begin
      for jj := 0 to ii-1 do
      begin
          B:=Mat;
          for  k := 1 to ii-1 do
          begin
             c:=0;
             for l := 0 to ii-1 do
                 if not(l=jj) then
                 begin
                    B.Cells[k-1,c] := Mat.Cells[k,l];
                    c := c +1;
                 end ;
          end;
          aux := power(-1,2+jj)* StrToFloat(Mat.Cells[0,jj])* determinante2(B);
          det := det + aux;
      end;
   end  ;
    result := det;
end;

procedure TMatriz.inversa(ma: TStringGrid; res:TStringGrid);
var
  nc,c,i,j,a,dim:Integer;
  pivot,v1,v2:Real;
begin
  res.RowCount:=ma.RowCount;
  res.ColCount:=ma.ColCount;
  dim:= res.RowCount;
  for i:=0 to dim-1 do
  begin
      for j:=0 to dim-1 do
      begin
          if i=j then
             res.Cells[j,i]:=FloatToStr(1)
          else
             res.Cells[j,i]:=FloatToStr(0);
      end;
  end;

  for c:=0 to dim-1 do
  begin
    nc:=0;
    a:=c;
    while nc=0 do
    begin
      if (StrToFloat(ma.Cells[c,a])> 0.0000001) or (StrToFloat(ma.Cells[c,a])< -0.0000001) then
         nc:=1
      else a:=a+1;
    end;
    pivot:=StrToFloat(ma.Cells[c,a]);
    for i:=0 to dim-1 do
    begin
      v1:=StrToFloat(ma.Cells[i,a]);
      ma.Cells[i,a]:=ma.Cells[i,c];
      ma.Cells[i,c]:=FloatToStr(v1/pivot);

      v2:=StrToFloat(res.Cells[i,a]);
      res.Cells[i,a]:=res.Cells[i,c];
      res.Cells[i,c]:=FloatToStr(v2/pivot);
    end;
    for j:=c+1 to dim-1 do  //
    begin
      v1:=StrToFloat(ma.Cells[c,j]);
      for i:=0 to dim-1 do
      begin
        ma.Cells[i,j]:=FloatToStr(StrToFloat(ma.Cells[i,j])-v1*StrToFloat(ma.Cells[i,c]));
        res.Cells[i,j]:=FloatToStr(StrToFloat(res.Cells[i,j])-v1*StrToFloat(res.Cells[i,c]));
      end;
    end;
  end;
  for c:=dim-1 downto 0 do
  for i:=c-1 downto 0 do       //
  begin
    v1:=StrToFloat(ma.Cells[c,i]);
    for j:=0 to dim-1 do
    begin
      ma.Cells[j,i]:=FloatToStr(StrToFloat(ma.Cells[j,i])-v1*StrToFloat(ma.Cells[j,c]));
      res.Cells[j,i]:=FloatToStr(StrToFloat(res.Cells[j,i])-v1*StrToFloat(res.Cells[j,c]));
    end;
  end;
end;

end.


