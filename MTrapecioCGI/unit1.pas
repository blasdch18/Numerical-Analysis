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
    rMethods: TMetodos;
    function makeTable(F:string;Pi,Pf,N: Extended): String;
  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.DataModuleCreate(Sender: TObject);
begin
  rMethods:= TMetodos.Create();
end;

procedure TFPWebModule1.DataModuleRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; Var Handled: Boolean);
var
  Pi,Pf,N : Extended;
  F : String;
begin
  F :=(ARequest.QueryFields.Values[ 'F' ]);
  Pi:=(StrToFloat(ARequest.QueryFields.Values[ 'Pi' ]));
  Pf:=(StrToFloat(ARequest.QueryFields.Values[ 'Pf' ]));
  N :=(StrToFloat(ARequest.QueryFields.Values[ 'N' ]));
  AResponse.ContentType:= 'text/html; charset= utf-8' ;
  AResponse.Contents.Text := makeTable(F,Pi,Pf,N);
  Handled := true;
end;

function TFPWebModule1.makeTable(F:string;Pi,Pf,N: Extended): String;
var
    Result2:TStringlist;
begin
    Result2:=TStringList.Create;
    Result2:=rMethods.Metodo_Trapecio(F,Pi,Pf,N);

    Result:=Result+'METODO DEL TRAPECIO'+ '</br>';
    Result:=Result+'Respuesta:  '+ Result2[0]+ '</br>';
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

