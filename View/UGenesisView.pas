unit UGenesisView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, UMessageUtil, UPessoa, ExtCtrls, Grids, DBGrids,
  Provider, DB, DBClient, ComCtrls, CheckLst, Mask, Buttons, Gauges,
  pngimage, ExtDlgs;

type
  TfrmGenesis = class(TForm)
    pnlEsquerda: TPanel;
    pnlDireita: TPanel;
    grbMensagens: TGroupBox;
    btnInformacao: TButton;
    btnAlerta: TButton;
    btnPergunta: TButton;
    btnPerguntaFocoNao: TButton;
    btnErro: TButton;
    grbObjeto: TGroupBox;
    btnCriarObjeto: TButton;
    grbStandard: TGroupBox;
    lblSexo: TLabel;
    chkAtivo: TCheckBox;
    cmbSexo: TComboBox;
    rdgEstadoCivil: TRadioGroup;
    grbGroupBox: TGroupBox;
    pnlPainel: TPanel;
    lblInfoPainel: TLabel;
    grbEditBotoes: TGroupBox;
    edtCampo: TEdit;
    btnLerEdit: TButton;
    btnPreencherEdit: TButton;
    memObservacao: TMemo;
    btnLerMemo: TButton;
    btnPreencherMemo: TButton;
    dtsDataSource: TDataSource;
    cdsClientDataSet: TClientDataSet;
    dspDataSetProvider: TDataSetProvider;
    grbAdditional: TGroupBox;
    btnSpeedButton: TSpeedButton;
    imgLogo: TImage;
    btnComIcone: TBitBtn;
    mskMascara: TMaskEdit;
    clbOpcoes: TCheckListBox;
    grbDataAccess: TGroupBox;
    grbSamples: TGroupBox;
    gagBarraProgresso: TGauge;
    grbWin32: TGroupBox;
    tabAbas: TTabControl;
    lblInfoAbaA: TLabel;
    pgcPaginas: TPageControl;
    tabAba1PageControl: TTabSheet;
    lblInfoAba1: TLabel;
    tabAba2PageControl: TTabSheet;
    Label1: TLabel;
    stbBarraStatus: TStatusBar;
    prgBarraProgresso: TProgressBar;
    pnlInferior: TPanel;
    grbDataControls: TGroupBox;
    dbgGrid: TDBGrid;
    grbAddDadosGrid: TGroupBox;
    btnProcessar: TButton;
    lblTexto: TLabel;
    edtTexto: TEdit;
    lblValorReal: TLabel;
    cdsClientDataSetTexto: TStringField;
    cdsClientDataSetValorReal: TFloatField;
    cdsClientDataSetValorPercentual: TFloatField;
    cdsClientDataSetValorInteiro: TIntegerField;
    cdsClientDataSetBoolean: TBooleanField;
    cdsClientDataSetData: TDateField;
    lblValorPercentual: TLabel;
    edtValorInteiro: TEdit;
    lblValorInteiro: TLabel;
    edtData: TMaskEdit;
    lblData: TLabel;
    rdgBoolean: TRadioGroup;
    btnAdicionar: TBitBtn;
    btnLimpar: TBitBtn;
    lblCompNaoVisual: TLabel;
    btnProcessar10: TButton;
    grbDialogs: TGroupBox;
    opdImagem: TOpenPictureDialog;
    lblOpenDialog: TLabel;
    lblAlterarImagem: TLabel;
    procedure btnCriarObjetoClick(Sender: TObject);
    procedure btnInformacaoClick(Sender: TObject);
    procedure btnAlertaClick(Sender: TObject);
    procedure btnPerguntaClick(Sender: TObject);
    procedure btnPerguntaFocoNaoClick(Sender: TObject);
    procedure btnErroClick(Sender: TObject);
    procedure chkAtivoClick(Sender: TObject);
    procedure cmbSexoChange(Sender: TObject);
    procedure cmbSexoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgEstadoCivilClick(Sender: TObject);
    procedure btnLerEditClick(Sender: TObject);
    procedure btnPreencherEditClick(Sender: TObject);
    procedure btnLerMemoClick(Sender: TObject);
    procedure btnPreencherMemoClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure btnComIconeClick(Sender: TObject);
    procedure btnSpeedButtonClick(Sender: TObject);
    procedure mskMascaraChange(Sender: TObject);
    procedure clbOpcoesClickCheck(Sender: TObject);
    procedure btnProcessar10Click(Sender: TObject);
    procedure edtValorInteiroKeyPress(Sender: TObject; var Key: Char);
    procedure imgLogoClick(Sender: TObject);
  private
    { Private declarations }
    vKey : Word;
  public
    { Public declarations }
  end;

var
  frmGenesis: TfrmGenesis;

implementation

uses StrUtils;

{$R *.dfm}

procedure TfrmGenesis.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   // * ------------------ Evento do Formulário ------------------------------ *
   // Evento FormKeyDown responsável por capturar cada tecla que foi pressionada
   // dentro do formulário.
   // O Down representa a tecla sendo apertada no teclado, ao qual é o oposto de
   // "Up" que corresponde quando a tecla está sendo "solta", "desapertada"

   vKey := Key; // Variável responsável por capturar a tecla que foi acionada
   // vKey = Variaável privada criada para capturar a tecla pressionada pelo
   // usuário, sendo que a vKey poderá ser utilizada em outros métodos. Já a
   // "Key : Word" só pode ser acessada dentro deste método FormKeyDown
   case vKey of
      VK_RETURN: // Correspondente a tecla <ENTER>
      begin
         // ActiveControl apresenta qual campo o sistema está processando neste
         // momento, normalmente é o campo que o usuário interagiu.
         // No caso do campo cmbSexo, por se tratar de um combobox, ou seja, uma
         // lista, ao clicar com a seta para cima, o sistema não deve
         // voltar um campo do formulário e sim para a opção anterior, por isso
         // que neste caso o sistema aplica o "Exit" e não executa a linha
         // "Perform..." para retornar um campo
         if (ActiveControl = memObservacao) then
            Exit;

         // Comando responsável para passar para o próximo campo do formulário
         Perform(WM_NextDlgCtl, 0, 0);
      end;

      VK_ESCAPE: // Correspondente a tecla <ESC>
      begin
         // Se o estado da tela é o padrão, então o sistema exibirá uma
         // pergunta ao usuário, para saber se a tela pode ser fechada
         if TMessageUtil.Pergunta('Deseja sair da rotina?') then
            Close; // Fecha o formulário, acionará o evento FormClose
      end;

      VK_UP: // Correspondente a tecla <SETA_PARA_CIMA>
      begin
         vKey := VK_CLEAR; // Limpa o conteúdo da tecla selecionada

         // ActiveControl apresenta qual campo o sistema está processando neste
         // momento, normalmente é o campo que o usuário interagiu.
         // No caso do campo cmbSexo, por se tratar de um combobox, ou seja, uma
         // lista, ao clicar com a seta para cima, o sistema não deve
         // voltar um campo do formulário e sim para a opção anterior, por isso
         // que neste caso o sistema aplica o "Exit" e não executa a linha
         // "Perform..." para retornar um campo
         if (ActiveControl = cmbSexo) or
            (ActiveControl = dbgGrid) then
            Exit;

         // Comando responsável para passar para o campo anterior do formulário
         // Quando o segundo parâmetro [WM_NextDlgCTL, <Segundo>, <Terceiro>]
         // é "1", corresponde ao campo anterior
         Perform(WM_NextDlgCTL, 1, 0);
      end;

      VK_PRIOR: // Correspondente a tecla <SETA_PARA_ESQUERDA>
      begin
         // Nenhum procedimento para está ação
      end;

      VK_NEXT: // Correspondente a tecla <SETA_PARA_DIREITA>
      begin
         // Nenhum procedimento para está ação
      end;
   end;
end;

procedure TfrmGenesis.btnCriarObjetoClick(Sender: TObject);
var
   xObjPessoa: TPessoa; // Declara a variável da classe desejada
   xTipo     ,
   xAtivo    ,
   xMensagem : String;
begin
   try
      // Define um padrão para o objeto e variáveis
      xObjPessoa := nil;
      xTipo      := EmptyStr;
      xAtivo     := EmptyStr;
      xMensagem  := EmptyStr;
      try
         // Instancia o objeto para poder acessar suas propriedades
         xObjPessoa := TPessoa.Create;

         // Valida se o ojeto está criado ou se não ocorreu erro em sua criação
         // evitando erro Access Violation
         if (xObjPessoa <> nil) then
         begin
            xObjPessoa.Id                  := 1;
            xObjPessoa.Nome                := 'Adão';
            xObjPessoa.Fisica_Juridica     := 0;
            xObjPessoa.IdentificadorPessoa := '000.000.000-01';
            xObjPessoa.Ativo               := False;
         end;

         xMensagem :=
            'Objeto Pessoa foi instanciado: '#13#13+ // #13 = Quebra de linha
            'Nome: '+ xObjPessoa.Nome+#13+
            'Tipo: '+
               IfThen(xObjPessoa.Fisica_Juridica = 0, 'Física','Jurídica')+#13+
            'CPF: '+ xObjPessoa.IdentificadorPessoa+#13+
            'Ativo: '+
               IfThen(xObjPessoa.Ativo, 'Não', 'Sim');
         MessageDlg(xMensagem, mtInformation, [mbOk], 0);

      except
         on E: Exception do
         begin
            // Caso ocorra algum erro no processo, será apresentado uma exceção
            // com as informações do erro em questão
            Raise Exception.Create(
               'Falha ao carregar os dados do objeto Pessoa: '#13+
               e.Message);
         end;
      end;
   finally
      // Sempre que terminar de usar um objeto, é preciso liberar o espaço na
      // memória, ou seja, destruir o objeto, para isso utilizamos o comando:
      if (xObjPessoa <> nil) then
         FreeAndNil(xObjPessoa);
      // Muito cuidado ao destruir um objeto, caso ele for utilizado fora do
      // método, ao tentar acessar suas propriedades ocorrerá erro
      // Access Violation
   end;
end;

procedure TfrmGenesis.btnInformacaoClick(Sender: TObject);
begin
   // Comando padrão do Delphi
   MessageDlg('Informação (Delphi)', mtInformation, [mbOk], 0);
   // Comando padrão da ATS
   TMessageUtil.Informacao('Informação (ATS)');
end;

procedure TfrmGenesis.btnAlertaClick(Sender: TObject);
begin
   // Comando padrão do Delphi
   MessageDlg('Alerta (Delphi)', mtWarning, [mbOk], 0);
   // Comando padrão da ATS
   TMessageUtil.Alerta('Alerta (ATS)');
end;

procedure TfrmGenesis.btnPerguntaClick(Sender: TObject);
begin
   // Comando padrão do Delphi
   if MessageDlg(
        'Deseja continuar? (Delphi)',
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      MessageDlg('Clicou em não (Delphi)', mtInformation, [mbOk], 0)
   else
      MessageDlg('Clicou em sim (Delphi)', mtInformation, [mbOk], 0);

   // Comando padrão da ATS
   if TMessageUtil.Pergunta('Deseja continuar? (ATS)') then
      TMessageUtil.Informacao('Clicou em "Sim".')
   else
      TMessageUtil.Informacao('Clicou em "Não".');
end;

procedure TfrmGenesis.btnPerguntaFocoNaoClick(Sender: TObject);
begin
   // Para aplicar o foco no botão "Não" é utilizado o seguinte comando
   if Application.MessageBox(
         PAnsiChar(
            'Deseja continuar?'), 'Confirmação',
            MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IdYes then
      TMessageUtil.Informacao('Clicou em "Sim".')
   else
      TMessageUtil.Informacao('Clicou em "Não".')
end;

procedure TfrmGenesis.btnErroClick(Sender: TObject);
begin
   // Comando padrão do Delphi
   MessageDlg('Erro (Delphi)', mtError, [mbOk], 0);
   // Comando padrão da ATS
   TMessageUtil.Erro('Erro (ATS)');
end;

procedure TfrmGenesis.chkAtivoClick(Sender: TObject);
begin
   // Para validar se o parâmetro está marcado ou não, utiliza-se o comando
   // ".Checked" corresponde a "True" (Verdadeiro)
   if (chkAtivo.Checked) then
   begin
      // Dentro deste bloco você poderá implementar outras validações ou exibir
      // uma mensagem informando o que ocorreu
      TMessageUtil.Informacao(
         'Parâmetro marcado. '#13#13+
         'Acesse o evento OnClick para saber mais sobre essa implementação.');
   end
   else
   begin
      // Neste caso o ".Checked" está "Falso"
      TMessageUtil.Informacao(
         'Parâmetro desmarcado. '#13#13+
         'Acesse o evento OnClick para saber mais sobre essa implementação.');
   end;
end;

procedure TfrmGenesis.cmbSexoChange(Sender: TObject);
begin
   // Para validar se o componente foi selecionado ou não, utiliza-se o comando
   // ".ItemIndex" corresponde ao número do indice que a opção está posicionada
   if (cmbSexo.ItemIndex = 0) then
   begin
      // Primeira opção definida nas proriedates "Items" =
      // Object Inspector > Properties > Items
      TMessageUtil.Informacao(
         'Sexo "'+cmbSexo.Items.Strings[cmbSexo.ItemIndex]+'" selecionado. '#13+
         'Exibindo todos os parâmetros do componente: "'+
         cmbSexo.Items.CommaText+'" '#13+ // Ou Items.Text para vir por linha
         'ItemIndex selecionado: "'+IntToStr(cmbSexo.ItemIndex)+'". '#13#13+
         'Acesse o evento OnChange e OnExit para saber mais sobre essa '+
         'implementação.');
   end
   else
   if (cmbSexo.ItemIndex = 1) then
   begin
      // Segunda opção definida nas proriedates "Items" =
      // Object Inspector > Properties > Items
      TMessageUtil.Informacao(
         'Sexo "'+cmbSexo.Items.Strings[cmbSexo.ItemIndex]+'" selecionado. '#13+
         'Exibindo todos os parâmetros do componente: "'+
         cmbSexo.Items.CommaText+'" '#13+ // Ou Items.Text para vir por linha
         'ItemIndex selecionado: "'+IntToStr(cmbSexo.ItemIndex)+'". '#13#13+
         'Acesse o evento OnChange e OnExit para saber mais sobre essa '+
         'implementação.');
   end;
end;

procedure TfrmGenesis.cmbSexoExit(Sender: TObject);
begin
   if vKey = VK_RETURN then
   begin
      TMessageUtil.Informacao(
         'Pressionou a tecla [ENTER] após selecionar a opção: '+
         cmbSexo.Items.Strings[cmbSexo.ItemIndex]);
   end;
   vKey := VK_CLEAR;
end;

procedure TfrmGenesis.rdgEstadoCivilClick(Sender: TObject);
begin
   // Para validar se o componente foi selecionado ou não, utiliza-se o comando
   // ".ItemIndex" corresponde ao número do indice que a opção está posicionada

   // Para definir o padrão da opção que virá marcada ao carregar a tela pela
   // primeira vez, utilize a proriedade "ItemIndex" da "Properties" do Object
   // Inspector, caso ele fique como -1, corresponderá que o componente virá
   // desmarcado 

   if (rdgEstadoCivil.ItemIndex = 0) then
   begin
      // Primeira opção definida nas proriedates "Items" =
      // Object Inspector > Properties > Items
      TMessageUtil.Informacao(
         'Opção "'+rdgEstadoCivil.Items.Strings[rdgEstadoCivil.ItemIndex]+
         '" selecionada. '#13+
         'Exibindo todos os parâmetros do componente: "'+
         rdgEstadoCivil.Items.CommaText+'" '#13+ // Ou Items.Text para vir por linha
         'ItemIndex selecionado: "'+IntToStr(rdgEstadoCivil.ItemIndex)+'". '#13#13+
         'Acesse o evento OnClick para saber mais sobre essa implementação.');
   end
   else
   if (rdgEstadoCivil.ItemIndex = 1) then
   begin
      // Segunda opção definida nas proriedates "Items" =
      // Object Inspector > Properties > Items
      TMessageUtil.Informacao(
         'Opção "'+rdgEstadoCivil.Items.Strings[rdgEstadoCivil.ItemIndex]+
         '" selecionada. '#13+
         'Exibindo todos os parâmetros do componente: "'+
         rdgEstadoCivil.Items.CommaText+'" '#13+ // Ou Items.Text para vir por linha
         'ItemIndex selecionado: "'+IntToStr(rdgEstadoCivil.ItemIndex)+'". '#13#13+
         'Acesse o evento OnClick para saber mais sobre essa implementação.');
   end;
end;

procedure TfrmGenesis.btnLerEditClick(Sender: TObject);
begin
   // O BEGIN_e_END só deve ser usado quando existir + de 1 linha
   if (Trim(edtCampo.Text) = EmptyStr) then// Valida se o valor do campo é vazio
      TMessageUtil.Informacao('O campo está vazio.')
   else
   begin
      // Para ler o campo, utiliza-se o ".Text"
      TMessageUtil.Informacao(
         'O valor do campo é: '+ edtCampo.Text);
   end;
end;

procedure TfrmGenesis.btnPreencherEditClick(Sender: TObject);
begin
   // Para gravar os dados do campo, utiliza-se o ".Text"
   TMessageUtil.Informacao(
      'O valor do campo é: '#13+ edtCampo.Text+#13#13+
      'Observe, pois o mesmo será alterado...');

   edtCampo.Text :=
      'Este texto foi adicionado na propriedade ".Text" do componente '+
      '"edtCampo.Text"(TEdit)';
end;

procedure TfrmGenesis.btnLerMemoClick(Sender: TObject);
begin
   // O BEGIN_e_END só deve ser usado quando existir + de 1 linha
   if (Trim(memObservacao.Text) = EmptyStr) then// Valida se o valor do campo é vazio
      TMessageUtil.Informacao('O campo (TMemo) está vazio.')
   else
   begin
      // Para gravar os dados do campo, utiliza-se o ".Text"
      TMessageUtil.Informacao(
         'O valor do campo (TMemo) com Text é: '#13+
         memObservacao.Text+ #13#13+
         'por uma única linha com CommaText: '#13+
         memObservacao.Lines.CommaText+#13#13+
         'por linha com GetText: '#13+
         memObservacao.Lines.GetText);
   end;
end;

procedure TfrmGenesis.btnPreencherMemoClick(Sender: TObject);
begin
   // Para gravar os dados do campo, utiliza-se o ".Text"
   TMessageUtil.Informacao(
      'O valor do campo é: '#13+ memObservacao.Text+#13#13+
      'Observe, pois o mesmo será alterado...');

   memObservacao.Text :=
      'Este texto foi adicionado na propriedade ".Lines.CommaText" '+
      'do componente "memObservacao.Lines.CommaText"(TMemo)';
end;

procedure TfrmGenesis.btnAdicionarClick(Sender: TObject);
begin
   // Valida se o ClientDataSet pode ser acessado
   if (cdsClientDataSet.Active) then
   begin
      // Comando para adicionar registro no DBGrid no efeito de fila, um abaixo
      // do outro. Diferente do comando ".Insert" que adiciona o registro com
      // efeito de pilha, um acima do outro.
      cdsClientDataSet.Append;
      // cdsClientDataSet.Insert;

      // Para inserir um valor de um campo a tabela temporária (TClientDataSet)
      // pode ser utilizado o comando cdsNomeDataSetCAMPO.Value, ou seja,
      // informando o nome do ClientDataSet + o nome do Campo seguido do
      // ".Value" e passando o valor desejado
      cdsClientDataSetTexto.Value     := edtTexto.Text;

      // Outra forma de passar informações para o ClientDataSet é:
      //      cdsClientDataSet.FieldByName('ValorReal').AsFloat := edtValorReal.Value;

      //      cdsClientDataSetValorPercentual.Value := edtValorPercentual.Value;

      // Sempre antes de converter, temos que validar se o campo não está em
      // branco, pois caso esteja em brancc e o sistema tente converter um valor
      // em branco, ocorrerá !ERRO
      if (edtValorInteiro.Text <> EmptyStr) then
      begin
         // Para acessar os valores dos campos do tipo "TEdit" e passar para
         // outro tipo que não seja "String", devemos converter o valor para o
         // tipo desejado. No exemplo abaixo está sendo passado uma String para
         // Integer por isso foi utilizado o "StrToInt(CAMPO)", porém podemos
         // usar:
         // "StrToFloat", "StrToDate", etc.
         // e vice-versa "FloatToStr", "DateToStr"
         cdsClientDataSetValorInteiro.Value := StrToInt(edtValorInteiro.Text);
      end;

      // Será armazenado o valor True = 1 ou False = 0
      if (rdgBoolean.ItemIndex = 1) then
         cdsClientDataSetBoolean.Value := True
      else
         cdsClientDataSetBoolean.Value := False;

      if (edtData.Text <> '  /  /    ') then
      begin
         // Para gravar um campo de data, podemos usar o "StrToDate" ou
         // "StrToDateTime" para armazenar a Data e Hora
         cdsClientDataSetData.Value := StrToDate(edtData.Text);
      end;

      // Salva (Commit) as informações passadas para a tabela temporária
      cdsClientDataSet.Post;
   end;
end;

procedure TfrmGenesis.btnLimparClick(Sender: TObject);
begin
   if (cdsClientDataSet.Active) and
      (cdsClientDataSet.RecordCount > 0) then
      cdsClientDataSet.Delete;
end;

procedure TfrmGenesis.btnProcessarClick(Sender: TObject);
begin
   if gagBarraProgresso.Progress < 100 then
      gagBarraProgresso.Progress := gagBarraProgresso.Progress + 10
   else
      gagBarraProgresso.Progress := 0;
end;

procedure TfrmGenesis.btnComIconeClick(Sender: TObject);
begin
   // O ícone desejado deve ser referenciado na propriedade Glyph
   // Selecionando a imagem através do botão "Load"
   TMessageUtil.Informacao(
      'O ícone desejado deve ser selecionado na propriedade "Glyph" do '+
      '"Object Inspector".'#13#13+
      'Selecionando a imagem através do botão "Load".');
end;

procedure TfrmGenesis.btnSpeedButtonClick(Sender: TObject);
begin
   // O ícone desejado deve ser referenciado na propriedade Glyph
   // Selecionando a imagem através do botão "Load"
   TMessageUtil.Informacao(
      'O ícone desejado deve ser selecionado na propriedade "Glyph" do '+
      '"Object Inspector".'#13#13+
      'Selecionando a imagem através do botão "Load".');   
end;

procedure TfrmGenesis.mskMascaraChange(Sender: TObject);
begin
   // Mascara adicionada na propriedade EditMask
   TMessageUtil.Informacao(
      'Informe a mascara na propriedade ".EditMask"'#13#13+
      'Exemplo de mascara de data:'#13+
      ''#13+
      '!99/99/0000;1;_');
end;

procedure TfrmGenesis.clbOpcoesClickCheck(Sender: TObject);
var
   i : Integer;
begin
   for i := 0 to pred(clbOpcoes.Items.Count) do
   begin
      if clbOpcoes.Selected[i] then
      begin
         TMessageUtil.Informacao(
            'Comando ".Selected" exibe:'#13#13+
            clbOpcoes.Items.Strings[i]);
      end;
   end;

   for i := 0 to pred(clbOpcoes.Items.Count) do
   begin
      if clbOpcoes.Checked[i] then
      begin
         TMessageUtil.Informacao(
            'Apresentando todos os itens marcados ".Checked":'#13#13+
            clbOpcoes.Items.Strings[i]);
      end;
   end;

   TMessageUtil.Informacao(
      'Comando ".Items.GetText" exibe todas as opções (Quebra de linha):'#13#13+
      clbOpcoes.Items.GetText);

   TMessageUtil.Informacao(
      'Comando ".Items.CommaText" exibe todas as opções em uma linha:'#13#13+
      clbOpcoes.Items.CommaText);

end;

procedure TfrmGenesis.btnProcessar10Click(Sender: TObject);
begin
   if prgBarraProgresso.Position < 100 then
      prgBarraProgresso.Position := prgBarraProgresso.Position + 10
   else
      prgBarraProgresso.Position := 0;
end;

procedure TfrmGenesis.edtValorInteiroKeyPress(Sender: TObject;
  var Key: Char);
begin
   // Define os caracteres que podem ser informados no campo em questão
   if not (Key In ['0'..'9', #8]) then
      Key := #0;
end;

procedure TfrmGenesis.imgLogoClick(Sender: TObject);
var
   xTipoArquivo : String;
begin
   // Propriedades importantes do componente TImagem
   // Center:
   //        Receber o valor "True" ou "False"
   //        Responsável por centralizar a imagem
   // Stretch:
   //        Receber o valor "True" ou "False"
   //        Responsável por adaptar o tamanho da imagem selecionada pelo
   //        tamanho que tem disponivel no componente de TImagem

   // Aciona a janela do Windows para carregar uma nova imagem no componente
   // "imgLogo"(TImage)
   if opdImagem.Execute then
   begin
      // Captura o tipo do arquivo
      // Comando COPY, copia parte do texto desejado
      // Copy(TEXTO, VlrInicialQueSeráCapturado, VlrFinalQueSerá capturado
      xTipoArquivo :=
         Copy(
            opdImagem.FileName,
            Length(opdImagem.FileName) - 2,
            Length(opdImagem.FileName));

      // Valida tipos de imagens que não serão válidos
      // Validação adicionada na propriedade ".Filter" do componente
      // "opdImagem"(TOpenPictureDialog).
      if (xTipoArquivo = 'jpg') or
         (xTipoArquivo = 'JPG') or
         (xTipoArquivo = 'bmp') or
         (xTipoArquivo = 'BMP') then
         imgLogo.Picture.LoadFromFile(opdImagem.FileName) // Carrega imagem
      else
      begin
         TMessageUtil.Alerta(
            'O arquivo selecionado não é uma imagem do tipo jpg ou bmp.');
      end;
   end;
end;

end.
