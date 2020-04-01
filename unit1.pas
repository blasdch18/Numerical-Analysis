unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ediA: TEdit;
    procedure Botonclic(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
     if not(sender is tbutton) then
     exit;
     //ediA.Text:=ediA.Text + Tbutton(sender).Caption;
     with TButton(sender)do begin

     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

