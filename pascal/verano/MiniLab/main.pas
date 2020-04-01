unit main;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, FileUtil, uCmdBox, TAGraph, Forms, Controls, Graphics,
 Dialogs, ComCtrls, Grids, ValEdit, ExtCtrls, ShellCtrls, EditBtn, Menus, math,
 ParseMath, StdCtrls, ColorBox, spktoolbar, spkt_Tab, spkt_Pane, spkt_Buttons,
 TAChartUtils, TASeries, TAFuncSeries, TATools, cmatriz, ParseMath1,
 spkt_Checkboxes, parsestring, Types;
type

  { TfrmMain }

  TfrmMain = class(TForm)
    cboxColorFuncion: TColorBox;
    chkMostrarValores: TCheckBox;
    chkEscogerN: TCheckBox;
    chkMostrarPuntos: TCheckBox;
    DoPlot: TCheckBox;
    ediN: TEdit;
    ListBox1: TListBox;
    Panel1: TPanel;
    Plotchar: TChart;
    CmdBox: TCmdBox;
    lblCommandHistory: TLabel;
    lblCommandHistory1: TLabel;
    pgcRight: TPageControl;
    Funcion: TFuncSeries;
    EjeX: TConstantLine;
    EjeY: TConstantLine;
    Plotear: TLineSeries;
    pnlArvhivos: TPanel;
    pnlCommand: TPanel;
    pnlPlot: TPanel;
    slvFiles: TShellListView;
    spkcheckSeePlot: TSpkCheckbox;
    SpkLargeButton1: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkPane3: TSpkPane;
    spkRdoPlotIn: TSpkRadioButton;
    spkRdoPlotEx: TSpkRadioButton;
    SpkTab1: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    StatusBar1: TStatusBar;
    StatusBar2: TStatusBar;
    TabSheet1: TTabSheet;
    tbtnClosePlot: TToolButton;
    tshVariables: TTabSheet;
    tBarPlot: TToolBar;
    tvwHistory: TTreeView;
    ValueListEditor1: TValueListEditor;
    procedure ChartToolset1DataPointClickTool1AfterKeyDown(ATool: TChartTool;
      APoint: TPoint);
    procedure DoPlotChange(Sender: TObject);
    procedure CmdBoxInput(ACmdBox: TCmdBox; Input: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure spkcheckSeePlotClick(Sender: TObject);
    procedure tbtnClosePlotClick(Sender: TObject);

    procedure FuncionCalculate(const AX: Double; out AY: Double);

    Procedure GraficarFuncion();
    Procedure GraficarFuncionConPloteo();



  private
    { private declarations }
    ListVar: TStringList;
    Parse: TParseMathString;
    Parsegraf:TParseMath;
    CBOfunction,
    Xminimo,
    Xmaximo: String;

    function f( x: Double ): Double;
    Procedure DetectarIntervalo();

    procedure StartCommand();

  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;
  minXPloteo, maxXPloteo : Float;
  i_ : Integer;

implementation
{$R *.lfm}


function GetElement(posi :Integer ; str_ : String): String;
var
  i, adetect :Integer;
  aux, aux1 : String;
begin
  aux1 := str_;
  aux := copy( aux1,8,Length(aux1)-8);
  aux := ';'+aux;

  for i:=0 to posi do
  begin
     adetect := Pos(';',aux);
     aux := copy( aux , adetect+1 , Length(aux) );
  end;

  adetect:= Pos(';',aux);
  if adetect >0 then
  begin
     delete (aux ,adetect, Length(aux)+1-adetect );

  end;
  Result := aux;
end;
{ TfrmMain }

Procedure TfrmMain.DetectarIntervalo();
var
    PosCorcheteIni, PosCorcheteFin, PosSeparador: Integer;
    PosicionValidad: Boolean;
    funcion_set : String ;
begin
    funcion_set := CBOfunction;

    Xminimo := GetElement(1,funcion_set);
    Xminimo := Trim( Xminimo );

    Xmaximo := GetElement(2,funcion_set);
    Xmaximo := Trim( Xmaximo );

end;

function TfrmMain.f( x: Double ): Double;
begin
     Parsegraf.Expression := GetElement(0,CBOfunction);
     Parsegraf.NewValue('x' , x );
     Result:= Parsegraf.Evaluate();
end;

Procedure TfrmMain.GraficarFuncion();
begin
    Plotear.Clear;
    with Funcion do begin
      Active:= False;

      Extent.XMax:= StrToFloat( Xmaximo );
      Extent.XMin:= StrToFloat( Xminimo );

      Extent.UseXMax:= true;
      Extent.UseXMin:= true;
      Funcion.Pen.Color:=  cboxColorFuncion.Colors[ cboxColorFuncion.ItemIndex ];
      Active:= True;



  end;
end;

Procedure TfrmMain.GraficarFuncionConPloteo();
var i: Integer;
    Max, Min, h, NewX: Real;

begin
    Funcion.Active:= False;
    Plotear.Clear;
    Max:=  StrToFloat( Xmaximo );
    Min:=  StrToFloat( Xminimo ) ;

    if chkEscogerN.Checked then
       h:= 1 / StrToFloat( ediN.Text )

    else
        h:= (Max - Min) /( 10 * Max );
        //h:=0.02;
    if chkMostrarValores.Checked then
       Plotear.Marks.Style:= smsxValue
    else
       Plotear.Marks.Style:= smsNone;

    Plotear.ShowPoints:= chkMostrarPuntos.Checked;

    NewX:= StrToFloat( Xminimo );
    Plotear.LinePen.Color:= cboxColorFuncion.Colors[ cboxColorFuncion.ItemIndex ];  ;

    while NewX < Max do begin
       Plotear.AddXY( NewX, f( NewX ) );
       NewX:= NewX + h;

    end;


end;

procedure TfrmMain.StartCommand();
begin
   CmdBox.StartRead( clYellow, clBlue,  'MaL_Lab-->', clYellow, clBlue);
end;

procedure TfrmMain.CmdBoxInput(ACmdBox: TCmdBox; Input: string);
var
    FinalLine,inicio,temp,tempa,tempb: string;
    A,rpta:Tmatriz;
    i,j,start,k,aa,b:Integer;
    fin:Double;

  procedure AddVariable( EndVarNamePos: integer );
  var PosVar: Integer;
    const NewVar= -1;
  begin
    PosVar:= ListVar.IndexOfName( trim( Copy( FinalLine, 1, EndVarNamePos  ) ) );

    with ValueListEditor1 do
    case PosVar of
         NewVar: begin
                  ListVar.Add(  FinalLine );
                  if FinalLine[Pos( '=', FinalLine )+1]='[' then
                     Parse.AddVariableString( ListVar.Names[ ListVar.Count - 1 ], ( ListVar.ValueFromIndex[ ListVar.Count - 1 ]) )
                  else
                     Parse.AddVariable( ListVar.Names[ ListVar.Count - 1 ], StrToFloat( ListVar.ValueFromIndex[ ListVar.Count - 1 ]) );

                  Cells[ 0, RowCount - 1 ]:= ListVar.Names[ ListVar.Count - 1 ];
                  Cells[ 1, RowCount - 1 ]:= ListVar.ValueFromIndex[ ListVar.Count - 1 ];
                  RowCount:= RowCount + 1;

         end else begin
              ListVar.Delete( PosVar );
              ListVar.Insert( PosVar,  FinalLine );
              Cells[ 0, PosVar + 1 ]:= ListVar.Names[ PosVar ] ;
              Cells[ 1, PosVar + 1 ]:= ListVar.ValueFromIndex[ PosVar ];

              if FinalLine[Pos( '=', FinalLine )+1]='[' then
                 Parse.NewValuestring( ListVar.Names[ PosVar ], ( ListVar.ValueFromIndex[ PosVar ] ) )
              else
                  Parse.NewValue( ListVar.Names[ PosVar ], StrToFloat( ListVar.ValueFromIndex[ PosVar ] ) ) ;
          end;
    end;
  end;
  procedure Execute();
  begin
      Parse.serExpression(Input);
      CmdBox.TextColors(clYellow,clBlue);
      CmdBox.Writeln( LineEnding + Parse.Evaluates() + LineEnding);
  end;
begin
  Input:= Trim(Input);
  case input of
       'help': ShowMessage( 'help ');
       'help EDO' : ShowMessage('EDO("fx" ,x0 ,xf ,y0 ,n ,_tipo_ )');
       'exit': Application.Terminate;
       'clear': begin CmdBox.Clear; StartCommand() end;
       'clearhistory': CmdBox.ClearHistory;

        else begin
             FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );

             //ANADIR MATRICES
             if FinalLine[Pos( '=', FinalLine )+1]='[' then
             begin
                A:=Tmatriz.Create;
                A.f:=1;
                A.c:=1;
                i:=Pos( '=', FinalLine )+2;
                while i< length(FinalLine)-1 do
                begin
                     if FinalLine[i]= ',' then
                     begin
                        A.f:=A.f +1;
                        i:=i+1;
                        A.c:=1;

                     end

                     else
                     begin
                          start:=i;
                          while FinalLine[i]<> ' ' do
                          begin
                               i:=i+1;
                          end;

                          inicio:=Copy(FinalLine,start,i-start);
                          A.matrix[A.f,A.c]:=StrToFloat(inicio);
                          A.c:=A.c +1;
                     end;
                     i:=i+1;
                end;
                temp:= FinalLine[ Pos( '=', FinalLine ) - 1];
                AddVariable( Pos( '=', FinalLine ) - 1 );
                Execute();
             end
             //GRAFICAR FUNCIONES
             else if Pos( 'grafic', FinalLine ) > 0 then
             begin
                  if (spkcheckSeePlot.Checked =false) or (DoPlot.Checked = false) then
                     ShowMessage('Marcar ver Plot y DoPlot')
                  else
                  begin
                  CBOfunction := FinalLine;
                  DetectarIntervalo();

                  if DoPlot.Checked then
                       GraficarFuncionConPloteo()
                  else
                      GraficarFuncion();
                  end;
             end

             else if Pos('EDO', FinalLine) > 0 then   //Ej.  EDO('x-y+1',0,0.5,1,5,1)   , //Ej.  EDO('x-y+1',-2,4,8,5,5)
             begin
                  if (spkcheckSeePlot.Checked =false) or (DoPlot.Checked = false) then
                     ShowMessage('Marcar ver Plot y DoPlot')
                  else
                  begin
                      Execute;

                      Funcion.Active:= False;
                      Plotear.Clear;

                      ////PLOTEAR
                      for i := 0 to matPloteoXY.cfil-1 do
                      begin
                           Plotear.AddXY(matPloteoXY.get_element(i,0),matPloteoXY.get_element(i,1));
                      end;
                  end;
             end
             else
             begin
                  FinalLine:= StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
                  //ANADIR VARIABLES
                  if Pos( '=', FinalLine ) > 0 then
                     AddVariable( Pos( '=', FinalLine ) - 1 )
                  else
                      Execute;
             end;
        end;
  end;
  StartCommand()    ;
end;

procedure TfrmMain.DoPlotChange(Sender: TObject);
begin
  Panel1.Enabled:=DoPlot.Checked;
end;

procedure TfrmMain.ChartToolset1DataPointClickTool1AfterKeyDown(
  ATool: TChartTool; APoint: TPoint);
var
x, y: Double;
begin
with ATool as TDatapointClickTool do
  if (Series is TLineSeries) then
    with TLineSeries(Series) do begin
      x := GetXValue(PointIndex);
      y := GetYValue(PointIndex);
      //ListBox1.AddItem(TEdit(EditList.Items[Tag]).Caption, TEdit(EditList.Items[Tag]));
      Statusbar2.SimpleText := Format('%s: x = %f, y = %f', [Title, x, y]);
    end
  else
    Statusbar2.SimpleText := ' ';
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  CmdBox.StartRead(  clYellow, clBlue,  'MaL_Lab-->', clYellow, clBlue);

  with ValueListEditor1 do begin
    Cells[ 0, 0]:= 'Nombre';
    Cells[1, 0]:= 'Valor';
    Clear;

  end;

  ListVar:= TStringList.Create;
  Parse:= TParseMathString.create();
  Parsegraf:=TParseMath.create();
  Parsegraf.AddVariable('x',0.0);

end;

procedure TfrmMain.FuncionCalculate(const AX: Double; out AY: Double);
begin
  AY := f( AX )
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ListVar.Destroy;
  Parse.Destroy;
end;

procedure TfrmMain.spkcheckSeePlotClick(Sender: TObject);
begin
  pnlPlot.Visible:= not pnlPlot.Visible;
  cboxColorFuncion.Visible := not cboxColorFuncion.Visible ;
  DoPlot.Visible := not DoPlot.Visible ;
  if spkcheckSeePlot.Checked = False then
  begin
    Panel1.Enabled:=cboxColorFuncion.Visible;
    DoPlot.Checked:=spkcheckSeePlot.Checked;
  end;
end;

procedure TfrmMain.tbtnClosePlotClick(Sender: TObject);
begin
  spkcheckSeePlot.Checked:= False;
  pnlPlot.Visible:= False;
  cboxColorFuncion.Visible:=False;
  Panel1.Enabled:= False;
   DoPlot.Visible := not DoPlot.Visible ;
end;

end.

