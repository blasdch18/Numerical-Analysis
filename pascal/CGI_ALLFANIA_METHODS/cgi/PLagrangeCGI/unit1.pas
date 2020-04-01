unit Unit1;
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, Unit2, math;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; Var Handled: Boolean);
  private

  public
    rMethods: TMetodos;
    function makeTable(Base: String): String;
    function StringToStringList(Base_String:String): TStringList;
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
  Base: String;
begin
  Base:=(ARequest.QueryFields.Values[ 'Base' ]);
  AResponse.ContentType:= 'text/html; charset= utf-8' ;
  AResponse.Contents.Text := makeTable(Base);
  Handled := true;
end;
function TFPWebModule1.StringToStringList(Base_String:String): TStringList;
var
  Base_TStringList:TStringlist;
  i,tmpIni,tmpEnd: Integer;
begin
  Base_TStringList:=TStringList.Create;
  i:= 0;
  while Base_String <> '}' do begin
    tmpIni:= pos('(',Base_String);
    tmpEnd:= pos(',',Base_String);
    Base_TStringList.add(Base_String.Substring(tmpIni,tmpEnd - tmpIni - 1));
    tmpIni:= tmpEnd;
    tmpEnd:= pos(')',Base_String);
    Base_TStringList.add(Base_String.Substring(tmpIni,tmpEnd - tmpIni - 1));
    Base_String:= Base_String.Substring(tmpEnd,Base_String.Length - tmpEnd);
    i:= i + 1;
  end;
  Result:=Base_TStringList;
end;

function TFPWebModule1.makeTable(Base: String): String;
var
  Result2:TStringlist;
begin
    Result2:=TStringList.Create;
    ///http://localhost/cgi-bin/cgiproject1.exe?Base={(2,3);(4,1);(3,5)}
    ///http://localhost/cgi-bin/cgiproject1.exe?Base={(0,0);(0.4,0.3894);(0.9,0.7833);(1.5,0.9974)}
    Result2:=rMethods.Polinomio_Lagrange(StringToStringList(Base));
    Result:=Result + Result2[0] + '</br>';
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

