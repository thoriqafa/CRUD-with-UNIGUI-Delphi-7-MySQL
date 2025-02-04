unit ServerModule;

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, ADODB, MyAccess, MyClasses, MyCall, DBAccess, MemDS;

type
  TUniServerModule = class(TUniGUIServerModule)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ADOConnection1: TMYConnection;
    UserQuery: TMyQuery;
    EmployeeQuery: TMyQuery;
    RoleQuery: TMyQuery;
    procedure UniServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure FirstInit; override;
  public
    { Public declarations }
  end;

function UniServerModule: TUniServerModule;

implementation

{$R *.dfm}

uses
  UniGUIVars;

function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TUniServerModule.UniServerModuleCreate(Sender: TObject);
begin
  if not ADOConnection1.Connected then
  begin
    ADOConnection1.ConnectString := 'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Initial Catalog=db_slf;';
  end;

  UserQuery.SQL.Clear;
  UserQuery.Connection := ADOConnection1;
  UserQuery.SQL.Text := 'SELECT u.*, r.name FROM tx_user u JOIN tm_role r ON r.id = u.role_id';
  UserQuery.Open;

  EmployeeQuery.SQL.Clear;
  EmployeeQuery.Connection := ADOConnection1;
  EmployeeQuery.SQL.Text := 'SELECT * FROM tm_employee WHERE is_delete = 0';
  EmployeeQuery.Open;
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
