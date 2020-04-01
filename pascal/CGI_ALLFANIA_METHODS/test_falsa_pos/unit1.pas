unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb , class_falsa_pos;

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
  falsa_pos: Tfalsa_pos;
  xn, error: real;
  a ,b: real;

begin

  a:= StrtoFloat( ARequest.QueryFields.Values[ 'a' ] );
  b:= StrtoFloat( ARequest.QueryFields.Values[ 'b' ] );
  error:= StrtoFloat( ARequest.QueryFields.Values[ 'error' ] );                                                                                                                xn:=xn+0.1;
  //error:=0.01;
  falsa_pos:= Tfalsa_pos.create;
  //falsa_pos.initx:= xn;
  falsa_pos.init_a:=a;
  falsa_pos.init_b:=b;
  falsa_pos.error:= error;
  falsa_pos.execute;
  AResponse.contenttype := 'text/html;charset=utf-8';
  AResponse.contents.text := falsa_pos.displaytable;
  falsa_pos.Destroy;
  Handled := True;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

