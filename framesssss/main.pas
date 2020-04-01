unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,
  theframeone,
  theframetwo;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    ActualFrame: Tframe;
    procedure TheButtonClic(Sender: TObject);

  private
    FrameSelected: Integer;
    procedure InstanFrame;

  public

  end;

var
  Form1: TForm1;

implementation

const IsFrame1 = 1;
      IsFrame2 = 2;

{$R *.lfm}

{ TForm1 }

procedure TForm1.InstanFrame;
begin
   if Assigned(ActualFrame) then
     ActualFrame.Free;

   case FrameSelected of
       IsFrame1: ActualFrame:= TTheFrame1.Create( Form1 );
       IsFrame2: ActualFrame:= TTheFrame2.Create( Form1 );
   end;

   ActualFrame.Parent:= Form1;
   ActualFrame.Align:= alClient;

end;

procedure TForm1.TheButtonClic(Sender: TObject);
begin
    FrameSelected:= TButton(Sender).Tag;
    InstanFrame;
end;


end.

