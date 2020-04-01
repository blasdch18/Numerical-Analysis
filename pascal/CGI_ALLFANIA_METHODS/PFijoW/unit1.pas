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
    function makeTable(): String;
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
begin
  AResponse.ContentType:= 'text/html; charset= utf-8' ;
  AResponse.Contents.Text := makeTable();
  Handled := true;
end;

function TFPWebModule1.makeTable(): String;
var i: Integer;
  Result2:TStringlist;
begin
    Result2:=TStringList.Create;
    Result2:=rMethods.Punto_Fijo(0,0.001);

    Result:= '<!DOCTYPE html><html><body>';
    Result:=IntToStr(Result2.Count);
    Result:= Result +'</body></html>';

    Result:= '<!DOCTYPE html><html><body>'
           +   '<table border="1">'
           +     '<tr>'
           +       '<th>N</th>'
           +       '<th>Xn</th>'
           +       '<th>Error</th>'
           +     '</tr>';
    i:= 0;
    Result:= Result
             + '<tr>'
             +   '<td>' + Result2[0] + '</td>'
             +   '<td>' + Result2[1] + '</td>'
             + '</tr>';
    while i< round((Result2.Count-2)/3) do begin
          Result:= Result + '<tr><td>'+ Result2[i*3 + 2]
                   + '</td><td>' + Result2[i*3 + 3] +'</td>'
                   + '</td><td>' + Result2[i*3 + 4] +'</td></tr>';
          i := i+1;
    end;
    Result:= Result + '</table>' + '</body></html>';

end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.



