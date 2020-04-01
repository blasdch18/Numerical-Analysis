unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Grids, StdCtrls,Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
   end;

var
  Form1: TForm1;
  A,B,Error,error2,anterior,funct,x,signo:Double;
  i,j:Integer;
  number, zero : Integer;

implementation

{$R *.lfm}

{ TForm1 }

Function funcion(x:Double):Double;
begin




     funct:=x*x-ln(x)*(2.71828183)**x;///(1/x)*((2.71828183)**(x-1))*((3*x*x)-4);
     //((3*x**2)/(1-x*x))+x;
     //(2.71828183**(x-1))*(3*(x**(2))-4)/x;

     //(x**3)+4*x*x-10;

  //(2.71828183**x)-cos(x);
 //  funct:=(x*x)-ln(x)*(2.71828183**x);
  //funct:=(1/x)*((2.71828183)**(x-1))*((3*x*x)-4);
  funcion:=funct;
end;

Function biyeccion(A:Double;B:Double):Double;
begin
  x:=(A+B)/2;
  biyeccion:=x;
end;

Function falsa_posicion(A:Double;B:Double):Double;
begin
  x:=A-((funcion(A)*(B-A))/(funcion(B)-funcion(A)));
  falsa_posicion:=x;
end;

function derivada(var x:Float):Float;
var
  h:Float;
Begin
  h:=0.000001;
  Derivada:=(funcion(x+h)-funcion(x))/h;
end;



procedure TForm1.Button1Click(Sender: TObject);
var tam:Integer;
begin


  // Try to divide an integer by zero - to raise an exception
 { number := -1;
  try
    zero   := 0;
    number := 1 div zero;
    //ShowMessage('number / zero = '+IntToStr(number));
  finally
      ShowMessage('Number was not assigned a value - using default');
      number := 0;

  end;
  }   {*
  try
    zero   := 0;
    number := 1 div zero;
    //ShowMessage('number / zero = '+IntToStr(number));
  except
    on E : Exception do
      ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
  end;


     *}



     B:=StrToFloat(Edit2.Text);
     A:=StrToFloat(Edit3.Text);
     Error:=StrToFloat(Edit1.Text);


     tam:=Length(FloatToStr(Error))-2;

     i:=1;

     error2:=50;
     signo:=-1;
     anterior:=0;

  while (error2>Error) do
  begin
        {
    try
     if funcion(A,f)=0 then
      begin
        Result.resString := FloatToStr(A);
        Exit;
      end;
     if funcion(B,f)=0 then
      begin
        Result.resString := FloatToStr(B);
        Exit;
      end;
    except
     Result.resString := 'NaN';
       Exit;
    end;  }
   if RadioButton1.Checked then
      x:=biyeccion(A,B)
   else
      x:=falsa_posicion(A,B);

    //    x:=RoundTo(falsa_posicion(A,B,f),-tam);

  StringGrid1.RowCount:=i+1;
  StringGrid1.Cells[0,i]:=IntToStr(i);
  StringGrid1.Cells[1,i]:=FormatFloat('0.00000',A);
  StringGrid1.Cells[2,i]:=FloatToStr(B);
  StringGrid1.Cells[3,i]:=FloatToStr(x);
  signo:=funcion(A)*funcion(x);
  StringGrid1.Cells[4,i]:=FloatToStr(signo);

  if i=1 then
    error2:=50
  else
      error2:=abs((anterior-x)/x);

  StringGrid1.Cells[5,i]:=FloatToStr(error2);
  anterior:=x;

  i:=i+1;
  if signo<0 then
    B:=x
  else
    A:=x;

  end;



  end;






procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
end;

end.

