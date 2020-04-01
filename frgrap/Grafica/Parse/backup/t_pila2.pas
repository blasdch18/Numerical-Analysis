unit t_pila2;
interface
{$mode objfpc}{$H+}
 uses
   Classes, SysUtils, crt,dialogs;
 const
   MAX_PILA=255;
 type
      Tpila2 = Class
            private
            Cima : Integer;
            Elementos : Array[1..MAX_PILA] of String;

    public

     Procedure crear();
     Procedure vacia() ;
     function EsPilaVacia(): Boolean;
     Function llena(): Boolean;
     Function cimas(): String;
     Procedure push(elem: String);
     Procedure pop();

 end;

 implementation
 Procedure Tpila2.crear();
 begin
      Cima := 0;
 end;
 Procedure Tpila2.vacia();
 begin
      Cima := 0;
 end;
 function Tpila2.EsPilaVacia() : boolean;
 begin

      EsPilaVacia := ( Cima = 0 );

 end;
 Function tpila2.llena() : Boolean;
 begin
      llena := cima = MAX_PILA
 end;
 Function tpila2.cimas() : String;
 begin
     cimas:=elementos[cima];
 end;
 Procedure tpila2.push(elem : STring);
 begin
      Inc(cima);
      elementos[cima] := elem
 end;
 Procedure tpila2.pop();
 begin
      //elem := pila.elementos[pila.cima];
      dec(cima)
 end;

end.
