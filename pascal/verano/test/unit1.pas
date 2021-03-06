unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uCmdBox, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ValEdit, ParseMatematico, ReadArguments, MetodosCerrados;

type

  { TForm1 }

  TForm1 = class(TForm)
    CmdBox1: TCmdBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TreeView1: TTreeView;
    VariableGrid: TValueListEditor;
    procedure CmdBox1Click(Sender: TObject);
    procedure CmdBox1Input(ACmdBox: TCmdBox; Input: string);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    ListVar: TStringList;
    Parse, ParsePlot: TParseMath;
    procedure StartCommand();
    procedure biseccion( command: string );
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
       'clear': begin CmdBox1.Clear; StartCommand() end;
       'clearhistory': CmdBox1.ClearHistory;

        else begin
            FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
             if Pos( '=', FinalLine ) > 0 then
                AddVariable( Pos( '=', FinalLine ) - 1 )
             else if pos('biseccion', FinalLine) > 0 then
                  biseccion( Input )
                  else
                      Execute;
        end;
  end;
  finally
     StartCommand()
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    CmdBox1.StartRead( clWhite, clBlue, 'MaL_Lab-->', clWhite, clBlue );

  with VariableGrid do begin
    Cells[ 0, 0]:= 'Nombre';
    Cells[1, 0]:= 'Valor';
    Clear;
  ListVar:= TStringList.Create;
   Parse:= TParseMath.create();
  ParsePlot:= TParseMath.create();
  ParsePlot.AddVariable( 'x', 0 );
  StartCommand();
  end;
end;

procedure TForm1.StartCommand()    ;
begin
  CmdBox1.StartRead( clWhite, clBlue, 'MaL_Lab-->', clWhite, clBlue );
end;

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
      MetodoBiseccion.casotype:= 0 ;
      MetodoBiseccion.tracker:= 0.26;

      CmdBox1.TextColors(clLime,clBlue);
      tmp:= 1;
      tmp2:=MetodoBiseccion.a;

     while MetodoBiseccion.a <= MetodoBiseccion.b do begin
        tmp:=MetodoBiseccion.execute;
        ShowMessage('XN='+FloatTostr(tmp));

        if tmp<>0.0 then begin
             CmdBox1.writeln(LineEnding +' Xn = ' + FormatFloat('0.000000',tmp ) + LineEnding)     ;
             MetodoBiseccion.a:= tmp + 0.001                                                        ;
        end;

        MetodoBiseccion.a:= MetodoBiseccion.a +0.26;
        ShowMessage('a='+FloatTostr(MetodoBiseccion.a));
      end;
    end;
    TheArguments.Destroy;
end;


end.

