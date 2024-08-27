object UniServerModule: TUniServerModule
  OldCreateOrder = False
  TempFolder = 'temp\'
  Title = 'New Application'
  SuppressErrors = []
  Bindings = <>
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  Height = 397
  Width = 293
  object DataSource1: TDataSource
    DataSet = EmployeeQuery
    Left = 40
    Top = 192
  end
  object DataSource2: TDataSource
    DataSet = RoleQuery
    Left = 40
    Top = 256
  end
  object DataSource3: TDataSource
    DataSet = UserQuery
    Left = 40
    Top = 152
  end
  object ADOConnection1: TMyConnection
    Database = 'db_slf'
    Username = 'root'
    Server = 'localhost'
    Connected = True
    Left = 88
    Top = 40
  end
  object UserQuery: TMyQuery
    Connection = ADOConnection1
    SQL.Strings = (
      'select u.*, e.name, r.name as role_name'
      'from tx_user u'
      'join tm_role r ON r.id = u.role_id'
      'join tm_employee e ON e.user_id = u.id;')
    Active = True
    Left = 168
    Top = 152
  end
  object EmployeeQuery: TMyQuery
    Connection = ADOConnection1
    SQL.Strings = (
      'select * from tm_employee where is_delete = 0;')
    Active = True
    Left = 168
    Top = 200
  end
  object RoleQuery: TMyQuery
    Connection = ADOConnection1
    SQL.Strings = (
      'select * from tm_role where is_delete = 0;')
    Active = True
    Left = 176
    Top = 255
  end
end
