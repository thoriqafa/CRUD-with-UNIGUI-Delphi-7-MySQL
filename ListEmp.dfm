object UniForm1: TUniForm1
  Left = 0
  Top = 0
  ClientHeight = 454
  ClientWidth = 825
  Caption = 'UniForm1'
  OnShow = UniForm1Create
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniDBGrid1: TUniDBGrid
    Left = 8
    Top = 8
    Width = 809
    Height = 195
    ClicksToEdit = 3
    CellCursor = crHandPoint
    DataSource = UniServerModule.DataSource3
    ReadOnly = True
    LoadMask.Message = 'Loading data...'
    TabOrder = 4
    OnCellClick = UniDBGridCellClick
    Columns = <
      item
        FieldName = 'name'
        Title.Caption = 'name'
        Width = 274
      end
      item
        FieldName = 'username'
        Title.Caption = 'username'
        Width = 304
      end
      item
        FieldName = 'role_name'
        Title.Caption = 'role_name'
        Width = 274
      end
      item
        FieldName = 'created_at'
        Title.Caption = 'created_at'
        Width = 112
      end
      item
        FieldName = 'updated_at'
        Title.Caption = 'updated_at'
        Width = 112
      end>
  end
  object BtnExport: TUniButton
    Left = 480
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 0
    OnClick = BtnExportClick
  end
  object Bedit: TUniButton
    Left = 128
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 1
    OnClick = BeditClick
  end
  object BtnNew: TUniButton
    Left = 8
    Top = 232
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 2
    OnClick = BtnNewClick
  end
  object BtnDelete: TUniButton
    Left = 262
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = BtnDeleteClick
  end
end
