unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TSerieTAylor = class
    Error : real;
    x : real;
    tipotaylor: integer;
    function execute : real;

  private
    it: integer;
    Xn , Xn_ant , ErrorCal: real;

    function seno(): real;
    function coseno(): real;
    function ex(): real;


  end;

implementation

end.

