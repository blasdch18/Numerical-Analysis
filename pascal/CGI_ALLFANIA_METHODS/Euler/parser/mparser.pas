unit mParser;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, gstack, gmap, mMaps, mTree;

type

   TParser = class
   private
      type
         TAssoc = (leftAsc, rightAsc);
         TOperator = record
            funcName : string;
            precedence : integer;
            assoc : TAssoc;
         end;

         TOperatorMap = specialize TMap<char, TOperator, TStringCompare>;
         TStringStack = specialize  TStack<string>;
      var
         operators : TOperatorMap;
         functions : PtrFunctionMap;
         constants : PtrVarMap;

         function createOp(fname : string; prec : integer; asso : TAssoc) : TOperator;
         procedure setOperators();
         function precedence(op : char) : integer;

         function isOperator(ch : char) : boolean;
         function isFunction(str : string) : boolean;
         function isConstant(str : string) : boolean;

         function recognizeRowsCols(input : string; pos : integer) : TStringList;
   public
      // IMPORTANTE: inicializar siempre los objetos con TParser.create !!!
      // NOTA: es posible que ya no funcione al ser creado con este create.
      //constructor create; overload;
      constructor create(funcMap : PtrFunctionMap; constMap : PtrVarMap); overload;
      destructor destroy; override;

      // Por ahora estas funciones son públicas:
      function parseString(input : string) : TStringList;
      function toRPN(input : TStringList) : TStringList;

      procedure strIntoST(str : string; stTree : PtrTree);

   end;

implementation

//constructor TParser.create;
//begin
//   operators := TOperatorMap.create;
//   self.setOperators();
//end;

constructor TParser.create(funcMap : PtrFunctionMap; constMap : PtrVarMap);
begin
   operators := TOperatorMap.create;
   self.setOperators();
   self.functions := funcMap;
   self.constants := constMap;
end;

destructor TParser.destroy;
begin
   operators.destroy;
end;

procedure TParser.setOperators();
begin
   // http://ee.hawaii.edu/~tep/EE160/Book/chap5/subsection2.1.4.1.html
   // http://docs.roxen.com/pike/7.0/tutorial/expressions/operator_tables.xml
   // http://es.cppreference.com/w/cpp/language/operator_precedence
   self.operators['='] := self.createOp('=', 0, rightAsc);
   self.operators['+'] := self.createOp('fsum', 2, leftAsc);
   self.operators['-'] := self.createOp('fsub', 2, leftAsc);
   self.operators['*'] := self.createOp('fmul', 3, leftAsc);
   self.operators['/'] := self.createOp('fdiv', 3, leftAsc);
   self.operators['^'] := self.createOp('fpow', 4, rightAsc);
   self.operators['$'] := self.createOp('fneg', 10, leftAsc);
end;

function TParser.parseString(input : string) : TStringList;
var
   parsed: TStringList;
   matrixDimensions : TStringList;
   i, j : Integer;
   tmp : string;
begin
   parsed := TStringList.create;
   i := 1; // NOTA: strings start in 1, not in 0 :(
   // IMPORTANTE: controlar el i adentro de cada caso!
   {
    Identificadores:
    * Números    : n
    * Operadores : o
    * Variables  : v
    * Funciones  : f
    * Constantes : c
    Los paréntesis(()) y comas(,) no tienen identificador,
    estos se eliminan en el rpn.
   }
   while  (i <= length(input)) do
   begin
      case input[i] of
         '0'..'9', '.' : { -Números- }
            begin
               j := i;
               i := i + 1;
               while (input[i] in ['0'..'9', '.']) do
                  i := i + 1;
               if (parsed.count <> 0) and (parsed[parsed.count - 1][2] = '$') then
                  parsed[parsed.count - 1] := 'n-' + copy(input,j, i - j)
               else
                  parsed.add('n' + copy(input,j, i - j));
            end;
         '[' :
            begin
               parsed.addStrings(['fbuildMat','(']);
               matrixDimensions := self.recognizeRowsCols(input, i);
               i := i + 1;
            end;
         ';' :
            begin
               parsed.add(',');
               i := i + 1;
            end;
         ']' :
            begin
               parsed.addStrings(matrixDimensions);
               parsed.add(')');
               i := i + 1;
            end;
         '(', ')' , ',' : { -Paréntesis, comas- }
            begin
               parsed.add(input[i]);
               i := i + 1;
            end;
         ' ' : i := i + 1; { -Espacio- } // Solo pasa al siguiente char.
      else
      begin
         if (self.isOperator(input[i])) then {- Operadores -}
         begin
            if (input[i] = '-') then
            begin
               // el - es binario(operación binaria) si el que le precede es un
               // número, una variable, una constante o un ')' y es unario si el que
               // le precede es un operador , '(' o ',' o si es el primer elemento del input.
               if (parsed.count = 0) or (parsed[parsed.count - 1][1] in ['o', '(', ',']) then
                  parsed.add('o$')
               else
                  parsed.add('o-');
            end
            else
               parsed.add('o' + input[i]);
            i := i + 1;
         end
         else {- Palabras -}
         begin
            j := i;
            i := i + 1;
            // Los nombres pueden tener letras mayúsculas, minúsculas y _ :
            while (input[i] in ['A'..'Z', 'a'..'z', '_']) do
               i := i + 1;

            tmp := copy(input,j, i - j);
            if (isFunction('f' + tmp)) then  {- Funciones -}
               parsed.add('f' + tmp)
            else if (isConstant('c' + tmp)) then {- Constantes -}
               parsed.add('c' + tmp)
            else {- Variables -}
               parsed.add('v' + tmp);
         end;
      end;

      end;
   end;
   Result := parsed;
end;

function TParser.toRPN(input : TStringList) : TStringList;
var
   rpn : TStringList;
   stack : TStringStack;
   token : string;
   prec1 : integer;
   assoc : TAssoc;

begin
   rpn := TStringList.create;
   stack := TStringStack.create;

   for token in input do
   begin
      case token[1] of
         'n', 'c', 'v' : rpn.add(token);
         'f' : stack.push(token);
         ',' :
            begin
               while ((not stack.isEmpty()) and (stack.top()[1] <> '(')) do
               begin
                  rpn.add(operators[stack.top()[2]].funcName);
                  stack.pop();
               end;
               // TODO: If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.
            end;
         'o' :
            begin
               if (not stack.isEmpty() and (stack.top()[1] = 'o')) then
               begin
                  assoc := operators[token[2]].assoc;
                  prec1 := precedence(token[2]);

                  while ((not stack.isEmpty()) and (stack.top()[1] = 'o')
                         and (((assoc = leftAsc) and (prec1 <= precedence(stack.top()[2]))) {Left-associative}
                              or (prec1 < precedence(stack.top()[2])))) do {Right-associative}
                  begin
                     rpn.add(operators[stack.top()[2]].funcName);
                     stack.pop();
                  end;
               end;
               stack.push(token);
            end;
         '(' : stack.push(token);
         ')' :
            begin
               while ((not stack.isEmpty()) and (stack.top()[1] <> '(')) do
               begin
                  rpn.add(operators[stack.top()[2]].funcName);
                  stack.pop();
               end;
               stack.pop();
               if ((not stack.isEmpty()) and (stack.top()[1] = 'f')) then
               begin
                  rpn.add(stack.top());
                  stack.pop();
               end;
               // TODO: If the stack runs out without finding a left parenthesis, then there are mismatched parentheses.
            end;
      end;
   end;

   while ((not stack.isEmpty()) and  (stack.top()[1] = 'o')) do
   begin
      // TODO: If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses.
      rpn.add(operators[stack.top()[2]].funcName);
      stack.pop();
   end;

   Result := rpn;
end;

procedure TParser.strIntoST(str : string; stTree : PtrTree);

var
   parsed : TStringList;
   stack : TStringStack;
   token : string;
   prec1 : integer;
   assoc : TAssoc;

begin
   parsed := self.parseString(str);
   stack := TStringStack.create;
   for token in parsed do
   begin
      case token[1] of
         'n', 'c', 'v' : stTree^.insertRpnTerm(token);
         'f' : stack.push(token);
         ',' :
            begin
               while ((not stack.isEmpty()) and (stack.top()[1] <> '(')) do
               begin
                  stTree^.insertRpnTerm(operators[stack.top()[2]].funcName);
                  stack.pop();
               end;
               // TODO: If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.
            end;
         'o' :
            begin
               if (not stack.isEmpty() and (stack.top()[1] = 'o')) then
               begin
                  assoc := operators[token[2]].assoc;
                  prec1 := precedence(token[2]);

                  while ((not stack.isEmpty()) and (stack.top()[1] = 'o')
                         and (((assoc = leftAsc) and (prec1 <= precedence(stack.top()[2]))) {Left-associative}
                              or (prec1 < precedence(stack.top()[2])))) do {Right-associative}
                  begin
                     stTree^.insertRpnTerm(operators[stack.top()[2]].funcName);
                     stack.pop();
                  end;
               end;
               stack.push(token);
            end;
         '(' : stack.push(token);
         ')' :
            begin
               while ((not stack.isEmpty()) and (stack.top()[1] <> '(')) do
               begin
                  stTree^.insertRpnTerm(operators[stack.top()[2]].funcName);
                  stack.pop();
               end;
               stack.pop();
               if ((not stack.isEmpty()) and (stack.top()[1] = 'f')) then
               begin
                  stTree^.insertRpnTerm(stack.top());
                  stack.pop();
               end;
               // TODO: If the stack runs out without finding a left parenthesis, then there are mismatched parentheses.
            end;
      end;
   end;

   while ((not stack.isEmpty()) and  (stack.top()[1] = 'o')) do
   begin
      // TODO: If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses.
      stTree^.insertRpnTerm(operators[stack.top()[2]].funcName);
      stack.pop();
   end;

end;


function TParser.createOp(fname : string; prec : integer; asso : TAssoc) : TOperator;
var
   res : TOperator;
begin
   res.funcName := fname;
   res.precedence := prec;
   res.assoc := asso;
   Result := res;
end;

function TParser.recognizeRowsCols(input : string; pos : integer) : TStringList;
var
   rows, cols : integer;
   res : TStringList;
begin
   pos := pos + 1;
   rows := 0;
   cols := 0;

   while ((pos <= length(input)) and (input[pos] <> ']')) do
   begin
      while ((pos <= length(input)) and (not (input[pos] in [',', ';', ']', '(']))) do
         pos := pos + 1;

      if (input[pos] = ',') then
      begin
         cols := cols + 1;
         pos := pos + 1;
      end
      else if (input[pos] = ';') then
      begin
         rows := rows + 1;
         cols := cols + 1;
         pos := pos + 1;
      end
      else if (input[pos] = '(') then
      begin
         pos := pos + 1;
         while (input[pos] <> ')') do
            pos := pos + 1;
         pos := pos + 1;
      end;

   end;

   rows := rows + 1;
   cols := cols + 1;
   res := TStringList.create;
   res.addStrings([',','n' + intToStr(rows), ',' ,'n' + floatTostr(cols/rows)]);
   Result := res;
end;

function TParser.isOperator(ch : char) : boolean;
begin
   Result := operators.find(ch) <> nil;
end;

function TParser.isFunction(str : string) : boolean;
begin
   Result := functions^.find(str) <> nil;
end;

function TParser.isConstant(str : string) : boolean;
begin
   Result := constants^.find(str) <> nil;
end;

function TParser.precedence(op : char) : integer;
begin
   Result := operators[op].precedence;
end;

end.
