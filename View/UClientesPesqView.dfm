object frmClientesPesq: TfrmClientesPesq
  Left = 503
  Top = 244
  Width = 570
  Height = 305
  Caption = 'Pesquisa de Cliente'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object stbBarraStatus: TStatusBar
    Left = 0
    Top = 247
    Width = 554
    Height = 19
    Panels = <>
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 200
    Width = 554
    Height = 47
    Align = alBottom
    Caption = #39
    TabOrder = 2
    object btnConfirmar: TBitBtn
      Left = 297
      Top = 8
      Width = 77
      Height = 25
      Caption = 'C&onfirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFBAE3C170CE8426B7461DB9401DB94026B74670CE84BAE3C1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FDFA4EB86119C1401FCE4C24DC5827
        DD5C27DD5C24DC581FCE4C19C1404EB861F9FDFAFFFFFFFFFFFFFFFFFFFAFDFB
        21A93A1ED04E21D45420D05304B62A18C4401DCE4A18C84420D15121D4541ED0
        4E21A93AFAFDFBFFFFFFFFFFFF4DB15A1ECE4D22D45615C9481CAC2F9DD2A137
        AF4614C13B1FD24E1ECE4B1ECD4A20D2531ECE4D4DB15AFFFFFFBCDEBE17BA3F
        21D85A13C64612A826F2F4ECFFFFFFEAF2E626AA380DC03920D24F1ECE491DCD
        4D20D75817BA3FBCDEBE6ABB7318D15214CB4E0BA01EF2F4ECFFFBFFFFFAFFFF
        FFFFEAF2E623A8350BC03A1ED3591CCF531ED25818CF516ABB7330A03E2DE172
        1BA82DF2F4ECFFF8FFEAF2E6A9D5A4EEF2EBFFFFFFD0EBD323A8340AC24218D6
        6213CF5430E17330A14030A34265EAA158B25CEAF2E6EAF2E60EB42F00BF303A
        B649F2F4ECFFFFFFEAF2E623A83307C13D24D86973F0B130A04122943678F4BC
        49CD7A74BF7F2DB64C24D3672ED87219CC5A48B558EAF2E6FFFFFFEAF2E626A7
        3125D06077F6BE22943532923C71F2B561E4A84CDB955BE1A561DEA563DDA463
        E2AB4DDA964FB860EEF2E8FFFFFFEAF2E62AB3436DF0B332923C67AA6686E3B5
        62E7A95DE2A460E2A65FE1A65FE1A65EE1A563E5AD4CDA954DB75EEAF0E5FFFF
        FF61BC6580DFAE67AA66B9D3B94EB068A8FCE15FE1A257E09F5BE0A35DE1A45D
        E1A45DE1A461E5AB4EDC9748BA605DC27096EABF4EB068B9D3B9FFFFFF458845
        7BDBA7B0FCE876E5B562E3AA5EE0A65EE1A65EE1A65EE0A566E6B06FE3AFA7F9
        E07ADCA8458845FFFFFFFFFFFFFAFCFA1572156DD6A3B3FDF0A4F5DF8CE9C78C
        E8C48AE7C28DE9C6A5F5DEB3FDF06DD6A3157215FAFCFAFFFFFFFFFFFFFFFFFF
        F9FBF945854538A75E7FE1B8A9FFECB9FFFBB9FFFBA9FFEC7FE1B838A75E4585
        45F9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7CDB767A567247C3228
        8637288637247C3267A567B7CDB7FFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnLimpar: TBitBtn
      Left = 381
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Limpar'
      TabOrder = 1
      OnClick = btnLimparClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        825B1EA383529E7C479E7C489E7C489E7C489E7C489E7C489E7C489E7C489D7B
        4B9975448D6632FFFFFFFFFFFFFFFFFFA08052FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF997645FFFFFFFFFFFFFFFFFF
        A68556FFFFFFF5F4ECF3F1E8F3F1E9F3F1E9F2F0E7EFE8DEEEE9E0EFEBE2F6F3
        EDF0EBE2997238FFFFFFFFFFFFFFFFFFAD9164FFFFFFF6F4EFF5F2EFF5F2EFF5
        F2EFF5F2EFF6F5EDF3F4E8F3F0EAFCFCF9EFE9E0997339FFFFFFFFFFFFFFFFFF
        B39669FFFFFFF6F4EFF5F2EDF5F2EDF5F2EDF5F3EEF5F2EEF7F3EFF5F2EDFDFD
        FAEFE8E0997339FFFFFFFFFFFFFFFFFFB19667FFFFFFF6F4EFF5F2EDF5F2EDF5
        F2EDF7F6EFF6F1EEFCF6F4FAF3F2FEFBFDEFE9DF997338FFFFFFFFFFFFFFFFFF
        B19666FFFFFFF6F4EFF5F2EDF4F1ECF4F0ECF9F3F2FBFAF0FBF9F5FBF4F3FCF7
        F3EFEAE399733AFFFFFFFFFFFFFFFFFFB0956DFFFFFFF7F4EDF4F1ECF6F2EDF9
        F2F2FAFAF4FBFDF6FCFAF9F4EFE7F5F1ECF0EAE29A743BFFFFFFFFFFFFFFFFFF
        B19E7CFFFFFFFCFEF8F9F9F0FBFAF9FAF9FCFBFCFBFAFAFCF3F1E9EAE5DDECE7
        E0E6D8CB9A753BFFFFFFFFFFFFFFFFFFBDA787FFFFFFFDFEFCFAFBF8FAFAFCFA
        FBFEFCFBF9F5F2EAF0EEE7E9E2DAE6DDD4D6CBB49A763EFFFFFFFFFFFFFFFFFF
        C5B190FFFFFFFCFDFDFAF9F9FAFBFDFBFDFAF9F7F0F3EEE4DDD4C5D4BEABD0BC
        A1BEA7849A773FFFFFFFFFFFFFFFFFFFC7B596FFFFFFF8FDFDFAFBFBFBFDFAF6
        F7EBF3F1E9E3D9CAC9B493EBE3DCE1D9C6B79D739D763FFFFFFFFFFFFFFFFFFF
        C8B599FFFFFFFBFDFFFDFDFDF6F7F2EDE7E0EFE4DDD1BEA6CDB99AFFFFFFCFBB
        A1B3956AF9F7F4FFFFFFFFFFFFFFFFFFC9B89BFFFFFFFCFFFFFCF8F3F4EBE5E5
        DFD7E3D6C6CDB696BCAA89D6C8B4AA8A56FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        CBBDA2FFFFFFFFFFFFFAF7F6F0E8DFDFD7C7D8C6B1C1AA859F824CB29569FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4B293CEBDA4CCBBA1C9B79BC8B699C5
        AF8DC2AA84AA9161A98B5DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnSair: TBitBtn
      Left = 469
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Sair'
      TabOrder = 2
      OnClick = btnSairClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAC6A2CE1A53CE6C590F2E1C4F9F0
        E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5CDBAB6
        B6BA975B19DF9C1FCC891BCD8A1BCD8A1BD6A149E6BE74E4CEB7FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFB36623121019804A09E39C20CB891CCD8A1CCD8A
        1CCC891CD6941CAC641DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC77C2D13
        111A864F09E49A21CD8A1DCF8B1DCF8B1DCE8A1DD8941BB36F2BFFFFFFFFFFFF
        FFFFFFFDFDFF2121CBFFFFFFD7924014111B8A530BE69E22CE8C1FCF8D1FCF8D
        1FCE8C1FD6941DB7742FFFFFFFFFFFFFFFFFFFFFFFFF1614D92429F4AE6D4125
        1A008E530ED89220CF8C1FD08F23D08F22CF8E22D79620BA79333039E71D2AE8
        232CE8222EEB2430EF2032FF1B25F900002FAA6F06E4EAF1BC7418D69324D292
        27D29127D89925BE7D36606DEF152EF4223AF42137F42338F2273AEF213CFF2B
        3FFF895645FAD273D29A3DD6982ED39229D4932BDA9C2DC282396A7BF44565F7
        4A67F64E69F6425CF31F3CF25E7FFF1F28B9A46820F0BA4DDEAE56DFAF58DBA7
        49D59A36DB9F31C6893E5960EF656FF1636DF16670F0495FF1638AFF8667B40D
        0300AA7628F2C46DE0B05DE0B25EE2B462E2B261E1AE4BCB8C3FFFFFFFFFFFFF
        FFFFFFFFFFFF3B40F05460FFE9A94E22180BA8793AF5CA77E2B768E3B869E3B8
        69E4B86AEAC377D1984DFFFFFFFFFFFFFFFFFFFBFAFF2222FFFFFFFFF7B64C1C
        1014B2803FF8D284E6BF73E7C074E7C074E7BF73ECCB80D59E53FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF6B1441D1212B98949FDD991EAC681EAC581EAC5
        81EAC581F0D08FD9A457FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7AC5B18
        0D0EC49957FFF2AFFFE09DFFE4A0F8DB9AF3D495F5DEA3DEAB5DFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFECB05C301F1B231F206E5A449E8663BBA77CDDC1
        8CF1D399FEEBBAE3B164FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAB968DB
        A851CF9D4EC59346B98A40B38139CE9A47DFAB53E8B863E4B25F}
    end
    object BtnExportar: TBitBtn
      Left = 17
      Top = 8
      Width = 77
      Height = 25
      Caption = 'Exportar'
      TabOrder = 3
      OnClick = BtnExportarClick
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF0084000084000084000084000084000084000084000084
        000084000084000084006666666666666666666666666666664F4F4F4F4F4F4F
        4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4FAA7F7AB88384
        B88384B88384B88384008400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF0084008181818888888888888888888888884F4F4FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FAD827BFCEBCE
        F7DFBFF4DAB3F3D6AB008400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF008400848484E4E4E4D7D7D7D0D0D0CCCCCC4F4F4FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FB1857CFDEDD5
        F5DFC5F4DBBBF2D7B2008400FFFFFF91CA91008400309B30FBFDFB84C4840084
        0068B668FFFFFF008400868686E7E7E7D9D9D9D3D3D3CECECE4F4F4FFFFFFFB3
        B3B34F4F4F707070FCFCFCAAAAAA4F4F4F969696FFFFFF4F4F4FB6897EFEF2DE
        F7E5CEF5E0C5F4DCBC008400FFFFFFFFFFFFC4E3C40486041C911C00840084C4
        84FFFFFFFFFFFF0084008A8A8AEDEDEDDFDFDFDADADAD4D4D44F4F4FFFFFFFFF
        FFFFD6D6D65252526262624F4F4FAAAAAAFFFFFFFFFFFF4F4F4FBA8D80FFF7E8
        F8E8D6F6E4CDF5E0C4008400FFFFFFFFFFFFFFFFFF69B769008400178F17FBFD
        FBFFFFFFFFFFFF0084008D8D8DF3F3F3E4E4E4DEDEDED9D9D94F4F4FFFFFFFFF
        FFFFFFFFFF9797974F4F4F5F5F5FFCFCFCFFFFFFFFFFFF4F4F4FBF9183FFFCF2
        F9EDDFF7E8D6F6E4CD008400FFFFFFFFFFFF7ABF7A00840065B5650486043AA0
        3AF2F9F2FFFFFF008400919191F9F9F9EAEAEAE4E4E4DEDEDE4F4F4FFFFFFFFF
        FFFFA3A3A34F4F4F959595525252777777F6F6F6FFFFFF4F4F4FC49685FFFFFC
        FAF1E8F9ECDEF8E8D5008400FFFFFF61B3610084007BBF7BFFFFFFCAE5CA0385
        033AA03AFFFFFF008400959595FEFEFEEFEFEFE9E9E9E3E3E34F4F4FFFFFFF92
        92924F4F4FA3A3A3FFFFFFDADADA515151777777FFFFFF4F4F4FC99B87FFFFFF
        FDF7F2FBF1E8FAEEDF008400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF008400999999FFFFFFF6F6F6EFEFEFEAEAEA4F4F4FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FCD9E8AFFFFFF
        FFFCFBFEF7F1FBF2E7008400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF0084009C9C9CFFFFFFFCFCFCF5F5F5EFEFEF4F4F4FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FD1A38BFFFFFF
        FFFFFFFFFDFBFDF7F10084000084000084000084000084000084000084000084
        00008400008400008400A0A0A0FFFFFFFFFFFFFCFCFCF5F5F54F4F4F4F4F4F4F
        4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4FD6A78DFFFFFF
        FFFFFFFFFFFFFFFDFBFDF7F1FBF1E6FAEDDEFDF0DDEADDCAC7BFB0B88384FF00
        FFFF00FFFF00FFFF00FFA3A3A3FFFFFFFFFFFFFFFFFFFCFCFCF5F5F5EEEEEEE9
        E9E9EBEBEBD8D8D8BBBBBB888888666666666666666666666666D9AA8FFFFFFF
        FFFFFFFFFFFFFFFFFFFEFDFBFDF8F0FBF3E7B88384B88384B88384B88384FF00
        FFFF00FFFF00FFFF00FFA6A6A6FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF6F6F6F0
        F0F0888888888888888888888888666666666666666666666666DDAC91FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF7F0ECB88384E9B676F3AE52CA8A6AFF00
        FFFF00FFFF00FFFF00FFA8A8A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEEF
        EFEF888888A7A7A7999999868686666666666666666666666666DFAF92FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFEB88384EBB87AD09877FF00FFFF00
        FFFF00FFFF00FFFF00FFABABABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB
        FBFB888888AAAAAA939393666666666666666666666666666666DBA685DBA685
        DBA685DBA685DBA685DBA685DBA685DBA685B88384CA9784FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFA1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1
        A1A1888888969696666666666666666666666666666666666666}
      NumGlyphs = 2
    end
  end
  object pnFiltro: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 49
    Align = alTop
    TabOrder = 0
    object grbFiltrar: TGroupBox
      Left = 1
      Top = 1
      Width = 552
      Height = 47
      Align = alClient
      Caption = 'Filtrar'
      TabOrder = 0
      object lblNome: TLabel
        Left = 8
        Top = 24
        Width = 28
        Height = 13
        Caption = 'Nome'
      end
      object lblInfo: TLabel
        Left = 56
        Top = 8
        Width = 227
        Height = 13
        Caption = 'Digite parte ou todo conte'#250'do a ser pesquisado '
      end
      object edtNome: TEdit
        Left = 56
        Top = 24
        Width = 361
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object btnFiltrar: TBitBtn
        Left = 449
        Top = 16
        Width = 77
        Height = 25
        Caption = '&Filtrar'
        TabOrder = 1
        OnClick = btnFiltrarClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFB46822CF9D73F0E2D8FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0933CE8
          A527AD570FBB7A4CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFCD903FEAAF30BD660EB56217FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD09446E9
          B23EC06B14BA671DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD2994AECB849C6711BBE6B1FFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD59C4EEE
          BF53CB7820C26F22FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD8A253F1C45FCE7E24C77A27FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAA558F2
          C866D1842ACB7F2CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFE1B78AEAC681EFC261DA983ACB7824E3BC8EFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEED6B9E9C588F3CF76EF
          C264E7B358D17D26D58C33F0DABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF5E5D2E5BB7CF8DB8FEEC463EFC76CF2C96CDC9337D5852CD9983CF6E7
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF7EFE0AC5AF8DE91F1C55DF2C666F1
          C363F4CB6AE8AF44D9851DDF9331E09F40FDFAF6FFFFFFFFFFFFFFFFFFFFFFFF
          E4B46CFBEEC3FAE8B9F7E8C6F5EEE0F3F0EAF1EDE9EEE9DBDAA964D6A259E0AB
          5DE3AF60FFFFFFFFFFFFFBF3E7ECC990FEFEFAFFFFFFF6F4F3F2F3F4EEE9DFE7
          D5AAE2CFA1E6E2D7D9C9A8CFB278CAB796D3C4ADEAC68DFBF3E7E5AE54E7B75B
          E5B24EDB931ADC981EDD971EDD971EDC961ADD951BDF9920E09D29E19F2AE2A0
          29E0AA43E2AF52E4AF54F9ECD3F4DAACEFCB88F0CA7DEFC56DEFC56CF0C56BF4
          CC7AF4CD7BF0C56DEFC56CEFC66DF0CA7EF2CD8AF4DBADF9ECD3}
      end
    end
  end
  object pnResultado: TPanel
    Left = 0
    Top = 49
    Width = 554
    Height = 151
    Align = alClient
    TabOrder = 1
    object grbGrid: TGroupBox
      Left = 1
      Top = 1
      Width = 552
      Height = 149
      Align = alClient
      Caption = 'Resultado da Busca'
      TabOrder = 0
      object dbgCliente: TDBGrid
        Left = 2
        Top = 15
        Width = 548
        Height = 132
        Align = alClient
        DataSource = dtsCliente
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = dbgClienteDblClick
        OnKeyDown = dbgClienteKeyDown
        OnTitleClick = dbgClienteTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 447
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoAtivo'
            Title.Caption = 'Ativo'
            Width = 46
            Visible = True
          end>
      end
    end
  end
  object dtsCliente: TDataSource
    DataSet = cdsCliente
    Left = 17
    Top = 122
  end
  object cdsCliente: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    BeforeDelete = cdsClienteBeforeDelete
    Left = 57
    Top = 122
    Data = {
      6F0000009619E0BD0100000018000000040000000000030000006F0002494404
      00010000000000044E6F6D650100490000000100055749445448020002006400
      05417469766F04000100000000000E44657363726963616F417469766F010049
      00000001000557494454480200020003000000}
    object cdsClienteID: TIntegerField
      DisplayWidth = 5
      FieldName = 'ID'
    end
    object cdsClienteNome: TStringField
      DisplayWidth = 71
      FieldName = 'Nome'
      Size = 100
    end
    object cdsClienteAtivo: TIntegerField
      DisplayWidth = 7
      FieldName = 'Ativo'
    end
    object cdsClienteDescricaoAtivo: TStringField
      DisplayWidth = 20
      FieldName = 'DescricaoAtivo'
      Size = 3
    end
  end
  object svdDiretorio: TSaveDialog
    FileName = 'ListagemCliente'
    Filter = 'ArquivosXLS| *.xls'
    InitialDir = 'C:\'
    Left = 97
    Top = 210
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 128
    Top = 208
  end
  object dsClienteGrupo: TDataSource
    Left = 417
    Top = 9
  end
end
