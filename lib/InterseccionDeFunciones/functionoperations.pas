unit FunctionOperations;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Result, mOpenMethod, ClosedMethods, ParseMath;

type
  TFunOperations = class
    const
     INTERVAL = 0.1;
    public
      AList,
      BList,
      BolzanoList: TStringList;
      constructor create();
      //function intersection( f1, f2 : String; xmin, xmax, e: Double): TStringList;
      function intersection( f1, f2 : String; xmin, xmax, e: Double): TResult;
    private
      open: TOpenMethod;
      closed : TClosedMethods;
      function bolzano( x1,x2: Double; fun: String): Integer;
      function evaluar(valorX : Real ; f_x : String ) : Real;
      function clearPointsOutOfRange(XResults:TStringList; xmin, xmax: Double): TStringList;
  end;

implementation

constructor TFunOperations.create();
begin
  open := TOpenMethod.Create();
  closed := TClosedMethods.create();
  AList := TStringList.Create();
  BList := TStringList.Create();
  BolzanoList := TStringList.Create();
end;

function TFunOperations.bolzano( x1,x2: Double; fun: String): Integer;
var
  fx1, fx2: Double;
begin
  fx1 := evaluar(x1,fun);
  fx2 := evaluar(x2,fun);

  if( fx1 = 0) then // x1 is the solution
      Result := 1
  else begin
    if( fx2 = 0) then // x2 is the solution
      Result := 2
    else begin
      if ( (fx1*fx2) < 0 ) then // success bolzano test
        Result := 3
      else  // don´t success bolzano test
        Result := 0
    end;
  end;
end;

function TFunOperations.evaluar(valorX : Real ; f_x : String ) : Real;
var
   MiParse : TParseMath;
begin
  try
   Miparse := TParseMath.create();
   MiParse.AddVariable('x',valorX);
   MiParse.Expression:= f_x;
   evaluar := MiParse.Evaluate();
  except
     evaluar:=0.0001;
     Exit;
  end;
end;

// use closed method - parameter [ Point - 1 , Point +1]
// use open method - parameter [Result closed method]

function TFunOperations.intersection( f1, f2 : String; xmin, xmax, e: Double): TResult;
var
  funExpression: String;
  xa, xb: Double;
  thereSolution : Integer;
  resultTemp: String;
  leastOneSolution:Boolean;
begin
  leastOneSolution:=False;
  Result.result := TStringList.Create;
  //Result.result.Sorted := True;
  Result.result.Duplicates := dupIgnore;
  funExpression := f1 + '-(' + f2 + ')';
  xa:= xmin;
  while( xa <= xmax )do begin
    xb := xa + INTERVAL ;
    try
      thereSolution:= bolzano(xa,xb,funExpression);
    except
       thereSolution:=0;
    end;

    AList.Add( FloatToStr( xa ));
    BList.Add( FloatToStr( xb ));
    BolzanoList.Add( IntToStr(thereSolution));

    case thereSolution of
     0:
       leastOneSolution:= (leastOneSolution or False);
       //Result.result.Add( 'No bolzano' );
     1: begin
       leastOneSolution:= (leastOneSolution or True);
       Result.result.Add( FloatToStr(xa) );
     end;
     2: begin
       leastOneSolution:= (leastOneSolution or True);
       Result.result.Add( FloatToStr(xb) );
     end;
     3:
       begin
         leastOneSolution:= (leastOneSolution or True);
         resultTemp := closed.bisectionMethod(xa,xb,0.01,funExpression).result;
         resultTemp := open.secante(StrToFloat(resultTemp),funExpression, e ).result;

         Result.result.Add( resultTemp );
       end;
    end;
    xa := xb;
  end;
  Result.thereIsResult := leastOneSolution;
  Result.result := clearPointsOutOfRange(Result.result, xmin, xmax);
end;

function TFunOperations.clearPointsOutOfRange(XResults:TStringList; xmin, xmax: Double): TStringList;
var i: Integer;
begin
  Result := TStringList.Create;
  for i:=0 to XResults.Count -1 do begin
    if ( StrToFloat( XResults[i] ) >= xmin ) and ( StrToFloat( XResults[i] ) <= xmax ) then begin
      Result.Add( XResults[i]);
    end;
  end;
end;

end.

