object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 464
  ClientWidth = 884
  Caption = 'MainForm'
  WindowState = wsMaximized
  OldCreateOrder = False
  Menu = UniMainMenu1
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniMainMenu1: TUniMainMenu
    Left = 24
    Top = 48
    object masterdata1: TUniMenuItem
      Caption = 'master data'
      object employee1: TUniMenuItem
        Caption = 'employee'
        OnClick = employee1Click
      end
    end
  end
end
