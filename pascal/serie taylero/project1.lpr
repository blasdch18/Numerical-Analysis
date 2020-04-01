program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, crt, SysUtils, CustApp, serie_taylor
  { you can add units after this };

type

  { Taylor }

  Taylor = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Taylor }

procedure Taylor.DoRun;
var
  ErrorMsg: String;
  MySerie: TSerie_Taylor;
  x: double;
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
  MySerie:= TSerie_Taylor.create();
  writeln('**** Exp(x)');
  write( '------->  x =  ');
  ReadLn ( x );

  WriteLn( MySerie.serie() );
  writeLn( MySerie.serie_exp(x));

  writeln('***** sen (x) ');
  write( '------->  x =  ');
  ReadLn ( x );
  WriteLn( MySerie.serie() );
  writeLn( MySerie.serie_sen(x));

  writeln('****** cos(x)');
  write( '------->  x =  ');
  ReadLn ( x );
  WriteLn( MySerie.serie() );
  writeLn( MySerie.serie_cos(x));

  writeln('****** ln (x)');
  write( '------->  x =  ');
  ReadLn ( x );
  WriteLn( MySerie.serie() );
  writeLn( MySerie.serie_ln(x));

  writeln('*******  senh(x)');
  write( '------->  x =  ');
  ReadLn ( x );
  WriteLn( MySerie.serie() );
  writeLn( MySerie.serie_sinh(x));

  readkey;


  // stop program loop
  Terminate;
end;

constructor Taylor.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Taylor.Destroy;
begin
  inherited Destroy;
end;

procedure Taylor.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Taylor;
begin
  Application:=Taylor.Create(nil);
  Application.Title:='Taylor';
  Application.Run;
  Application.Free;
end.

