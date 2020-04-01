
-----------------------------------------
Graficar funciones
-----------------------------------------
grafic(fx, x0, xf)   

//NOTA!
En este caso la funcion no ira entre ' '.
Ej:
	grafic(2*x,2,3)


-----------------------------------------
EDO:
-----------------------------------------

rungekutta3('fx', x_0, y_0, x_f, n )
Ej:
  rungekutta3('2*x',-2,2,4,10)


rungekutta4('fx', x_0, y_0, x_f, n )
Ej:
  rungekutta4('2*x',-2,2,4,10)


euler('fx', x_0 , x_f, y_0, n)
Ej:
  euler('2*x',-2,2,4,10)


heun ('fx', x_0, x_f, y_0 , n)
Ej:
  heun('2*x',-2,2,4,10)

-----------------------------------------
Edo con gra'fica:
-----------------------------------------

	EDO(funcion , x0 , xf , y0 , n_iteraciones ,tipo)	

Tipos
	1 ....... Euler
	2 ....... Heun
	3 ....... Rk3
	4 ....... Rk4

 Edo Euler  con   x e [0 , 0.5]  :  
	EDO('x-y+1',0,0.5,1,5,1)

 Edo Heun con   x e [0 , 0.5]  :
	EDO('x-y+1',0,0.5,1,5,2) 

 Edo RK3 con   x e [0 , 0.5]  :
	EDO('x-y+1',0,0.5,1,5,3)

 Edo RK4 con   x e [0 , 0.5]  :
	EDO('x-y+1',0,0.5,1,5,4) 




------------------------------
Me'todos
------------------------------

biseccion('2*x',-2,2,0.01)
fposicion('2*x',-2,2,0.01)
newton('2*x*x',4*x,2,0.01)
secante('2*x',-2,2,0.01)

------------------------------
 Matrices
------------------------------

Salvar Matrices: 
   a=[1 2 4 5 , 3 5 6 7 ]

Operaciones:
   traza(a)
   multmatriz(a,b)
   multescalar(a,2)
   det(a)
   suma(a,b)
   resta(a,b)
   inv(a,2)

------------------------------
Integrales y A'reas
------------------------------
integral(funcion, intervalo_x, intervalo_y, iteraciones, Tipo, BOOL)

Tipo:
	1 ....... Trapecio
	2 ....... Simpson 1/3
        3 ....... Simpson 3/8
	4 ....... Simpson Compuesto
Bool:
	True ....... A'rea
	False ....... Intgral

Ej:
	integral('2*x',2,6,1,3,True)

---------------------------------
Ma's m'etodos
---------------------------------

simpson13(fx, a, b, n)
Ej:
   simpson13('2*x',-1,1,100)

simpson38(fx, a, b, n)
Ej:
   simpson38('2*x',-1,1,100)

simpsonsimple(fx, a, b, n)
Ej:
   simpsonsimple('2*x',-1,1,100)

trapecio(fx, a, b, n)
Ej:
   trapecio('2*x',-1,1,100)

---------------------------------
Newton Generalizado
---------------------------------

Ej:
   gnewton("[x ;y ]","[power(x,2)+x*y-10 ;y+3*x*power(y,2)-57 ]","[2.036 ;2.845 ]",0.001)








