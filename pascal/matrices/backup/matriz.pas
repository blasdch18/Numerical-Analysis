unit matriz;

{$mode objfpc}{$H+}

interface
 uses
     Classes, crt, SysUtils ;
 type
    m_Matriz = array of array of real;

 type
    TMatrix = class
 public
    Matriz1: m_Matriz;
    Ident: m_Matriz;
    Constructor Create( const n, m: Integer );
    Function Suma( Matriz2: TMatrix ) : TMatrix;
    Function Resta( Matriz2: TMatrix ) : TMatrix;
    Function Multiplicacion( Matriz3: TMatrix ; Matriz2: TMatrix ) : TMatrix;

    function potencia( Matriz2 : TMatrix ; expo : integer) : TMatrix;

    Function MultEscalar( Matriz2: TMatrix ; n: Real ) : TMatrix;
    Function Transpuesta( Matriz2: TMatrix ) : TMatrix;
    Function SubMatriz( Matriz2: TMatrix ; i: Integer ; j: Integer ) : TMatrix;
    Function Determinante( Matriz2: TMatrix ) : Real;
    Function Adjunta( Matriz2: TMatrix ) : TMatrix;
    Function Inversa( Matriz2: TMatrix ) : TMatrix;
    Procedure Fill ( ) ;
    Procedure Print ( Matriz2: TMatrix ) ;

  end;

implementation

Constructor TMatrix.Create(const n,m:Integer);
    begin
      SetLength(Matriz1,n,m);
    end;

    Function TMatrix.Suma( Matriz2: TMatrix ) : TMatrix;
    var
       i, j, ma, na, mb, nb: Integer ;
       res: TMatrix;
    begin
         ma:= Length( Matriz1 );
         na:= Length( Matriz1[0] );
         mb:= Length( Matriz2.Matriz1 );
         nb:= Length( Matriz2.Matriz1[0] );
         res:= TMatrix.Create( ma,na );

         if not ( ( ma= mb ) and ( na= nb ) )
         then
         begin
           exit;
         end;
         for i:= 0 to ma-1 do
             for j:= 0 to na-1 do
                 begin
                   res.Matriz1[i,j]:= ( Matriz1[i,j]+ Matriz2.Matriz1[i,j] );
                 end;
         Result:= res;
    end;

    Function TMatrix.Resta( Matriz2: TMatrix ) : TMatrix;
    var
       i, j, ma, na, mb, nb: integer ;
       res: TMatrix;
    begin
         ma:= Length( Matriz1 );
         na:= Length( Matriz1[0] );
         mb:= Length( Matriz2.Matriz1 );
         nb:= Length( Matriz2.Matriz1[0] );
         res:= TMatrix.Create( ma, na );

         if not ( ( ma= mb ) and ( na= nb ) )then exit;
         for i:= 0 to ma-1 do
             for j:= 0 to na-1 do
                 begin
                   res.Matriz1[i,j]:= ( Matriz1[i,j]-Matriz2.Matriz1[i,j] );
                 end;
         Result:=res;
    end;

    Function TMatrix.Multiplicacion( Matriz3: TMatrix ; Matriz2: TMatrix ) : TMatrix;
    var
       i, j, h, ma, na, mb, nb: Integer ;
       res: TMatrix;
    begin
         ma:= Length( Matriz3.Matriz1 );
         na:= Length( Matriz3.Matriz1[0] );
         mb:= Length( Matriz2.Matriz1 );
         nb:= Length( Matriz2.Matriz1[0] );
         res:= TMatrix.Create( ma, nb );

         if not ( na= mb )then exit;
         for i:= 0 to ma-1 do
             for j:= 0 to nb-1 do
             begin
                 res.Matriz1[i,j]:= 0;
                 for h:= 0 to na-1 do
                 begin
                   res.Matriz1[i,j]:= res.Matriz1[i,j]+ ( Matriz3.Matriz1[i,h]*Matriz2.Matriz1[h,j] );
                 end;
             end;
         Result:= res;
    end;

    function TMatrix.potencia(Matriz2 : TMatrix ; expo : integer) : TMatrix;
    var
       i, j, ma: integer ;
       res: TMatrix;

    begin
          ma:= Length ( Matriz2.Matriz1 );
         if expo=0 then
            for i:= 0 to ma do
              for j:= 0 to ma do
                begin
                  if i=j then
                    res.matriz1[i,j]:= 1
                  else
                    res.matriz1[i,j]:= 0;
                end;
            //res:= Iden;
         if expo=1 then
            res:= Matriz2 ;
         for i:= 0 to Expo do
             res:= Matriz2;
             res:= multiplicacion(res , Matriz2);
         result:= res;


         end;


    Function TMatrix.MultEscalar( Matriz2: TMatrix ; n: Real) : TMatrix;
    var
       i, j, ma, na: Integer ;
       res: TMatrix ;
    begin
         ma:= Length( Matriz2.Matriz1 );
         na:= Length( Matriz2.Matriz1[0] );
         res:= TMatrix.Create( ma, na );

         for i:= 0 to ma-1 do
             for j:= 0 to na-1 do
             begin
                  res.Matriz1[i,j]:= Matriz2.Matriz1[i,j]*n ;
             end;
         Result:= res;
    end;
    Function TMatrix.Transpuesta( Matriz2: TMatrix ) : TMatrix;
    var
       i, j, ma, na: Integer ;
       res: TMatrix;
    begin
         ma:= Length( Matriz2.Matriz1 );
         na:= Length( Matriz2.Matriz1[0] );
         res:= TMatrix.Create( na, ma );

         for i:= 0 to ma-1 do
             for j:= 0 to na-1 do
             begin
                  res.Matriz1[j,i]:= Matriz2.Matriz1[i,j];
             end;
         Result:= res;
    end;
    Function TMatrix.SubMatriz( Matriz2: TMatrix ; i: Integer ; j: Integer ): TMatrix;
     var
        x, y, w, z, ma, na: Integer;
        res: TMatrix;
     begin
         ma:= Length( Matriz2.Matriz1 ) ;
         na:= Length( Matriz2.Matriz1[0] );
         res:= TMatrix.Create( ma-1, na-1 );
         w:= 0;
         z:= 0;

         for x:= 0 to ma-1 do
         begin
           if( x<>i )then
           begin
              for y:= 0 to na-1 do
                  if( ( x<>i )and( y<>j ) )then
                  begin
                       res.Matriz1[w,z]:= Matriz2.Matriz1[x,y];
                       z:= z+1
                  end;
              w:= w+1;
              z:= 0;
           end;
         end;
         Result:= res;
     end;

    Function TMatrix.Determinante( Matriz2: TMatrix ) : Real;
    var
       s, k, ma, na: Integer ;
    begin
         result:= 0.0;
         ma:= Length( Matriz2.Matriz1 );

         if ma> 1 then na:= Length( Matriz2.Matriz1[0] )
         else
             begin
               result:= Matriz2.Matriz1[0,0];
               exit;
             end;

         if not ( ma= na )then exit;

         if( ma= 2) then result:= Matriz2.Matriz1[0,0]*Matriz2.Matriz1[1,1] -
                                  Matriz2.Matriz1[0,1]*Matriz2.Matriz1[1,0]
         else if ma= 3 then
              result:= Matriz2.Matriz1[0,0]*Matriz2.Matriz1[1,1]*Matriz2.Matriz1[2,2] +
                       Matriz2.Matriz1[2,0]*Matriz2.Matriz1[0,1]*Matriz2.Matriz1[1,2] +
                       Matriz2.Matriz1[1,0]*Matriz2.Matriz1[2,1]*Matriz2.Matriz1[0,2] -
                       Matriz2.Matriz1[2,0]*Matriz2.Matriz1[1,1]*Matriz2.Matriz1[0,2] -
                       Matriz2.Matriz1[1,0]*Matriz2.Matriz1[0,1]*Matriz2.Matriz1[2,2] -
                       Matriz2.Matriz1[0,0]*Matriz2.Matriz1[2,1]*Matriz2.Matriz1[1,2]
         else
         begin
              s:= 1;
              for k:= 0 to na-1 do
              begin
                   result:= result + s*Matriz2.Matriz1[0,k]*Determinante( Submatriz( Matriz2, 0, k ) );
                   s:= s*-1;
              end;
         end;
    end;

    Function TMatrix.Adjunta( Matriz2: TMatrix ) : TMatrix;
    var
       i, j, s, s1, ma, na: Integer;
       res, temp: TMatrix;
    begin
         ma:= Length( Matriz2.Matriz1 );
         na:= Length( Matriz2.Matriz1[0] );

         if not ( ma= na )then exit;
         res:= TMatrix.Create( ma, na );
         temp:= TMatrix.Create( ma-1, na-1 );
         s1:= 1;

         for i:= 0 to ma-1 do
         begin
             s:= s1;
             for j:= 0 to na-1 do
             begin
                  temp:= SubMatriz( Matriz2, i, j);;
                  res.Matriz1[i,j]:= s*Determinante( temp );
                  s:= s*(-1);
             end;
             s1:= s1*(-1);
         end;
         Result:= res;
    end;

    Function TMatrix.Inversa( Matriz2: TMatrix ) : TMatrix;
    var
          ma, na: Integer ;
          det: Real;
          adj, res: TMatrix;
    begin
         ma:= Length( Matriz2.Matriz1 );
         na:= Length( Matriz2.Matriz1[0] );

         if not ( ma= na )then exit;
         adj:= TMatrix.Create( ma, na );
         res:= TMatrix.Create( ma, na );
         adj:= Adjunta( Matriz2 );
         det:= Determinante( Matriz2 );

         if det= 0 then
         begin
              writeln('Imposible la determinante es 0');
              //readkey;
              exit;
         end;


         adj:= Transpuesta( adj );
         det:= 1/det;
         res:= MultEscalar( adj, det );
         Result:= res;
    end;

    Procedure TMatrix.Fill( );
    var
      m, n, j, i: Integer;
      num : double;
    begin
         m:= Length( Matriz1 );
         n:= Length( Matriz1[0] );

         for j:= 0 to m-1 do
         begin
             for i:= 0 to n-1 do
             begin
                 write('elemento[');
                 write(j);
                 write(',');
                 write(i);
                 write(']:=');
                 read( num );
                 Matriz1[j,i]:=  num ;
             end;
         end;

         for j:= 0 to m-1 do
         begin
             for i:= 0 to n-1 do
             begin
                 write( FloatToStr( Matriz1[j,i] ) + '     '  ) ;
             end;
             writeln;
         end;
       //  readkey;
    end;

    Procedure TMatrix.Print( Matriz2 : TMatrix )  ;
    var
      m, n, j, i: Integer;
    begin
         m:= Length( Matriz1 );
         n:= Length( Matriz1[0] );
         for j:= 0 to m-1 do
         begin
             for i:= 0 to n-1 do
             begin
                 write( FloatToStr( Matriz1[j,i] ) + '     '  ) ;
             end;
             writeln;
         end;

    end;

end.

