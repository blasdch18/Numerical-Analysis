unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  StdCtrls, LCLType, ExtCtrls, ColorBox, ComCtrls, Grids, ParseMath, TASeries,
  TAFuncSeries, TARadialSeries, TATools, Types, Math, EditBtn, IntersectedFunctions,
  MetodosCerrados, MetodosAbiertos;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Chart1: TChart;
    Chart1ConstantLine1: TConstantLine;
    Chart1ConstantLine2: TConstantLine;
    Chart1LineSeries1: TLineSeries;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    ChartToolset1ZoomMouseWheelTool2: TZoomMouseWheelTool;
    colorbtnFunction: TColorButton;
    ediMax: TEdit;
    ediMin: TEdit;
    ediStep: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    DerivadaNow: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    h_x: TMemo;
    ImagesY: TMemo;
    LagrangeRoots: TMemo;
    Roots: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    IntersectedDots: TLineSeries;
    StringGrid1: TStringGrid;

    //IntersectedFunctions: TIntersectedFunctions;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TrackBar1: TTrackBar;
    trbarVisible: TTrackBar;


    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ClearClick(Sender: TObject);

    procedure IntersectionClick(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);

    procedure FormDestroy(Sender: TObject);
    procedure FunctionSeriesCalculate(const AX: Double; out AY: Double);
    procedure FormShow(Sender: TObject);
    procedure FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure trbarVisibleChange(Sender: TObject);

    procedure CleanStringGrid;
    procedure ExecuteClick(Sender: TObject);
    procedure execute_MCerrados;
    procedure execute_MAbiertos;




  private
    FunctionList,
    EditList: TList;
    ActiveFunction: Integer;
    min,
    max: Real;
    Parse  : TparseMath;
    function f( x: Real ): Real;
    function fxx(x : double; s: String):Real;
    procedure CreateNewFunction;
    procedure Graphic2D;
    procedure TagRoots;

  public

  end;

var
  Form1: TForm1;

implementation

const
  FunctionEditName = 'FunctionEdit';
  FunctionSeriesName = 'FunctionLines';

     col_n = 0;
     col_a = 1;
     col_b = 2;
     col_sgn = 3;
     col_Xn = 4;
     col_error = 5;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CleanStringGrid;
  FunctionList:= TList.Create;
  EditList:= TList.Create;
  min:= -5.0;
  max:= 5.0;
  Parse:= TParseMath.create();
  Parse.AddVariable('x', min);

end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;


procedure TForm1.trbarVisibleChange(Sender: TObject);
begin
  Self.AlphaBlendValue:= trbarVisible.Position;
end;

function TForm1.f( x: Real ): Real;
begin
  //func:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.Expression:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.NewValue('x', x);
  Result:= Parse.Evaluate();
end;

function TForm1.fxx(x : double; s: String):Real;
var MiParse: TParseMath;
begin
  MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  //check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    //ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    //check:=true;
    end;
  end;

  MiParse.destroy;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Parse.destroy;
  FunctionList.Destroy;
  EditList.Destroy;
end;

procedure TForm1.ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
  APoint: TPoint) ;
  var
  x, y: Double;
begin
  with ATool as TDatapointClickTool do
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        x := GetXValue(PointIndex);
        y := GetYValue(PointIndex);
        ListBox1.AddItem(TEdit(EditList.Items[Tag]).Caption, TEdit(EditList.Items[Tag]));
        Statusbar1.SimpleText := Format('%s: x = %f, y = %f', [TEdit(EditList.Items[Tag]).Caption, x, y]);
      end
    else
      Statusbar1.SimpleText := 'x';
end;

procedure TForm1.IntersectionClick(Sender: TObject);
var
funcion1, funcion2: string;
Yn: TStringList;
i: Integer;
operations: TIntersectedFunctions;
res: double;
begin
  if (ListBox1.Count < 2) then
       Exit;

    operations := TIntersectedFunctions.create();
    Yn := TStringList.Create();
    funcion1:= ListBox1.Items[ListBox1.Count-2];
    funcion2:= ListBox1.Items[ListBox1.Count-1];
    h_x.Lines.add( funcion1 + '-(' + funcion2+')');
    edit4.Text:=h_x.Lines[1];


end;

procedure TForm1.ClearClick(Sender: TObject);
begin
     ListBox1.Clear;
     h_x.clear;
     Roots.Clear;
     ImagesY.clear;
     LagrangeRoots.Clear;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.Button4Click(Sender: TObject);
var i: integer ;
test:double;
begin
  i:=0;
  for i:= 1 to 6 do
  begin
       LagrangeRoots.Lines.Add( FormatFloat('0.00000', fxx(i,edit4.text) ) );
    end;
end;

procedure TForm1.CleanStringGrid;
begin
  with StringGrid1 do begin
    Clean;
    RowCount:= 1;
    Columns[ col_n ].Title.Caption:= 'n';
    Columns[ col_a ].Title.Caption:= 'a';
    Columns[ col_b ].Title.Caption:= 'b';
    Columns[ col_sgn ].Title.Caption:= 'Sgn';
    Columns[ col_Xn ].Title.Caption:= 'Xn';
    Columns[ col_error ].Title.Caption:= 'Error';
  end;
end;

procedure TForm1.ExecuteClick(Sender: TObject);

begin
   if (RadioGroup1.ItemIndex=0) or (RadioGroup1.ItemIndex=1) then
     execute_MCerrados;

  if (RadioGroup1.ItemIndex=2) or (RadioGroup1.ItemIndex=3) then
   // showmessage('ho');
     execute_MAbiertos;

end;

procedure TForm1.execute_MCerrados;
var Metodo: TMetodosCerrados;
begin

  edimin.text:= FloatToStr( (StrToFloat( edimin.Text )+0.001) );
  Metodo := TMetodosCerrados.create;
  Metodo.casotype:= RadioGroup1.ItemIndex;
  Metodo.funcion:=Edit4.Text;// h_x.Lines[1];
  Metodo.tracker:= StrToFloat( Edit3.Text );
//  Metodo.funcion:= edit2.text;
  //ShowMessage(trim(h_x.Text)) ;            exe
  Metodo.a:= StrToFloat( EdiMin.Text );
  Metodo.b:= StrToFloat( EdiMax.Text );
  Metodo.Error1:= StrToFloat( Edit1.Text );
  Label1.Caption:= RadioGroup1.Items [ RadioGroup1.ItemIndex ]
                   + ' Xn = ' +
                   FloatToStr( Metodo.execute );
  Roots.Lines.add(FormatFloat('0.00000', Metodo.execute ));
  ImagesY.Lines.add(FormatFloat('0.00000', f( Metodo.execute ) ));

  edimin.text:=  FormatFloat('0.00000', (Metodo.execute) +0.001)  ;

  StringGrid1.RowCount:= Metodo.Lxn.Count;
  StringGrid1.RowCount:= Metodo.La.Count;
  StringGrid1.RowCount:= Metodo.Lb.Count;
  StringGrid1.RowCount:= Metodo.Lsgn.Count;
  StringGrid1.RowCount:= Metodo.Lerr.Count;

  StringGrid1.Cols[ col_Xn ].Assign( Metodo.Lxn );
  StringGrid1.Cols[ col_n ].Assign( Metodo.Li );
  StringGrid1.Cols[ col_a ].Assign( Metodo.La );
  StringGrid1.Cols[ col_b ].Assign( Metodo.Lb );
  StringGrid1.Cols[ col_sgn ].Assign( Metodo.Lsgn );
  StringGrid1.Cols[ col_error ].Assign( Metodo.Lerr );

  Metodo.Destroy;

end;

procedure TForm1.execute_MAbiertos;
var Metodo2: TMetodosAbiertos;
begin
  Metodo2 := TMetodosAbiertos.create;
  Metodo2.casotype := RadioGroup1.ItemIndex;
  Metodo2.funcion:= edit2.text;
  Metodo2.funcionDerivada:= DerivadaNow.text;
  Metodo2.error1:= StrToFloat( edit1.text );
  //ShowMessage('X0='+ Metodo2.x0);
  Metodo2.x0:=StrToFloat(ediMin.Text);
//  ShowMessage('X0='+ floattostr(Metodo2.x0)) //;               paso
  Label1.Caption:= RadioGroup1.Items [ RadioGroup1.ItemIndex ]
                   + ' Xn = ' +
                   FloatToStr( Metodo2.execute );

  Roots.Lines.add(FormatFloat('0.00000', Metodo2.execute ));
  ImagesY.Lines.add(FormatFloat('0.00000', f( Metodo2.execute ) ));

//  ShowMessage('hola'+ IntToStr(Metodo2.Lerr.Count) );
  StringGrid1.RowCount:= Metodo2.Lxn.Count;
  StringGrid1.RowCount:= Metodo2.Lerr.Count;

  StringGrid1.Cols[ col_n ].Assign( Metodo2.Li );
  StringGrid1.Cols[ col_Xn ].Assign( Metodo2.Lxn );
  StringGrid1.Cols[ col_error ].Assign( Metodo2.Lerr );

  metodo2.destroy;
end;

procedure TForm1.TagRoots;
var
i: integer;
begin
  //for i:=1 to 6 do


end;

procedure TForm1.FunctionSeriesCalculate(const AX: Double; out AY: Double);
begin
   // AY:= f( AX )

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  CreateNewFunction;
end;

procedure TForm1.FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if not (key = VK_RETURN) then
     exit;

   with TEdit( Sender ) do begin
       ActiveFunction:= Tag;
       Graphic2D;
       if tag = EditList.Count - 1 then
          CreateNewFunction;
   end;

end;

procedure TForm1.Graphic2D;
var x, h: Real;

begin
  h:= StrToFloat( ediStep.Text );
  min:= StrToFloat( ediMin.Text );
  max:= StrToFloat( ediMax.Text );

  with TLineSeries( FunctionList[ ActiveFunction ] ) do begin
       LinePen.Color:= colorbtnFunction.ButtonColor;
       LinePen.Width:= TrackBar1.Position;

  end;

  x:= min;
  TLineSeries( FunctionList[ ActiveFunction ] ).Clear;
  with TLineSeries( FunctionList[ ActiveFunction ] ) do
  repeat
      AddXY( x, f(x) );
      x:= x + h
  until ( x>= max );


end;

procedure TForm1.CreateNewFunction;
begin
   EditList.Add( TEdit.Create(ScrollBox1) );

   //We create Edits with functions
   with Tedit( EditList.Items[ EditList.Count - 1 ] ) do begin
        Parent:= ScrollBox1;
        Align:= alTop;
        name:= FunctionEditName + IntToStr( EditList.Count );
        OnKeyUp:= @FunctionsEditKeyUp;
        Font.Size:= 15;
        Text:= EmptyStr;
        Tag:= EditList.Count - 1;
        SetFocus;

   end;

   //We create serial functions
   FunctionList.Add( TLineSeries.Create( Chart1 ) );
   with TLineSeries( FunctionList[ FunctionList.Count - 1 ] ) do begin
        Name:= FunctionSeriesName + IntToStr( FunctionList.Count );
        Tag:= EditList.Count - 1; // Edit Asossiated

   end;


   Chart1.AddSeries( TLineSeries( FunctionList[ FunctionList.Count - 1 ] ) );

end;

{$R *.lfm}

end.


