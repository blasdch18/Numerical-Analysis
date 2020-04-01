program pepsd;

{$mode objfpc}{$H+}

uses
   gmap,  dialogs, gutil, mFunction, math, SysUtils, classes,
   mMaps, mParser, mValue;

function algo (const args : array of TValue) : TValue;
var
   i : integer;
   res : real;
begin
   res := 0;
   for i := 0 to length(args) do
   begin
      res :=  res + args[i].getVal()[0][0];
   end;
   Result := TValue.create(res);
end;

var
   functions : TFunctionMap;
   constants : TVarMap;
   pparser : TParser;
   list : TStringList;
   str : string;
begin

   functions := TFunctionMap.create;
   constants := TVarMap.create;

   functions['fsin'] := TFunc.create(@algo, 3);
   functions['fcos'] := TFunc.create(@algo, 3);
   functions['fln'] := TFunc.create(@algo, 3);
   functions['fbuildMat'] := TFunc.create(@algo, 0);
   constants['cpi'] := TValue.create(pi);

   pparser := TParser.create(@(functions), @(constants));
   //   str := '123 + -[-0.1 * 23 ,0.2,0.3;0.4,0.5,0.6] * [2,3;4,x]- 0.5';
   str := '[4,5,6;7,8,9;4,5,6]';
   list := pparser.parseString(str);
   list := pparser.toRpn(list);
   writeln(list.text);
end.
