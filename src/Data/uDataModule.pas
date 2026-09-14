unit uDataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait,
  uCommonUtils;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQueryCategories: TFDQuery;
    FDQueryControls: TFDQuery;
    FDQueryMembers: TFDQuery;
    FDQuerySnippets: TFDQuery;
    FDQueryBestPractices: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  public
    procedure ConnectDatabase;
    procedure FilterControls(const ASearchText: string);
    procedure LoadControlDetails(AControlID: Integer);
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ConnectDatabase;
end;

procedure TDM.ConnectDatabase;
var
  DBPath: string;
begin
  DBPath := GetDatabasePath;
  FDConnection1.Connected := False;
  FDConnection1.DriverName := 'SQLite';
  FDConnection1.Params.Values['Database'] := DBPath;
  FDConnection1.Connected := True;
end;

procedure TDM.FilterControls(const ASearchText: string);
begin
  FDQueryControls.Close;
  if Trim(ASearchText) = '' then
  begin
    FDQueryControls.SQL.Text :=
      'SELECT c.*, cat.name AS category_name ' +
      'FROM controls c ' +
      'JOIN categories cat ON c.category_id = cat.id ' +
      'ORDER BY cat.sort_order, c.control_name';
  end
  else
  begin
    FDQueryControls.SQL.Text :=
      'SELECT c.*, cat.name AS category_name ' +
      'FROM controls c ' +
      'JOIN categories cat ON c.category_id = cat.id ' +
      'WHERE c.control_name LIKE :keyword OR c.description LIKE :keyword ' +
      'ORDER BY cat.sort_order, c.control_name';
    FDQueryControls.ParamByName('keyword').AsString := '%' + Trim(ASearchText) + '%';
  end;
  FDQueryControls.Open;
end;

procedure TDM.LoadControlDetails(AControlID: Integer);
begin
  // 1. Members
  FDQueryMembers.Close;
  FDQueryMembers.SQL.Text :=
    'SELECT * FROM control_members ' +
    'WHERE control_id = :control_id ' +
    'ORDER BY member_type, member_name';
  FDQueryMembers.ParamByName('control_id').AsInteger := AControlID;
  FDQueryMembers.Open;

  // 2. Snippets
  FDQuerySnippets.Close;
  FDQuerySnippets.SQL.Text :=
    'SELECT * FROM snippets ' +
    'WHERE control_id = :control_id ' +
    'ORDER BY id';
  FDQuerySnippets.ParamByName('control_id').AsInteger := AControlID;
  FDQuerySnippets.Open;

  // 3. Best Practices
  FDQueryBestPractices.Close;
  FDQueryBestPractices.SQL.Text :=
    'SELECT * FROM best_practices ' +
    'WHERE control_id = :control_id ' +
    'ORDER BY id';
  FDQueryBestPractices.ParamByName('control_id').AsInteger := AControlID;
  FDQueryBestPractices.Open;
end;

end.
