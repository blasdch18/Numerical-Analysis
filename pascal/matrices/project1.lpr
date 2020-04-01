program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, crt, SysUtils, CustApp, matriz
  { you can add units after this };

type

  { MyMatriz }

  MyMatriz = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ MyMatriz }

procedure MyMatriz.DoRun;
var
  ErrorMsg: String;
  MyMatriz1: TMatrix;
  MyMatriz2: TMatrix;
  MyMatriz3: TMatrix;
  MyMatriz4: TMatrix;
  MyMatriz5: TMatrix;
  MyMatriz6: TMatrix;
  MyMatriz7: TMatrix;
  MyMatriz8: TMatrix;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  MyMatriz1:= TMatrix.create( 2, 2);
  MyMatriz2:= TMatrix.create( 2, 2);
  MyMatriz3:= TMatrix.create( 2, 2);
  writeln('   OPERACIONES CON MATRICES   ');
  Writeln;

  writeln('------------------> Matriz 1 .');
  MyMatriz1.Fill();
  writeln;
  writeln('------------------> Matriz 2 .');
  MyMatriz2.Fill();
  MyMatriz3:= MyMatriz1.suma( MyMatriz2 );

  writeln;
  writeln('------------------> Suma ;)');
  MyMatriz3.Print( MyMatriz3 );

  writeln;
  writeln('------------------> Resta >:v');
  MyMatriz3:= MyMatriz1.resta( MyMatriz2 );
  MyMatriz3.Print( MyMatriz3 );

  writeln;
  MyMatriz4:= TMatrix.create( 2, 3);
  MyMatriz5:= TMatrix.create( 3, 2);
  MyMatriz6:= TMatrix.create( 2, 2);
  writeln('------------------> Matriz 4 .');
  MyMatriz4.Fill();
  writeln;
  writeln('------------------> Matriz 5 .');
  MyMatriz5.Fill();
  MyMatriz6:= MyMatriz6.multiplicacion( MyMatriz4, MyMatriz5 );
  writeln;
  writeln('------------------> Multiplicacion  ;v');
  MyMatriz6.Print( MyMatriz6 );

  writeln;
  MyMatriz7:= TMatrix.create( 3, 3);
  MyMatriz8:= TMatrix.create( 3, 3);
  writeln('-----------------> Matriz 7 .');
  MyMatriz7.Fill();

  writeln;
  writeln('-----------------> Potencia de Matriz ');
  MyMatriz8:= MyMatriz7.potencia( MyMatriz7, 2 );
  MyMatriz8.print( MyMatriz8) ;

  writeln;
  writeln('------------------> Determinante ');
  write( floatToStr( MyMatriz7.determinante ( MyMatriz7 ) ));

  writeln;
  writeln('------------------> Transpuesta ');
  mymatriz8:= MyMatriz7.transpuesta ( MyMatriz7 ) ;
  MyMatriz8.print( MyMatriz7 );

  writeln;
  writeln('-----------------> Inversa :.');
  MyMatriz8:= MyMatriz7.Inversa( MyMatriz7 );
  MyMatriz8.print( MyMatriz8 );
  writeln;
  mymatriz8:=mymatriz8.MultEscalar(mymatriz8,-20);
   MyMatriz8.print( MyMatriz8 );












  readkey;

  // stop program loop
  Terminate;
end;

constructor MyMatriz.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor MyMatriz.Destroy;
begin
  inherited Destroy;
end;

procedure MyMatriz.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: MyMatriz;
begin
  Application:=MyMatriz.Create(nil);
  Application.Title:='MyMatriz';
  Application.Run;
  Application.Free;
end.

