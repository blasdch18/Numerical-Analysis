unit ReadArguments;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

type
  TReadArg = Class
    FunctionName: string;
    Arguments: Tstringlist;

    constructor Create( Line:string );
    destructor Destroy; override;


end;

implementation

constructor TReadArg.Create( Line: string );
var ArgLines: string;
begin
   Arguments:= TStringList.Create;
   //Line:= StringReplace( Line, ' ', '', [rfIgnoreCase, rfReplaceAll] );
   Line:= Trim( Line );
   FunctionName:= Copy( Line, 1, Pos( '(', Line ) - 1 );
   ArgLines:= Copy( Line, Pos( '(', Line ) + 1, Length( Line ) );

   ArgLines:= Copy( ArgLines, 1, Length( ArgLines ) - 1 ) ;
   Arguments.Delimiter:=';';
   Arguments.StrictDelimiter:= true;
   Arguments.DelimitedText:= ArgLines;


end;

destructor TReadArg.Destroy;
Begin
   Arguments.Destroy;
end;

end.

