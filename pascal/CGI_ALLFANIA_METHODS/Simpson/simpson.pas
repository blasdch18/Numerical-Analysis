unit Simpson;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, unit2;

type
  TFPWebModule1 = class(TFPWebModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

