unit FrmCrtEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniMultiItem, uniComboBox,
  uniGUIBaseClasses, uniEdit;

type
  TUniForm2 = class(TUniForm)
    TxtNama: TUniEdit;
    TxtUsername: TUniEdit;
    TxtPassword: TUniEdit;
    CBRole: TUniComboBox;
    BtnSave: TUniButton;
    procedure UniFormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    FIDToEdit: Integer;
  public
    property IDToEdit: Integer read FIDToEdit write FIDToEdit;
  end;

function UniForm2: TUniForm2;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, ServerModule;

function UniForm2: TUniForm2;
begin
  Result := TUniForm2(UniMainModule.GetFormInstance(TUniForm2));
end;

procedure TUniForm2.BtnSaveClick(Sender: TObject);
var
  SelectedID: Integer;
  NewID: Integer;
begin
  UniServerModule.UserQuery.SQL.Clear;
  UniServerModule.EmployeeQuery.SQL.Clear;

  SelectedID := Integer(CBRole.Items.Objects[CBRole.ItemIndex]);

  if VarIsNull(IDToEdit) or (IDToEdit = 0) then
  begin
    // Menyisipkan data ke tx_user
    with UniServerModule.UserQuery do
    begin
      SQL.Clear;
      SQL.Add('INSERT INTO tx_user (username, password, role_id, created_at) ' +
            'VALUES (:username, :password, :role_id, :created_at);');
      ParamByName('username').Value := TxtUsername.Text;
      ParamByName('password').Value := TxtPassword.Text;
      ParamByName('role_id').Value := SelectedID;
      ParamByName('created_at').Value := Now;
      try
        ExecSQL;
      except
        on E: Exception do
        begin
          // Tangani kesalahan jika perlu
          Exit;
        end;
      end;
    end;

    // Mendapatkan ID yang baru saja diinsert
    UniServerModule.UserQuery.SQL.Clear;
    UniServerModule.UserQuery.SQL.Add('SELECT LAST_INSERT_ID() AS NewID;');
    UniServerModule.UserQuery.Open;
    NewID := UniServerModule.UserQuery.FieldByName('NewID').AsInteger;

    // Menyisipkan data ke tm_employee
    UniServerModule.UserQuery.SQL.Clear;
    UniServerModule.UserQuery.SQL.Add(
      'INSERT INTO tm_employee (user_id, name, created_at) ' +
      'VALUES (:user_id, :name, :created_at)');
    UniServerModule.UserQuery.ParamByName('user_id').Value := NewID;
    UniServerModule.UserQuery.ParamByName('name').Value := TxtNama.Text;
    UniServerModule.UserQuery.ParamByName('created_at').Value := Now;
    UniServerModule.UserQuery.ExecSQL;

    ShowMessage('Data berhasil disimpan');
  end
  else
  begin
    UniServerModule.UserQuery.SQL.Clear;
    UniServerModule.UserQuery.SQL.Add(
                                    'UPDATE tx_user SET username = :username, '
                                  + 'role_id = :role_id, updated_at = :updated_at '
                                  + 'WHERE id = :EmpId;');
    UniServerModule.UserQuery.ParamByName('username').Value := TxtUsername.Text;
    UniServerModule.UserQuery.ParamByName('role_id').Value := SelectedID;
    UniServerModule.UserQuery.ParamByName('updated_at').Value := Now;
    UniServerModule.UserQuery.ParamByName('EmpId').Value := IDToEdit;
    UniServerModule.UserQuery.ExecSQL;

    // Mengupdate data di tm_employee
    UniServerModule.UserQuery.SQL.Clear;
    UniServerModule.UserQuery.SQL.Add(
      'UPDATE tm_employee SET name = :name, updated_at = :updated_at ' +
      'WHERE user_id = :EmpId;');
    UniServerModule.UserQuery.ParamByName('name').Value := TxtNama.Text;
    UniServerModule.UserQuery.ParamByName('updated_at').Value := Now;
    UniServerModule.UserQuery.ParamByName('EmpId').Value := IDToEdit;
    UniServerModule.UserQuery.ExecSQL;

    ShowMessage('Data berhasil diupdate');
  end;

  // Refresh form atau melakukan tindakan lain setelah menyimpan
  FormShow(Sender);
end;

procedure TUniForm2.FormShow(Sender: TObject);
var
  RoleId : Integer;
begin

  UniServerModule.EmployeeQuery.SQL.Clear;
  UniServerModule.EmployeeQuery.SQL.Text := 'SELECT id, user_id, name, created_at, updated_at FROM tm_employee';
  UniServerModule.EmployeeQuery.Open;

  // Load roles into the combo box
  UniServerModule.RoleQuery.SQL.Text := 'select * from tm_role where is_delete = 0;';
  UniServerModule.RoleQuery.Open;
  CBRole.Clear; // Clear existing items

  UniServerModule.RoleQuery.Active := True;
  while not UniServerModule.RoleQuery.Eof do
  begin
    CBRole.Items.AddObject(UniServerModule.RoleQuery.FieldByName('name').AsString,
                           TObject(UniServerModule.RoleQuery.FieldByName('id').AsInteger));
    UniServerModule.RoleQuery.Next;
  end;

  UniServerModule.UserQuery.SQL.Clear;
  UniServerModule.UserQuery.SQL.Text := 'select u.*, e.*, r.name as role_name from tx_user u '
                                    + 'join tm_role r ON r.id = u.role_id '
                                    + 'join tm_employee e ON e.user_id = u.id '
                                    + 'where u.id_delete = 0';
  UniServerModule.UserQuery.Open;

  if IDToEdit > 0  then
  begin

    CBRole.Text := '';

    UniServerModule.EmployeeQuery.SQL.Clear;
    UniServerModule.EmployeeQuery.SQL.Text :=
          'SELECT u.username, u.role_id, u.updated_at, r.name AS role_name, ' +
          'e.user_id, e.name, e.updated_at ' +
          'FROM tx_user u ' +
          'JOIN tm_role r ON r.id = u.role_id ' +
          'JOIN tm_employee e ON e.user_id = u.id ' +
          'WHERE u.id = :ID ';
    UniServerModule.EmployeeQuery.ParamByName('ID').Value := IDToEdit;
    UniServerModule.EmployeeQuery.Open;

    TxtNama.Text        := UniServerModule.EmployeeQuery.FieldByName('name').AsString;
    TxtUsername.Text    := UniServerModule.EmployeeQuery.FieldByName('username').AsString;
    TxtPassword.Visible := False;
    RoleId              := UniServerModule.EmployeeQuery.FieldByName('role_id').AsInteger;
    CBRole.ItemIndex    := CBRole.Items.IndexOfObject(TObject(RoleId));
  end
  else
  begin
    TxtNama.Text := '';
    TxtUsername.Text := '';
    TxtPassword.Text := '';
  end;

end;

procedure TUniForm2.UniFormCreate(Sender: TObject);
begin
  UniServerModule.RoleQuery.Open;
  CBRole.Clear;

  UniServerModule.RoleQuery.Active:=True;
  while not UniServerModule.RoleQuery.Eof do
  begin
    CBRole.Items.AddObject(UniServerModule.RoleQuery.FieldByName('name').AsString,
                           TObject(UniServerModule.RoleQuery.FieldByName('id').AsInteger));
    UniServerModule.RoleQuery.Next;
  end;

  UniServerModule.EmployeeQuery.Active := True;
  UniServerModule.UserQuery.Active     := True;
end;

end.
