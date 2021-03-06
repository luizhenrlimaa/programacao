object frmGenesis: TfrmGenesis
  Left = 2195
  Top = 100
  Width = 877
  Height = 674
  Caption = 'Projeto G'#234'nesis'
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
  object pnlEsquerda: TPanel
    Left = 0
    Top = 0
    Width = 423
    Height = 366
    Align = alLeft
    TabOrder = 0
    object grbMensagens: TGroupBox
      Left = 8
      Top = 1
      Width = 185
      Height = 105
      Caption = ' Mensagens '
      TabOrder = 0
      object btnInformacao: TButton
        Left = 8
        Top = 16
        Width = 81
        Height = 25
        Caption = 'Informa'#231#227'o'
        TabOrder = 0
        OnClick = btnInformacaoClick
      end
      object btnAlerta: TButton
        Left = 96
        Top = 16
        Width = 81
        Height = 25
        Caption = 'Alerta'
        TabOrder = 1
        OnClick = btnAlertaClick
      end
      object btnPergunta: TButton
        Left = 8
        Top = 48
        Width = 81
        Height = 25
        Caption = 'Pergunta (Sim)'
        TabOrder = 2
        OnClick = btnPerguntaClick
      end
      object btnPerguntaFocoNao: TButton
        Left = 96
        Top = 48
        Width = 81
        Height = 25
        Caption = 'Pergunta (N'#227'o)'
        TabOrder = 3
        OnClick = btnPerguntaFocoNaoClick
      end
      object btnErro: TButton
        Left = 49
        Top = 76
        Width = 81
        Height = 25
        Caption = 'Erro'
        TabOrder = 4
        OnClick = btnErroClick
      end
    end
    object grbObjeto: TGroupBox
      Left = 200
      Top = 1
      Width = 217
      Height = 105
      Caption = ' Objeto '
      TabOrder = 1
      object btnCriarObjeto: TButton
        Left = 6
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Criar Objeto'
        TabOrder = 0
        OnClick = btnCriarObjetoClick
      end
    end
    object grbStandard: TGroupBox
      Left = 8
      Top = 107
      Width = 410
      Height = 280
      Caption = ' Standard '
      TabOrder = 2
      object lblSexo: TLabel
        Left = 11
        Top = 42
        Width = 84
        Height = 13
        Caption = 'Sexo (ComboBox)'
      end
      object chkAtivo: TCheckBox
        Left = 8
        Top = 17
        Width = 106
        Height = 17
        Caption = 'Ativo (CheckBox)'
        TabOrder = 0
        OnClick = chkAtivoClick
      end
      object cmbSexo: TComboBox
        Left = 99
        Top = 38
        Width = 79
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbSexoChange
        OnExit = cmbSexoExit
        Items.Strings = (
          'Masculino'
          'Feminino')
      end
      object rdgEstadoCivil: TRadioGroup
        Left = 8
        Top = 64
        Width = 169
        Height = 57
        Caption = ' Estado Civil (RadioGroup) '
        ItemIndex = 0
        Items.Strings = (
          'Solteiro'
          'Casado')
        TabOrder = 2
        OnClick = rdgEstadoCivilClick
      end
      object grbGroupBox: TGroupBox
        Left = 180
        Top = 8
        Width = 226
        Height = 113
        Caption = ' Caixa de grupos (GroupBox)'
        TabOrder = 3
        TabStop = True
        object pnlPainel: TPanel
          Left = 2
          Top = 15
          Width = 222
          Height = 96
          Align = alClient
          Caption = 'Painel (Panel)'
          TabOrder = 0
          object lblInfoPainel: TLabel
            Left = 1
            Top = 1
            Width = 220
            Height = 26
            Align = alTop
            Alignment = taCenter
            Caption = 'Dentro de um painel pode ser incluso qualquer componente visual'
            WordWrap = True
          end
        end
      end
      object grbEditBotoes: TGroupBox
        Left = 8
        Top = 123
        Width = 398
        Height = 51
        Caption = ' Campos (TEdit) e Bot'#245'es (TButton) '
        TabOrder = 4
        object edtCampo: TEdit
          Left = 7
          Top = 16
          Width = 223
          Height = 21
          TabOrder = 0
          Text = 'Digite a informa'#231#227'o desejada'
        end
        object btnLerEdit: TButton
          Left = 235
          Top = 14
          Width = 75
          Height = 25
          Caption = 'Ler'
          TabOrder = 1
          OnClick = btnLerEditClick
        end
        object btnPreencherEdit: TButton
          Left = 316
          Top = 15
          Width = 75
          Height = 25
          Caption = 'Preencher'
          TabOrder = 2
          OnClick = btnPreencherEditClick
        end
      end
      object memObservacao: TMemo
        Left = 8
        Top = 181
        Width = 315
        Height = 70
        Lines.Strings = (
          'Informe o texto desejado')
        TabOrder = 5
      end
      object btnLerMemo: TButton
        Left = 327
        Top = 187
        Width = 75
        Height = 25
        Caption = 'Ler'
        TabOrder = 6
        OnClick = btnLerMemoClick
      end
      object btnPreencherMemo: TButton
        Left = 327
        Top = 220
        Width = 75
        Height = 25
        Caption = 'Preencher'
        TabOrder = 7
        OnClick = btnPreencherMemoClick
      end
    end
  end
  object pnlDireita: TPanel
    Left = 423
    Top = 0
    Width = 445
    Height = 366
    Align = alRight
    TabOrder = 1
    object grbAdditional: TGroupBox
      Left = 8
      Top = 1
      Width = 268
      Height = 177
      Caption = ' Additional '
      TabOrder = 0
      object btnSpeedButton: TSpeedButton
        Left = 242
        Top = 17
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          94713B94713B94713B96713B96713B96713B96713B96713B96713B94713B9471
          3B5D3E242F5B912F5B91FFFFFFFFFFFF94713BFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC2D1F62F5B91C1FFFF005FDEFFFFFFFFFFFF
          A38453FAEEEEB98361B88160BC8767C5916FC89674BE8B6BCC8F64714B4B2F5B
          91B6FFFF005FDEFFFFFFFFFFFFFFFFFFA38453FFFFFFF8F8F5FFFFFFECF1F798
          7771987771925B4CD9E4EB2F5B91AEFBFF005FDE543B21FFFFFFFFFFFFFFFFFF
          A38453F3E3DEC8906E8F513A724535DCD09FF6F5C5FFFFFD925B4C597097005F
          DEB8C0C6754605FFFFFFFFFFFFFFFFFFAD9060FFFFFFF3F9F9987771F8D69EFB
          EBC0FFFAD9FFFFFDFFFFFFA9614BD2DFEBFFFBE7754605FFFFFFFFFFFFFFFFFF
          AD9060F9E9E18D5B4AC48962F2C69AECD2B0FEF8DAFAF5DEFFFFFFDBD0CEBF88
          75F8F9F2784706FFFFFFFFFFFFFFFFFFAC9167FFFFFFC3B6B8C4835AF6D8ACF0
          DABEF8EAD0FEF8DEFFFDE3E9E4D1BEB0B1FAF6EE784A08FFFFFFFFFFFFFFFFFF
          B19F7CFCEDE7A77D6CBA7455FCDEABFFFFFFF1DEBFF2E0BBFFFDD3CCBC98AC87
          7DEDE5D77A4C0BFFFFFFFFFFFFFFFFFFBAA180FFFFFFFFFFFFA57668D68952FB
          E0A9F2DAAEF6D9A1F6D9A18E6A62DCD1CDD9CDB57D5010FFFFFFFFFFFFFFFFFF
          C6B191F5E8E3C28A69B98E7BB0897FB8714FCC8C63D09D77A0786C874B2DAD7A
          51C0AC88815518FFFFFFFFFFFFFFFFFFC4B192FFFFFFFCFFFFFFFFFFF8FBFACF
          C6C2C6B5B6B3A19ACCBA9EF9F8F0E5E1D0B3976D865A1DFFFFFFFFFFFFFFFFFF
          C8B89AF2E6DFBD8563BE8664BC8563BB8563BF84639C623DCDBA99E5E1D0CCB6
          9B9C7741FFFFFFFFFFFFFFFFFFFFFFFFC8B89AFFFFFFFFFFFFFFFFFFFCFCFAED
          EDEAEBE5D9D3C0A1B9A883D4C5AF946D31FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          C8BA9DFFFFFFFFFFFFF8F6F5F0E5DEDED5C4D5C2AABEA57E9A7B449D7741FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8B89ACCB89CC6B497C3AF90C2AE90BF
          A780BBA077A890608D652DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = btnSpeedButtonClick
      end
      object imgLogo: TImage
        Left = 132
        Top = 43
        Width = 132
        Height = 115
        Center = True
        Picture.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000008000
          0000800806000000C33E61CB0000000473424954080808087C08648800000009
          7048597300000EC400000EC401952B0E1B0000151A4944415478DAED9D0BBCA6
          431DC7FF645D8AC2BAABF62062B19B12D6252721B784CD258A2D44B2259284DA
          42683F452B21973DE5924B4AB172EB6323CAAD9558D4CA0A956B11B9B69AEFCE
          33CE9C67DFCBCC3C33CF33EFE1F7F9FC3FE77DDFF33CF35CE63F33FFFBCC27C3
          136F52B48AA29514F5291AA56869454B291AA96811450B16349FA21715BDA4E8
          79454F2A7A42D1E38AFEA6E88182FEAAE895A61F2C36E66BFA0622607E456B2B
          DA48D17AC5E7D18A168E7C9D1714DDA3E84E45B728BAA9F83CA7E9175005BDCA
          008CECAD0ADA54D1DB1ABA8F6714FD46D1AF145D297AA6E829F4120330A5EFA2
          6857456332BD7766840B155DA46856D337E3821C5FA28D372BDA59D1BE8A36EC
          81FB357855F41271A66866F86FD337D40EB9BED0772AFABCA2BD152DDEF4CD54
          C4D38ACE52F43DD1426556C88D01D6507494A28F291AD1F4CD44C6CB8A7EAAE8
          68D1C26416C8850158DFBFAE6877D12ADC70C6FF14FD44D137240339A1690678
          ABE8113F51D1424DBF8C9A81DD618AE819E199A66EA24906D853D1B7152DDBE0
          3DE480C7141DAAE8C74D5CBC090640873F5DD1164D3C70C6B846D1FEA22D8EB5
          A16E06D847D1898A16ADF9BABD82E7141DACE887755DB02E065852B44EBC635D
          0FD6E3B854F4607932F585EA6080F72ABA44B453E60DB8E34145E315DD9EF222
          A919602F45A78AF6BEBD017FE09DFCACA21FA5BA402A06A0DD63141D9EF01AAF
          1760563E4ED191C5E7A848D139F8D807147D3CE96B09C7658A4E12EDC635F46A
          E97BB7DFCDFF906DAE53F496A26D8C3C5831972AFE6E26F12C9A188F2688B61F
          44436C0660AAFF9968376DAEC0A37871A4B6CE56F429EB3B23F5ABD6F725147D
          5434336C2ED58D5DB89C7712BD3444414C06584CF4E8DA34629BB1C1E8213228
          86E5ED038AA6CBE03B44581B27DAE6DF0AC42C7C44B460F76109978BAE57B49D
          A2FFC47821B1188087212822A7CEBF437458976D70BA56E218A04614ED8F2EBE
          E3EE7D9FA27B1DCFC70EB2ADE899616B195C425C011330CB569E096230006BFE
          2F248F699F517181A23314DD2ADAA0B2AFF5FF8344BB65AB02E1F65BD6F70344
          6B3B2120E601268019608AC51CCFBB4AD1F6525126A8CA009C7F9E342FF0D1D9
          743A82D2B3D6EF378B8E13347897A2FB2B5E0B53F65DA23B0E5C2E7A6A8F01E2
          18591EC6176D768B8520FA88771FAC1D5465806365A8D0532708B4385F74C7CF
          68F17FDCCAACF5A6A3F0C18F766BBA23A629DAA6F8FCA8E8F0B4C7123C1F332B
          822321709F94F67D75BCE819290855180023CFD48A6DF8024EFFBDE84E87FB3B
          855A115C32D3FA3E59D1972B5E9F69DA6810DC0B53F0E5099F1777394BDAD65D
          DE09915353432E10DA7998777F2BF559F8FEA5E85CD11DFF27C7737613BD2418
          20A05E5FE11E589B9945562CBE9F26DA4A970A04C9FC52DC662D42D63751749B
          EF45421800E3072A4F5FC28737B85BD109A243A97C255E74F2AF149F9F52B48C
          68434D28301E7DA1F87C9FE841902AD8B3BF78E6911EE7E03B4013F172208530
          00869EBABC7ADF51F4A5C073AF90C1A91341F51315EE631DD1C9200B8896BA89
          504EE5A4D94F74A4D08201E7A28DEDE073822F03A052D5E6AB161D25B357E0B9
          8F285AA1F88CA47C41603B641EFD4E06B50984DEE3123C2B422BB112132BB603
          0339F7910F03AC2C3AF1C1D76851058CE26D03CEC3DA6724732C734CFFFF0EBC
          0774FC538ACF37889E9E63A783A1EE21D46E19A12D824AD04C9C228B7C188090
          A5CD233F782BF072E72F3EA3DFAF17D006D6BEAB8BCFD3157D30F05E96132DF8
          D141A89D6345AFB531B1AA6813FABB23B6E96CF17465800912A8667802E70A0E
          933D8AEFE4DAAD1CD00E72C3E4E2F3218ABE1B783FD8198C910B5DFCDCC8CFFB
          21D199434B466E17E0A41AE876900B03E0C4F88BE8693525986659FF3EA7E8E4
          E237AC7AAEA6511BE7C8A0D0C7C8FA73401B8CA0AB8A7784FC10DBDAC9D28266
          912A01063F08B3CBD39D0E72610024F18313DDA47D0D23ED33E5DF6CFD0F5BC3
          0B9EED21AB90264EC7874CAD0B176DF0021F12BDA686CA1065A049E08F382052
          7B9DC0CC7748A703BA31002F00BB77884AE20A22878EB2BEB3043C635D933CC1
          873CDAE37C9C42235C5E401B90B5F335D1F208D3F4F448CF4A7CC0C5459B7500
          95752DD133784B746300D6BC3D240D30611E21AD552A84BF758BCF1837FEE0D1
          2E061AA3A31391739DE77DAD267AF4C34831CCC706CC44087BAB466ACF15C831
          6DFBB013038C2E5E448A5C3D3A9F65E5A436FF471E305324DEB1AB5D1A2D80F0
          8330C9948DDCE25BD6E5D7A2190707D3061227040BF50E35AF894C67AC9F682F
          77B7FA672706B025E098605A45D03BADC331136450EB40983BCFA37D63B20D11
          DC1829CC7A989D9981667A9EDF0AA4B923E32C10A1AD50C07CBBB5FA473B06A0
          A8D2AC04370D37E2B9EA16E6CCEC6338D637888329BF5FFC1987D149440FB98A
          6823DFAFF8AC238A363E13E1BD5505B3204BCFECF23FDA310026C98322DF0416
          3974E90B1D8EC510C4148E0A48CCC1911ED779AA386FD9E2B32B989130A312DA
          B68DC779AD801307674E7F84F7160BCC8C5F2CFFD88A0130F5FE5DB42F3A1628
          C3C61474A9C73966249348BABFE339680C58EA30D97EC0E35AACF5378AF6A4A1
          F2FDB3C2B3327BE1C65D25C27B8B09342B7C23CFD93FB66200A6E833235E1881
          8F28D62B3CCFC30D8C048EF771BCE3390468E0113B4C74EAB90B58E6F0A3D3F1
          3B16E78702EF2331084D552DEB06F20DCFB27F68C50044DCAC1FF9C244D25C12
          700E3A33411CAED1C6D813BE297A14BA9661C1D9445815D27F95650FAD06A6CB
          B9C20906B60DEC1FCA0C80AE7A8FC40FF3228A0755C42778114174B6F8C5F2B1
          EEBE4774F0675DC0604544F0A76BBC662878FF84CADD677E2877B41941294070
          E3459EE7B01633A25CFD1058BC90FC27257A863248016389DAA4A6EBC50016CE
          A3CD9732033052D74A7461746AECF33EBE742C67ACAB0B3A9EC70C769FC37131
          C07B42D85BA9A6EBC502A6FDB5CD179B01905A5357ADC2D072BEC7F1702B7679
          023A1EAF78EDE545078954890BB481A18A68A55ECC7E7E2D3FC2BE79AC73558D
          1FDDC0E85C53DC3B816C23F4721FA1AEFCA014A3224113AE27B9924EABCA4C06
          3875305BC70CE6A803AF19BA6C0620BE3D24FCAA1370E36297B75D9F74806B45
          2C0C2A7456BFB88774F34C3B14D7C4A68F51890819649B1B223F1F20F10453EF
          7ED23BB3C16BA176E68611B488BD0F09BEE88401D181A404551AEF1ECB0C92A8
          AB9386E38D3DA01B18E993446B0200B587AC195F8F6008B05560E2AE33663214
          04DAE09A7EC53080ED428D05540E3A1D57EEEA45FB264D0B63D3D98EED605899
          2EDA22D80ED82D88227A7FF19D59839C80A992A0AA4607E0BAC690B4A2F51BCB
          1DCB572AE13A14F4CDED86015813A644BE00A6D58DADEFF63588F563DD7CD9A1
          1D0C2CF8E65BC50D102D84F1850C1D66313A1BC662C6F0F103C404318CD315BD
          43F4ECC5928710FBF386EEA71DF0984E310C9022F0A31C8BCFB510C24CE8B36B
          FC3A011A74E613A5DFC714EDAF517CC78E8FA9D3C7DF900A30014C3949B4ED1D
          66C8AD52F8DC6419C3007F14FD42630167529FCC3BC2991A093259B27821B828
          43022E2893C27A6B0A4E62C6DDB3B86EAE20937899A66FC202FD301606C06F8D
          501033EE6F88B5A9043B6913D5F3079E6DB394E0DA44BA7FB5F84CADDD58FA7D
          2AD8A96A398081B7280C60075FC400AE5FECF88F7638C6441B3D2C5A577FD1B1
          6DBC7CC802DC379641A26D4E713CB76930207CE21AEAC09ABC48F4C19839EEC4
          E4EFD9E5185410A6A0B78BEEC493BB352A5A73203D9C7B66B4E37C69A4C27620
          B04DE426086EC7CB3C50DC3AC015C4F5DFEA701C6966245E305360867EBECBB1
          4CA12C57AF16F7ECBB74348D1C05C18930006AD4A1911A2496609CC7F1C4FA31
          03A0EA9DD8E618042784D4E58AEF5552C69B466E82E064180063C984480D324A
          89AA7195ECD1E33110A115A03AB52AB8609BA8D9A38FD9A05777F0CC4D101C80
          017069C6AA7205B0B7A3A63DE1783CD6334CC524894C2EFDCF8478019803874E
          AD1B2A44466E82E0653000B57E368ADC309D441CA0AB078F97829067FBD6514B
          D14E4C740FC12AC734F6AAE2203741F04618005BFD3A111B659D23249BB06EA2
          805CB27A30E322D59F61FD860975A0F88C25B04F2295476D10B9098233600046
          598CFA7900099DC00B3A926585B51A9B7388C44E29D6B1C5E77211E65E464E82
          E04C188038BA5841948CFA258ACF48F6741C53F994E2BBABB50E2792EDBB6786
          BAA3E9B71509390982B36233006DAD667DC72680C386B59DC81ECCC02E95BAB1
          4B1C587CBE3FE2FDE5809C04C159B19700A4F90D4BBF91734732029A0101892C
          0DB3BBB4C3FF47159F39779FA6DF5444E42408CE8C2D0412C5BB7D9BFFE1C441
          CDA36409B6829BDA1CD7273A5EC08099A057ECFD2E30E96B3960466C3590608C
          BD3BFC9FC8239243F10130AA5B65EFDAF5780115BEA637FDA622231741F0C6D8
          8620CCCA87753986A453B4849D45EBF56C1A6D876D995070038C3F7735FDA622
          03792887FD152E8B6D0A26146BB2E3B164FC52C3077F805DEEBCBCC903B3C523
          8DBEA6F880F18F68FA26A43005C7740661CCF1A927889E4F6CBD5DC78FFC3E3B
          1BD8B74854EE2090C504B5348DC9B1DDC12C2555630BCA0C4044715DE95E2980
          1644462E5E52342454E398B517AA6062EC8010CAA1505BA04A283609A43B5BDF
          11506F0A6CAB6EF03E6158D3D9E38AEFF357693421B64B11124628344C30209D
          C3C2DA817841BBA011D145E734F482BA81441A46B4E96C46FA12955AAC176BA6
          0A0A054404A361C00C38845CB3829107EC5A36ECCE9583C00488621E6711C91E
          391784E8046236163361E1A6B46A0C50690B87905D2605C307163DEC04DD24FA
          72922A695D9B35F082C86222D3C8EEF0D4F592EB04A500C6A4480C418DA31399
          0E4902A1D023411F8C14BC83E8C0D801708AB4720E6D2D43EB09915841C450D4
          3D735BA04F8676361A4AAA42CE39604862087179313654048C70FCDEB6204807
          12CA0533C01446B73FBBA0D9D6B1C412FC438666DAC21457467E0166DD367F97
          8FDC7EEE18921A163B3974DD2EED512360CB8270FDC210765973228956B7BE33
          63C42EB858E7DE473982E5EDB654E9E1987227391E4B697604447B8A37451B0D
          8833A0C65DB45DB3450BBD14A1244E2157352D15E6490F07310B4430FAD7AD70
          3E953AA7957E73DA0123000898A89E393867EAC23C052240CC1231ACFFC801A1
          367C842FE4007BDF3C93631F7BC32640C00A0320565C44EE68592226769128AF
          EDCB5A8038C2F2CE9C21A5E65CC10C80CAF97A60829645A240CC32715577D5E6
          3EEE2CDD23DF29FF92AAEA07D94730C1EA551BCA186DCBC48198852249E4585A
          AA6DAF4A71A7F2F62AB88A63D6322E8399000D2176AE442EE858283276A9580C
          3D8CD639D6DF392D7EE32F8C42DCA09D58DA2FF31678A2120823D435F3280468
          084434533B783869085D4BC58214C5A2016A2649110F5A647F7F4C5A4FEDF811
          CA9B20BAA4A0C700DAC8800C1F1370D762D12076B9785CB9BCC8A703CF475F25
          8AB65C31DC7747905050D686D0F68DAB3694019CCAC5A7D8308238F8632B9CCF
          944C31885DADDF105871C5FAEE291802F6146049600BBA5E29065986F3861120
          F69631ACF3848B4F0B3C9F7518E3127E02228619912C5575D6000404AA509C6A
          919AAF1B03CE5BC680149B46B104205BB88477E18A6506B2B76EA1343B49A229
          0C413E403B809173DD15A415BC378D0229B68D23560021A49D3C8093080312EB
          3B42E1FAD25976802930E5E2CCC28083F511CF237203FE8D39C5C3C3388F176D
          927442FA3A696CE8C421D9BA3C03E56D7289EDEB06EF6DE340AA8D23311051D3
          D78C64AA80920C42C76F2CF316B0B68F35C0C0843B93A411A3A6D1B9A8B07436
          4B039DD35750A7990C471353FBB59ECF415CFF34C95F4D0CDE3812A4DA3A9630
          2FD6523A9D3A00233B1C6BD704A22399994CD028F50230192320B6DBE4114660
          470F660A84C8155B1C43E76F21FE98243AB12567046F1D0B526D1E6D84375789
          DA641CD945233010610B78B8F88EF6C2AC35AAA091C57D43CC62D422244E918E
          2EE742723F442DCDF07C0EDA45381DEB795E5DA8BC7934A863FB7817102C4AD9
          19D2CF99B6614EAC8144F33043103554453A9F1B2215701E1145D432C87129A8
          BC7D3C40DA858372B28691C9C4B44FD6F078C7E7E8066607BC6421426139943D
          0720F49AC1D216AE2F6E82F8A57CA504523D5C8D71293653761D316D800F85A5
          B2C90DA2CB700AA0F11939D7880EEC1CCEC05A462E6288D91AA1B60EFF840B9C
          855A1F06A090236A612F6C8952053EDBCEDA6815BFD00430F552FADFA99EA2EF
          CDE28BAF12E5D30B208C8D103197DD4CCAC8A1009457245608B7BE1EC2A92788
          9ED27D514E6AA91B5455DDC1E7841006C0D48AEEDBD7E083A6C6DCB4A980F350
          05997A47059C5B15C45460CB78D2E7A4D0F50ADB3BB5857AD12BE68AD06C24B4
          93A303CEAB025CE2583B6FF33DB18AC082556E6AC5367206FB1085683DF8DC19
          8D75A984583109E20952D3AB761E411EC3A5846B19A1E661906217D676385E86
          D658F2425506E07C4CA8B1DDC6B9A0A323A50338E7DC1AEE0F372FEF3E383026
          C6F48DB305E93387B267B1116A1E6E95D4121BC423E02A77DD70AB2562ADDF08
          83A83FFD891FBA09101EE7E30C238F8148E694CE21764E4148AD9C2C1B538063
          13474AC5F6277CF02640CC0191462EE661D2DC09BD5E21E1FD4C171D10F36C8C
          C6624BF0CC04188A86DB72C046D42774390613396EE1989B6F94815A4AF24CB4
          34F9142A1C32C1800C2FC110F330BE9076656A8841A42056CADC015CCE132472
          A99C543A3CED520EF5F084D7A81B13A4B57918AF1B154C5259FF90F0C9493852
          1284C1A7EE1C8C45A7CAF0B0180EC9AA151D06861D24A5BECF548F3611E29770
          421DA313B3F125323C7C0738C1B0F0E11565E4A77C7F581389768A59BB691ED4
          353DE340629ADCA9A6EBA50253701DEFEC52D1797C5E8E9D10D4BD3E63B32645
          69D19AAFDB2B40B5237D2B65FD8321684240EB5374BAE812716F6010188FD843
          E181AA0DF9A049099DF83942AF966DF01E7200194D26CAB97634ADA291B54359
          1AAA562DD4F0BDD40DF479F653445D0EAD9D50194D33800115CA48B1DA5D7AB7
          FAB62BC8D5C3CB482DA69855D982900B031850FB0783C72E32FC0A35E359A4C4
          1D23FEDEA66FC620370630C0F942F62F5AC3E24DDF4C4530BD53968562DC396D
          1C3D17B93280018522C804C6F0B2610FDCAF01F6026A23A1CE31EAAB94CA4B8A
          5E79A1003981A58114EF3199DE3B892144E9D0E98DAFEF2EC8F125BA80C48DAD
          0AEA97E62A75904A4670069B60E0AAAD55878F815E65001B44DEE0A4A176CF7A
          C567EA042C1CF93A845E538184517E8BE8299ECF4DD72CAA84E1C000AD802AC9
          92C14CD127DA554B26313585281C817712BB83297CF15241ACD5D8DFA93B407A
          3542DB03325857E895A61F2C36FE0FFA1B1AC46D547F610000000049454E44AE
          426082}
        Stretch = True
        OnClick = imgLogoClick
      end
      object lblAlterarImagem: TLabel
        Left = 127
        Top = 160
        Width = 137
        Height = 13
        Caption = 'Clique na imagem p/ altera-la'
      end
      object btnComIcone: TBitBtn
        Left = 5
        Top = 16
        Width = 121
        Height = 25
        Caption = 'Bot'#227'o c/ Icone'
        TabOrder = 0
        OnClick = btnComIconeClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          906D37A8895AB68C56AC8956B59756AC8C57B48665AB8659A5895AA78F68A68A
          619C7A4B977445FFFFFFFFFFFFFFFFFFAB8D61FEFFFFFEFFFFFEFFFFFEFFFFFE
          FFFFFEFFFFEFF2E8EBE4DEEBE4DEEBE4DEEBE4DEA48559FFFFFFFFFFFFFFFFFF
          B3956AF5FCFF0097EEFFF7F00C00EECFD6E409E604EFF2E8F8D5C2DA9A42E19F
          41EBE8E0A58451FFFFFFFFFFFFFFFFFFBA9E75F4FBFF009CF0FFF7F05F59FFCF
          D6E402DF11EFF2E8FCDCC6EBE4DEEBE4DEEBE4DEA58451FFFFFFFFFFFFFFFFFF
          BEA37AF4FBFF009AF0FFF7F0FFFFEFEEF5E300D911EFF2E8FFDCCBDE9E41E19F
          41EAE6DFA58451FFFFFFFFFFFFFFFFFFBDA279F4FBFF079FF0FFF7F0FFF7F0EA
          F1E300DC11EFF2E8FFDECEEBE4DEEBE4DEEAE6DEA58450FFFFFFFFFFFFFFFFFF
          BAA279FEFFFFEBF0F0F1F0EDF7F2EEEAF0E300DB0EEFF2E8FFE2CFE19F41E19F
          41EBE7E1A58452FFFFFFFFFFFFFFFFFFB9A27FFFFFFFFBF6EFF6F2EDF9F3F1EF
          F2E808E11CEFF2E8FFE2D3DD9C41E19F41EBE4DEA68553FFFFFFFFFFFFFFFFFF
          BBAA8BFFFFFEFEFFFFFBFFFFFCFFFFFCFFFFF2FFFFF9FFFFF9FFFFEBE8E0EBE8
          E0EBE8E0A68552FFFFFFFFFFFFFFFFFFC5B297FDFAF5E6AC54E3A546E2A54AE3
          A54BE6A54DDEA148D9A04CD3994CD3994CD3C8B3A58552FFFFFFFFFFFFFFFFFF
          CBBA9EFCF9F4FCFFFFFCFFFFFCFFFFF9FDFBF5F6F7E4E0D9D0C2ADBFAB8BBFAB
          8BB69B71A48451FFFFFFFFFFFFFFFFFFCDBDA2FDFCFCFCFFFFFCFFFFFCFFFFF9
          FDFBF5F6F7E4E0D9D0C2ADEAE6E4DFD6C7B69B71A98857FFFFFFFFFFFFFFFFFF
          CEBDA5FDFCFBFBFDFEFCFCFCF6F6F1EEE8E1EDE2D9D3C1AACFBDA0FFFFFFCDB9
          9DB9A078F2EDE5FFFFFFFFFFFFFFFFFFCFC0A7FDFCFCFCFEFFFBF7F3F3EBE5E6
          DFD6E2D4C4CDB798BEAC8AD1C1A9B59A6EF9F7F3FFFFFFFFFFFFFFFFFFFFFFFF
          D0C3ABFDFCFBFEFEFEF6F2EFEDE4DADED5C4D6C4ADC0A984A38652B9A078FCFA
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCABA9ED1C1A9D0C0A7CCBBA1CAB99DC7
          B191C3AB85AC9264AF9266F9F6F3FFFFFFFFFFFFFFFFFFFFFFFF}
      end
      object mskMascara: TMaskEdit
        Left = 133
        Top = 18
        Width = 100
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        OnChange = mskMascaraChange
      end
      object clbOpcoes: TCheckListBox
        Left = 5
        Top = 43
        Width = 121
        Height = 130
        OnClickCheck = clbOpcoesClickCheck
        ItemHeight = 13
        Items.Strings = (
          'Op'#231#227'o 1'
          'Op'#231#227'o 2'
          'Op'#231#227'o 3'
          'Op'#231#227'o 4'
          'Op'#231#227'o 5'
          'Op'#231#227'o 6'
          'Op'#231#227'o 7'
          'Op'#231#227'o 8'
          'Op'#231#227'o 9')
        TabOrder = 2
      end
    end
    object grbDataAccess: TGroupBox
      Left = 277
      Top = 3
      Width = 154
      Height = 63
      Caption = ' Data Access '
      TabOrder = 1
      object lblCompNaoVisual: TLabel
        Left = 17
        Top = 48
        Width = 121
        Height = 13
        Caption = 'Componentes n'#227'o visuais'
      end
    end
    object grbSamples: TGroupBox
      Left = 279
      Top = 112
      Width = 153
      Height = 66
      Caption = ' Samples '
      TabOrder = 2
      object gagBarraProgresso: TGauge
        Left = 4
        Top = 15
        Width = 145
        Height = 18
        ForeColor = clNavy
        Progress = 50
      end
      object btnProcessar: TButton
        Left = 40
        Top = 36
        Width = 75
        Height = 25
        Caption = 'Processar...'
        TabOrder = 0
        OnClick = btnProcessarClick
      end
    end
    object grbWin32: TGroupBox
      Left = 8
      Top = 183
      Width = 425
      Height = 203
      Caption = ' Win32 '
      TabOrder = 3
      object tabAbas: TTabControl
        Left = 8
        Top = 20
        Width = 191
        Height = 87
        TabOrder = 0
        Tabs.Strings = (
          'Aba A (TabControl)'
          'Aba B (TabControl)')
        TabIndex = 0
        object lblInfoAbaA: TLabel
          Left = 32
          Top = 48
          Width = 114
          Height = 13
          Caption = 'Informa'#231#245'es da aba "A"'
        end
      end
      object pgcPaginas: TPageControl
        Left = 202
        Top = 16
        Width = 218
        Height = 90
        ActivePage = tabAba1PageControl
        TabOrder = 1
        object tabAba1PageControl: TTabSheet
          Caption = 'Aba 1 (PageControl)'
          object lblInfoAba1: TLabel
            Left = 34
            Top = 24
            Width = 147
            Height = 16
            Caption = 'Informa'#231#245'es da aba "1"'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsItalic]
            ParentFont = False
          end
        end
        object tabAba2PageControl: TTabSheet
          Caption = 'Aba 2 (PageControl)'
          ImageIndex = 1
          object Label1: TLabel
            Left = 40
            Top = 24
            Width = 136
            Height = 13
            Caption = 'Informa'#231#245'es da aba "2"'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object stbBarraStatus: TStatusBar
        Left = 2
        Top = 182
        Width = 421
        Height = 19
        Panels = <
          item
            Text = 
              'Barra de status para definir uma descri'#231#227'o sobre o status do for' +
              'mular'#237'o.'
            Width = 50
          end>
      end
      object prgBarraProgresso: TProgressBar
        Left = 8
        Top = 120
        Width = 409
        Height = 17
        Position = 50
        TabOrder = 3
      end
      object btnProcessar10: TButton
        Left = 168
        Top = 139
        Width = 75
        Height = 25
        Caption = 'Processar +10'
        TabOrder = 4
        OnClick = btnProcessar10Click
      end
    end
    object grbDialogs: TGroupBox
      Left = 279
      Top = 66
      Width = 153
      Height = 47
      Caption = ' Dialogs '
      TabOrder = 4
      object lblOpenDialog: TLabel
        Left = 3
        Top = 13
        Width = 107
        Height = 26
        Caption = '<--- Respons'#225'vel por '#13#10'"Carregar" imagem --->'
      end
    end
  end
  object pnlInferior: TPanel
    Left = 0
    Top = 366
    Width = 868
    Height = 252
    Align = alBottom
    TabOrder = 2
    object grbDataControls: TGroupBox
      Left = 1
      Top = 55
      Width = 866
      Height = 196
      Align = alClient
      Caption = 
        ' Data Controls (Utilizando os componentes n'#227'o-visuais da aba Dat' +
        'a Access) '
      TabOrder = 0
      object dbgGrid: TDBGrid
        Left = 2
        Top = 15
        Width = 862
        Height = 179
        Align = alClient
        DataSource = dtsDataSource
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object grbAddDadosGrid: TGroupBox
      Left = 1
      Top = 1
      Width = 866
      Height = 54
      Align = alTop
      Caption = ' Adicionar informa'#231#245'es no GRID (DBGrid) '
      TabOrder = 1
      object lblTexto: TLabel
        Left = 8
        Top = 24
        Width = 27
        Height = 13
        Caption = 'Texto'
      end
      object lblValorReal: TLabel
        Left = 276
        Top = 25
        Width = 47
        Height = 13
        Caption = 'Valor (R$)'
      end
      object lblValorPercentual: TLabel
        Left = 396
        Top = 25
        Width = 41
        Height = 13
        Caption = 'Valor (%)'
      end
      object lblValorInteiro: TLabel
        Left = 505
        Top = 25
        Width = 56
        Height = 13
        Caption = 'Valor Inteiro'
      end
      object lblData: TLabel
        Left = 690
        Top = 25
        Width = 23
        Height = 13
        Caption = 'Data'
      end
      object edtTexto: TEdit
        Left = 41
        Top = 20
        Width = 232
        Height = 21
        TabOrder = 0
        Text = 'Informe um texto'
      end
      object edtValorInteiro: TEdit
        Left = 568
        Top = 18
        Width = 60
        Height = 21
        TabOrder = 1
        OnKeyPress = edtValorInteiroKeyPress
      end
      object edtData: TMaskEdit
        Left = 715
        Top = 18
        Width = 64
        Height = 21
        EditMask = '!00/00/0000;1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
      end
      object rdgBoolean: TRadioGroup
        Left = 632
        Top = 7
        Width = 55
        Height = 45
        Caption = ' Boolean '
        Items.Strings = (
          'False'
          'True')
        TabOrder = 5
      end
      object btnAdicionar: TBitBtn
        Left = 784
        Top = 16
        Width = 26
        Height = 25
        TabOrder = 2
        OnClick = btnAdicionarClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFBAE3C170CE8426B7461DB9401DB94026B74670CE84BAE3C1FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FDFA4EB86119C1401FCE4C24DC5827
          DD5C27DD5C24DC581FCE4C19C1404EB861F9FDFAFFFFFFFFFFFFFFFFFFFAFDFB
          21A93A1ED04E22D55521D35503B82C00A71200A71203B82C21D35522D5551ED0
          4E21A93AFAFDFBFFFFFFFFFFFF4DB15A1ECE4D21D3541FCC4D0FCC4500AD13FF
          FFFFFFFFFF00AD130FCC451FCC4D21D3541ECE4D4DB15AFFFFFFBCDEBE17BA3F
          21DA5A1ECC5120D0530DC74200BE25FFFFFFFFFFFF00BE250DC74220D0531ECC
          5121DA5A17BA3FBCDEBE6ABB7317D15120D45F0BCC4A04CA4300C13300BC22FF
          FFFFFFFFFF00BD2700C23B10CA4B0ECC4C20D45F17D1516ABB7330A03E33E67A
          00B62D00AD1300AD1300AD1300AD13FFFFFFFFFFFF00AD1300BD2700BD2300AD
          1300B62D33E67A30A14030A34281FCC300AF21FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00AF2181FCC430A04122943685FDCC
          2AC262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF2AC26285FDCC22943532923C7BFAC33CD07D71C7801EBF5921C05B0ABA4DFF
          FFFFFFFFFF10BC5122C05C1EBF5971C7803CD07D7BFAC332923C67AA668AE5B9
          65EAB050DF9756DF9C41DB8D22C05CFFFFFFFFFFFF22C05C49DC9356DF9C50DF
          9765EAB08AE5B967AA66B9D3B94EB068AFFFEA5EE0A156E19F45DE9766D589FF
          FFFFFFFFFF23C05B50E09E56E19F5EE0A1AFFFEA4EB068B9D3B9FFFFFF458845
          7BDCA8B6FFEF76E5B551DFA366D589FFFFFFFFFFFF24BF5956E2A876E5B5B6FF
          EF7BDCA8458845FFFFFFFFFFFFFAFCFA1572156DD6A3B7FFF5AAF7E370E0B022
          C05C22C05C74E2B3ABF7E4B7FFF56DD6A3157215FAFCFAFFFFFFFFFFFFFFFFFF
          F9FBF945854538A75E7FE1B8A9FFECB9FFFBB9FFFBA9FFEC7FE1B838A75E4585
          45F9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7CDB767A567247C3228
          8637288637247C3267A567B7CDB7FFFFFFFFFFFFFFFFFFFFFFFF}
      end
      object btnLimpar: TBitBtn
        Left = 816
        Top = 16
        Width = 26
        Height = 25
        TabOrder = 4
        OnClick = btnLimparClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFB3B3DF6361C91C19BA140EC1140EC11C19BA6361C9B3B3DFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3FB4A48BE0F0BD8140FF71711FF17
          11FF1711FF1711FF140FF70F0BD84A48BEF3F3FBFFFFFFFFFFFFFFFFFFF5F5FC
          2623BF1513F61917FF1715F91715F41715F41715F41715F41715F91917FF1513
          F62623BFF5F5FCFFFFFFFFFFFF4C4ACC191BF61B1EFC191CF5191CF5191CF619
          1CF6191CF6191CF6191CF5191CF51B1EFC191BF64C4ACCFFFFFFB8B6EC1416E4
          1D27FF1A22F91B22F91B22F91B22F91B22F91B22F91B22F91B22F91B23F91A21
          F91D27FF1416E4B8B6EC6663DF1D2AFE1B2BFD1B2AFF1B2AFF1B2AFF1D2CFF1D
          2CFF1D2CFF1D2CFF1E2CFF1E2CFF1E2CFF1F2DFF1E29FE6866DF3334E8182CEB
          322E11272410242111221F0F1F1E0C1E1B0B1B1A091B18081A18071816071817
          041613002134ED2627E55559F33049E64A46393D3B373B3939373533322F2E2D
          2B2B292727262425242222212021201E1E1E1908273FEC171AE75555F56983F4
          766F6543413E383635383635353331312E2D2B29282724231F1F1F1E1C1D1817
          171C1608233CEB1F22E25E5BF7667DF49C99888E897E7C776C6561575A554A51
          4C404F4A414B463D48433A454138413E314340305168EB5E5BEA8D84F57186FF
          6283FF6684FF6987FF6A89FF6685FF5876FF5270FF5271FF5472FF5E7DFF6A87
          FF6B8EFF7387F48A83ECC8C4FA6260FA81A2FF617EFE6783FE6984FF6986FF6C
          89FF6E8AFF6E8AFF6E8AFF6B87FF627FFF84A3FF5858DBC8C4FAFFFFFF746CF6
          8089FD89A8FF6685FD6A88FD6E8AFD6E8AFD6E8AFD6D8AFD6A87FC6685FE8CAA
          FF747CE27069ECFFFFFFFFFFFFF8F7FF554AF68289FBA0BEFF83A2FF6F91FE70
          90FD7090FD7091FF84A2FFA1C0FF7986E84F46E3F8F7FFFFFFFFFFFFFFFFFFFF
          F6F6FF746DF76562F696A5F9A4BBFDA4BCFFA2BCFFA3BAFC93A4F15F5EE6716A
          EFF6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C3FD877FF8625DF45E
          5AF25E5AF15F5BF0857EF4C6C2FCFFFFFFFFFFFFFFFFFFFFFFFF}
      end
    end
  end
  object dtsDataSource: TDataSource
    DataSet = cdsClientDataSet
    Left = 735
    Top = 23
  end
  object cdsClientDataSet: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 771
    Top = 23
    Data = {
      900000009619E0BD010000001800000006000000000003000000900005546578
      746F01004900000001000557494454480200020032000956616C6F725265616C
      08000400000000000F56616C6F7250657263656E7475616C0800040000000000
      0C56616C6F72496E746569726F040001000000000007426F6F6C65616E020003
      0000000000044461746104000600000000000000}
    object cdsClientDataSetTexto: TStringField
      FieldName = 'Texto'
      Size = 50
    end
    object cdsClientDataSetValorReal: TFloatField
      FieldName = 'ValorReal'
    end
    object cdsClientDataSetValorPercentual: TFloatField
      FieldName = 'ValorPercentual'
    end
    object cdsClientDataSetValorInteiro: TIntegerField
      FieldName = 'ValorInteiro'
    end
    object cdsClientDataSetBoolean: TBooleanField
      FieldName = 'Boolean'
    end
    object cdsClientDataSetData: TDateField
      FieldName = 'Data'
    end
  end
  object dspDataSetProvider: TDataSetProvider
    DataSet = cdsClientDataSet
    Left = 805
    Top = 23
  end
  object opdImagem: TOpenPictureDialog
    Filter = 'All (*.jpg;*.bmp)|*.jpg;*.bmp|Jpeg|*.jpg|Bmp|*.bmp'
    Left = 824
    Top = 79
  end
end
