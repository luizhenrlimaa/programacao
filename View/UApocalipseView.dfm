object frmApocalipse: TfrmApocalipse
  Left = 390
  Top = 223
  Width = 637
  Height = 223
  Caption = 'Apocalipse'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grbErros: TGroupBox
    Left = 0
    Top = 0
    Width = 629
    Height = 137
    Align = alClient
    Caption = ' Erros '
    TabOrder = 0
    object btnAccessViolation: TButton
      Left = 8
      Top = 12
      Width = 125
      Height = 33
      Caption = 'Access Violation'
      TabOrder = 0
      OnClick = btnAccessViolationClick
    end
    object btnListIndex: TButton
      Left = 140
      Top = 12
      Width = 126
      Height = 33
      Caption = 'List index out of a bound'
      TabOrder = 1
      OnClick = btnListIndexClick
    end
    object btnConversaoInteiro: TButton
      Left = 272
      Top = 10
      Width = 136
      Height = 34
      Caption = 'is not a valid integer value'#13#10'Convers'#227'o para inteiro'
      TabOrder = 2
      WordWrap = True
      OnClick = btnConversaoInteiroClick
    end
    object grbBDouSQL: TGroupBox
      Left = 8
      Top = 48
      Width = 620
      Height = 82
      Caption = 'Banco de Dados ou SQL'
      TabOrder = 3
      object btnConexaoBD: TButton
        Left = 8
        Top = 20
        Width = 145
        Height = 53
        Caption = 
          '"SQLConnection property '#13#10'required for this operation"'#13#10'Conex'#227'o ' +
          'com BD'
        TabOrder = 0
        WordWrap = True
        OnClick = btnConexaoBDClick
      end
      object btnFaltaCampoSQL: TButton
        Left = 156
        Top = 20
        Width = 126
        Height = 53
        Caption = '"Column unknown"'#13#10'Falta de campos SQL'
        TabOrder = 1
        WordWrap = True
        OnClick = btnFaltaCampoSQLClick
      end
      object btnTabelaSQL: TButton
        Left = 286
        Top = 20
        Width = 126
        Height = 53
        Caption = '"Table unknown"'#13#10'Tabela incorreta no SQL'
        TabOrder = 2
        WordWrap = True
        OnClick = btnTabelaSQLClick
      end
      object btnParametroSQL: TButton
        Left = 417
        Top = 19
        Width = 198
        Height = 55
        Caption = '"Parameter NomeParametro not found"'#13#10'Par'#226'metro incorreto no SQL'
        TabOrder = 3
        WordWrap = True
        OnClick = btnParametroSQLClick
      end
    end
  end
  object grbAuxiliares: TGroupBox
    Left = 0
    Top = 137
    Width = 629
    Height = 55
    Align = alBottom
    Caption = 'Auxiliares para aplicar o erro'
    TabOrder = 1
    object cmbItens: TComboBox
      Left = 8
      Top = 16
      Width = 73
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'Itens'
      Items.Strings = (
        'Item 1'
        'Item 2'
        'Item 3')
    end
  end
end
