unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uCmdBox, TAGraph, TARadialSeries, TAFuncSeries,
  TASeries, Forms, Controls, Graphics, Dialogs, ComCtrls, Grids, ValEdit,
  ExtCtrls, ShellCtrls, EditBtn, Menus, ParseMath, StdCtrls, spktoolbar,
  spkt_Tab, spkt_Pane, spkt_Buttons, spkt_Checkboxes, ReadArguments;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    Plotchar: TChart;
    CmdBox: TCmdBox;
    lblCommandHistory: TLabel;
    lblCommandHistory1: TLabel;
    pgcRight: TPageControl;
    EjeX: TConstantLine;
    EjeY: TConstantLine;
    FuncionCartesiana: TFuncSeries;
    FuncionPolar: TPolarSeries;
    PlotLines: TLineSeries;
    pnlCommand: TPanel;
    pnlPlot: TPanel;
    spkcheckSeePlot: TSpkCheckbox;
    NuevoScript: TSpkLargeButton;
    Abrir: TSpkLargeButton;
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
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    StatusBar1: TStatusBar;
    tbtnClosePlot: TToolButton;
    tshcomandos: TTabSheet;
    tshVariables: TTabSheet;
    tBarPlot: TToolBar;
    tvwHistory: TTreeView;
    ValueListEditor1: TValueListEditor;
    procedure CmdBoxInput(ACmdBox: TCmdBox; Input: string);
    procedure dEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FuncionCartesianaCalculate(const AX: Double; out AY: Double);
    procedure spkcheckSeePlotClick(Sender: TObject);
    procedure tbtnClosePlotClick(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private
    { private declarations }
    ListVar: TStringList;
    Parse, ParsePlot: TParseMath;

    function f( x: Double ): Double;
    procedure StartCommand();
    procedure Plot2d( command: string );

  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

function TfrmMain.f( x: Double ): Double;
begin

   ParsePlot.NewValue('x' , x );
   Result:= ParsePlot.Evaluate();
end;

procedure TfrmMain.Plot2d( command: string  );
var TheArguments: TReadArg;
begin
    PlotLines.Clear;
    TheArguments:= TReadArg.Create( command );
    pnlPlot.Visible:= true;
    spkcheckSeePlot.Checked:= true;

    with FuncionCartesiana, TheArguments do begin
      ParsePlot.Expression:= Arguments[ 0 ];
      Active:= False;

      Extent.XMax:= StrToFloat( Arguments[ 1 ] );
      Extent.XMin:= StrToFloat( Arguments[ 2 ] );

      Extent.UseXMax:= true;
      Extent.UseXMin:= true;
      FuncionCartesiana.Pen.Color:= clBlue;

      Active:= True;

  end;
    TheArguments.Destroy;
end;

procedure TfrmMain.dEditChange(Sender: TObject);
begin

end;

procedure TfrmMain.StartCommand();
begin
   CmdBox.StartRead( clBlack, clWhite,  'MiniLab--> ', clBlack, clWhite);
end;

procedure TfrmMain.CmdBoxInput(ACmdBox: TCmdBox; Input: string);
var FinalLine: string;

  procedure AddVariable( EndVarNamePos: integer );
  var PosVar: Integer;
    const NewVar= -1;
  begin

    PosVar:= ListVar.IndexOfName( trim( Copy( FinalLine, 1, EndVarNamePos  ) ) );

    with ValueListEditor1 do
    case PosVar of
         NewVar: begin
                  ListVar.Add(  FinalLine );
                  Parse.AddVariable( ListVar.Names[ ListVar.Count - 1 ], StrToFloat( ListVar.ValueFromIndex[ ListVar.Count - 1 ]) );
                  Cells[ 0, RowCount - 1 ]:= ListVar.Names[ ListVar.Count - 1 ];
                  Cells[ 1, RowCount - 1 ]:= ListVar.ValueFromIndex[ ListVar.Count - 1 ];
                  RowCount:= RowCount + 1;

         end else begin
              ListVar.Delete( PosVar );
              ListVar.Insert( PosVar,  FinalLine );
              Cells[ 0, PosVar + 1 ]:= ListVar.Names[ PosVar ] ;
              Cells[ 1, PosVar + 1 ]:= ListVar.ValueFromIndex[ PosVar ];
              Parse.NewValue( ListVar.Names[ PosVar ], StrToFloat( ListVar.ValueFromIndex[ PosVar ] ) ) ;

          end;

    end;


  end;

  procedure Execute();
  begin
      Parse.Expression:= Input ;
      CmdBox.TextColors(clBlack,clWhite);
      CmdBox.Writeln( LineEnding +  FloatToStr( Parse.Evaluate() )  + LineEnding);


  end;


begin
  try
     Input:= Trim(Input);
     case input of
       'help': ShowMessage( 'help ');
       'exit': Application.Terminate;
       'clear': begin CmdBox.Clear; StartCommand() end;
       'clearhistory': CmdBox.ClearHistory;

        else begin
             FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
             if Pos( '=', FinalLine ) > 0 then
                AddVariable( Pos( '=', FinalLine ) - 1 )
             else if pos('plot', FinalLine) > 0 then
                 Plot2d( Input )

             else
                Execute;

        end;

  end;

  finally
     StartCommand()
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  CmdBox.StartRead( clBlack, clWhite,  'MiniLab-->', clBlack, clWhite);

  with ValueListEditor1 do begin
    Cells[ 0, 0]:= 'Nombre';
    Cells[1, 0]:= 'Valor';
    Clear;

  end;

  ListVar:= TStringList.Create;
  Parse:= TParseMath.create();
  ParsePlot:= TParseMath.create();
  ParsePlot.AddVariable( 'x', 0 );

  StartCommand();

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ListVar.Destroy;
  Parse.Destroy;
  ParsePlot.destroy;

end;

procedure TfrmMain.FuncionCartesianaCalculate(const AX: Double; out AY: Double);
begin
   AY := f( AX )
end;

procedure TfrmMain.spkcheckSeePlotClick(Sender: TObject);
begin
  pnlPlot.Visible:= not pnlPlot.Visible;
end;

procedure TfrmMain.tbtnClosePlotClick(Sender: TObject);
begin
  spkcheckSeePlot.Checked:= False;
  pnlPlot.Visible:= False;
end;

procedure TfrmMain.ValueListEditor1Click(Sender: TObject);
begin

end;

end.

