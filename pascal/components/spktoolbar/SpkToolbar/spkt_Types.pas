unit spkt_Types;

{$mode Delphi}

(*******************************************************************************
*                                                                              *
*  Plik: spkt_Types.pas                                                        *
*  Opis: Definicje typów u¿ywanych podczas pracy toolbara                      *
*  Copyright: (c) 2009 by Spook.                                               *
*  License:   Modified LGPL (with linking exception, like Lazarus LCL)         *
'             See "license.txt" in this installation                           *
*                                                                              *
*******************************************************************************)

interface

uses
  Controls, Classes, ContNrs, SysUtils, Dialogs,
  spkt_Exceptions;

type
  TSpkListState = (lsNeedsProcessing, lsReady);

  TSpkCollection = class(TPersistent)
  protected
    FList: TFPObjectList;
    FNames: TStringList;
    FListState: TSpkListState;
    FRootComponent: TComponent;

    // *** Metody reakcji na zmiany w liœcie ***
    // *** Methods responding to changes in list ***
    procedure Notify(Item: TComponent; Operation: TOperation); virtual;
    procedure Update; virtual;

    // *** Wewnêtrzne metody dodawania i wstawiania elementów ***
    // *** Gettery i settery ***

    // *** Internal methods for adding and inserting elements ***
    // *** Getters and setters ***
    function GetItems(AIndex: integer): TComponent; virtual;

  public
    // *** Konstruktor, destruktor ***
    constructor Create(ARootComponent : TComponent); reintroduce; virtual;
    destructor Destroy; override;

    // *** Obs³uga listy ***
    // *** List operations ***
    procedure AddItem(AItem: TComponent);
    procedure InsertItem(AIndex: integer; AItem: TComponent);
    procedure Clear;
    function Count: integer;
    procedure Delete(AIndex: integer); virtual;
    function IndexOf(Item: TComponent) : integer;
    procedure Remove(Item: TComponent); virtual;
    procedure RemoveReference(Item: TComponent);
    procedure Exchange(item1, item2: integer);
    procedure Move(IndexFrom, IndexTo: integer);

    // *** Reader, writer i obs³uga designtime i DFM ***
    // *** Reader, writer and operation designtime and DFM
    procedure WriteNames(Writer: TWriter); virtual;
    procedure ReadNames(Reader: TReader); virtual;
    procedure ProcessNames(Owner: TComponent); virtual;

    property ListState: TSpkListState read FListState;
    property Items[index: integer] : TComponent read GetItems; default;
    property RootComponent: TComponent read FRootComponent;
  end;

  TSpkComponent = class(TComponent)
  protected
    FParent: TComponent;
    FCollection: TSpkCollection;
  public
    // *** Obs³uga parenta ***
    // *** Parent operations ***
    function HasParent: boolean; override;
    function GetParentComponent: TComponent; override;
    procedure SetParentComponent(Value: TComponent); override;

    property Parent: TComponent read FParent write SetParentComponent;
    property Collection: TSpkCollection read FCollection;
  end;


implementation

{ TSpkCollection }

constructor TSpkCollection.Create(ARootComponent: TComponent);
begin
  inherited Create;
  FRootComponent := ARootComponent;
  FNames := TStringList.Create;
  FList := TFPObjectList.Create(False);
  FListState := lsReady;
end;

destructor TSpkCollection.Destroy;
begin
  FNames.Free;
  FList.Free;
  inherited;
end;

procedure TSpkCollection.AddItem(AItem: TComponent);
begin
  // Ta metoda mo¿e byæ wywo³ywana bez przetworzenia nazw (w szczególnoœci, metoda
  // przetwarzaj¹ca nazwy korzysta z AddItem)

  // This method can be recalling untreated names (in particular, the method
  // uses the name przetwarzaj¹ca AddItem)   --- ???

  Notify(AItem, opInsert);
  FList.Add(AItem);

  if AItem is TSpkComponent then
    TSpkComponent(AItem).FCollection := self;

  Update;
end;

procedure TSpkCollection.Clear;
begin
  FList.Clear;
  Update;
end;

function TSpkCollection.Count: integer;
begin
  Result := FList.Count;
end;

procedure TSpkCollection.Delete(AIndex: integer);
begin
  if (AIndex < 0) or (AIndex >= FList.count) then
    raise InternalException.Create('TSpkCollection.Delete: Illegal index!');

  Notify(TComponent(FList[AIndex]), opRemove);
  FList.Delete(AIndex);
  Update;
end;

procedure TSpkCollection.Exchange(item1, item2: integer);
begin
  FList.Exchange(item1, item2);
  Update;
end;

function TSpkCollection.GetItems(AIndex: integer): TComponent;
begin
  if (AIndex < 0) or (AIndex >= FList.Count) then
    raise InternalException.Create('TSpkCollection.Delete: Illegal index!');

  Result := TComponent(FList[AIndex]);
end;

function TSpkCollection.IndexOf(Item: TComponent): integer;
begin
  result := FList.IndexOf(Item);
end;

procedure TSpkCollection.InsertItem(AIndex: integer; AItem: TComponent);
begin
  if (AIndex < 0) or (AIndex > FList.Count) then
    raise InternalException.Create('TSpkCollection.Delete: Illegal index!');

  Notify(AItem, opInsert);
  FList.Insert(AIndex, AItem);
  if AItem is TSpkComponent then
    TSpkComponent(AItem).FCollection := self;
  Update;
end;

procedure TSpkCollection.Move(IndexFrom, IndexTo: integer);
begin
  if (indexFrom < 0) or (indexFrom >= FList.Count) or
     (indexTo < 0) or (indexTo >= FList.Count)
  then
    raise InternalException.Create('TSpkCollection.Delete: Illegal index!');

  FList.Move(IndexFrom, IndexTo);
  Update;
end;

procedure TSpkCollection.Notify(Item: TComponent; Operation: TOperation);
begin
//
end;

procedure TSpkCollection.ProcessNames(Owner: TComponent);
var
  s: string;
begin
  FList.Clear;
  if Owner <> nil then
    for s in FNames do
      AddItem(Owner.FindComponent(s));
  FNames.Clear;
  FListState := lsReady;
end;

procedure TSpkCollection.ReadNames(Reader: TReader);
begin
  Reader.ReadListBegin;
  FNames.Clear;
  while not(Reader.EndOfList) do
    FNames.Add(Reader.ReadString);
  Reader.ReadListEnd;
  FListState := lsNeedsProcessing;
end;

procedure TSpkCollection.Remove(Item: TComponent);
var
  i: integer;
begin
  i := FList.IndexOf(Item);
  if i >= 0 then
  begin
    Notify(Item, opRemove);
    FList.Delete(i);
    Update;
  end;
end;

procedure TSpkCollection.RemoveReference(Item: TComponent);
var
  i: integer;
begin
  i := FList.IndexOf(Item);
  if i >= 0 then
  begin
    Notify(Item, opRemove);
    FList.Extract(Item);
    Update;
  end;
end;

procedure TSpkCollection.Update;
begin
  //
end;

procedure TSpkCollection.WriteNames(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FList.Count - 1 do
    Writer.WriteString(TComponent(FList[i]).Name);
  Writer.WriteListEnd;
end;


{ TSpkComponent }

function TSpkComponent.GetParentComponent: TComponent;
begin
  Result := FParent;
end;

function TSpkComponent.HasParent: boolean;
begin
  Result := (FParent <> nil);
end;

procedure TSpkComponent.SetParentComponent(Value: TComponent);
begin
  FParent := Value;
end;

end.
