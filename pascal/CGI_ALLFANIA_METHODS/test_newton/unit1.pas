unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, class_newton;

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
  newton: Tnewton;
  xn, error: real;

begin

  xn:= StrtoFloat( ARequest.QueryFields.Values[ 'xn' ] );
  error:= StrtoFloat( ARequest.QueryFields.Values[ 'error' ] );                                                                                                                //xn:=xn+0.1;

  newton:= Tnewton.create;
  newton.initx:= xn;
  newton.error:= error;
  newton.execute;
  AResponse.contenttype := 'charset=utf-8';
  AResponse.contents.text := newton.displaytable;
  newton.Destroy;
  Handled := True;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

