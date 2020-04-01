unit main;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
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

procedure TFPWebModule1.DataModuleRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; Var Handled: Boolean);
var f: string;
const
    f_sin = '0';
    f_sqrt = '1';
    f_square = '2';
    f_polynomial = '3';
    f_points = '-1';

    function RandomPoints: string;
    var h, x, y: Real;

    const
        maxValue = 10;
    begin
        Randomize;
        h:= 1/50; //same as grahics.js
        x:= -10;
        Result:= EmptyStr;
        while x <= maxValue do begin
           y:=  ( -1 * Random( 10 ) + Random( 10 ) );
           y:= trunc(y * 1000)/1000;
           Result:= Result + '(' + FloatToStr(x)  + ',' + FloatToStr( y ) +');';
           x:= x + h;
        end;
        Result:= Copy( Result, 1, Length(Result) -1 );

    end;

begin

  f := ARequest.QueryFields.Values['f'];
  AResponse.ContentType := 'text/html;charset=utf-8';
  with AResponse.Contents do
  case f of
     f_sin: Text:= 'Math.sin(x)';
     f_sqrt: text:= 'Math.sqrt(x)';
     f_square: Text:= 'Math.pow(x,2)';
     f_polynomial: Text:= '3*Math.pow(x,3) -4* Math.pow(x,4) + 4*Math.pow(x,2)';
     f_points: Text:= RandomPoints;
  end;
  Handled := True;

end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

