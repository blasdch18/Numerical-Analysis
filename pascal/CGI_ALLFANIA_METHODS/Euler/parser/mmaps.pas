unit mMaps;

{$mode objfpc}{$H+}

interface
uses
   gmap, gutil, mFunction, mMatrix;

type
   TStringCompare = specialize TLess<string>;
   TFunctionMap = specialize TMap<string, TFunc, TStringCompare>;
   TVarMap = specialize TMap<string, TMatrix, TStringCompare>;

   PtrFunctionMap = ^TFunctionMap;
   PtrVarMap = ^TVarMap;
implementation
end.
