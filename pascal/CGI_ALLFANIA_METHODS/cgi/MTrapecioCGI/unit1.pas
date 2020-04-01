unit Unit1;
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, MTrapecio,math;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; Var Handled: Boolean);
  private

  public
    Methods: TMetodos;
    function makeTable(fx:string;Pi,Pf,n,x: Extended): String;
  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.DataModuleCreate(Sender: TObject);
begin
  Methods:= TMetodos.Create();
end;

procedure TFPWebModule1.DataModuleRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; Var Handled: Boolean);
var
  a,b,n ,x : real;
  fx : String;
begin
  fx :=(ARequest.QueryFields.Values[ 'fx' ]);
  a:=(StrToFloat(ARequest.QueryFields.Values[ 'a' ]));
  b:=(StrToFloat(ARequest.QueryFields.Values[ 'b' ]));
  n :=(StrToFloat(ARequest.QueryFields.Values[ 'n' ]));
  x :=(StrToFloat(ARequest.QueryFields.Values[ 'x' ]));
  AResponse.ContentType:= 'text/html; charset= utf-8' ;
  AResponse.Contents.Text := makeTable(fx,a,b,n,x);
  Handled := true;
end;

function TFPWebModule1.makeTable(fx:string;Pi,Pf,n,x: Extended): String;
var
    Result2:TStringlist;
    Result3:real;
    tmp:string;
begin
    Result2:=TStringList.Create;
    Result2:=Methods.Metodo_Trapecio( fx,Pi,Pf,n);

    //Result3:=TStringList.Create;
    Result3:=Methods.f(x,fx);
    tmp:= FloatToStr(result3);
    Result:='<h1 font="tahoma">Metodo del Trapecio</h1>'+'n ='+FloattoStr(n) +'</br>';
    Result:=Result+'Respuesta:  '+ Result2[0]+ '</br>';
    Result:=Result+'f(x)= '+tmp;

end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

