unit FrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniButton, uniLabel,
  uniGUIBaseClasses, uniEdit, IdHashSHA1, IdHash, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ADODB, MyAccess, MyClasses, MyCall, DBAccess, MemDS;
type
  TUniLoginForm2 = class(TUniLoginForm)
    TxtUsername: TUniEdit;
    TxtPassword: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    BtnLogin: TUniButton;
    UniLabel3: TUniLabel;
    ADOQuery1: TMyQuery;
    procedure BtnLoginClick(Sender: TObject);
    procedure UniLoginFormCreate(Sender: TObject);
  private
  public
    cUsername:string;
  end;

function UniLoginForm2: TUniLoginForm2;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule, Main;

function UniLoginForm2: TUniLoginForm2;
begin
  Result := TUniLoginForm2(UniMainModule.GetFormInstance(TUniLoginForm2));
end;

procedure TUniLoginForm2.BtnLoginClick(Sender: TObject);
var
  Username, Password, HashedPassword: string;
  StoredHashedPassword: string;
  ZQuery: TMyQuery;
begin
  Username := TxtUsername.Text;
  Password := TxtPassword.Text;

  HashedPassword := LowerCase(TIdHashSHA1.Create.HashStringAsHex(Password));

  ZQuery := TMyQuery.Create(nil);
  try
    ZQuery.Connection := UniServerModule.ADOConnection1;
    ZQuery.SQL.Text := 'Select password FROM tx_user WHERE username = :Username';
    ZQuery.ParamByName('Username').Value := Username;
    ZQuery.Open;
    if not ZQuery.EOF then
    begin
      StoredHashedPassword := LowerCase(ZQuery.FieldByName('Password').AsString);

      // Cek apakah hashed password yang diinput sesuai dengan yang tersimpan
      if HashedPassword = StoredHashedPassword then
      begin
        ShowMessage('Login berhasil!');
        MainForm.Show;
        Self.Hide;
      end
      else
      begin
        ShowMessage('Password salah! Hashed Password Input: ' + HashedPassword + 'Stored Hashed Password: ' + StoredHashedPassword);
      end;
    end
    else
    begin
      ShowMessage('Username tidak ditemukan!');
    end;

  finally
    ZQuery.Free;
  end;
end;

procedure TUniLoginForm2.UniLoginFormCreate(Sender: TObject);
begin
  Self.BorderStyle := bsNone;
  Self.Caption := '';
  Self.BorderIcons := [];
  TxtPassword.PasswordChar := '*';
end;

initialization
  RegisterAppFormClass(TUniLoginForm2);

end.
