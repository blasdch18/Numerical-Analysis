unit persona;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

type
  TPerson = class
    Name: TStringList;
    Count: Integer;
    procedure AddName( sName: String );
    function FirstPerson: String;
    function LastPerson: String;
    function GetPerson( Position: Integer ): String;
    constructor Create;
    destructor Destroy; override;

  end;


implementation

   constructor TPerson.Create;
   begin
      Name:= TStringList.Create;
      Count:= 0;


   end;

   destructor TPerson.Destroy;
   begin
      Name.Destroy;
   end;

   procedure Tperson.AddName( sName: string);
   begin
      Name.Add( sName );
      Count:= Count + 1;
   end;

   function Tperson.FirstPerson: string;
   begin
       Result:= Name[ 0 ];
   end;

   function Tperson.LastPerson: string;
   begin
       Result:= Name[ Count - 1 ];
   end;

   function Tperson.GetPerson( Position: Integer ): String;
   begin

       if ( Position >= Count ) or ( Position < 0 ) then begin
         ShowMessage( 'La posicion no se encuentra en el rango de cantidad de personas.' );
         exit;

       end;

       Result:= Name[ Position ];


   end;


end.

