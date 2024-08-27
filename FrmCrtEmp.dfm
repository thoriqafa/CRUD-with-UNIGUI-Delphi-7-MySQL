object UniForm2: TUniForm2
  Left = 0
  Top = 0
  ClientHeight = 304
  ClientWidth = 271
  Caption = 'UniForm2'
  OnShow = FormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object TxtNama: TUniEdit
    Left = 8
    Top = 32
    Width = 255
    TabOrder = 0
    FieldLabel = 'Nama'
  end
  object TxtUsername: TUniEdit
    Left = 8
    Top = 72
    Width = 255
    TabOrder = 1
    FieldLabel = 'Username'
  end
  object TxtPassword: TUniEdit
    Left = 8
    Top = 112
    Width = 255
    TabOrder = 2
    FieldLabel = 'Password'
  end
  object CBRole: TUniComboBox
    Left = 8
    Top = 152
    Width = 255
    TabOrder = 3
    FieldLabel = 'Role'
    IconItems = <>
  end
  object BtnSave: TUniButton
    Left = 88
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = BtnSaveClick
  end
end
