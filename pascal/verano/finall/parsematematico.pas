unit parsematematico;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math, fpexprpars, Dialogs;

type
  TParseMath = Class
  private
    FParser: TFPExpressionParser;
    identifier: array of TFPExprIdentifierDef;
    Procedure AddFunctions();
  public
    Expression: string;
    function NewValue( Variable:string; Value: Double ): Double;
    procedure AddVariable( Variable: string; Value: Double );
    procedure AddString( Variable: string; Value: string );
    function Evaluate(  ): Double;
    constructor create();
    destructor destroy;
  end;

function IsNumber(AValue: TExprFloat): Boolean;

implementation

constructor TParseMath.create;
begin
  FParser:= TFPExpressionParser.Create( nil );
  FParser.Builtins := [ bcMath ];
  AddFunctions();
end;

destructor TParseMath.destroy;
begin
  FParser.Destroy;
end;

function TParseMath.NewValue( Variable: string; Value: Double ): Double;
begin
  FParser.IdentifierByName(Variable).AsFloat:= Value;
end;

function TParseMath.Evaluate(): Double;
begin
  FParser.Expression:= Expression;
  Result:= ArgToFloat( FParser.Evaluate );
end;

function IsNumber(AValue: TExprFloat): Boolean;
begin
  result := not (IsNaN(AValue) or IsInfinite(AValue) or IsInfinite(-AValue));
end;



procedure ExprFloor(var Result: TFPExpressionResult; Const Args: TExprParameterArray); // maximo entero
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  if x > 0 then
   Result.ResFloat:= trunc( x )

  else
   Result.ResFloat:= trunc( x ) - 1;
end;

procedure ExprTan( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
  ymid: real;
begin
   x := ArgToFloat( Args[ 0 ] );
   ymid:= 100;
   if IsNumber(x) and ((x-0.5)/pi<>0) then begin
     if(tan(x)>ymid) or (tan(x)<(-ymid)) then
       Result.resFloat := NaN
     else
       Result.resFloat := tan(x)
   end
   else
     Result.resFloat := NaN;
end;

{
Procedure ExprNewton( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
  f: string;
  TheNewton: TNewton;
begin
   f:= Args[ 0 ].ResString;
   x:= ArgToFloat( Args[ 1 ] );

   TheNewton:= TNewton.Create;
   TheNewton.InitialPoint:= x;
   TheNewton.Expression:= f;
   Result.ResFloat := TheNewton.Execute;

   TheNewton.Destroy;
end;
}
procedure ExprSin( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  Result.resFloat := sin(x)
end;

procedure ExprCosh( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  Result.resFloat := cosh(x)
end;

procedure ExprCos( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  Result.resFloat := cos(x)
end;

procedure ExprLn( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  if IsNumber(x) and (x > 0) then
    Result.resFloat := ln(x)
  else
   Result.resFloat := NaN;
end;

procedure ExprLog( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  if IsNumber(x) and (x > 0) then
    Result.resFloat := ln(x) / ln(10)
  else
   Result.resFloat := NaN;
end;

procedure ExprSQRT( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  if IsNumber(x) and (x > 0) then
    Result.resFloat := sqrt(x)
  else
   Result.resFloat := NaN;
end;

procedure ExprPower( var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x,y: Double;
begin
  x := ArgToFloat( Args[ 0 ] );
  y := ArgToFloat( Args[ 1 ] );

  Result.resFloat := power(x,y);
end;


procedure TParseMath.AddFunctions();
begin
  with FParser.Identifiers do begin
    AddFunction('tan', 'F', 'F', @ExprTan);
    AddFunction('sin', 'F', 'F', @ExprSin);
    AddFunction('sen', 'F', 'F', @ExprSin);
    AddFunction('cosh', 'F', 'F', @ExprCosh);
    AddFunction('cos', 'F', 'F', @ExprCos);
    AddFunction('ln', 'F', 'F', @ExprLn);
    AddFunction('log', 'F', 'F', @ExprLog);
    AddFunction('sqrt', 'F', 'F', @ExprSQRT);
    AddFunction('floor', 'F', 'F', @ExprFloor );
    AddFunction('power', 'F', 'FF', @ExprPower); //two float arguments 'FF' , returns float
  end
end;

procedure TParseMath.AddVariable( Variable: string; Value: Double );
var
  Len: Integer;
begin
  Len:= length( identifier ) + 1;
  SetLength( identifier, Len ) ;
  identifier[ Len - 1 ]:= FParser.Identifiers.AddFloatVariable( Variable, Value);
end;

procedure TParseMath.AddString( Variable: string; Value: string );
var
  Len: Integer;
begin
  Len:= length( identifier ) + 1;
  SetLength( identifier, Len ) ;

  identifier[ Len - 1 ]:= FParser.Identifiers.AddStringVariable( Variable, Value);
end;

end.


