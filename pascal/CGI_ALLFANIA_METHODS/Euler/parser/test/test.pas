program ParserTest;

{$mode objfpc}{$H+}

uses
   Classes, SysUtils, mParser;

var
   pparser : TParser;
   list,rpn, other : TStringList;
   op : string;
   ss : string;
   i, pre,cnt : Integer;


begin
   pparser := TParser.create;
   //   op := '3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3';
   op := 'sin ( max ( 2, 3 ) / 3 * pi )';
   list := pparser.parseString(op);

   for i := 0 to list.count - 1 do
   begin
         writeln(list[i][1]);
   end;


   writeln('---' + list[list.count - 1]);

   i := 0;
   while (list[i][1] <> '(') do
   begin
      writeln(list[i]);
      i := i + 1;
   end;
   writeln('---');
   rpn := pparser.toRPN(list);
   writeln(rpn.text);

   other := TStringList.create;
   other.addStrings(['a','b','c','d','e','f']);
   for i := 0 to other.count - 1 do
   begin
         write(other[i]);
   end;
   writeln();
   cnt := other.count - 1;
   i := 0;
   while (i < cnt) do
   begin
      if (other[i] = 'c') then
      begin;
         other.delete(i);
         cnt := other.count - 1;
      end;
      write(other[i]);
      i := i + 1;
   end;
   writeln();

   op := '-1 + 2 - 3 * -4 / -(-5 - 6)';
   list := pparser.parseString(op);
   for i := 0 to list.count - 1 do
   begin
         write(list[i] + ' | ');
   end;
   writeln();
   rpn := pparser.toRPN(list);
   for i := 0 to rpn.count - 1 do
   begin
      write(rpn[i] + ' ');
   end;
   writeln();



end.
