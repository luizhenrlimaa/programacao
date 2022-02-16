unit UClientesView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask, UEnumerationUtil,
  UCliente , UPessoaController;

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


  private
    { Private declarations }
   vKey : Word;

   // Variaveis de Classes
   vEstadoTela : TEstadoTela;
   vObjCliente : TCliente;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;

   function ProcessaConfirmacao : Boolean;
   function ProcessaInclusao    : Boolean;
   function ProcessaCliente     : Boolean;

   function ProcessaPessoa      : Boolean;
   function ProcessaEndereco    : Boolean;
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

Uses
  uMessageUtil;

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
        etIncluir: Result := ProcessaInclusao;
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
          TPessoaController.getInstancia.GravaPessoa(vObjCliente);

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

//       if not ValidaCliente then
//            Exit;

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
begin
    try
      Result := False;


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

end.


