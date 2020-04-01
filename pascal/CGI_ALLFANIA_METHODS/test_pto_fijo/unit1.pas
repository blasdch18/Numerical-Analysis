unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, fphtml, class_fijo;

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
  Punto_fijo: TPunto_fijo;
  xn, error: real;

begin

  xn:= StrtoFloat( ARequest.QueryFields.Values[ 'xn' ] );
  error:= StrtoFloat( ARequest.QueryFields.Values[ 'error' ] );                                                                                                      //          xn:=xn+0.1;

  Punto_fijo:= TPunto_fijo.create;
  Punto_fijo.initx:= xn;
  Punto_fijo.error:= error;
  Punto_fijo.execute;
  AResponse.contenttype := 'charset=utf-8';
  AResponse.contents.text := Punto_fijo.displaytable;
  Punto_fijo.Destroy;
  Handled := True;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

