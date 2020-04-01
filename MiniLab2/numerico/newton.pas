{*
Metodo de newton aproximado
Christian Ortiz
*}

unit Newton;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TNewton = class
    public
      InitialPoint: Double;
      Error: Double;
      Variable: string;
      Expression: string;
      MaxIteration: Integer;
      HasSolution: Boolean;

      function Execute: Double;

      constructor Create;
      destructor Destroy; override;

    private

       function df( x: Double ): Double;
       function f(x: Double): Double;

  end;

implementation

uses ParseMath;

var

  //
  Parse: TParseMath;

constructor TNewton.Create;
begin
  Error:= 0.000001;
  Parse:= TParseMath.create();
  Variable:= 'x';
  MaxIteration:= 10000;
  HasSolution:= true;

end;

destructor TNewton.Destroy;
begin
  Parse.destroy;
end;

function TNewton.f( x: Double): Double;
begin
  Parse.NewValue( Variable, x );
  Result:= Parse.Evaluate();

end;

function TNewton.df( x: Double): Double;
var h: Double;
begin
   h:= Error / 10;
   Result:= ( f( x + h) - f(x - h) )/ ( 2 * h ) ;

end;

function TNewton.Execute: Double;
var xn, TMPxn: double;
    ActualError: Double;
    Step: integer;
    dfxn: Double;

begin
   Step := 0;
   xn := InitialPoint;
   ActualError:= 1;
   Parse.Expression:= Expression;
   Parse.AddVariable( Variable, InitialPoint );

   while ( HasSolution ) and ( Error <= ActualError ) do begin
       dfxn:= df( xn );

       if dfxn < 0.0000001 then
         dfxn := 0.01;

       TMPxn:= xn;

       xn := xn - f( xn ) / dfxn;
       ActualError:= abs( xn - TMPxn );

       Step:= Step + 1;
       HasSolution:= ( Step <= MaxIteration );

   end;

   Result:= xn;

end;


end.

