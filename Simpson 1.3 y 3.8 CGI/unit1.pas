unit Unit1;
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, Unit2;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; Var Handled: Boolean);
  private

  public
    rMethods: TMetodos;
    function makeTable(Funcion:String;Pinicial,Pfinal:Extended;NumeroSecciones:Integer): String;
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
  Funcion: String;
  Pinicial,Pfinal:Extended;
  NumeroSecciones:Integer;
begin
  Funcion:=ARequest.QueryFields.Values[ 'Funcion' ];
  Pinicial:=StrToFloat(ARequest.QueryFields.Values[ 'Pinicial' ]);
  Pfinal:=StrToFloat(ARequest.QueryFields.Values[ 'Pfinal' ]);
  NumeroSecciones:=StrToInt(ARequest.QueryFields.Values[ 'NumeroSecciones' ]);
  AResponse.ContentType:= 'text/html; charset= utf-8' ;
  AResponse.Contents.Text := makeTable(Funcion,Pinicial,Pfinal,NumeroSecciones);
  Handled := true;
end;
function TFPWebModule1.makeTable(Funcion:String;Pinicial,Pfinal:Extended;NumeroSecciones:Integer): String;
var
  Integral_Simpson13,Integral_Simpson38 : String;
begin
  Result:=Result+'METODO DE SIMPSON 1/3'+ '</br>';
  Integral_Simpson13:=rMethods.Metodo_Simpson13(Funcion,Pinicial,Pfinal,NumeroSecciones);
  Result:=Result+'Respuesta:  '+Integral_Simpson13+ '</br>';


  Result:=Result+'METODO DE SIMPSON 3/8'+ '</br>';
  Integral_Simpson38:=rMethods.Metodo_Simpson38(Funcion,Pinicial,Pfinal,NumeroSecciones);
  Result:=Result+'Respuesta:  '+Integral_Simpson38+ '</br>';
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.


