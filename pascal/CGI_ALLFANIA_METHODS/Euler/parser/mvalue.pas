unit mValue;

{$mode objfpc}{$H+}

interface
//uses
//gmap, gutil, mFunction;

type

   TMatrix =  array of array of real;
   TValueType = (nReal, nMatrix);

   // Esta clase almacena valores, ya sean reales o matrices
   TValue = class
   private
      _val : TMatrix;
      _type : TValueType;

      procedure setType();
   public
      constructor create(mat : TMatrix); overload;
      constructor create(rows, cols : integer; vals : array of real); overload;
      constructor create(val : real); overload;

      procedure setVal(other : TMatrix); overload;
      procedure setVal(rows, cols : integer; vals : array of real); overload;
      procedure setVal(val : real); overload;

      function getVal() : TMatrix;
      function getType() : TValueType;

      procedure copy(other : TValue);
      function cols() : integer;
      function rows() : integer;
   end;

implementation

constructor TValue.create(mat : TMatrix);
begin
   self._val := mat;
   self.setType()
end;

constructor TValue.create(rows, cols : integer; vals : array of real);
var
   i, j, k : integer;
begin
   setLength(self._val, rows, cols);

   k := 0;
   for i := 0 to rows - 1 do
   begin
      for j := 0 to cols - 1 do
      begin
         self._val[i][j] := vals[k];
         k := k + 1;
      end;
   end;
   self.setType()
end;

constructor TValue.create(val : real); overload;
begin
   setLength(self._val,1 , 1);
   self._val[0][0] := val;
   self.setType()
end;

procedure TValue.setVal(other : TMatrix);
begin
   self._val := other;
   self.setType()
end;

procedure TValue.setVal(rows, cols : integer; vals : array of real);
var
   i, j, k : integer;
begin
   setLength(self._val, rows, cols);

   k := 0;
   for i := 0 to rows - 1 do
   begin
      for j := 0 to cols - 1 do
      begin
         self._val[i][j] := vals[k];
         k := k + 1;
      end;
   end;
   self.setType()
end;

procedure TValue.setVal(val : real);
begin
   setLength(self._val,1 , 1);
   self._val[0][0] := val;
   self.setType()
end;

function TValue.getVal() : TMatrix;
begin
   Result := self._val;
end;

function TValue.getType() : TValueType;
begin
   Result := self._type;
end;

function TValue.rows() : integer;
begin
   Result := length(self._val);
end;


function TValue.cols() : integer;
begin
   Result := length(self._val[0]);
end;

procedure TValue.setType();
begin
   // if (length(other) = 0) -> Está vació, no existe caso en el que suceda esto?
   if ((length(self._val) > 1) or (length(self._val[0]) > 1)) then
      self._type := nMatrix
   else
      self._type := nReal;
end;

procedure TValue.copy(other : TValue);
begin
   self._val := other.getVal();
   self._type := other.getType();
end;

end.
