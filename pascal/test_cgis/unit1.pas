unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; Var Handled: Boolean);
  private

  public

  end;

var
  FPWebModule1: TFPWebModule1;

implementation
{$R *.lfm}
{ TFPWebModule1 }
procedure TFPWebModule1.DataModuleCreate(Sender: TObject);
begin
end;

procedure TFPWebModule1.DataModuleRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; Var Handled: Boolean);
var a, b: real;
begin
  a:= StrToFloat (Arequest.QueryFields.Values[ 'a' ]);
  b:= StrToFloat (Arequest.QueryFields.Values[ 'b' ]);
  Aresponse.ContentType := 'text/html;charset=utf=8';
  Aresponse.contents.Text := 'Suma : ' + FloatToStr( a+b );
  Handled := True;

end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

