program for_while;
uses crt;

var
  x:integer;


begin

  for x:=1 to 100 do
  begin

    write(x,' ');
    if(x mod 10=0) then
    begin
      writeln;
    end;
  end;

  writeln;
  readkey;

  x:=0;
  while x<=100 do
  begin
    write(x,' ');
    x:=x+1;
    end;


      readkey;

end.

