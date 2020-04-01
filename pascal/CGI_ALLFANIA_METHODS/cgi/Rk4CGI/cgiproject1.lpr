program cgiproject1;

{$mode objfpc}{$H+}

uses
  fpCGI, Unit1, Rk4;

begin
  Application.Title:='cgiproject1';
  Application.Initialize;
  Application.Run;
end.

