unit DynMatrixUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dynmatrix;

// Fill StringGrid with matrix elements
//procedure DMatrixToGrid(SG: TStringGrid; M: TMatrix);

// Fill matrix with StringGrid values
//function StringGridToMDatrix(SG: TStringGrid) : TMatrix;

// Converts string representation to a TMatrix
function StringListToDMatrix(SL: TStrings): TMatrix;

// Adds to TS all the elements from matrix A, line by line
procedure MAddToStringList(M: TMatrix; TS: TStrings; FormatString: string = '%.6g'; ItemSeparator: string = ' ');

// Converts a String representation to a TMatrix
// a11 a12 a13; a12 a22 a23;
function StringToDMatrix(str: string): TMatrix;

implementation



{// Fill StringGrid with matrix elements
procedure DMatrixToGrid(SG: TStringGrid; M: TMatrix);
var r,c: integer;
begin
  SG.RowCount := integer(M.NumRows) + SG.FixedRows;
  SG.ColCount := integer(M.NumCols) + SG.FixedCols;

  for r := 0 to M.NumRows - 1 do begin
    for c := 0 to M.NumCols - 1 do begin
      SG.cells[c + SG.FixedCols, r + SG.FixedRows] := FloatToStr(M.getv(r, c));
    end;
  end;
end;


// Fill matrix with StringGrid values
function StringGridToMDatrix(SG: TStringGrid) : TMatrix;
var r,c: integer;
begin
  result := Mzeros(SG.RowCount - SG.FixedRows, SG.ColCount - SG.FixedCols);

  for r := 0 to result.NumRows - 1 do begin
    for c := 0 to result.NumCols - 1 do begin
      result.setv(r, c, StrToFloat(SG.Cells[c + SG.Fixedcols, r + SG.Fixedrows]));
    end;
  end;
end;}


// Fill each line of a TStringList with the text that is found between the separator
// chars given by separatorList.
// Consecutive separators are treated as one.
procedure ParseString(s, separatorList: string; sl: TStringList);
var p, i, last: integer;
begin
  sl.Clear;
  last := 1;
  for i := 1 to length(s) do begin
    p := Pos(s[i], separatorList);
    if p > 0 then begin
      if i <> last then
        sl.add(copy(s,last,i-last));
      last := i + 1;
    end;
  end;
  if last <= length(s) then
    sl.add(copy(s, last, length(s) - last + 1));
end;


// Converts a StringList representation to a TMatrix
function StringListToDMatrix(SL: TStrings): TMatrix;
var
  r,c,lines,rxc : integer;
  s : string;
  SLRow : TStringList;
begin
  result := zeros(0,0);
  lines := SL.Count;
  if lines < 1 then
    raise Exception.Create('StringListToDMatrix error: stringlist with zero lines');

  s := SL.Strings[0];
  slRow := TStringList.Create;

  try
    ParseString(s, ' ', slRow);
    rxc := slRow.Count;
    if rxc < 1 then
      raise Exception.Create('StringListToDMatrix error: first line with zero columns');

    result := zeros(lines, rxc);

    for r := 0 to SL.Count - 1 do begin
      s := SL.Strings[r];
      ParseString(s, ' ', slRow);
      if slRow.Count <> rxc then
        raise Exception.Create(format('StringListToDMatrix error: line %d with %d columns instead of %d',[r, slRow.Count, rxc]));

      for c := 0 to slRow.Count - 1 do begin
        result.SetValue(r, c, StrToFloat(slRow[c]));
      end;
    end;
  finally
    slRow.Free;
  end;

end;



// Adds to TS all the elements from matrix A, line by line
procedure MAddToStringList(M: TMatrix; TS: TStrings; FormatString: string = '%.6g'; ItemSeparator: string = ' ');
var
    r,c,rows, cols: Longword;
    sr: string;
begin
  rows := m.NumRows;
  cols := m.NumCols;

  for r:=0 to rows-1 do begin
    sr:='';
    for c:=0 to cols-1 do begin
      if sr <> '' then sr := sr + ItemSeparator;
      sr := sr + format(FormatString, [m.GetValue(r,c)]);
    end;
    TS.add(sr);
  end;
end;


// Converts a String representation to a TMatrix
// a11 a12 a13; a12 a22 a23;
function StringToDMatrix(str: string): TMatrix;
var SL: TStringList;
begin
  if str = '' then
    raise Exception.Create('StringToDMatrix error: empty string');

  SL := TStringList.Create;
  ParseString(str, ';', SL);
  try
    result := StringListToDMatrix(SL);

  finally
    SL.Free;
  end;

end;


end.



