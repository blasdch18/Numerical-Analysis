unit form_taylor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    StringGrid1: TStringGrid;
    procedure botonclicked(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);

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

function abso(xi:Double ):Double;
var i:Integer;
  sum:Double;
begin
 if xi<0 then abso:=xi*(-1)
 else
     abso:=xi;
end;

function factorial(xi:Integer):Double;
var i:Integer;
  sum:Double;
begin
  sum:=1;
  for i:=2 to xi do
  begin
    sum:=sum*i;
  //  ShowMessage(FloatToStr(sum));
  end;
  factorial:=sum;
end;

function pow(x:Double;y:Integer ):Double;
var i:Integer;
  sum:Double;
begin
  sum:=1;
  for i:=1 to y do
  begin
    sum:=sum*x;
  end;
   // ShowMessage(FloatToStr(sum));
  pow:=sum;

end;

function GradtoRad(x:Double):Double;
begin
  GradtoRad:=x*(3.1416/180);
end;


function Eabsoluto(x,xa:Double):Double;
var
  error:Double;
begin
  error:=abso(x-xa);
  Eabsoluto:=error;
end;

function Erelativo(x,xa:Double):Double;
var
  error:Double;
begin
  error:=abso((x-xa)/x);
  Erelativo:=error;
end;

procedure TForm1.botonclicked(Sender: TObject);
var x,error,error1,error2,sum,valor:Double;
  i:Integer;

begin
  error2:=50;
  error:=0;
  sum:=0;
  i:=0;
  x:= StrToFloat(Edit1.Text);
  error:=StrToFloat(Edit2.Text);

  {primera iteracion}
  if RadioButton1.Checked then
  begin
  {senx}
  sum:=sum+(power(-1,i)/factorial(2*i+1))*power(x,2*i+1);
  valor:=sin(x);
  end;
  if RadioButton2.Checked then
  begin
  {e^x}
  sum:=sum+(pow(x,i)/factorial(i));
  valor:=exp(x);
  end;
  if RadioButton3.Checked then
  begin
  {cos (x)}
  sum:=sum+(power(-1,i)/factorial(2*i))*power(x,2*i);
  valor:=cos(x);
  end;
  if RadioButton4.Checked then
  begin
  {Ln (1+x)}
  i:= 1;
  sum:=sum+((power(-1,i+1))*((power(x,i))/i));
  valor:=Ln(1+x);
  end;
  if RadioButton5.Checked then
  begin
  {Ln (1+x)}
  i:= 1;
  sum:=sum+((power(-1,i+1))*((power(x,i))/i));
  valor:=Ln(1+x);
  end;


  StringGrid1.RowCount:=i+2;
  StringGrid1.Cells[0,i+1]:=FloatToStr(i);
  StringGrid1.Cells[1,i+1]:=FloatToStr(sum);
//  StringGrid1.Cells[1,i+1]:=FormatFloat('0.0000',sum);

  StringGrid1.Cells[2,i+1]:=FloatToStr(Eabsoluto(valor,sum));
 // StringGrid1.Cells[2,i+1]:=FormatFloat('0.0000',Eabsoluto(valor,sum));

  StringGrid1.Cells[3,i+1]:=FloatToStr(Erelativo(valor,sum));
 // StringGrid1.Cells[3,i+1]:=FormatFloat('0.0000',Erelativo(valor,sum));


  StringGrid1.Cells[4,i+1]:=FloatToStr(Erelativo(valor,sum)*100);
  //StringGrid1.Cells[4,i+1]:=FormatFloat('0.0000',Erelativo(valor,sum)*100);



  i:=i+1;

  error1:=sum;

  while error2>=error do
  begin
    if RadioButton1.Checked then
    {senx}
    sum:= sum+(pow(-1,i)/factorial(2*i+1))*pow(x,2*i+1);
    if RadioButton2.Checked then
    {e**X}
    sum:=sum+(pow(x,i)/factorial(i));


    StringGrid1.RowCount:=StringGrid1.RowCount+1;

    StringGrid1.Cells[0,i+1]:=FloatToStr(i);
    StringGrid1.Cells[1,i+1]:=FloatToStr(sum);
 //   StringGrid1.Cells[1,i+1]:=FormatFloat('0.00000',sum);

    StringGrid1.Cells[2,i+1]:=FloatToStr(Eabsoluto(valor,sum));
    StringGrid1.Cells[3,i+1]:=FloatToStr(Erelativo(valor,sum));
    StringGrid1.Cells[4,i+1]:=FloatToStr(Erelativo(valor,sum)*100);

{    StringGrid1.Cells[2,i+1]:=FormatFloat('0.00000',Eabsoluto(valor,sum));
    StringGrid1.Cells[3,i+1]:=FormatFloat('0.00000',Erelativo(valor,sum));
    StringGrid1.Cells[4,i+1]:=FormatFloat('0.00000',Erelativo(valor,sum)*100);}

    StringGrid1.Cells[5,i+1]:=FloatToStr(Eabsoluto(error1,sum));
    StringGrid1.Cells[6,i+1]:=FloatToStr(Erelativo(error1,sum));
    StringGrid1.Cells[7,i+1]:=FloatToStr(Erelativo(error1,sum)*100);

{    StringGrid1.Cells[5,i+1]:=FormatFloat('0.00000',Eabsoluto(error1,sum));
    StringGrid1.Cells[6,i+1]:=FormatFloat('0.00000',Erelativo(error1,sum));
    StringGrid1.Cells[7,i+1]:=FormatFloat('0.00000',Erelativo(error1,sum)*100);}

    error2:=Eabsoluto(error1,sum);
    error1:=sum;
    i:=i+1;


  end;



end;

procedure TForm1.RadioButton4Change(Sender: TObject);
begin

end;


                                end.
