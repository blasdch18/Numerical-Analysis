program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, MetodosAbiertos
  { you can add units after this };

type

  { MetodosAbiertos }

  MetodosAbiertos = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ MetodosAbiertos }

procedure MetodosAbiertos.DoRun;
var
  ErrorMsg: String;
  a: TMetodosAbiertos;
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
  a.create();
  a.desarrollo_metodos();

  // stop program loop
  Terminate;
end;

constructor MetodosAbiertos.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor MetodosAbiertos.Destroy;
begin
  inherited Destroy;
end;

procedure MetodosAbiertos.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: MetodosAbiertos;
begin
  Application:=MetodosAbiertos.Create(nil);
  Application.Title:='MetodosAbiertos';
  Application.Run;
  Application.Free;
end.

