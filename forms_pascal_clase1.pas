unit forms_pascal_clase1;

{with  Tbutton(sender) do begin   cas}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

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
    procedure BotonClic(Sender: TObject);
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

procedure TForm1.BotonClic(Sender: TObject);
begin
   if not (Sender is Tbutton) then
   exit;
   // ediA.Text:=ediA.Text + Caption;
   with TButton (sender) do begin
     ediA.Text:=ediA.Text + Caption;
   end;
end;


end.
