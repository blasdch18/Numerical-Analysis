unit class_secant;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, Unit2;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.DataModuleRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; var Handled: Boolean);
var
  secant: TSecant;
  xn, error: real;

begin

  xn:= StrtoFloat( ARequest.QueryFields.Values[ 'xn' ] );
  error:= StrtoFloat( ARequest.QueryFields.Values[ 'error' ] );                                                                                                                xn:=xn+0.1;

  secant:= TSecant.create;
  secant.initx:= xn;
  secant.error:= error;
  secant.execute;
  AResponse.contenttype := 'charset=utf-8';
  AResponse.contents.text := Secant.displaytable;
  Secant.Destroy;
  Handled := True;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

