unit plot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, ExtCtrls, StdCtrls;

type

  { TframePlot }

  TframePlot = class(TFrame)
    Chart1: TChart;
    edifuntion: TEdit;
    ediInterval: TEdit;
    Label1: TLabel;
    lblfuncion: TLabel;
    pnlPlot: TPanel;
    Splitter1: TSplitter;
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

end.

