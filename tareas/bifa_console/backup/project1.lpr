program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, crt, SysUtils, CustApp, metodoscerrados
  { you can add units after this };

type

  { MetodoCerrado }

  MetodoCerrado = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ MetodoCerrado }

procedure MetodoCerrado.DoRun;
var
  ErrorMsg: String;
  a: TMetodosCerrados ;
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

  a.Xn_biseccion();

  readkey;
  // stop program loop
  Terminate;
end;

constructor MetodoCerrado.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor MetodoCerrado.Destroy;
begin
  inherited Destroy;
end;

procedure MetodoCerrado.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: MetodoCerrado;
begin
  Application:=MetodoCerrado.Create(nil);
  Application.Title:='MetodoCerrado';
  Application.Run;
  Application.Free;
end.

