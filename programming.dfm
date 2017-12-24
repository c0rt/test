object Form1: TForm1
  Left = 638
  Top = 254
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1093#1088#1072#1085#1085#1086#1081' '#1089#1080#1089#1090#1077#1084#1099' '#1085#1072' '#1086#1089#1085#1086#1074#1077' '#1074#1077#1073'-'#1082#1072#1084#1077#1088#1099
  ClientHeight = 333
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 408
    Top = 24
    Width = 147
    Height = 13
    Caption = #1055#1077#1088#1080#1086#1076' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1074' '#1089#1077#1082#1091#1085#1076#1072#1093
  end
  object Label2: TLabel
    Left = 408
    Top = 48
    Width = 31
    Height = 13
    Caption = #1055#1086#1088#1086#1075
  end
  object Label3: TLabel
    Left = 488
    Top = 48
    Width = 8
    Height = 13
    Caption = '%'
  end
  object Label4: TLabel
    Left = 512
    Top = 112
    Width = 3
    Height = 13
  end
  object Label5: TLabel
    Left = 408
    Top = 112
    Width = 90
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1089#1088#1072#1074#1085#1077#1085#1080#1103
  end
  object LabelAttention: TLabel
    Left = 504
    Top = 80
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 408
    Top = 136
    Width = 88
    Height = 13
    Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1081' '#1087#1086#1088#1086#1075
  end
  object LabelThreshold: TLabel
    Left = 512
    Top = 136
    Width = 3
    Height = 13
  end
  object EditPeriod: TEdit
    Left = 560
    Top = 24
    Width = 33
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object ButtonSettings: TButton
    Left = 24
    Top = 296
    Width = 153
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1082#1072#1095#1077#1089#1090#1074#1086' '#1079#1072#1087#1080#1089#1080
    TabOrder = 1
    OnClick = ButtonSettingsClick
  end
  object ButtonPreview: TButton
    Left = 320
    Top = 296
    Width = 75
    Height = 25
    Caption = #1055#1088#1077#1074#1100#1102
    TabOrder = 2
    OnClick = ButtonPreviewClick
  end
  object ButtonSave: TButton
    Left = 408
    Top = 72
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object ButtonReset: TButton
    Left = 480
    Top = 296
    Width = 121
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 4
    OnClick = ButtonResetClick
  end
  object ButtonScreenshot: TButton
    Left = 192
    Top = 296
    Width = 113
    Height = 25
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1089#1082#1088#1080#1085
    TabOrder = 5
    OnClick = ButtonScreenshotClick
  end
  object ButtonStart: TButton
    Left = 408
    Top = 168
    Width = 195
    Height = 25
    Caption = #1047#1072#1074#1077#1089#1090#1080' '#1090#1072#1081#1084#1077#1088' '#1080' '#1085#1072#1095#1072#1090#1100' '#1089#1083#1077#1078#1082#1091
    TabOrder = 6
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 408
    Top = 200
    Width = 193
    Height = 25
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1083#1077#1078#1082#1091
    TabOrder = 7
    OnClick = ButtonStopClick
  end
  object ButtonDirScreen: TButton
    Left = 408
    Top = 232
    Width = 193
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1089#1086' '#1089#1082#1088#1080#1085#1096#1086#1090#1072#1084#1080
    TabOrder = 8
    OnClick = ButtonDirScreenClick
  end
  object Panel1: TPanel
    Left = 24
    Top = 16
    Width = 369
    Height = 265
    Caption = #1054#1075#1091#1088#1077#1094
    TabOrder = 9
  end
  object EditThreshold: TEdit
    Left = 448
    Top = 48
    Width = 33
    Height = 21
    TabOrder = 10
    Text = '20'
  end
  object ButtonDirAttention: TButton
    Left = 408
    Top = 264
    Width = 193
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1089' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1103#1084#1080
    TabOrder = 11
    OnClick = ButtonDirAttentionClick
  end
  object TrayIcon1: TTrayIcon
    Visible = True
    Hint = #1086#1088#1091
    PopupMenu = PopupMenu1
    Hide = True
    RestoreOn = imLeftClickUp
    PopupMenuOn = imRightClickUp
    OnRestore = TrayIcon1Restore
    Left = 24
    Top = 65528
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 56
    Top = 65528
  end
  object PopupMenu1: TPopupMenu
    Left = 88
    Top = 65528
    object N1: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = N1Click
    end
    object N4: TMenuItem
      Caption = #1053#1072#1095#1072#1090#1100' '#1089#1083#1077#1078#1082#1091
      OnClick = N4Click
    end
    object N2: TMenuItem
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1083#1077#1078#1082#1091
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1042#1099#1081#1090#1080
      OnClick = N3Click
    end
  end
end
