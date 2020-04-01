program test2;

{$mode objfpc}{$H+}

uses mFunction, fgl;

type
   MyMap = specialize TFPGMap<string, TFunc>;

   TOperator = record
      funcName : string;
      precedence : integer;
      assoc : integer;
   end;

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

function createOp (n : string; p, a : integer) : TOperator;
var
   res : TOperator;
begin
   res.funcName := n ;
   res.precedence := p;
   res.assoc := a;
   Result := res;
end;



var
   pr : TFunc;
   ff : real;
   unmap : MyMap;
   i : integer;
   unrec : TOperator;
   str : string;
   ch : char;
begin
   pr := TFunc.create(@algo, 3);
   ff := pr.solve([1,2,3]);
   writeln(ff);

   unmap := MyMap.create;
   unmap.sorted := true;

   unmap['algo'] := TFunc.create(@algo, 3);
   unmap['otro'] := TFunc.create(@algo, 3);
   unmap['mas'] := TFunc.create(@algo, 3);
   unmap['xd'] := TFunc.create(@algo, 3);

//   unmap['pepe'] := 123;
//   unmap['juan'] := 21;
//   unmap['alex'] := 32;
//   unmap['sofia'] := 91;
//   unmap['vale'] := 0;

//   unmap['alex'] := -1;
   for i := 0 to unmap.count - 1 do
   begin
      write (unmap.keys[i] + ' :: ');
      write(unmap.data[i].solve([1,2,3]));
      writeln();
   end;

   writeln(unmap.keyData['mas'].solve([1,2,4]));
   unrec := createOp('hola', 123, 0);

   writeln(unrec.funcName, unrec.precedence, unrec.assoc);
   ch := 'p';
   str := 'p';
   if (str[1] = ch) then
      writeln('ADASDS');

end.
