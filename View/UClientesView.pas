unit UClientesView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask, UEnumerationUtil,
  UCliente , UPessoaController, UEndereco;

type
  TfrmClientes = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlBotoes: TPanel;
    pnlArea: TPanel;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    chkAtivo: TCheckBox;
    rdgTipoPessoa: TRadioGroup;
    lblCPFCNPJ: TLabel;
    edtCPFCNPJ: TMaskEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    grbEndereco: TGroupBox;
    lblEndereco: TLabel;
    edtEndereco: TEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    cmbUF: TComboBox;
    lblUF: TLabel;
    lblCidade: TLabel;
    edtCidade: TEdit;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnConsultar: TBitBtn;
    btnListar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSair: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoExit(Sender: TObject);
    procedure rdgTipoPessoaClick(Sender: TObject);


  private
    { Private declarations }
   vKey : Word;

   // Variaveis de Classes
   vEstadoTela : TEstadoTela;
   vObjCliente : TCliente;
   vObjColEndereco : TColEndereco;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;

   // Carrega dados padr�o na tela

   procedure carregaDadosTela;

   function ProcessaConfirmacao : Boolean;
   function ProcessaAlteracao   : Boolean;
   function ProcessaExclusao    : Boolean;
   function ProcessaInclusao    : Boolean;
   function ProcessaConsulta    : Boolean;
   function ProcessaCliente     : Boolean;

   function ProcessaPessoa      : Boolean;
   function ProcessaEndereco    : Boolean;

   function ValidaCliente       : Boolean;
   function ValidaEndereco      : Boolean;

  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

Uses
  uMessageUtil, UClientesPesqView;

{$R *.dfm}

procedure TfrmClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := Key;

   case vKey of
      VK_RETURN: // Correspondente a tecla <enter>
      begin
        //Comando respons�vel para passar para o pr�ximo campo do formul�rio
        Perform(WM_NextDlgCtl, 0, 0);
      end;

      VK_ESCAPE:  // Correpodente a tecla <esc>
      begin
        if (vEstadoTela <> etPadrao) then
        begin
          if (TMessageUtil.Pergunta('Deseja realmente abortar esta opera��o?'))then
          begin
            vEstadoTela := etPadrao;
            DefineEstadoTela;
           end;
        end
        else
        begin
          if (TMessageUtil.Pergunta(
             'Deseja sair da rotina?'))then
             Close; // Fechar o formul�rio
        end;
      end;
   end;
end;

procedure TfrmClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   frmClientes := nil;
end;

procedure TfrmClientes.CamposEnabled(pOpcao: Boolean);
var
  i : Integer; // Varia�vel para auxiliar o comando de repeti��o

begin
  for i := 0 to pred(ComponentCount) do
  begin
      // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Enabled := pOpcao;
      // Se o compo for do tipo MASKEDIT
      if (Components[i] is TMaskEdit)  then
      (Components[i] as TMaskEdit).Enabled := pOpcao;
      // Se o compo for do tipo RADIOGROUP
      if (Components[i] is TRadioGroup)  then
      (Components[i] as TRadioGroup).Enabled := pOpcao;
      // Se o compo for do tipo COMBOBOX
      if (Components[i] is TComboBox)  then
      (Components[i] as TComboBox).Enabled := pOpcao;
      // Se o compo for do tipo CHECKBOX
      if (Components[i] is TCheckBox)  then
      (Components[i] as TCheckBox).Enabled := pOpcao;
  end;
    grbEndereco.Enabled := pOpcao;
end;

 procedure TfrmClientes.LimpaTela;
var
  i : Integer;
begin
  for i:= 0 to pred(ComponentCount)do
  begin
       // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Text := EmptyStr;
         // Se o compo for do tipo MASKEDIT
      if (Components[i] is TMaskEdit)  then
      (Components[i] as TMaskEdit).Text := EmptyStr;
      // Se o compo for do tipo RADIOGROUP
      if (Components[i] is TRadioGroup)  then  // Ent�o , define seu padr�o
      (Components[i] as TRadioGroup).ItemIndex := 0;
      // Se o compo for do tipo COMBOBOX
      if (Components[i] is TComboBox)  then    // Ent�o , define seu padr�o -1
      (Components[i] as TComboBox).ItemIndex := -1;
      // Se o compo for do tipo CHECKBOX
      if (Components[i] is TCheckBox)  then
      // Ent�o , define seu padr�o desmarcado
      (Components[i] as TCheckBox).Checked := False;
  end;
   if(vObjCliente <> nil) then
   FreeAndNil(vObjCliente);

   if(vObjColEndereco <> nil) then
   FreeAndNil(vObjColEndereco);

end;

procedure TfrmClientes.DefineEstadoTela;
begin
  btnIncluir.Enabled    := (vEstadoTela in [etPadrao]);
  btnAlterar.Enabled    := (vEstadoTela in [etPadrao]);
  btnExcluir.Enabled    := (vEstadoTela in [etPadrao]);
  btnConsultar.Enabled  := (vEstadoTela in [etPadrao]);
  btnListar.Enabled     := (vEstadoTela in [etPadrao]);
  btnPesquisar.Enabled  := (vEstadoTela in [etPadrao]);

  btnConfirmar.Enabled :=
     vEstadoTela in [etIncluir, etAlterar, etExcluir, etConsultar];
  btnCancelar.Enabled :=
     vEstadoTela in [etIncluir, etAlterar, etExcluir, etConsultar];

  case vEstadoTela of
    etPadrao:
    begin
        CamposEnabled(False);
        LimpaTela;

        stbBarraStatus.Panels[0].Text := EmptyStr;
        stbBarraStatus.Panels[1].Text := EmptyStr;

        if (frmClientes <> nil) and
            (frmClientes.Active) and
            (btnIncluir.CanFocus) then
            btnIncluir.SetFocus;

       Application.ProcessMessages;
    end;

    etIncluir:
    begin
      stbBarraStatus.Panels[0].Text := 'Inclus�o';
      CamposEnabled(True);

      edtCodigo.Enabled := False;

      chkAtivo.Checked := True;

      if edtNome.CanFocus then
         edtNome.SetFocus;
    end;

    etAlterar:
    begin
      stbBarraStatus.Panels[0].Text := 'Altera��o';

      if (edtCodigo.Text <> EmptyStr) then
     begin
        CamposEnabled(True);

        edtCodigo.Enabled      := False;
        btnAlterar.Enabled     := False;
        btnConfirmar.Enabled   := True;


      if (chkAtivo.CanFocus) then
          chkAtivo.SetFocus;
     end
    else
     begin

       lblCodigo.Enabled := True;
       edtCodigo.Enabled := True;

       if(edtCodigo.CanFocus) then
          edtCodigo.SetFocus;
     end;
    end;

    etExcluir:
    begin
      stbBarraStatus.Panels[0].Text := 'Exclus�o';
      if (edtCodigo.Text <> EmptyStr) then
        ProcessaExclusao;
      begin
        lblCodigo.Enabled := True;
        edtCodigo.Enabled := True;

        if(edtCodigo.CanFocus) then
           edtCodigo.SetFocus;

      end;
    end;

    etConsultar:
    begin
     stbBarraStatus.Panels[0].Text := 'Consulta';

     CamposEnabled(False);

     if (edtCodigo.Text <> EmptyStr) then
     begin
       edtCodigo.Enabled    := False;
       btnAlterar.Enabled   := True;
       btnExcluir.Enabled   := True;
       btnListar.Enabled    := True;
       btnConfirmar.Enabled := False;

        if(btnAlterar.CanFocus) then
          btnAlterar.SetFocus;
     end
     else
     begin
       lblCodigo.Enabled := True;
       edtCodigo.Enabled := True;

       if edtCodigo.CanFocus then
          edtCodigo.SetFocus;
     end;


    end;
     etPesquisar:
     begin
       stbBarraStatus.Panels[0].Text := 'Pesquisa';

       if (frmClientesPesq = nil) then
           frmClientesPesq := TfrmClientesPesq.Create(Application);

       frmClientesPesq.ShowModal;

       if (frmClientesPesq.mClienteID <> 0) then
       begin
          edtCodigo.Text := IntToStr(frmClientesPesq.mClienteID);
          vEstadoTela    := etConsultar;
          ProcessaConsulta;
       end
       else
       begin
          vEstadoTela := etPadrao;
          DefineEstadoTela;
       end;

       frmClientesPesq.mClienteID := 0;
       frmClientesPesq.mClienteNome := EmptyStr;

       if edtNome.CanFocus then
          edtNome.SetFocus;

     end;

  end;
end;

procedure TfrmClientes.btnIncluirClick(Sender: TObject);
begin
      vEstadoTela := etIncluir;
      DefineEstadoTela;
end;

procedure TfrmClientes.btnAlterarClick(Sender: TObject);
begin
      vEstadoTela := etAlterar;
      DefineEstadoTela;
end;

procedure TfrmClientes.btnExcluirClick(Sender: TObject);
begin
      vEstadoTela := etExcluir;
      DefineEstadoTela;
end;

procedure TfrmClientes.btnConsultarClick(Sender: TObject);
begin
      vEstadoTela := etConsultar;
      DefineEstadoTela;
end;


procedure TfrmClientes.btnListarClick(Sender: TObject);
begin
      vEstadoTela := etListar;
      DefineEstadoTela;
end;

procedure TfrmClientes.btnPesquisarClick(Sender: TObject);
begin
      vEstadoTela := etPesquisar;
      DefineEstadoTela;
end;

procedure TfrmClientes.btnConfirmarClick(Sender: TObject);
begin
    ProcessaConfirmacao;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
      vEstadoTela := etPadrao;
      DefineEstadoTela;
end;


procedure TfrmClientes.btnSairClick(Sender: TObject);
begin
    if (vEstadoTela <> etPadrao) then
    begin
       if (TMessageUtil.Pergunta('Deseja realmente abortar esta opera��o?'))then
       begin
         vEstadoTela := etPadrao;
         DefineEstadoTela;
       end;
    end
    else
      Close;
end;

procedure TfrmClientes.FormCreate(Sender: TObject);
begin
   vEstadoTela := etPadrao;
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
   DefineEstadoTela;
end;

procedure TfrmClientes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    vKey := VK_CLEAR;
end;

function TfrmClientes.ProcessaConfirmacao: Boolean;
begin
   Result := False;

  try
      case vEstadoTela of
        etIncluir:   Result := ProcessaInclusao;
        etAlterar:   Result := ProcessaAlteracao;
        etExcluir:   Result := ProcessaExclusao;
        etConsultar: Result := ProcessaConsulta;
      end;

      if not Result then
        Exit;
  except
      on E: Exception do
      TMessageUtil.Alerta(E.Message);
  end;

   Result := True;
end;

function TfrmClientes.ProcessaInclusao: Boolean;
begin
   try

     Result := False;

     if ProcessaCliente then
     begin
       TMessageUtil.Informacao('Cliente cadastrado com sucesso.'#13+
       'C�digo cadastrado: '+ IntToStr(vObjCliente.Id));

       vEstadoTela := etPadrao;
       DefineEstadoTela;
       DefineEstadoTela;

       Result  := True;
     end;
   except
      on E: Exception do
      begin
          Raise Exception.Create(
          'Falha ao incluir os dados do cliente [View]: '#13+
          e.Message);
      end;

   end;
end;

function TfrmClientes.ProcessaCliente: Boolean;
begin
   try
       Result := False;
     if(ProcessaPessoa) and
      (ProcessaEndereco) then
      begin
          // Grava��o no BD
          TPessoaController.getInstancia.GravaPessoa(
              vObjCliente, vObjColEndereco);

          Result := True;
      end;

   except
       on E : Exception do
       begin
         Raise Exception.Create(
              'Falha ao gravar os dados do cliente [View]: '#13+
              e.Message);
       end;
   end;
end;

function TfrmClientes.ProcessaPessoa: Boolean;
begin
     try
       Result := False;

     if not ValidaCliente then
            Exit;

      if vEstadoTela = etIncluir then
      begin
        if vObjCliente = nil then
           vObjCliente := TCliente.Create;
      end
      else
      if  vEstadoTela = etAlterar then
      begin
         if vObjCliente = nil then
            Exit;
      end;

      if (vObjCliente = nil) then
         Exit;

        vObjCliente.Tipo_Pessoa               := 0;// Cliente
        vObjCliente.Nome                      := edtNome.Text;
        vObjCliente.Fisica_Juridica           := rdgTipoPessoa.ItemIndex;
        vObjCliente.Ativo                     := chkAtivo.Checked;
        vObjCliente.IdentificadorPessoa       :=  edtCPFCNPJ.Text;

       Result := True;
     except
       on E : Exception do
       begin
          Raise Exception.Create(
          'Falha ao processar os dados da Pessoa [View]'#13+
          e.Message);
       end;

     end;

end;

function TfrmClientes.ProcessaEndereco: Boolean;
var
  xEndereco  : TEndereco;
  xID_Pessoa : Integer;
begin
    try
      Result := False;

      xEndereco := nil;
      xID_Pessoa := 0;

      if (not validaEndereco) then
         Exit;

      if (vObjColEndereco <> nil) then
        FreeAndNil(vObjColEndereco);

      vObjColEndereco := TColEndereco.Create;

      if vEstadoTela = etAlterar then
         xID_Pessoa := StrToIntDef(edtCodigo.Text , 0);

      xEndereco               := TEndereco.Create;
      xEndereco.ID_pessoa     := xID_Pessoa;
      xEndereco.Tipo_Endereco := 0;
      xEndereco.Endereco      := edtEndereco.Text;
      xEndereco.Numero        := edtNumero.Text;
      xEndereco.Complemento   := edtComplemento.Text;
      xEndereco.Bairro        := edtBairro.Text;
      xEndereco.UF            := cmbUF.Text;
      xEndereco.Cidade        := edtCidade.Text;

      vObjColEndereco.Add(xEndereco);


      Result := True;
    except
      on E : Exception do
      begin
        Raise Exception.Create(
        'Falha ao preencher os dados de endere�o do cliente [View]. '#13+
        e.Message);
      end;

    end;
end;

function TfrmClientes.ValidaCliente: Boolean;
begin
   Result := False;

   if (edtNome.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Nome do cliente n�o pode ficar em branco.');

     if edtNome.CanFocus  then
        edtNome.SetFocus;

     Exit;
   end;
   Result := True;
end;

function TfrmClientes.ProcessaConsulta: Boolean;
begin
   try
       Result := False;

       if (edtCodigo.Text = EmptyStr) then
       begin
            TMessageUtil.Alerta('C�digo do cliente n�o pode ficar em branco');

            if (edtCodigo.CanFocus) then
                edtCodigo.SetFocus;

            Exit;
       end;

      vObjCliente :=
         TCliente(TPessoaController.getInstancia.BuscaPessoa(
            StrToIntDef(edtCodigo.Text, 0)));

      vObjColEndereco :=
        TPessoaController.getInstancia.BuscaEnderecoPessoa(
            StrToIntDef(edtCodigo.Text, 0));

          if (vObjCliente <> nil) then
            CarregaDadosTela
          else
          begin
            TMessageUtil.Alerta(
                'Nenhum cliente encontrado para o c�digo informado.');
            LimpaTela;

            if (edtCodigo.CanFocus) then
                edtCodigo.SetFocus;

            Exit;
          end;

          DefineEstadoTela;
          Result := True;

   except
      on E:Exception do
      begin
        Raise Exception.Create(
        'Falha ao consultar os dados do cliente [View]: '#13+
        e.Message);
      end;
   end;

end;

procedure TfrmClientes.carregaDadosTela;
var
  i : Integer;
  xEndereco : TEndereco;
 begin
  if (vObjCliente = nil) then
     Exit;

  edtCodigo.Text          := IntToStr(vObjCliente.Id);
  rdgTipoPessoa.ItemIndex := vObjCliente.Fisica_Juridica;
  edtNome.Text            := vObjCliente.Nome;
  chkAtivo.Checked        := vObjCliente.Ativo;
  edtCPFCNPJ.Text         := vObjCliente.IdentificadorPessoa;

  if (vObjColEndereco <> nil) then
  begin
    for  i:= 0 to pred(vObjColEndereco.Count) do
    begin
      edtEndereco.Text      := vObjColEndereco.Retorna(i).Endereco;
      edtNumero.Text        := vObjColEndereco.Retorna(i).Numero;
      edtComplemento.Text   := vObjColEndereco.Retorna(i).Complemento;
      edtBairro.Text        := vObjColEndereco.Retorna(i).Bairro;
      cmbUF.Text            := vObjColEndereco.Retorna(i).UF;
      edtcidade.Text        := vObjColEndereco.Retorna(i).Cidade;
    end;
  end;
 end;

function TfrmClientes.ProcessaAlteracao: Boolean;
begin
  try
    Result := False;

    if ProcessaCliente then
    begin
      TMessageUtil.Informacao('Dados alterados com sucesso.');

      vEstadoTela := etPadrao;
      DefineEstadoTela;
      Result := True;

    end;

  except
     on E:Exception do
      begin
        Raise Exception.Create(
        'Falha ao alterar os dados do cliente [View]: '#13+
        e.Message);
      end;
  end;
 end;

procedure TfrmClientes.edtCodigoExit(Sender: TObject);
begin
   if vKey = VK_RETURN then
   ProcessaConsulta;

   vKey := VK_CLEAR;


end;

function TfrmClientes.ProcessaExclusao: Boolean;
begin
  try
    Result := False;

     if (vObjCliente = nil) or
        (vObjColEndereco = nil) then

     begin
       TMessageUtil.Alerta(
        'N�o foi possivel carregar todos os dados cadastrados do cliente');

       LimpaTela;
       vEstadoTela := etPadrao;
       DefineEstadoTela;
       Exit;
     end;
     try
       if TMessageUtil.Pergunta('Confirma a exclus�o do cliente?') then
       begin
          Screen.Cursor := crHourGlass;
          TPessoaController.getInstancia.ExcluiPessoa(vObjCliente);
       end
       else
       begin
         LimpaTela;
         vEstadoTela := etPadrao;
         DefineEstadoTela;
         Exit;
       end;

     finally
        Screen.Cursor := crDefault;
        Application.ProcessMessages;
     end;

     Result := True;
     TMessageUtil.Informacao('Cliente exluido com sucesso.');
     LimpaTela;
     vEstadoTela := etPadrao;
     DefineEstadoTela;
     Exit;
     
  except
      on E:Exception do
      begin
        Raise Exception.Create(
        'Falha ao excluir os dados do cliente [View]: '#13+
        e.Message);
      end;
  end;
end;

function TfrmClientes.ValidaEndereco: Boolean;
begin
   Result  := False;

    if (Trim(edtEndereco.Text) = EmptyStr) then
    begin
       TMessageUtil.Alerta('Endere�o do cliente n�o pode ficar em branco.');

       if (edtEndereco.CanFocus) then
           edtEndereco.SetFocus;
      Exit;
    end;

    if (Trim(edtNumero.Text) = EmptyStr)then
    begin
       TMessageUtil.Alerta('N�mero de endere�o do cliente n�o pode ficar em branco.');

       if (edtNumero.CanFocus) then
           edtNumero.SetFocus;
      Exit;
    end;

    if (Trim(edtBairro.Text) = EmptyStr)then
    begin
       TMessageUtil.Alerta('Bairro n�o pode ficar em branco.');

       if (edtBairro.CanFocus) then
           edtBairro.SetFocus;
      Exit;
    end;

      if (Trim(cmbUF.Text) = EmptyStr)then
    begin
       TMessageUtil.Alerta('UF n�o pode ficar em branco.');

       if (cmbUF.CanFocus) then
           cmbUF.SetFocus;
      Exit;
    end;

       if (Trim(edtCidade.Text) = EmptyStr)then
    begin
       TMessageUtil.Alerta('Cidade n�o pode ficar em branco.');

       if (edtCidade.CanFocus) then
           edtCidade.SetFocus;
      Exit;
    end;



   Result  := True;
end;

procedure TfrmClientes.rdgTipoPessoaClick(Sender: TObject);
begin
  if rdgTipoPessoa.ItemIndex = 1 then
  begin
     edtCPFCNPJ.Clear;
     edtCPFCNPJ.EditMask := '00\.000\.000\/0000\-00;1_;'
  end
  else
  begin
     edtCPFCNPJ.Clear;
     edtCPFCNPJ.EditMask :=  '000\.000\.000\.00;1;_';
  end;

end;

end.


