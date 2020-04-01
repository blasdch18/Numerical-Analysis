unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, Rk4,Math;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleCreate(Sender:Tobject);
    procedure DataModuleRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
  private
    { private declarations }
  public
        Methods: trk4;
        function makeTable(fx: string ; a,b,lim: extended): string;
  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.DataModuleCreate(Sender: TObject);
begin
  MEthods:= trk4.Create();
end;

procedure TFPWebModule1.DataModuleRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; var Handled: Boolean);
var
  fx : String;
  a, b, lim :Extended;
begin
  fx :=(ARequest.QueryFields.Values[ 'fx' ]);
  a:=(StrToFloat(ARequest.QueryFields.Values[ 'a' ]));
  b:=(StrToFloat(ARequest.QueryFields.Values[ 'b' ]));
  lim :=(StrToFloat(ARequest.QueryFields.Values[ 'lim' ]));
  AResponse.ContentType:= 'text/html; charset=utf-8';
  Aresponse.Contents.Text:= makeTable(fx,a,b,lim);
  Handled := true ;
end;

function TFPWebModule1.makeTable(fx:string; a, b, lim:Extended):String;
var
  result2 :Tstringlist;
  result3 : real;
  tmp: string;
  begin
    result2:=Tstringlist.Create;
    result2:=Methods.Rk4 (fx , a ,b ,lim);
    Result:='<h1 font="tahoma">Metodo RK4</h1>'+'n =' +'</br>';
    Result:=Result+'Respuesta:  '+ Result2[0]+ '</br>';



    end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

