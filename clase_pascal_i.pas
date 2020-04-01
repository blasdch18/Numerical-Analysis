unit clase_pascal_i;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  persona;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnAddClick: TButton;
    cboPerson: TComboBox;
    ediName: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    lblCount: TLabel;
    lblName: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure cboPersonChange(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
  private
    { private declarations }
    ThePerson:TPerson;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;

procedure TForm1.btnAddClick(Sender: TObject);
var i: Integer;
begin
  ThePerson.AddName( ediName.Text );
  lblFirstName.Caption:= ThePerson.FirstPerson;
  lblLastName.Caption:= ThePerson.LastPerson;
  lblCount.Caption:= IntToStr( ThePerson.Count );
  cboPerson.Clear;

  for i:= 1 to ThePerson.Count do
     cboPerson.Items.Add( IntToStr( i ) );

end;

procedure TForm1.cboPersonChange(Sender: TObject);
var ThePosition:integer;
begin
  ThePosition=StrToInt( cboPerson.Text );
  lblName.Caption:=ThePerson.GetPerson( ThePosition-1 );
end;

end.

