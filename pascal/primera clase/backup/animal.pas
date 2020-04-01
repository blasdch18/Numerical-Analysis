unit Animal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TTipoAnimal = class
    public
      Name: string;
      Age: Integer;
      Feet: Integer;
      Features: TStringList;

      function Describe() : string;
      constructor create() ;
      destructor Destroy; override;

    private
  end;

implementation

constructor TTipoAnimal.create();
begin
  Self.Age:= 0;
  Self.Name:= 'Without name';
  Self.Feet:= 2;
  Features:= TStringList.Create;
end;

destructor TTipoAnimal.Destroy;
begin
  Features.Destroy;
end;

function TTipoAnimal.Describe() : string;
var i: Integer;
begin
  Result:= 'This animal is: ' + Self.Name + LineEnding +
  'and has: ' + IntToStr( Self.Age ) + 'years old' + LineEnding + 'besides, it has' +
  IntToStr( Self.Feet ) + 'feet.' + LineEnding + 'My features are:' + LineEnding;
  for i:= 0 to Features.Count - 1 do
      Result:= Result + IntToStr( i ) + ' ' + Features[ i ] + LineEnding;
end;

end.

