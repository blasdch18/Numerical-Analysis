unit ListaptrFloat;

{$mode objfpc}{$H+}

interface

uses
  Classes,math ,Dialogs, SysUtils;
type
  TListptrFloat =class
    private
      lista: TList;
    public
      constructor create;
      procedure push_float(val:float);
      procedure remove_float(index :Integer);
      function get_val(j:Integer):float;
      procedure set_val(j:Integer;val:float);
      function contenido():String;
end;

implementation
constructor  TListptrFloat.create;
begin
  lista:=TList.Create;
end;

procedure TListptrFloat.push_float(val:float);
var
  auxval:^float;
begin
  new(auxval);
  auxval^:=val;
  lista.Add(auxval);
end;

procedure TListptrFloat.remove_float(index :Integer);
begin
  lista.Delete(index);
end;

function TListptrFloat.get_val(j:Integer):float;
var
  val:^float;
begin
  val:=lista.Items[j];
  get_val:=val^;
end;

procedure TListptrFloat.set_val(j:Integer;val:float);
var
  auxval:^float;
begin
  new(auxval);
  auxval^:=val;
  if j> lista.Count-1 then
     ShowMessage('Excede en la columna, j='+IntToStr(j))
  else lista.Items[j]:=auxval;
end;

function TListptrFloat.contenido():String;
var
  conte:String;
  i:Integer;
  auxval:^float;
begin
  new(auxval);
  for i:=0 to lista.Count - 1 do
  begin
    auxval:=lista.Items[i];
    conte:=conte+FloatToStr(auxval^)+'#';
  end;
  contenido:=conte;
end;

end.
