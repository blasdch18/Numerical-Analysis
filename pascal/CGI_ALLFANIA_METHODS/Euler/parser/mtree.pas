unit mTree;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, mNode, mMaps, mMatrix;

type

   TTree = class
   private
      root:TList;   // raiz como lista (para transformar posfija a arbol de expresion)
      functions : PtrFunctionMap;
      constants : PtrVarMap;
      variables : PtrVarMap;

   public
      constructor create(funcMap : PtrFunctionMap; constMap : PtrVarMap; varMap : PtrVarMap ); overload;
      destructor destroy; override;
      procedure pushNode(val : TNode);
      procedure clearRoot();
      function empty() : boolean;
      function display(): string;
      function top() : PtrNode;
      function size() : integer;
      function pop() : string;
      function solve() : TMatrix;
      procedure insertRpnTerm (term : string);
   end;

   PtrTree = ^TTree;

implementation

constructor TTree.create(funcMap : PtrFunctionMap; constMap : PtrVarMap; varMap : PtrVarMap );
begin
   root := TList.create;
   self.functions := funcMap;
   self.constants := constMap;
   self.variables := varMap;
end;

destructor TTree.destroy;
begin
   root.destroy;
end;

procedure TTree.pushNode(val : TNode);
var
   pnode : PtrNode;
begin
   new (pnode);
   pnode^ := val;
   root.Add(pnode);
end;

procedure TTree.clearRoot();
begin
   root.clear;
end;

function TTree.size() : integer;
begin
   Result := root.count;
end;

function TTree.empty() : boolean;
begin
   Result := root.count = 0;
end;

function TTree.display() : string;  //display the child's list
var
   content : string;
   pnode : PtrNode;
   i : integer;
begin

   for i:=0 to root.count - 1 do
   begin
      pnode := root.Items[i];
      content := content + (pnode^.display());
      content := content + ' ';
   end;

   Result := content;
end;

function TTree.pop() : string;
var
   ptr : ^string;
begin
   if (not self.empty()) then
   begin
      ptr := root.Items[root.count - 1];
      Result := ptr^;
      root.remove(ptr);
   end
   else
      Result := '-1';
end;

function TTree.top() : PtrNode;
begin
   Result := root.Items[root.count - 1];
end;

function TTree.solve() : TMatrix;
var
   pnode : PtrNode;
begin
   pnode := root.Items[0];      //TODO: comprobar que el arbol fue seteado
   Result := pnode^.solve(functions, variables, constants);
end;

procedure TTree.insertRpnTerm (term : string);
var
   node1 : TNode;
   pnode1 : PtrNode;
   numop1 : integer;
   i : integer;
   // Para la matriz:
   ptrNodeRows, ptrNodeCols : PtrNode;
   rows, cols : integer;
begin
   case term[1] of
      'n', 'v' :
         begin
            delete(term,1,1);
            node1 := TNode.create(term);
            self.pushNode(node1);
         end;
      'c' :
         begin
            node1 := TNode.create(term);
            self.pushNode(node1);
         end;

      'f', 'o' :
         begin
            if (term = 'fbuildMat') then // Caso especial para construir matriz
            begin
               ptrNodeCols := root.Items[root.count - 1];
               ptrNodeRows := root.Items[root.count - 2];
               cols := strToInt(ptrNodeCols^.value);
               rows := strToInt(ptrNodeRows^.value);
               numop1 := cols * rows + 2; // el + 2 es para incluir los valores de Cols y Rows;
            end
            else
            begin
               numop1 := functions^[term].numOp;
               if (self.size() < numop1) then
                  exit; //begin ShowMessage('error -.-');
            end;

            node1:= TNode.create(term);
            for i := 0 to numop1 - 1  do
            begin
               pnode1 := self.top();
               node1.addChild(pnode1);
               self.pop();
            end;
            self.pushNode(node1);
         end;
      '=' :
         begin
            node1 := TNode.create(term);
            for i := 0 to 1  do
            begin
               pnode1:= top();
               node1.addChild(pnode1);
               self.pop();
            end;
            self.pushNode(node1);
         end;
   end;
end;

end.
