unit matrizX;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, liblistptrlist,ListaptrFloat,Grids,math,Dialogs;

type
    TMatriz = class
    private
      listaM:TListptrList;
    public
      ccol : Integer;
      cfil : Integer;
      constructor create;
      procedure def_matriz(i:Integer;j:Integer); //MATRIX de 0    pseudo CTOR
      procedure salvar_matriz(grid : TStringGrid);   //           pseudo CTOR

      procedure set_element(i: Integer;j:Integer ;val :float );
      procedure asignar( matToCopy : TMatriz );
      function get_element(i:Integer;j:Integer):float;

      procedure rezise(jcol : Integer); //Incrementa a la derecha la matriz identidad
      procedure tomar_media_matriz();   //quita la matriz identid
      procedure redondear_vals(n_decim : Integer);
      procedure ident_matr(ij: Integer);
      procedure print_matriz(grid : TStringGrid);
      function multi_cruz(mat: TMatriz): float;
      function convColZero(mat : TMatriz; posPte:Integer; col: integer): TMatriz;

      //HACER UN DESTRUCTOR
end;

implementation
constructor TMatriz.create;
begin
    listaM :=TListptrList.Create;
    ccol:=0;
    cfil:=0;
end;
procedure TMatriz.def_matriz(i:Integer;j:Integer);
var
  plist_fl :^ TListptrFloat;
  i1 , j1 :Integer;

begin
    new (plist_fl);

    ccol:=j;
    cfil:=i;

     for i1:=0 to i-1 do
     begin
        plist_fl^:=TListptrFloat.create;
       for j1:=0 to j-1 do
       begin
           plist_fl^.push_float(0);
       end;
       listaM.push_list(plist_fl^);
     end;
end;


procedure TMatriz.salvar_matriz(grid : TStringGrid);
var
  i1,j1,i,j :Integer;
  plist_fl :^ TListptrFloat;
begin

  new (plist_fl);
  i1 := grid.RowCount;
  j1 := grid.ColCount;

  cfil:=i1;
  ccol:=j1;

  for i:=0 to i1-1 do
  begin
    plist_fl^:=TListptrFloat.create;

    for j:=0 to j1-1 do
    begin
        plist_fl^.push_float(StrToFloat(grid.Cells[j,i]));
    end;

    listaM.push_list(plist_fl^);
  end;

end;


procedure TMatriz.set_element(i: Integer;j:Integer ;val :float );
begin
    listaM.sub_list(i).set_val(j,val);
end;


function TMatriz.get_element(i:Integer;j:Integer):Float;
begin
    if (i<cfil) and (j<ccol)then
        get_element:=listaM.sub_list(i).get_val(j)
    else
      begin
           ShowMessage('La pos excede a matriz de '+IntToStr(ccol)+' i:'+ IntToStr(i)+' j: '+ IntToStr(j));
           get_element := -1;
      end;

end;


procedure TMatriz.asignar( matToCopy : TMatriz );
var
  i,j : Integer;
begin
     def_matriz(matToCopy.cfil, matToCopy.ccol);

     ShowMessage('eSTO DEBE SER != a 0' + IntToStr(matToCopy.ccol));
     for i:=0 to cfil-1 do
     begin
          for j:= 0 to ccol-1 do
          begin
            set_element(i,j,matToCopy.get_element(i,j));
          end;
     end;
end;

procedure TMatriz.rezise(jcol : Integer);  //Incrementa a la derecha la matriz identidad
var
  i,j, i1,j1 :Integer;
begin
  i := cfil;
  ccol := ccol+jcol;


  for i1 := 0 to i-1 do
  begin
    for j:=0 to jcol-1 do
    begin
      if i1 = j then
          listaM.sub_list(i1).push_float(1)
      else
          listaM.sub_list(i1).push_float(0);
    end;
  end;

end;

procedure TMatriz.tomar_media_matriz();
var
  i1,j1 : Integer;
  mat_aux :TMatriz;
begin
  mat_aux := TMatriz.create;

  for i1:=0 to cfil-1 do
  begin
    for j1:=0 to (ccol shr 1)-1 do
    begin
       ShowMessage( FloatToStr(listaM.sub_list(i1).get_val(j1)) );
       listaM.sub_list(i1).remove_float(0);
    end;
  end;
  ccol:= (ccol shr 1);
end;


procedure TMatriz.redondear_vals(n_decim : Integer);
var
  i , j : Integer;
begin
  for i := 0 to cfil -1 do
  begin
    for j := 0 to ccol-1 do
    begin
      set_element(i,j,RoundTo(get_element(i,j),-n_decim));
    end;
  end;
end;

procedure TMatriz.ident_matr(ij: Integer);
var
  plist_fl :^ TListptrFloat;
  i1 , j1 :Integer;

begin
    new (plist_fl);

    ccol:=ij;
    cfil:=ij;

     for j1:=0 to ij-1 do
     begin
        plist_fl^:=TListptrFloat.create;
       for i1:=0 to ij-1 do
       begin
           if i1=j1 then
           begin
             plist_fl^.push_float(1);
           end
           else
           begin
               plist_fl^.push_float(0);
           end;
       end;
       listaM.push_list(plist_fl^);
     end;
end;

procedure TMatriz.print_matriz(grid : TStringGrid);
var
  i1,j1 : Integer;
  //plist_fl :^ TListptrFloat;
begin
   grid.Clean;
   grid.ColCount:=ccol;
   grid.RowCount:=cfil;
   //ShowMessage('print col'+IntToStr(ccol)+' fil '+IntToStr(cfil));

   for i1 := 0 to cfil-1 do
   begin
     for j1:=0 to ccol-1 do
     begin
       grid.Cells[j1,i1]:=FloatToStr(listaM.sub_list(i1).get_val(j1));
     end;
   end;
end;


function TMatriz.multi_cruz(mat: TMatriz): float;
var
  mul_cruz :float;
begin
   if(mat.ccol=2) and (mat.cfil=2)then
   begin
       mul_cruz :=  mat.listaM.sub_list(0).get_val(0)*mat.listaM.sub_list(1).get_val(1);
       mul_cruz :=  mul_cruz - mat.listaM.sub_list(1).get_val(0)*mat.listaM.sub_list(0).get_val(1);
       multi_cruz := mul_cruz;
   end
   else
   begin
     ShowMessage('la matriz debe ser de orden 2');
     multi_cruz := -1;
   end;
end;


function TMatriz.convColZero(mat:TMatriz; posPte:Integer; col: integer): TMatriz;
var
  i,j: integer;
begin
     for i:=0 to mat.cfil-1 do
     begin
          if (i <> posPte) then
          begin
             mat.listaM.sub_list(i).set_val(col,0);
          end;
     convColZero:=mat;
     end;

end;



end.

