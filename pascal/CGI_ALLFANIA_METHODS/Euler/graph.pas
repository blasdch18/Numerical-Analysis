unit graph;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, FileUtil,  Forms, Controls,
   Graphics, Dialogs, ExtCtrls, StdCtrls, ColorBox,
    Types;

type

   { TfrmGraficadora }
   Treal22 = array of array of real;
   TfrmGraficadora = class(TForm)
      chrGrafica: TChart;
      Funcion: TFuncSeries;
      Plotear: TLineSeries;
      EjeX: TConstantLine;
      EjeY: TConstantLine;

      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FuncionCalculate(const AX: Double; out AY: Double);

      Procedure GraficarFuncionConPloteo();
      procedure PlotearDrawPointer(ASender: TChartSeries; ACanvas: TCanvas;
        AIndex: Integer; ACenter: TPoint);

   private
      { private declarations }
      calculator : TCalculator;

      _xyVals : Treal22;

      function f( x: Double ): Double;

   public
      { public declarations }
      procedure setData(xyVals : Treal22);  //TODO aqui mandar arrays con x y
   end;

var
   frmGraficadora: TfrmGraficadora;


implementation

{$R *.lfm}

{ TfrmGraficadora }

procedure TfrmGraficadora.setData(xyVals : Treal22);
begin
   _xyVals := xyVals;
end;

function TfrmGraficadora.f( x: Double ): Double;
begin
   Result := calculator.solveSavedExpression(['x'], [x])[0][0];
end;

procedure TfrmGraficadora.GraficarFuncionConPloteo;
var
   i: Integer;
begin
   Funcion.Active:= False;

   //TODO SET COLOR!!
   for i := 0 to length(_xyVals[0]) - 1 do
   begin
      Plotear.AddXY(_xyVals[0][i], _xyVals[1][i]);
   end;

   Plotear.Active:= true;
end;

procedure TfrmGraficadora.PlotearDrawPointer(ASender: TChartSeries;
  ACanvas: TCanvas; AIndex: Integer; ACenter: TPoint);
begin

end;

procedure TfrmGraficadora.FormCreate(Sender: TObject);
begin
   calculator := TCalculator.create();
   calculator.solveExpression('x = 0');
end;

procedure TfrmGraficadora.FormDestroy(Sender: TObject);
begin
   calculator.destroy();
end;

procedure TfrmGraficadora.FormShow(Sender: TObject);
begin
   Plotear.Clear;
   GraficarFuncionConPloteo()
end;

procedure TfrmGraficadora.FuncionCalculate(const AX: Double; out AY: Double);

begin
   AY := f( AX ) ;

end;

end.
