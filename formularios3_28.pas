unit formularios3_28;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    EdiA: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    procedure Botonclic(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Botonclic(Sender: TObject);
begin
  if not (sender is TButton) then
    exit;
  with TButton(sender) do begin
    ediA.Text:=ediA.Text+Caption;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

end.
