unit authactns;

{$mode objfpc}{$H+}

interface

uses
  BrookAction, BrookHttpDefs, BrookSession, BrookUtils, Classes, SysUtils, TaylorExpo, Lagrangeclass, ArrStr;

type

  { TLog }

  TLog = class(TBrookAction)
  private
    FLog: TStringList;
    function GetText: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Request(ARequest: TBrookRequest;
      AResponse: TBrookResponse); override;
    procedure Load;
    procedure Save;
    procedure Add(const ALog: string);
    procedure Add(const ALog: string; const AArgs: array of const);
    property Log: TStringList read FLog;
    property Text: string read GetText;
  end;

  { TAuth }

  TAuth = class(TLog)
  private
    FSession: TBrookSession;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Request(ARequest: TBrookRequest;
      AResponse: TBrookResponse); override;
    procedure Location(const AActionClassName: string);
    procedure Get; override;
    property Session: TBrookSession read FSession;
  end;

  { TLogin }

  TLogin = class(TAuth)
  public
    lagrange :TLagrange;
    procedure Get; override;
    procedure Post; override;
  end;

  { TLogout }

  TLogout = class(TAuth)
  public
    procedure Request(ARequest: TBrookRequest;
      AResponse: TBrookResponse); override;
  end;

implementation

{ TLog }

constructor TLog.Create;
begin
  inherited Create;
  FLog := TStringList.Create;
end;

destructor TLog.Destroy;
begin
  FLog.Free;
  inherited Destroy;
end;

function TLog.GetText: string;
begin
  Result := FLog.Text;
end;

procedure TLog.Request(ARequest: TBrookRequest; AResponse: TBrookResponse);
begin
  Load;
  inherited;
end;

procedure TLog.Load;
begin
  if FileExists('log.html') then
    FLog.LoadFromFile('log.html')
end;

procedure TLog.Save;
begin
  Log.SaveToFile('log.html');
end;

procedure TLog.Add(const ALog: string);
begin
  FLog.Add(ALog);
end;

procedure TLog.Add(const ALog: string; const AArgs: array of const);
begin
  FLog.Add(Format(ALog, AArgs));
end;

{ TAuth }

constructor TAuth.Create;
begin
  inherited Create;
  FSession := TBrookSession.Create(nil);
  FSession.CookieSecure := True;
  FSession.TimeOut := 0;
end;

destructor TAuth.Destroy;
begin
  FSession.Free;
  inherited Destroy;
end;

procedure TAuth.Request(ARequest: TBrookRequest; AResponse: TBrookResponse);
begin
  Session.Start(ARequest);
  if Session.Exists('nameA') then
    inherited
  else
    if ARequest.GetNextPathInfo = 'login' then
      inherited
    else
      Location('TLogin');
end;

procedure TAuth.Location(const AActionClassName: string);
begin
  Redirect(UrlFor(AActionClassName), 302);
end;

procedure TAuth.Get;
begin
  Location('TChatGetMsg');
end;

{ TLogin }

procedure TLogin.Get;
begin
  Render('login.html', ['']);
end;

procedure TLogin.Post;
const

 // MSG_Ev = '<div class="msgln"><i>La respuesta es  <b>%s</b> esa.</i><br></div>';
 MSG_P = '<div class="msgln"><i>El polinomio de Lagrange es  <b>%s</b> ese.</i><br></div>';
 MSG_Ev = '<div class="msgln"><i>La respuesta es  <b>%s</b> esa.</i><br></div>';
 {MSG = '<div class="msgln"><table >';
  MSGA = '<tr>';
  MSG1 = '<th class="msgl2">%s</th>';
  MSGB = '</tr>';
  MSG3 = '</table></div>';
  MSG4 = '<div class="msgln"><i>La respuesta es  <b>%s</b> esa.</i><br></div>';}
var
  VName, Respta, num: string;
   numSet  : Real;
  Number, i, j  : Integer;
 // ptrArrStr : ^TArrString;
begin
  if (Fields.Values['nameA'] = '' ) then
    Render('login.html', ['Please type your value.'])
  else
  begin
    VName := Fields.Values['nameA'];
    Number:= StrToInt(VName) ;
    lagrange := TLagrange.Create(Number);

    for i:=0 to 1 do begin
         for j:=0 to Number-1 do begin
              num :=  'fil'+IntToStr(i)+'col'+IntToStr(j);
              numSet := StrToFloat( Fields.Values[ num ] );
              lagrange.setMatriz(i,j,numSet);
         end;
    end;
    Respta := lagrange.getPolinomio();
    Render('login.html', [ Respta ]);


    Add(MSG_P, [ Respta ]);
    Save;
    Respta := FloatToStr(lagrange.evaluar_function(StrToFloat (Fields.Values("val"))));
    Add(MSG_Ev, [ Respta ];
    Save;


    //Session.Fields.Add('nameA=' + Respta);
    //Session.Finish(TheResponse);
    //Location('TChatGetMsg');
  end;
end;

{ TLogout }

procedure TLogout.Request(ARequest: TBrookRequest; AResponse: TBrookResponse);
const
  MSG = '<div class="msgln"><i>User <b>%s</b> has left the room.</i><br></div>';
begin
  inherited;
  Add(MSG, [Session.Fields.Values['name']]);
  Save;
  Session.Expire(ARequest, AResponse);
  Location('TChatGetMsg');
end;

initialization
  TAuth.Register('/');
  TLogin.Register('/login', rmGet);
  TLogin.Register('/login', rmPost);
  TLogout.Register('/logout', rmGet);

end.

