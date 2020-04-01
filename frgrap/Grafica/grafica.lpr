program grafica;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, tachartlazaruspkg, ParseMath, calculadora, funciones, Newton
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmGraficadora, frmGraficadora);
  Application.CreateForm(TfrmFunciones, frmFunciones);
  Application.Run;
end.

