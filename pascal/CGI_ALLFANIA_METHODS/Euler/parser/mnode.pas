unit mNode;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, math, mMaps, mMatrix;

type
   PtrNode = ^Tnode;
   TNode = class       //node with a list of its childs
   public
      value : string;
      childs : TList;
      constructor Create(sValue : string); overload;// This constructor uses defaults
      destructor Destroy; override;
      function empty() : boolean;
      function display() : string;        //shows its value and a list of its childs
      procedure addChild(newChild : PtrNode);      //add a new child
      function solve(functions : PtrFunctionMap; vars : PtrVarMap ; consts : PtrVarMap ) : TMatrix;

      function isFunct(functions : PtrFunctionMap; str : string) : boolean;
      function isvar(vars: PtrVarMap; str : string) : boolean;
      function isconst(consts: PtrVarMap; str : string) : boolean;
   end;

implementation

constructor TNode.Create(sValue : string);
begin
   self.value := sValue;
   childs := TList.Create;
end;

procedure Tnode.addChild(newChild : PtrNode);
begin
   if empty() then
      childs.Add(newChild)
   else
   begin
      childs.Insert(0, newChild);
   end;
end;

destructor TNode.Destroy;
begin
   childs.Destroy;
end;

function TNode.empty() : boolean;
begin
   Result := childs.count = 0;
end;

function TNode.display(): string;
var
   content : string;
   ptr : PtrNode;
   i : Integer;
begin
   content := value + '{';
   for i := 0 to childs.count - 1 do
   begin
      ptr := childs.Items[i];
      content := content + ptr^.value ;
      content := content + ' ';
   end;
   content := content + '}' ;
   Result := content;
end;

function TNode.solve(functions : PtrFunctionMap; vars: PtrVarMap ; consts: PtrVarMap ) : TMatrix;
var
   tmpPtrNode1, tmpPtrNode2 : PtrNode;
   args : array of TMatrix;
   i : integer;
   auxReal : real;
begin
   if self.empty() then
   begin
      if isvar(vars,value) then
         exit(vars^[value])
      else if isconst(consts,value) then
         exit(consts^[value])
      else
      begin
         if (tryStrToFloat(value, auxReal)) then
            exit(createMatrix(auxReal))
         else
            exit(createMatrix(NaN));
      end;
   end;

   if (value = '=') then
   begin
      tmpPtrNode1 := childs.Items[0]; // Variable a asignar
      tmpPtrNode2 := childs.Items[1]; // Número asignado

      vars^[tmpPtrNode1^.value] := tmpPtrNode2^.solve(functions, vars,consts);
      exit(vars^[tmpPtrNode1^.value]);
   end
   else
   begin
      setLength(args, childs.count);
      for i := 0 to childs.count - 1 do
      begin
         tmpPtrNode1 := childs.Items[i];
         if isFunct(functions, tmpPtrNode1^.value) then
            args[i] := tmpPtrNode1^.solve(functions, vars,consts)
         else if isvar(vars,tmpPtrNode1^.value)then
            args[i] := vars^[tmpPtrNode1^.value]
         else if isconst(consts,tmpPtrNode1^.value) then
            args[i] := consts^[tmpPtrNode1^.value]
         else
         begin
            if (tryStrToFloat(tmpPtrNode1^.value, auxReal)) then
               args[i] := createMatrix(auxReal)
            else
               args[i] := createMatrix(NaN);
         end;
      end;
      exit(functions^[value].solve(args));
   end;
end;


function TNode.isFunct(functions : PtrFunctionMap; str : string) : boolean;
begin
   Result := functions^.find(str) <> nil;
end;

function TNode.isvar(vars: PtrVarMap ; str : string) : boolean;
begin
   Result := vars^.find(str)  <> nil;
end;

function TNode.isconst(consts: PtrVarMap; str : string) : boolean;
begin
   Result := consts^.find(str) <> nil;
end;

end.
