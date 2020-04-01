unit funciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, LCLType;

type

  { TfrmFunciones }

  TfrmFunciones = class(TForm)
    StringGrid1: TStringGrid;
    procedure ediFuncionChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: char);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmFunciones: TfrmFunciones;

implementation

{$R *.lfm}

{ TfrmFunciones }

procedure TfrmFunciones.ediFuncionChange(Sender: TObject);
begin

end;

procedure TfrmFunciones.FormResize(Sender: TObject);
begin
  with StringGrid1 do
       Columns[ 1 ].Width:= Width - Columns[ 0 ]. Width - 10 ;
end;

procedure TfrmFunciones.StringGrid1KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TfrmFunciones.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // if Key = VK_RETURN then
 //    StringGrid1.RowCount:= StringGrid1.RowCount + 1;
end;

end.

