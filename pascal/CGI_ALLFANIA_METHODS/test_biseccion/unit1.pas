unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, class_biseccion;

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
  biseccion: Tbiseccion;
  xn, error: real;
  a ,b: real;

begin

  a:= StrtoFloat( ARequest.QueryFields.Values[ 'a' ] );
  b:= StrtoFloat( ARequest.QueryFields.Values[ 'b' ] );
  error:= StrtoFloat( ARequest.QueryFields.Values[ 'error' ] );                                                                                                                xn:=xn+0.1;
  //error:=0.01;
  biseccion:= Tbiseccion.create;
  //biseccion.initx:= xn;
  biseccion.init_a:=a;
  biseccion.init_b:=b;
  biseccion.error:= error;
  biseccion.execute;
  AResponse.contenttype := 'text/html;charset=utf-8';
  AResponse.contents.text := biseccion.displaytable;
  biseccion.Destroy;
  Handled := True;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

