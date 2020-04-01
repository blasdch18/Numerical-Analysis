program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, Animal, CustApp
  { you can add units after this };

type

  { TTanimal }

  TTanimal = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TTanimal }

procedure TTanimal.DoRun;
var
  ErrorMsg: String;
  MyAnimal: TTipoAnimal;
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
  MyAnimal:= TTipoAnimal.create();
  MyAnimal.Name:= 'Dog' ;
  MyAnimal.Age:= 3;
  MyAnimal.Feet:= 4;
  MyAnimal.Features.Add ( 'bark' );
  MyAnimal.Features.Add ( 'male' );
  WriteLn(  MyAnimal.Describe());

  // stop program loop
  Terminate;
end;

constructor TTanimal.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TTanimal.Destroy;
begin
  inherited Destroy;
end;

procedure TTanimal.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TTanimal;
begin
  Application:=TTanimal.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

