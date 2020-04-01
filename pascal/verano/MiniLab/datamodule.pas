unit DataModule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Menus;

type

  { TDM }

  TDM = class(TDataModule)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    popConstMat: TPopupMenu;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.lfm}

end.

