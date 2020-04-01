unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,
  FileUtil, Forms, Controls, ComCtrls,
  StdCtrls, ExtCtrls, Spin, Types,
  Grids,Dialogs, ParseMath, Lagrange_NewGen, Matriz,Matrices ;  //Matriz

type

  { TForm1 }

  TForm1 = class(TForm)
    Button10: TButton;
    Button11: TButton;
    Button6: TButton;
    ComboBox1: TComboBox;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit26: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label43: TLabel;
    Label48: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    StringGrid3: TStringGrid;
    StringGrid6: TStringGrid;
    StringGrid7: TStringGrid;
    StringGrid8: TStringGrid;
    StringGrid9: TStringGrid;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;

    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

    function f(x:Real;s: String):Real;
    procedure MatrizToGrill(m: TMatrices; res:TStringGrid);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit6Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure SpinEdit7Change(Sender: TObject);
    procedure TabSheet8ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  mn: TLagrange_NewGen;
  check: Boolean;
  i,j,u,v,fila,cont1,cont2: Integer;
  mat : TMatriz;
  matri : TMatrices;

implementation

{$R *.lfm}

{ TForm1 }


function TForm1.f(x : Real;s: String):Real;
var MiParse: TParseMath;
begin
  MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    check:=true;
    end;
  end;

  MiParse.destroy;
  //f:=power(x,2)-(ln(x)*exp(x));
  //f:=(x*ln(x))-x;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  i:=0;
  j:=0;
  cont1:=0;
  cont2:=0;
  u:=0;
  v:=0;
  fila:=1;
  ComboBox1.Items.Clear;
  ComboBox1.Items.Add('Suma');
  ComboBox1.Items.Add('Resta');
  ComboBox1.Items.Add('Escalar');
  ComboBox1.Items.Add('Multiplicar');
  ComboBox1.Items.Add('Inversa');
  ComboBox1.Items.Add('Transpuesta');
  ComboBox1.Items.Add('Determinante');
  //ComboBox1.Items.Add('Jacobiana');
  GroupBox1.Enabled:=False;
  GroupBox2.Enabled:=False;
  Edit16.Enabled:=False;



end;

procedure TForm1.SpinEdit7Change(Sender: TObject);
begin


end;

procedure TForm1.TabSheet8ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.SpinEdit5Change(Sender: TObject);
begin
  fila:=1;
  StringGrid9.Clear;
  StringGrid9.ColCount:=SpinEdit5.Value+1;
  StringGrid9.Cells[0,0]:='X';
  StringGrid9.Cells[0,1]:='Y';

end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  cont1:=0; i:=0;j:=0;
  StringGrid6.Clear;
  StringGrid6.ColCount:=SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
  cont1:=0; i:=0;j:=0;
  StringGrid6.Clear;
  StringGrid6.RowCount:=SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4Change(Sender: TObject);
begin
  cont2:=0; u:=0;v:=0;
  StringGrid7.Clear;
  StringGrid7.RowCount:=SpinEdit4.Value;
end;

procedure TForm1.SpinEdit6Change(Sender: TObject);
begin
  cont2:=0; u:=0;v:=0;
  StringGrid7.Clear;
  StringGrid7.ColCount:=SpinEdit6.Value;
end;

procedure TForm1.Button6Click(Sender: TObject);
var a,b,c :TMatrices;
  d:Real;
begin
  if ComboBox1.Text='Suma' then
  begin
    //mat.suma(StringGrid6,StringGrid7,StringGrid3);
     a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     b := TMatrices.Create(StringGrid7.RowCount,StringGrid7.ColCount);
     a.GrillToMatrix(StringGrid6);
     b.GrillToMatrix(StringGrid7);
     c:= TMatrices.Create(StringGrid7.RowCount,StringGrid7.ColCount);
     c:=a.MSuma(b);
     MatrizToGrill(c,StringGrid3);
  end;
  if ComboBox1.Text='Resta' then
  begin
    //mat.resta(StringGrid6,StringGrid7,StringGrid3);
     a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     b := TMatrices.Create(StringGrid7.RowCount,StringGrid7.ColCount);
     a.GrillToMatrix(StringGrid6);
     b.GrillToMatrix(StringGrid7);
     c:= TMatrices.Create(StringGrid7.RowCount,StringGrid7.ColCount);
     c:=a.MResta(b);
     MatrizToGrill(c,StringGrid3);
  end;

  if ComboBox1.Text='Multiplicar' then
  begin
     a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     b := TMatrices.Create(StringGrid7.RowCount,StringGrid7.ColCount);
     a.GrillToMatrix(StringGrid6);
     b.GrillToMatrix(StringGrid7);
     c:= TMatrices.Create(StringGrid6.RowCount,StringGrid7.ColCount);
     c:=a.MMultiplicacion(a,b);
     MatrizToGrill(c,StringGrid3);
  end;
  if ComboBox1.Text='Escalar' then
  begin
   //mat.escalar(StringGrid6,StrToFloat(Edit16.Text),StringGrid3);
     a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     a.GrillToMatrix(StringGrid6);
     c:= TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     c:=a.MMultEscalar(a,StrToFloat(Edit16.Text));
     MatrizToGrill(c,StringGrid3);
  end;

  if ComboBox1.Text='Inversa' then
  begin
    //mc:=StringGrid6;
    if StringGrid6.RowCount=StringGrid6.ColCount then
    begin
       //mat.inversa(StringGrid6,StringGrid3)
       a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
       a.GrillToMatrix(StringGrid6);
       c:= TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
       c:=a.MInversa(a);
       MatrizToGrill(c,StringGrid3);
    end
    else
       ShowMessage('La matriz tiene que ser cuadrada');
    //StringGrid6:=mc;
  end;
  if ComboBox1.Text='Transpuesta' then
  begin
    //mat.transpuesta(StringGrid6,StringGrid3);
     a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     a.GrillToMatrix(StringGrid6);
     c:= TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     c:=a.MTranspuesta(a);
     MatrizToGrill(c,StringGrid3);
  end;

  if ComboBox1.Text='Determinante' then
  begin
     //mat.determinant(StringGrid6,StaticText1);
    //StaticText1.Caption:=FloatToStr(mat.determinante(StringGrid6));
     a := TMatrices.Create(StringGrid6.RowCount,StringGrid6.ColCount);
     a.GrillToMatrix(StringGrid6);
     d:=a.MDeterminante(a);
     StaticText1.Caption:=FloatToStr(d);
  end;
 (* if ComboBox1.Text='Jacobiana' then
  begin
  end; *)

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Edit16.Enabled:=False;
  GroupBox2.Enabled:=False;
  GroupBox1.Enabled:=True;

  if (ComboBox1.Text='Suma')or(ComboBox1.Text='Resta')or(ComboBox1.Text='Multiplicar') then
  begin
    GroupBox2.Enabled:=True;
  end;

  if ComboBox1.Text='Escalar' then
  begin
    Edit16.Enabled:=True;
  end;
end;



procedure TForm1.Button10Click(Sender: TObject);
begin
  StaticText2.Caption:=FloatToStr(mn.Lagrange(StringGrid9,StrToFloat(Edit20.Text),StaticText4));
  Memo1.Text:= StaticText4.Caption;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  xo,xi:Real;
  fx,fy:String;
begin
  xo:=StrToFloat(Edit22.Text);
  xi:=StrToFloat(Edit23.Text);
  fx:=Edit17.Text;
  fy:=Edit21.Text;
  mn.NewtonGeneralizado(xo,xi,fx,fy,StrToFloat(Edit26.Text),StringGrid8);
end;


procedure TForm1.MatrizToGrill(m : TMatrices; res:TStringGrid);
var
  ma,na :Integer;
begin
  ma:=Length(m.A);na:=Length(m.A[0]);
  res.RowCount:=ma; res.ColCount:=na;
  for i:=0 to ma-1 do
    for j:=0 to na-1 do
      res.Cells[j,i]:=FloatToStr(m.A[i,j]);
end;


end.

