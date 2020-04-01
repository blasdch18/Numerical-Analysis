unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uCmdBox, TAGraph, TARadialSeries, TAFuncSeries,
  TASeries, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, Grids,
  ValEdit, ParseMatematico, ReadArguments, MetodosCerrados, MetodosAbiertos, test;

type

  { TForm1 }

  TForm1 = class(TForm)
    CmdBox1: TCmdBox;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tvwHistory: TTreeView;
    VAriableGrid: TValueListEditor;

    ActualFrame: Tframe;
    procedure test( command: string  );
    procedure CmdBox1Click(Sender: TObject);
    procedure CmdBox1Input(ACmdBox: TCmdBox; Input: string);
    procedure FormCreate(Sender: TObject);
    procedure VAriableGridClick(Sender: TObject);
  private
    { private declarations }
    ListVar: TStringList;
    Parse, ParsePlot: TParseMath;
    funccion : string;

    function f( x: Double ): Double;
    procedure biseccion( command: string );
    //procedure biseccion2( command: string );
    procedure StarCommand();
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CmdBox1Click(Sender: TObject);
begin

end;


function TForm1.f( x: Double ): Double;
begin

   ParsePlot.NewValue('x' , x );
   Result:= ParsePlot.Evaluate();
end;
                  {
procedure TForm1.Plot2d( command: string  );
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

    ACtualFrame:= TFrame1.create(Form1);

      Active:= True;

  end;
    TheArguments.Destroy;
end;                     }

procedure Tform1.biseccion( command: string  );
var TheArguments: TReadArg;
    MetodoBiseccion: TMetodosCerrados;
    tmp, tmp2 ,Na, Nb: real   ;
begin
//    PlotLines.Clear;
    TheArguments:= TReadArg.Create( command );
    MetodoBiseccion:=TmetodosCerrados.create;
    //TheArguments.FunctionName:= command;

    with MetodoBiseccion, TheArguments do
    begin
      //ParsePlot.Expression:= Arguments[ 0 ];
      MetodoBiseccion.funcion:=  Arguments[0];
      MetodoBiseccion.a:= StrtoFloat(Arguments[1]);
      MetodoBiseccion.b:= StrtoFloat(Arguments[2]);
      MetodoBiseccion.error1:= StrtoFloat(Arguments[3]);
      //MetodoBiseccion.error2:=50;
      MetodoBiseccion.casotype:= 0 ;
      //MetodoBiseccion.tracker:= 0.55;

      CmdBox1.TextColors(clLime,clBlue);
      tmp:= 1;
      tmp2:=MetodoBiseccion.a;

      while tmp2 <= MetodoBiseccion.b do begin
        tmp:=MetodoBiseccion.execute;
        ShowMessage('XN='+FloatTostr(tmp));

        if tmp<>0.0 then begin
             CmdBox1.writeln(LineEnding +' Xn = ' + FormatFloat('0.000000',tmp ) + LineEnding)     ;
             tmp2:= tmp + 0.001                                                        ;
        end;

        tmp2:= tmp2 +0.26;
        ShowMessage('a='+FloatTostr(tmp2));

      end;
      //funccion:=  Arguments[0];
      //showMessage(FloatToSTr(f(a)));
    end;
    TheArguments.Destroy;
end;
{
procedure Tform1.biseccion2( command: string  );
var TheArguments: TReadArg;
    MetodoBiseccion: TBiseccion;
    a, b, error:real;
begin
    TheArguments:= TReadArg.Create( command );
    MetodoBiseccion:=TBiseccion.create;
    //TheArguments.FunctionName:= command;

    with MetodoBiseccion, TheArguments do
    begin
      //ParsePlot.Expression:= Arguments[ 0 ];
      MetodoBiseccion.my_function:=  Arguments[0];
      a:= StrtoFloat(Arguments[1]);
      b:= StrtoFloat(Arguments[2]);
      error:= StrtoFloat(Arguments[3]);
      MetodoBiseccion.bisection(a,b,error);
      CmdBox1.TextColors(clLime,clBlue);
      CmdBox1.writeln(LineEnding +' Xn = ' + FormatFloat('0.000000',MetodoBiseccion.bisection(a,b,error) ) + LineEnding)     ;
    end;

end;                 }

procedure TForm1.test( command: string  );
var tttest: TTest;
    TheArguments: TReadArg;
begin
    TheArguments:= TReadArg.Create( command );
    with tttest, TheArguments do
    begin
         tttest.funcion:= Arguments[0];
         tttest.a:= StrToFloat(Arguments[1]);
         tttest.b:= StrToFloat(Arguments[2]);
         ShowMessage(FloatToSTr(tttest.execute));
         end;

  end                               ;

procedure TForm1.CmdBox1Input(ACmdBox: TCmdBox; Input: string);
var finalLine: String;

  procedure AddVAriable( EndVarNamePos : integer );
  var PosVar: Integer;
    const NewVar= -1;
      begin
         PosVar:= ListVar.IndexOfName(trim (Copy (FinalLine, 1, EndVarNamePos )));
         with VariableGrid do
         case PosVar of
           NewVar: begin
                   ListVar.Add ( FinalLine );
                   Parse.AddVAriable( ListVar.Names[ ListVAr.Count -1 ], StrToFloat( ListVar.ValueFromIndex[ ListVar.Count -1]) );
                   Cells[ 0, RowCount- 1 ]:= ListVar.Names[ ListVar.Count -1];
                   Cells[ 1, RowCount -1 ]:= ListVar.ValueFromIndex[ ListVar.Count -1 ];
                   RowCount:= RowCount + 1;
           end else begin
                   ListVar.Delete( PosVar );
                   ListVar.Insert( PosVar, FinalLine );
                   Cells[ 0, PosVar+1 ]:=ListVar.Names[ PosVar];
                   Cells[ 1, PosVar + 1 ]:= ListVar.ValueFromIndex[ PosVar ];
              Parse.NewValue( ListVar.Names[ PosVar ], StrToFloat( ListVar.ValueFromIndex[ PosVar ] ) ) ;
           end;
         end;
      end;

  procedure Execute();
  begin
      Parse.Expression:= Input ;
      CmdBox1.TextColors(clBlack,clWhite);
      CmdBox1.Writeln( LineEnding +  FloatToStr( Parse.Evaluate() )  + LineEnding);
  end;
begin
  try
     Input:= Trim(Input);
     case input of
       'help': ShowMessage( 'help ');
       'exit': Application.Terminate;
       'clear': begin CmdBox1.Clear; StarCommand() end;
       'clearhistory': CmdBox1.ClearHistory;

        else begin
            FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
             if Pos( '=', FinalLine ) > 0 then
                AddVariable( Pos( '=', FinalLine ) - 1 )
             else if pos('test', FinalLine) > 0 then
                  biseccion( Input )
                  else
                      Execute;
        end;
  end;
  finally
     StarCommand()
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CmdBox1.StartRead( clWhite, clBlue, 'MaL_Lab-->', clWhite, clBlue );

  with VariableGrid do begin
    Cells[ 0, 0]:= 'Nombre';
    Cells[1, 0]:= 'Valor';
    Clear;

  end;

  ListVar:= TStringList.Create;
  Parse:= TParseMath.create();
  ParsePlot:= TParseMath.create();
  ParsePlot.AddVariable( 'x', 0 );

  StarCommand();
end;

procedure TForm1.VAriableGridClick(Sender: TObject);
begin

end;

procedure TForm1.StarCommand()    ;
begin
  CmdBox1.StartRead( clWhite, clBlue, 'MaL_Lab-->', clWhite, clBlue );
end;

end.

