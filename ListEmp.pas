unit ListEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, uniDBNavigator, uniGUIBaseClasses,
  uniBasicGrid, uniDBGrid, uniButton, uniEdit, uniLabel, uniDBEdit,
  uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox,
  uniGridExporters, Dialogs, uniPanel;

type
  TUniForm1 = class(TUniForm)
    UniDBGrid1: TUniDBGrid;
    BtnExport: TUniButton;
    Bedit: TUniButton;
    BtnNew: TUniButton;
    BtnDelete: TUniButton;
    procedure UniForm1Create(Sender: TObject);
    procedure UniDBGridCellClick(Column: TUniDBGridColumn);
    procedure BtnExportClick(Sender: TObject);
    procedure BeditClick(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
  private
    EmpId: Integer;
  public
  end;

function UniForm1: TUniForm1;

implementation

{$R *.dfm}
                                        
uses
  MainModule, uniGUIApplication, ServerModule, FrmCrtEmp;

function UniForm1: TUniForm1;
begin
  Result := TUniForm1(UniMainModule.GetFormInstance(TUniForm1));
end;

procedure TUniForm1.BtnExportClick(Sender: TObject);
var
  SL: TStringList;
  CSVLine: string;
begin
  SL := TStringList.Create;
  try
    // Menambahkan header kolom jika diperlukan
    SL.Add('name'); // Sesuaikan dengan nama kolom yang ada di grid

    // Mengisi data dari dataset
    UniDBGrid1.DataSource.DataSet.First;
    while not UniDBGrid1.DataSource.DataSet.Eof do
    begin
      CSVLine := Format('%s', [UniDBGrid1.DataSource.DataSet.FieldByName('name').AsString]);
      SL.Add(CSVLine);
      UniDBGrid1.DataSource.DataSet.Next;
    end;

    // Simpan ke file CSV
    SL.SaveToFile('C:\Users\user\Documents\ExportedData.csv');
    ShowMessage('Data berhasil diekspor ke CSV.');
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan saat mengekspor: ' + E.Message);
  end;
  SL.Free;
end;


procedure TUniForm1.BtnNewClick(Sender: TObject);
begin
  with TUniForm2.Create(UniApplication) do
  try
    ShowModal;
  finally

  end;
end;

procedure TUniForm1.BeditClick(Sender: TObject);
begin
  if not (VarIsNull(EmpId) or (EmpId = 0)) then
  begin
    with TUniForm2.Create(UniApplication) do
    try
      IDToEdit := EmpId;
      ShowModal;
    finally
    end;
  end
  else
  begin
    UniSession.AddJS('Ext.Msg.alert("Warning", "Data cannot empty!!!");');
  end
end;

procedure TUniForm1.BtnDeleteClick(Sender: TObject);
var
Empname : String;
begin
  if not (VarIsNull(EmpId) or (EmpId = 0)) then
  begin
    UniServerModule.UserQuery.SQL.Clear;
    UniServerModule.UserQuery.SQL.Text := 'SELECT name FROM tm_employee WHERE user_id = :EmpId';
    UniServerModule.UserQuery.ParamByName('EmpId').Value := EmpId;
    UniServerModule.UserQuery.Open;
    EmpName := UniServerModule.UserQuery.FieldByName('name').AsString;
    MessageDlg('Are You Sure delete '+ Empname +'?', mtConfirmation, [mbYes, mbNo],
      procedure(Sender: TComponent; Res: Integer)
      begin
        if Res = mrYes then
        begin
          // Update data di tx_user
          UniServerModule.UserQuery.SQL.Clear;
          UniServerModule.UserQuery.SQL.Add(
            'UPDATE tx_user SET id_delete = 1, deleted_at = now() ' +
            'WHERE id = :EmpId');
          UniServerModule.UserQuery.ParamByName('EmpId').Value := EmpId;
          UniServerModule.UserQuery.ExecSQL;

          // Update data di tm_employee
          UniServerModule.UserQuery.SQL.Clear;
          UniServerModule.UserQuery.SQL.Add(
            'UPDATE tm_employee SET is_delete = 1, deleted_at = now() ' +
            'WHERE user_id = :EmpId');
          UniServerModule.UserQuery.ParamByName('EmpId').Value := EmpId;
          UniServerModule.UserQuery.ExecSQL;

          // Menampilkan pesan sukses
          UniSession.AddJS('Ext.Msg.alert("Success", "Record deleted successfully.");');
        end
        else
        begin
          // Menampilkan pesan batal
          UniSession.AddJS('Ext.Msg.alert("Cancelled", "Action was cancelled.");');
        end;
      end
    );
  end
  else
  begin
    UniSession.AddJS('Ext.Msg.alert("Warning", "Data cannot empty!!!");');
  end
end;


procedure TUniForm1.UniDBGridCellClick(Column: TUniDBGridColumn);
begin
  EmpId := 0;
  EmpId            := UniDBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
end;

procedure TUniForm1.UniForm1Create(Sender: TObject);
begin
  UniServerModule.EmployeeQuery.SQL.Clear;
  UniServerModule.EmployeeQuery.SQL.Text := 'SELECT id, user_id, name, created_at, updated_at FROM tm_employee';
  UniServerModule.EmployeeQuery.Open;

  UniServerModule.UserQuery.SQL.Clear;
  UniServerModule.UserQuery.SQL.Text := 'select u.*, e.*, r.name as role_name from tx_user u '
                                    + 'join tm_role r ON r.id = u.role_id '
                                    + 'join tm_employee e ON e.user_id = u.id '
                                    + 'where u.id_delete = 0';
  UniServerModule.UserQuery.Open;


end;

end.
