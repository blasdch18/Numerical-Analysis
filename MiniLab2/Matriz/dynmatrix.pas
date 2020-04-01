unit DynMatrix;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

type

  { TMatrix }

  TMatrix = object
  private
  protected
    data: array of double;
    rows, cols: Longword;

    procedure Init(newrows, newcols: Longword);
    procedure TestData(out NumRows, NumCols: Longword);

  public
    procedure Load( fname: string);
    procedure Save( fname: string);
    procedure SetSize( NewRows, NewCols: LongWord);
    procedure SetValue( r, c: LongWord; v: double);
    function GetValue( r, c: LongWord): double;
    procedure Usetv( r, c: LongWord; v: double);
    function Ugetv( r, c: Longword): double;
    function GetPointer: pdouble;

    function IsGood: boolean;
    function NumCols: Longword;
    function NumRows: Longword;

    function t: TMatrix;
  end;

  TDoubleFunc = function(v: double): double;

function zeros( NumRows, NumCols: LongWord): TMatrix;
function ones( NumRows, NumCols: LongWord): TMatrix;
function eye( n: Longword): TMatrix;
function Mrandom( NumRows, NumCols: LongWord): TMatrix;
function Minc( NumRows, NumCols: LongWord): TMatrix;
function Mdiag(const D: TMatrix): TMatrix;
procedure ArrayToMatrix(M: TMatrix; const D: array of double);

function Mpow(const M: TMatrix; n: longword): TMatrix;
function Trans(const M: TMatrix): TMatrix;
function Minv(const M: TMatrix): TMatrix;
function Minv_fast(const M: TMatrix): TMatrix;

function MelementMult(const A, B: TMatrix): TMatrix;

function MisEqual(const A, B: TMatrix; eps: double): boolean;
function Mmin(const M: TMatrix): double;
function Mmax(const M: TMatrix): double;
function MmaxAbs(const M: TMatrix): double;
function MTrace(const M: TMatrix): double;
function MGetDiag(const M: TMatrix): TMatrix;

function Mfunc(const A: TMatrix; f: TDoubleFunc): TMatrix;

operator + (const A, B: TMatrix): TMatrix;
operator + (const A: TMatrix; k: double): TMatrix;
operator + (k: double; const A: TMatrix): TMatrix;
operator - (const A: TMatrix): TMatrix;
operator - (const A, B: TMatrix): TMatrix;
operator - (const A: TMatrix; k: double): TMatrix;
operator - (k: double; const A: TMatrix): TMatrix;
operator * (const A: TMatrix; k: double): TMatrix;
operator * (k: double; const A: TMatrix): TMatrix;
operator * (const A, B: TMatrix): TMatrix;
operator ** (const M: TMatrix; const n: integer): TMatrix;

function MHflip(const M: TMatrix): TMatrix;
function MConv(const A, B: TMatrix): TMatrix;

function MCrop(const M: TMatrix; uprow, leftcol, downrow, rightcol: Longword): TMatrix;
function MOneCol(const M:TMatrix; col: Longword): TMatrix;
function MOneRow(const M:TMatrix; row: Longword): TMatrix;

function MStamp(const M, S: TMatrix; drow, dcol: Longword): TMatrix;
function MStampCol(const M, S: TMatrix; col: Longword): TMatrix;
function MStampRow(const M, S: TMatrix; row: Longword): TMatrix;

function MColSum(const M: TMatrix): TMatrix;
function MRowSum(const M: TMatrix): TMatrix;

function MColSquareSum(const M: TMatrix): TMatrix;
function MColMax(const M: TMatrix): TMatrix;
function MColMin(const M: TMatrix): TMatrix;

function MColCenter(const M: TMatrix): TMatrix;

// Matrix data internal format
// | TdynDoubleArray ...   |
// |<- rows*cols doubles ->|

// Missing:
//function Mvflip(M:Matrix): Matrix;

//function MColNorm2(M:Matrix): Matrix;

//procedure MShape(M:Matrix; newrow,newcol: integer);
//procedure MShape2col(M:Matrix);
//procedure MShape2row(M:Matrix);

//function VDotProduct(A: TMatrix; B: TMatrix): TMatrix;
//function VExtProduct(A: TMatrix; B: TMatrix): TMatrix;
//function VNorm1(A: TMatrix; B: TMatrix): TMatrix;
//function VNorm2(A: TMatrix; B: TMatrix): TMatrix;
//function VNormInf(A: TMatrix; B: TMatrix): TMatrix;


implementation

uses math;

// <- Transpose of M
function Trans(const M: TMatrix): TMatrix;
var
  r,c: Longword;
begin
  result.Init(M.cols, M.rows);
  for c:=0 to M.cols-1 do
    for r:=0 to M.rows-1 do begin
      result.data[r + c * M.rows] := M.data[c + r * M.cols];
    end;
end;

// Zeros matrix
function zeros(numrows, numcols: LongWord): TMatrix;
begin
  result.SetSize(numrows, numcols);
end;

// Ones Matrix
function ones(numrows, numcols: LongWord): TMatrix;
var i: Longword;
begin
  result.Init(numrows, numcols);
  for i := 0 to numrows * numcols - 1 do begin
    result.data[i] := 1;
  end;
end;


// Identity matrix
function eye(n: Longword): TMatrix;
var i: Longword;
begin
  result.Init(n, n);
  for i := 0 to n - 1 do begin
    result.data[i + i * n] := 1;
  end;
end;

// Returns a Matrix with (numrows, numcols) elements with random values between 0 e 1
function Mrandom(numrows, numcols: LongWord): TMatrix;
var i: Longword;
begin
  result.Init(numrows, numcols);
  for i := 0 to numrows * numcols - 1 do begin
    result.data[i] := random;
  end;
end;

function Minc(numrows, numcols: LongWord): TMatrix;
var i: Longword;
begin
  result.Init(numrows, numcols);
  for i := 0 to numrows * numcols - 1 do begin
    result.data[i] := i;
  end;
end;


function Mdiag(const D: TMatrix): TMatrix;
var i, n: Longword;
begin
  n := D.rows * D.cols;
  result.Init(n, n);
  for i := 0 to n - 1 do begin
    result.data[i + i * n] := D.data[i];
  end;
end;

function MTrace(const M: TMatrix): double;
var i, n: Longword;
begin
  result := 0;
  n := min(M.rows, M.cols);
  for i := 0 to n - 1 do begin
    result += M.data[i + i * M.cols];
  end;
end;

function MGetDiag(const M: TMatrix): TMatrix;
var i, n: Longword;
begin
  n := min(M.rows, M.cols);
  result.Init(n, 1);
  for i := 0 to n - 1 do begin
    result.data[i] := M.data[i + i * M.cols];
  end;
end;



// <- M^n (power n of a square matrix M) with non-negative, integer n.
function Mpow(const M: TMatrix; n: longword): TMatrix;
begin
  result := M ** n;
end;


operator+(const A, B: TMatrix): TMatrix;
var i : LongWord;
begin
  if (A.rows <> B.rows) or (A.cols <> B.cols) then
    raise  Exception.Create(format('Cannot add matrix (%d,%d) with matrix (%d,%d)',[A.rows, A.Cols, B.rows, B.cols]));

  result.Init(A.rows,A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := A.data[i] + B.data[i];
  end;
  
end;


operator+(const A: TMatrix; k: double): TMatrix;
var i: LongWord;
begin
  result.Init(A.rows, A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := A.data[i] + k;
  end;

end;


operator + (k: double; const A: TMatrix): TMatrix;
begin
  result := A + k;
end;


// <- -A  ie R(i,j) := -A(i,j)
operator-(const A: TMatrix): TMatrix;
var i: LongWord;
begin
  result.Init(A.rows, A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := - A.data[i];
  end;

end;

// <- A-B  ie R(i,j) := A(i,j) - B(i,j)
operator-(const A, B: TMatrix): TMatrix;
var i: LongWord;
begin
  if (A.rows <> B.rows) or (A.cols <> B.cols) then
    raise  Exception.Create(format('Cannot subtract matrix (%d,%d) with matrix (%d,%d)',[A.rows, A.Cols, B.rows, B.cols]));

  result.Init(A.rows, A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := A.data[i] - B.data[i];
  end;

end;

operator-(const A: TMatrix; k: double): TMatrix;
var i: LongWord;
begin
  result.Init(A.rows, A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := A.data[i] - k;
  end;

end;

operator-(k: double; const A: TMatrix): TMatrix;
var i: LongWord;
begin
  result.Init(A.rows, A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := k - A.data[i];
  end;

end;

// <- A * k (k: double) ie R(i,j) := A(i,j) * k
operator*(const A: TMatrix; k: double): TMatrix;
var i: LongWord;
begin
  result.Init(A.rows, A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := A.data[i] * k;
  end;

end;

// <- k * A (k: double) ie R(i,j) := A(i,j) * k
operator*(k: double; const A: TMatrix): TMatrix;
begin
  result := A * k;
end;


// <- A*B
operator*(const A, B: TMatrix): TMatrix;
var r,c,i: LongWord;
  sum: double;
begin
  if A.cols <> B.rows then
    raise Exception.Create(format('Cannot multiply matrix (%d,%d) with matrix (%d,%d)',[A.rows, A.Cols, B.rows, B.cols]));

  result.Init(A.rows, B.cols);

  for r := 0 to A.rows-1 do begin
    for c := 0 to B.cols-1 do begin
      sum := 0;
      for i :=0 to A.cols-1 do begin
        sum := sum + A.data[r*A.cols + i] * B.data[c + i*B.cols];
      end;
      result.data[c + r*B.cols] := sum;
    end;
  end;
end;


// <- M^n (power n of a square matrix M) with non-negative, integer n.
operator**(const M: TMatrix; const n: integer): TMatrix;
var np: longword;
    P: TMatrix;
begin
  if n < 0 then begin
    result := Minv(M)**(-n);
    exit;
  end;
  // Must handle special cases: n = 0, and n = 1
  if n = 0 then begin
    result := eye(n);
    exit;
  end;

  result := M;

  if n = 1 then exit;

  // General case: n >= 2
  P := M;                         // P holds the current square
  np := n - 1;
  while (np >= 1) do begin
    if (np and 1) = 0 then begin  // np is even, we have a zero in the binary expansion
      np := np div 2;
    end else begin                // np is odd, we have a one in the binary expansion
      np := (np - 1) div 2;
      result := result * P;
    end;
    P := P * P;
  end;
end;


{ TMatrix }

procedure TMatrix.Init(newrows, newcols: Longword);
begin
  rows := NewRows;
  cols := NewCols;
  Setlength(data, rows * cols);
end;

// Inicializes a matrix with numrows lines and numcols columns
procedure TMatrix.SetSize(NewRows, NewCols: Longword);
begin
  rows := NewRows;
  cols := NewCols;
  Setlength(data, rows * cols);
end;

// get a pointer to the double array
function TMatrix.GetPointer: pdouble;
begin
  Setlength(data, rows * cols); // Make unique
  result := @data[0];
end;


// Write v to Element [r,c]
procedure TMatrix.SetValue(r, c: Longword; v: double);
begin
  Setlength(data, rows * cols); // Make unique
  if (r >= Rows) or (c >= Cols) then
    raise Exception.Create(format('Invalid (row,col) value. Matrix is (%d,%d), element required is (%d,%d)',[Rows, Cols, r,c]));
  data[c + r*Cols] := v;
end;

// Get Element [r,c]
function TMatrix.GetValue(r, c: Longword): double;
begin
  if (r >= Rows) or (c >= Cols) then
    raise Exception.Create(format('Invalid (row,col) value. Matrix is (%d,%d), element required is (%d,%d)',[Rows, Cols, r,c]));
  result := data[c + r*Cols];
end;

// Write to v Element [r,c] , ignore operation if r,c is out of bounds
procedure TMatrix.Usetv(r, c: Longword; v: double);
begin
  Setlength(data, rows * cols);  // Make unique
  if (r >= Rows) or (c >= Cols) then exit;
  data[c + r*Cols] := v;
end;

// Get Element [r,c], 0 if r,c out of bounds
function TMatrix.Ugetv(r, c: Longword): double;
begin
  if (r >= Rows) or (c >= Cols) then begin
    result := 0;
    exit;
  end;
  result := data[c + r*Cols];
end;


procedure TMatrix.TestData(out NumRows, NumCols: Longword);
begin
  NumRows := rows;
  NumCols := cols;
  
  if data=nil then
    raise Exception.Create('Invalid matrix: nil data');

  if not (rows>0) then
    raise  Exception.Create('Invalid number of rows:'+inttostr(rows));

  if not (cols>0) then
    raise  Exception.Create('Invalid number of columns:'+inttostr(cols));

  if longword(length(data)) <> (rows * cols) * sizeof(double) then
    raise  Exception.Create('Invalid matrix: incompatible data size');
end;

// Get total number of columns
function TMatrix.NumCols: Longword;
begin
  result := cols;
end;


// Get total number of rows
function TMatrix.NumRows: Longword;
begin
  result := rows;
end;

function TMatrix.t: TMatrix;
begin
  result := Trans(Self);
end;


// Test the matrix goodness:
//  if the number of row and cols is not zero
//  if the string size is compatible with expected embeded array
// Returns true if it is good
function TMatrix.IsGood: boolean;
begin
  result := false;
  if (pointer(data) = nil) then exit;

  if (rows > 0) and (cols > 0) and (longword(length(data)) = (rows*cols)) then
    result := True;
end;


procedure TMatrix.Load(fname: string);
var
  r,c,lines,rxc: integer;
  F: TextFile;
  dum: double;
begin
  //result := zeros(0,0);
  AssignFile(F, fname);
  Reset(F);
  lines:=0;
  while not eof(F) do begin
    readln(F);
    inc(lines);
  end;
  CloseFile(F);

  AssignFile(F, fname);
  Reset(F);
  rxc := -1;
  dum := 0;  // no warning
  while not eof(F) do begin
    read(F,dum);
    inc(rxc);
  end;
  CloseFile(F);

  if (lines <= 0) or (rxc <= 0) or (((rxc div lines) * lines) <> rxc) then
     raise  Exception.Create('File: ' + fname + ' Bad file format: can not load matrix');

  //zeros(lines,rxc div lines);
  rows := lines;
  cols := rxc div lines;
  Setlength(data, rows * cols);

  AssignFile(F, fname);
  Reset(F);
  for r := 0 to lines - 1 do begin
    for c := 0 to (rxc div lines) - 1 do begin
      read(F, dum);
        //setv(r,c,dum);
      data[c + r * Cols] := dum;
    end;
  end;
  CloseFile(F);
end;


procedure TMatrix.Save(fname: string);
var r,c: integer;
    F: TextFile;
begin
  AssignFile(F, fname);
  Rewrite(F);
  for r := 0 to rows - 1 do begin
    for c := 0 to cols - 1 do begin
      write(F, data[c + r*Cols]);
      write(F,' ');
    end;
    write(F, chr($0d) + chr($0a));
  end;
  CloseFile(F);
end;


// Returns A+B
function MAdd(A: TMatrix; B: TMatrix): TMatrix; inline;
begin
  result := A + B;
end;


// Returns M^-1
function Minv(const M: TMatrix): TMatrix;
var
  ROW, COL: array of Longword;
  MatINV, MatTMP: TMatrix;
  HOLD , I_pivot , J_pivot: Longword;
  fv, pivot, abs_pivot, rel_eps: double;
  n, i, j, k, {r, c,} rin, rkn, ck, cj: Longword;
begin
//  M.GetData(r, c, Mda);
  if M.cols <> M.rows then // c:= M.cols r := M.rows
    raise Exception.Create('Cannot invert non-square matrix');

  n := M.cols;
  SetLength(ROW, n);
  SetLength(COL, n);
  MatTMP := zeros(n, n);
  MatINV := M;

  SetLength(MatINV.data, MatINV.rows * MatINV.cols);  // Make unique

  // Set up row and column interchange vectors
  for k := 0  to n-1 do begin
    ROW[k] := k;
    COL[k] := k;
  end;

  // Find largest element
  rel_eps := 0;
  for i := 0 to n-1 do begin
    for j := 0  to n-1 do begin
      fv := abs(MatINV.data[ROW[i]*n + COL[j]]);
      if  fv > rel_eps then begin
        rel_eps := fv ;
      end;
    end;
  end;
  rel_eps := rel_eps * 1e-15;


  // Begin main reduction loop
  for k := 0  to n-1 do begin
    // Find largest element for pivot
    pivot := MatINV.data[ROW[k]*n+COL[k]];
    abs_pivot := abs(pivot);
    I_pivot := k;
    J_pivot := k;
    for i := k to n-1 do begin
      for j := k  to n-1 do begin
        //abs_pivot := abs(pivot);
        fv := MatINV.data[ROW[i]*n+COL[j]];
        if  abs(fv) > abs_pivot then begin
          I_pivot := i;
          J_pivot := j;
          pivot := fv;
          abs_pivot := abs(pivot);
        end;
      end;
    end;
    if abs(pivot) < rel_eps then
      raise Exception.Create(format('Singular matrix: Pivot is %g, max element = %g',[pivot, rel_eps]));

    HOLD := ROW[k];
    ROW[k] := ROW[I_pivot];
    ROW[I_pivot] := HOLD;

    HOLD := COL[k];
    COL[k] := COL[J_pivot];
    COL[J_pivot] := HOLD;

    rkn := ROW[k]*n;
    ck := COL[k];

    // Reduce around pivot
    MatINV.data[rkn + ck] := 1.0 / pivot ;
    for j :=0 to n-1 do begin
      if j <> k  then begin
        cj := COL[j];
        MatINV.data[rkn + cj] := MatINV.data[rkn + cj] * MatINV.data[rkn + ck];
      end;
    end;

    // Inner reduction loop
    for i := 0 to n-1 do begin
      rin := ROW[i]*n;
      if k <> i then begin
        fv := MatINV.data[rin + ck];
        for j := 0 to n-1 do begin
          if  k <> j then begin
            cj := COL[j];
            MatINV.data[rin + cj] := MatINV.data[rin + cj] - fv * MatINV.data[rkn + cj] ;
          end;
        end;
        MatINV.data[rin + ck] := - MatINV.data[rin + ck] * MatINV.data[rkn + ck];
      end;
    end;
  end; // end of main reduction loop

  // Unscramble rows
  for j := 0  to n-1 do begin
    for i := 0 to n-1 do begin
      MatTMP.data[COL[i]] := MatINV.data[ROW[i]*n + j];
    end;
    for i := 0 to n-1 do begin
      MatINV.data[i*n + j] := MatTMP.data[i];
    end;
  end;

  // Unscramble columns
  for i := 0 to n-1 do begin
    for j := 0 to n-1 do begin
      MatTMP.data[ROW[j]] := MatINV.data[i*n + COL[j]];
    end;
    for j := 0 to n-1 do begin
      MatINV.data[i*n+j] := MatTMP.data[j];
    end;
  end;

  result := MatInv;
end;


// Returns M^-1
// Faster and less acurate version
function Minv_fast(const M: TMatrix): TMatrix;
var dim,r,c,t,pivrow,k: Longword;
  pivmax,pivot: double;
  INV,TMP: TMatrix;
  ex,pdisp,cdisp:Longword;
  dtmp,victim,rk,norm,invnorm: double;
  Mzero : double;
begin
  if M.cols <> M.rows then
    raise Exception.Create('Cannot invert non-square matrix');

  dim := M.rows;
  INV := eye(dim);
  TMP := M;

  setlength(TMP.data, TMP.cols * TMP.rows);  // Make unique

  MZero := 1e-10;
  for c := 0 to dim - 1 do begin
    // find the greatest pivot in the remaining columns
    pivmax := abs(TMP.data[c + c*dim]);
    pivrow := c;
    for k := c + 1 to dim - 1 do begin
      if abs(TMP.data[c + k*dim]) > pivmax then begin
        pivmax := abs(TMP.data[c + k*dim]);
	pivrow:=k;
      end;
    end;
    pivot:= TMP.data[c + pivrow*dim];
    if abs(pivot) < Mzero then
      raise Exception.Create('Singular matrix: Pivot is '+floattostr(pivot));

    if pivrow <> c then begin
      // swap lines
      pdisp:=pivrow*dim;
      cdisp:=c*dim;
      for ex:=c to dim-1 do begin
        dtmp:=TMP.data[cdisp+ex];
        TMP.data[cdisp+ex]:=TMP.data[pdisp+ex];
        TMP.data[pdisp+ex]:=dtmp;
      end;
      for ex:=0 to dim-1 do begin
	dtmp:=INV.data[cdisp+ex];
        INV.data[cdisp+ex]:=INV.data[pdisp+ex];
        INV.data[pdisp+ex]:=dtmp;
      end;
    end;

    for r:=0 to dim-1 do begin
      if r<>c then begin
        victim:=TMP.data[c+r*dim];
        rk:=-victim/pivot;
        for t:=0 to dim-1 do INV.data[r*dim+t]:= INV.data[r*dim+t] + rk * INV.data[c*dim+t];
        for t:=c+1 to dim-1 do TMP.data[r*dim+t]:= TMP.data[r*dim+t] + rk * TMP.data[c*dim+t];
      end;
    end;
  end;

  // normalize the pivots
  for r := 0 to dim - 1 do begin
    norm := TMP.data[r + r*dim];
    if abs(norm) < Mzero then
       raise Exception.Create('Singular matrix: Pivot has been '+floattostr(norm));
    invnorm := 1.0 / norm;
    for c := 0 to dim - 1 do
	    INV.data[c + r*dim] := INV.data[c + r*dim] * invnorm;
  end;
  result:=INV;
end;


function MisEqual(const A, B: TMatrix; eps: double): boolean;
var i : LongWord;
begin
  result := false;
  if (A.rows <> B.rows) or (A.cols <> B.cols) then exit;

  for i := 0 to A.rows * A.cols - 1 do begin
    if abs(A.data[i] - B.data[i]) > eps then exit;
  end;
  result := true;
end;


// Returns max M(i,j)
function Mmax(const M: TMatrix): double;
var i: Longword;
begin
  result := M.data[0];
  for i := 1 to M.rows * M.cols - 1 do begin
    if (result < M.data[i]) then result := M.data[i];
  end;
end;


// Returns max |M(i,j)|
function MmaxAbs(const M: TMatrix): double;
var i: Longword;
begin
  result := abs(M.data[0]);
  for i := 1 to M.rows * M.cols - 1 do begin
    if (result < abs(M.data[i])) then result := abs(M.data[i]);
  end;
end;


// Returns A .* B (Element-wise mutiplication)
function MelementMult(const A, B: TMatrix): TMatrix;
var i: LongWord;
begin
  if (A.rows <> B.rows) or (A.cols <> B.cols) then
    raise  Exception.Create(format('Cannot Element-wise mutiply matrix (%d,%d) with matrix (%d,%d)',[A.rows, A.Cols, B.rows, B.cols]));

  result.Init(A.rows,A.cols);

  for i := 0 to A.rows * A.cols - 1 do begin
    result.data[i] := A.data[i] * B.data[i];
  end;

end;

// Returns min M(i,j)
function Mmin(const M: TMatrix): double;
var i: Longword;
begin
  result := M.data[0];
  for i := 1 to M.rows * M.cols - 1 do begin
    if (result > M.data[i]) then result := M.data[i];
  end;
end;


function Mfunc(const A: TMatrix; f: TDoubleFunc): TMatrix;
var i: Longword;
begin
  result := A;
  SetLength(result.data, result.rows * result.cols);  // Make unique

  for i := 0 to result.rows * result.cols - 1 do begin
    result.data[i] := f(result.data[i]);
  end;
end;




// <- Reverse Columns
function Mhflip(const M: TMatrix): TMatrix;
var r,c: Longword;
begin
  result.Init(M.rows, M.cols);
  for r := 0 to M.rows - 1 do begin
    for c:= 0 to M.cols-1 do begin
      result.data[c + r * M.rows] := M.data[(M.cols - 1) - c + r * M.cols];
    end;
  end;
end;


// Returns row convolution between A and B
function MConv(const A, B: TMatrix): TMatrix;
var ar,br,disp,r,c,i: Longword;
    pivot,prod: double;
begin
  result := zeros(A.rows * B.rows, A.cols + B.cols - 1);

  for ar:=0 to A.rows-1 do begin
    for br:=0 to B.rows-1 do begin
      for disp:=0 to A.cols-1 do begin
        r:=ar*B.rows+br;
        pivot:= A.data[disp+ar*A.cols];
        for i:=0 to B.cols-1 do begin
          prod := pivot * B.data[i+br*B.cols];
          c:=disp+i;
          result.data[c+r*result.cols]:=result.data[c+r*result.cols] + prod;
        end;
      end;
    end;
  end;
end;


// Fill matrix A with the elements from array D
procedure ArrayToMatrix(M: TMatrix; const D: array of double);
var i: Longword;
begin
  if M.rows * M.cols <> length(D) then
    raise  Exception.Create('Const Array size does not match Matrix size');

  for i := 0 to M.cols * M.rows - 1 do begin
    M.data[i] := D[i];
  end;
end;



// Returns a submatrix from M
function MCrop(const M: TMatrix; uprow, leftcol, downrow, rightcol: Longword): TMatrix;
var rowsize,colsize,r,c: Longword;
begin
  rowsize:=downrow-uprow+1;
  colsize:=rightcol-leftcol+1;
  if (rowsize < 1) or (colsize < 1) then
     raise  Exception.Create('Invalid number of rows/cols:'+inttostr(rowsize)+'/'+inttostr(colsize));

  if (downrow > M.rows-1) or (rightcol > M.cols-1) then
     raise  Exception.Create('Invalid number of rows/cols:'+inttostr(downrow)+'/'+inttostr(rightcol));

  result.init(rowsize,colsize);

  for r:=0 to result.rows-1 do begin
    for c:=0 to result.cols-1 do begin
      result.data[c+r*result.cols]:= M.data[c+leftcol+(r+uprow)*M.cols];
    end
  end;
end;


// Returns one col from M
function MOneCol(const M:TMatrix; col: Longword): TMatrix;
begin
  result := Mcrop(M, 0, col, M.rows - 1, col)
end;


// Returns one row from M
function MOneRow(const M:TMatrix; row: Longword): TMatrix;
begin
  result := Mcrop(M, row, 0, row, M.cols - 1)
end;



// Returns a matrix with part of matrix M replaced with matrix S
function MStamp(const M, S: TMatrix; drow, dcol: Longword): TMatrix;
var r,c: Longword;
begin
  if (drow + S.rows > M.rows) or (dcol + S.cols > M.cols) then
     raise  Exception.Create(format('Matrix(%d,%d) does not fit im matrix(%d,%d)!',[M.rows, M.cols, S.rows, S.cols]));

  result := M;
  SetLength(result.data, result.rows * result.cols);  // Make unique

  for c:=0 to S.cols-1 do begin
    for r:=0 to S.rows-1 do begin
      result.data[c+dcol+(r+drow)*result.cols]:= S.data[c+r*S.cols];
    end
  end;
end;

// Returns a matrix where one column of M with index col was replaced by S
function MStampCol(const M, S: TMatrix; col: Longword): TMatrix;
begin
  result := MStamp(M, S, 0, col);
end;

// Returns a matrix where one row of M with index row was replaced by S
function MStampRow(const M, S: TMatrix; row: Longword): TMatrix;
begin
  result := MStamp(M, S, row, 0);
end;



// Returns a matrix with the sum of all M columns
function MColsum(const M: TMatrix): TMatrix;
var r,c: Longword;
begin
  result := zeros(1, M.cols);

  for c:=0 to M.cols-1 do begin
    for r:=0 to M.rows-1 do begin
      result.data[c] := result.data[c] + M.data[c + r * M.cols];
    end
  end;
end;

// Returns a matrix with the sum of all M rows
function MRowsum(const M: TMatrix): TMatrix;
var r,c: Longword;
begin
  result := zeros(M.rows, 1);

  for r:=0 to M.rows-1 do begin
    for c:=0 to M.cols-1 do begin
      result.data[r] := result.data[r]+ M.data[c + r * M.cols];
    end
  end;
end;

// Returns a matrix with the sum of squares for all M columns
function MColSquareSum(const M: TMatrix): TMatrix;
var r,c: Longword;
begin
  result := zeros(1, M.cols);

  for c:=0 to M.cols-1 do begin
    for r:=0 to M.rows-1 do begin
      result.data[c] := result.data[c] + sqr(M.data[c + r * M.cols]);
    end
  end;
end;


// Returns a matrix with zero mean for all M columns
function MColCenter(const M: TMatrix): TMatrix;
var r,c: Longword;
    Mean: TMatrix;
begin
  result := M;
  if M.rows = 0 then exit;

  Mean := zeros(1, M.cols);

  // Column Sum
  for c:=0 to M.cols - 1 do begin
    for r:=0 to M.rows - 1 do begin
      Mean.data[c] := Mean.data[c] + M.data[c + r * M.cols];
    end
  end;

  // Column Mean
  for c:=0 to M.cols - 1 do begin
    Mean.data[c] := Mean.data[c] / M.rows;
  end;

  for c:=0 to M.cols - 1 do begin
    for r:=0 to M.rows - 1 do begin
      result.data[c + r * M.cols] := M.data[c + r * M.cols] - Mean.data[c];
    end
  end;

end;


// Returns a matrix with the max value for each M column
function MColMax(const M: TMatrix): TMatrix;
var r,c: Longword;
begin
  result := zeros(1, M.cols);

  for c:=0 to M.cols-1 do begin
    result.data[c] := M.data[c];
    for r:=1 to M.rows-1 do begin
      result.data[c] := max(result.data[c], M.data[c + r * M.cols]);
    end
  end;
end;

// Returns a matrix with the min value for each M column
function MColMin(const M: TMatrix): TMatrix;
var r,c: Longword;
begin
  result := zeros(1, M.cols);

  for c:=0 to M.cols-1 do begin
    result.data[c] := M.data[c];
    for r:=1 to M.rows-1 do begin
      result.data[c] := min(result.data[c], M.data[c + r * M.cols]);
    end
  end;
end;

//{$R+}

initialization

end.
