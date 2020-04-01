unit mainWindow;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
   mCalculator, mMatrix;

type

  { TForm1 }
  TForm1 = class(TForm)
    Evaluar: TButton;
    Ed_x: TEdit;
    Ed_Expresion: TEdit;
    GO: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    procedure EvaluarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GOClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    //procedure Create(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
   Form1: TForm1;
   MaxCalculator :TCalculator;
implementation


{$R *.lfm}

function matrixToStr(constref input : TMatrix) : string;
var
   i, j : integer;
   res :string;
   cols, rows : integer;
begin
   if (isSingle(input)) then
      Result := floatTostr(input[0][0])
   else
   begin
      rows := countRows(input);
      cols := countCols(input);
      res := sLineBreak;
      for i := 0 to rows - 1 do
      begin
         for j := 0 to cols - 1 do
         begin
            res += floatTostr(input[i][j]) + '  ';
         end;
         res += sLineBreak;
      end;
      Result:= res;
   end;
end;

procedure TForm1.GOClick(Sender: TObject);
begin

  Memo1.Lines.Add('--------------------------- ');
  Memo1.Lines.Add(Ed_Expresion.Text);
  Memo1.Lines.Add('   Ans. '+ matrixToStr(MaxCalculator.solveExpression(Ed_Expresion.Text)));
  //Ed_Expresion.Clear;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
   Memo1.SelStart:=Length(Memo1.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MaxCalculator:= TCalculator.create;
end;

procedure TForm1.EvaluarClick(Sender: TObject);
begin
  Memo1.Lines.Add('--------------------------- ');
  Memo1.Lines.Add('f(x) = '+Ed_Expresion.Text);
  Memo1.Lines.Add('  f('+Ed_x.Text+') =  '+ matrixToStr(MaxCalculator.solveSavedExpression(['x'], [StrToFloat(Ed_x.Text)])));
end;

end.
