program arrays_matrices;
uses crt;

var
  vector:array[0..4] of integer;
  matriz:array[0..2,0..2] of integer;

  vector2:array[0..4] of integer=(6,7,8,9,10);

  matriz2:array[0..2,0..2] of integer=((9,8,7),
                                       (6,5,4),
                                       (3,2,1));
  i:integer;
  j:integer;

begin
  {vectores}
  {1,2,3,4,5}
  vector[0]:=1;
  vector[1]:=2;
  vector[2]:=3;
  vector[3]:=4;
  vector[4]:=5;

  for i:=0 to 4 do
      writeln(vector[i]);
  writeln();
  readkey;
  {matrices}

  {1,2,3}
  {4,5,6}
  {7,8,9}

  matriz[0,0]:=1;
  matriz[0,1]:=2;
  matriz[0,2]:=3;

  matriz[1,0]:=4;
  matriz[1,1]:=5;
  matriz[1,2]:=6;

  matriz[2,0]:=7;
  matriz[2,1]:=8;
  matriz[2,2]:=9;

  for i:=0 to 2 do
      begin
        for j:=0 to 2 do
            begin
              write(matriz[i,j]);
              write(' ');
            end;
        writeln();
      end;
  readkey;
end.

