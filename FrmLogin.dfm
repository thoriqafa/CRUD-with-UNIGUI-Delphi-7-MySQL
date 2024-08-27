object UniLoginForm2: TUniLoginForm2
  Left = 0
  Top = 0
  ClientHeight = 188
  ClientWidth = 499
  Caption = 'Login'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniLoginFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TxtUsername: TUniEdit
    Left = 192
    Top = 40
    Width = 145
    Height = 25
    TabOrder = 0
  end
  object TxtPassword: TUniEdit
    Left = 192
    Top = 71
    Width = 145
    Height = 25
    TabOrder = 1
  end
  object UniLabel1: TUniLabel
    Left = 96
    Top = 52
    Width = 48
    Height = 13
    Caption = 'Username'
    TabOrder = 2
  end
  object UniLabel2: TUniLabel
    Left = 96
    Top = 83
    Width = 46
    Height = 13
    Caption = 'Password'
    TabOrder = 3
  end
  object BtnLogin: TUniButton
    Left = 192
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 4
    OnClick = BtnLoginClick
  end
  object UniLabel3: TUniLabel
    Left = 160
    Top = 102
    Width = 157
    Height = 13
    Visible = False
    Caption = 'Username atau password salah !'
    ParentFont = False
    Font.Color = clRed
    ParentColor = False
    Color = clBackground
    TabOrder = 5
  end
  object ADOQuery1: TMyQuery
    SQL.Strings = (
      'select * from tx_user;')
    Left = 400
    Top = 128
  end
end
