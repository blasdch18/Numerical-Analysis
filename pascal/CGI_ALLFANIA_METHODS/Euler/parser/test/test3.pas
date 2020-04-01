program pepsd;

{$mode objfpc}{$H+}

uses
   gmap, gutil, mfunction;

function algo (const args : array of real) : real;
var
   i : integer;
   res : real;
begin
   res := 0;
   for i := 0 to length(args) do
   begin
      res :=  res + args[i];
   end;
   Result := res;
end;


type
   TStringCompare = specialize TLess<string>;
   TFunctionMap = specialize TMap<string, TFunc, TStringCompare>;
   TVarMap = specialize TMap<string, real, TStringCompare>;

var
   functions : TFunctionMap;
   vars : TVarMap;
   iter : TFunctionMap.TIterator;
   fnd : TVarMap.TIterator;
begin

   functions := TFunctionMap.create;
   vars := TVarMap.create;

   functions['algo'] := TFunc.create(@algo, 3);
   functions['otro'] := TFunc.create(@algo, 3);
   functions['mas'] := TFunc.create(@algo, 3);
   functions['xd'] := TFunc.create(@algo, 3);

   iter := functions.min;
   if (iter <> nil) then
   begin
      repeat
         writeln(iter.key, ' :: ', iter.value.solve([1,2,6]));
      until not iter.next;
   end;

   writeln('numero de opradoradores',functions['algo'].numOp);

   vars['uno'] := 1;
   vars['dos'] := 2;
   vars['tres'] := 3;
   vars['cuatro'] := 4;

   writeln(vars['cuatro']);
   fnd := vars.find('dos');
   writeln(fnd.value);

   fnd := vars.find('dos');
   fnd.value := 22;
   writeln(fnd.value,' ', vars['dos']);
   vars['tres'] := 33;
   writeln(vars['tres']);


end.
