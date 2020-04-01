unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  persona;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnAdd: TButton;
    cboPerson: TComboBox;
    ediName: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lblFirstName: TLabel;
    Label4: TLabel;
    lblLastName: TLabel;
    Label6: TLabel;
    lblCount: TLabel;
    lblName: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure cboPersonChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
    ThePerson: TPerson;


  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

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
var ThePosition: Integer;
begin

  ThePosition:= StrToInt( cboPerson.Text );
  lblName.Caption:= ThePerson.GetPerson( ThePosition - 1 );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ThePerson:= TPerson.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ThePerson.Destroy;
end;

end.

