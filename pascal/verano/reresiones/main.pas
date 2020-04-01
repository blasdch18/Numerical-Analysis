unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TARadialSeries, TAFuncSeries,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, ExtCtrls, MExtrapolacion,
  ParseMath;
 type
  t_vector= array of real;
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Chart1: TChart;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    FuntionGr: TLineSeries;
    Funtion: TFuncSeries;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo4: TMemo;
    Panel1: TPanel;
    Plotear: TLineSeries;
    EJEX: TConstantLine;
    EJEY: TConstantLine;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure lecturaArchivos();
    procedure readCSV(archivo_a_leer:String);
    procedure plotearPuntos();
    procedure FuncionCalculate(const AX: Double; out AY: Double);
    function f( x: Double ): Double;
  private
    matrixDatos:t_matrix;
    cantidad:Integer;
    XMAX,XMIN,YMAX,YMIN:Real;
    Parse  : TparseMath;
    Functiones: TStringList;
    RS:t_vector;

    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.readCSV(archivo_a_leer:String);
var
  LineasArchivo: TStringList;
  unaLinea: String;
  i: Integer;
  //para obtener intervalo
  PosSeparador: Integer;
  x_element,y_element:String;
const
   Separador = ',';
begin
  // Fase 1: Cargar Archivo En contendor
  LineasArchivo:= TStringList.Create();
  LineasArchivo.loadFromFile(archivo_a_leer);

  // Fase 2: Procesar archivo
  SetLength(matrixDatos,LineasArchivo.Count,4);//setear la cantidad de datos  era 2 col
  cantidad:=LineasArchivo.Count;
  StringGrid1.RowCount:=LineasArchivo.Count+1;
  for i:= 0 to LineasArchivo.Count - 1 do
  begin
    unaLinea:=LineasArchivo[i];
    PosSeparador:=Pos(Separador,unaLinea);
    x_element:=Copy(unaLinea,1,PosSeparador-1);
    y_element:=copy(unaLinea,PosSeparador+1);
    if StrToFloat(x_element)=0 then begin
       x_element:='0.001';
    end;
    if StrToFloat(y_element)=0 then begin
       y_element:='0.001';
    end;
    matrixDatos[i][0]:=StrToFloat(x_element);
    matrixDatos[i][1]:=StrToFloat(y_element);
    StringGrid1.Cells[0,i+1] := x_element;
    StringGrid1.Cells[1,i+1] := y_element;

  end;
  LineasArchivo.SaveToFile(archivo_a_leer);
  LineasArchivo.Free;

end;
{var F: TextFile;
    sLinea: String;
begin
    // AssignFile( F, ExtractFilePath( Application.ExeName ) + 'prueba.txt' );
    AssignFile(F, ExtractFilePath( Application.ExeName ) + 'ejemplo.txt');
    Reset(F);
    //Reset('ejemplo.txt');
    while not Eof( F ) do

     begin
          ReadLn( F, sLinea );
          Memo1.Lines.Add( sLinea );
     end;

     CloseFile( F );
end;  }
procedure TForm1.lecturaArchivos();
const
  C_FNAME = 'ejemplo.txt';

var
  tfIn: TextFile;
  s: string;

begin
  // Establece el nombre del fichero a leer.
  AssignFile(tfIn, C_FNAME);
  // Embebe el manejo del fichero en un bloque try/except para manejar errores de manera elegante.
 try // Abre el fichero en la modalidad de lectura.
    ReSet(tfIn);
    // Se mantiene leyendo líneas hasta alcanzar el final del fichero.
    while not eof(tfIn) do  // Mientras no fin de fichero haz...
    begin
      ReadLn(tfIn, s); // Lee una línea de texto desde el fichero.
      ShowMessage('mensaje______'+s);// Escribe la línea de texto leida anteriormente mostrándola en pantalla.
    end;
    // Realizado, por tanto procedemos a cerrar el fichero.
    CloseFile(tfIn);
  except
    on E: EInOutError do
    ShowMessage('Ha ocurrido un error en el manejo del fichero. Detalles: '+E.Message);
  end;
end;
{procedure TForm1.lecturaArchivos();
var
  fichero1:Text;
  linea:String;
begin
   assign( fichero1,'ejemplo.txt');  (* Le asignamos nombre *)
  // assign( fichero2, 'AUTOEXEC.BAN' );     (* y al otro *)
   {$I-}                                 (* Sin comprobación E/S *)
   reset( fichero1 );                    (* Intentamos abrir uno *)
   {$I+}(* La habilitamos otra vez *)
    while not eof( fichero1 ) do        (* Mientras que no acabe 1 *)
       begin
       readln( fichero1, linea );           (* Leemos una línea *)
       //writeln( fichero2, linea );          (* y la escribimos *)
       end;
   {if ioResult = 0 then                  (* Si todo ha ido bien *)
     begin
     rewrite( fichero2 );                (* Abrimos el otro *)
     while not eof( fichero1 ) do        (* Mientras que no acabe 1 *)
       begin
       readln( fichero1, linea );           (* Leemos una línea *)
       writeln( fichero2, linea );          (* y la escribimos *)
       end;
     writeln( 'Ya está ');                  (* Se acabó: avisamos, *)
     close( fichero1 );                     (* cerramos uno *)
     close( fichero2 );                     (* y el otro *)
     end                                    (* Final del "if" *)
   else
     writeln(' No he encontrado el fichero! ');     (* Si no existe *) }
ShowMessage(linea);
end; }
procedure TForm1.plotearPuntos();
var
 tx,ty:Double;
  i:Integer;
begin
 //hallando maximo X  y Y
 XMAX:=matrixDatos[0][0];
 YMAX:=matrixDatos[0][1];
 for i:=0 to cantidad-1 do begin
     if matrixDatos[i][0]>XMAX then
        XMAX:=matrixDatos[i][0];
     if matrixDatos[i][1]>YMAX then
        YMAX:=matrixDatos[i][1];
 end;
 //hallando minimos
 XMIN:=matrixDatos[0][0];
 YMIN:=matrixDatos[0][1];
 for i:=0 to cantidad-1 do begin
     if matrixDatos[i][0]<XMIN then
        XMIN:=matrixDatos[i][0];
     if matrixDatos[i][1]<YMIN then
        YMIN:=matrixDatos[i][1];
 end;
 //ahora ploteamos
 Plotear.Clear;
 Plotear.ShowPoints:=True;
 for i:=0 to cantidad-1 do begin
   tx:=matrixDatos[i][0];
   ty:=matrixDatos[i][1];
   Plotear.AddXY(tx,ty);
//Plotear.AddXY(matrixDatos[i][0],matrixDatos[i][1]);
 end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
// matri:t_matrix;
 M:TMextrapolacion;
 t,i,j:Integer;
 nombreFile:String;
 //RS:t_vector;
 MejorR:Real;
 //Functiones: TStringList;

begin
 Memo1.Clear;
 Memo2.Clear;
 Functiones:= TStringList.Create();
 SetLength(RS,3);//el tamaño de RS que puede existir
  //lecturaArchivos();
  nombreFile:=Edit1.Text;
  readCSV(nombreFile);     //Llenado de matrixDatos con x , y
  plotearPuntos();
  //creamos la clase con la matrix de datos y la cantidad de datos que tenemos
  M:=TMextrapolacion.Create(matrixDatos,cantidad);
  Functiones:= TStringList.Create();
  Functiones.Add(M.progresion_lineal());
  RS[0]:=M.rLi;
  Functiones.Add(M.exponencial());
  RS[1]:=M.rEx;
  Functiones.Add(M.logaritmica());
  RS[2]:=M.rLOG;



  Memo1.Lines.Add('--> Regresion Lineal ');
  Memo1.Lines.Add(Functiones[0]);
  Memo2.Lines.Add('--> Regresion Lineal -> R '+ FloatToStr(RS[0]));

  Memo1.Lines.Add(' --> Regresion Exponencial ');
  Memo1.Lines.Add(Functiones[1]);
  Memo2.Lines.Add(' --> Regresion Exponencial -->R  '+ FloatToStr(RS[1]));

  Memo1.Lines.Add('-->Regresion Logaritmica ');
  Memo1.Lines.Add(Functiones[2]);
  Memo2.Lines.Add('-->Regresion Logaritmica-->R'+ FloatToStr(RS[2]));




 //hallamos el mejor R
 MejorR:=RS[0];j:=0;
 for i:=0 to Functiones.Count-1 do begin;
      if RS[i]>MejorR then begin
         MejorR:=RS[i];
         j:=i;
      end;
 end;
 //Edit2.Text:=Functiones[j];
end;

procedure TForm1.Button2Click(Sender: TObject);
var i: Integer;
    Max, Min, h, NewX, NewY: Real;
begin
     FuntionGr.Clear;
    FuntionGr.Active:=False;
    Max:=XMAX;  //StrToFloat( Xmaximo );
    Min:=XMIN;  //StrToFloat( Xminimo ) ;
    h:= abs( ( Max - Min )/( 500* Max ) );

    NewX:=XMIN;

    while NewX < Max do begin
       NewY:= f( NewX );
       FuntionGr.AddXY( NewX, NewY );
       NewX:= NewX + h;

    end;

    FuntionGr.Active:= true;


end;
{begin
     {with Funtion do begin
      Active:= False;

      Extent.XMax:=XMAX;// StrToFloat( Xmaximo );
      Extent.XMin:=XMIN;//StrToFloat( Xminimo );

      Extent.UseXMax:= true;
      Extent.UseXMin:= true;
     // Funcion.Pen.Color:=  cboxColorFuncion.Colors[ cboxColorFuncion.ItemIndex ];
      Active:= True;
  end;}
     //Funtion.Active:= True;

end;}

procedure TForm1.Button3Click(Sender: TObject);
var
 valorEvaluar,rpt:Double;
begin
      Memo4.Clear;
     valorEvaluar:=StrToFloat(Edit3.Text);
     rpt:=f(valorEvaluar);
     Memo4.Lines.Add('f( x ) = ');
     Memo4.Lines.Add(FloatToStr(rpt));

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Memo1.Clear;
 Memo2.Clear;
 Memo1.Lines.Add('--> Regresion Lineal ');
  Memo1.Lines.Add(Functiones[0]);
  Memo2.Lines.Add('--> Regresion Lineal -> R '+ FloatToStr(RS[0]));
  Edit2.Text:=Functiones[0] ;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo2.Clear;
  Memo1.Lines.Add('-->Regresion Exponencial');
  Memo1.Lines.Add(Functiones[1]);
  Memo2.Lines.Add('-->Regresion Exponencial-->R '+ FloatToStr(RS[1]));
  Edit2.Text:=Functiones[1] ;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 Memo1.Clear;
 Memo2.Clear;
  Memo1.Lines.Add('-->Regresion Logaritmica ');
 Memo1.Lines.Add(Functiones[2]);
 Memo2.Lines.Add('-->Regresion Logaritmica-->R '+ FloatToStr(RS[2]));
 Edit2.Text:=Functiones[2] ;
end;


function TForm1.f( x: Double ): Double;
begin
     parse.Expression:=Edit2.Text;
     Parse.NewValue('x' , x );
     Result:= Parse.Evaluate();
end;
procedure TForm1.FuncionCalculate(const AX: Double; out AY: Double);
begin
  AY := f( AX )
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Parse := TparseMath.create;
  parse.AddVariable('x',0.0);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

end.

