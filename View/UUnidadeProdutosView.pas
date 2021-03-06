unit UUnidadeProdutosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask, UEnumerationUtil,
  UUnidade, UUnidadeProduto, UUnidadeProdutoController;

type
  TfrmUnidadeProdutos = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlPrincipal: TPanel;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    chkAtivo: TCheckBox;
    lblUnidade: TLabel;
    edtUnidade: TEdit;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    pnlBotoes: TPanel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnConsultar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSair: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);

  private
       { Private declarations }
    vKey : Word;
   // Variaveis de Classes
   vEstadoTela : TEstadoTela;
   vObjUnidade : TUnidade;
   vObjColProduto : TColUnidadeProduto;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;

     // Carrega dados padr?o na tela

   procedure carregaDadosTela;


   function ProcessaConfirmacao : Boolean;
   function ProcessaAlteracao   : Boolean;
   function ProcessaConsulta    : Boolean;
   function ProcessaExclusao    : Boolean;
   function ProcessaInclusao    : Boolean;
   function ProcessaProduto     : Boolean; 


   function ProcessaUnidade     : Boolean;

   
   function ValidaUnidade       : Boolean;

  public
    { Public declarations }
  end;

var
  frmUnidadeProdutos: TfrmUnidadeProdutos;

implementation

{$R *.dfm}
Uses
  uMessageUtil, StrUtils, UClassFuncoes, UClientesView, UUnidadeProdutoPesqView;


procedure TfrmUnidadeProdutos.btnSairClick(Sender: TObject);
begin
    if (vEstadoTela <> etPadrao) then
    begin
       if (TMessageUtil.Pergunta('Deseja realmente abortar esta opera??o?'))then
       begin
         vEstadoTela := etPadrao;
         DefineEstadoTela;
       end;
    end
    else
      Close;
end;

procedure TfrmUnidadeProdutos.CamposEnabled(pOpcao: Boolean);
var
  i : Integer; // Varia?vel para auxiliar o comando de repeti??o
begin
  for i := 0 to pred(ComponentCount) do
  begin
      // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Enabled := pOpcao;
      // Se o compo for do tipo CHECKBOX
      if (Components[i] is TCheckBox)  then
      (Components[i] as TCheckBox).Enabled := pOpcao;
  end;
end;
procedure TfrmUnidadeProdutos.DefineEstadoTela;
begin
   btnIncluir.Enabled    := (vEstadoTela in [etPadrao]);
   btnAlterar.Enabled    := (vEstadoTela in [etPadrao]);
   btnExcluir.Enabled    := (vEstadoTela in [etPadrao]);
   btnConsultar.Enabled  := (vEstadoTela in [etPadrao]);
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

        if (frmUnidadeProdutos <> nil) and
            (frmUnidadeProdutos.Active) and
            (btnIncluir.CanFocus) then
            btnIncluir.SetFocus;

       Application.ProcessMessages;
    end;

    etIncluir:
    begin
        stbBarraStatus.Panels[0].Text := 'Inclus?o';
        CamposEnabled(True);
        edtCodigo.Enabled := False;
        chkAtivo.Checked := True;

        if edtUnidade.CanFocus then
           edtUnidade.SetFocus;
    end;

    etAlterar:
    begin
      stbBarraStatus.Panels[0].Text := 'Altera??o';

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
      stbBarraStatus.Panels[0].Text := 'Exclus?o';
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

       if (frmUnidadeProdutoPesq = nil) then
           frmUnidadeProdutoPesq := TfrmUnidadeProdutoPesq.Create(Application);

       frmUnidadeProdutoPesq.ShowModal;

       if (frmUnidadeProdutoPesq.mUnidadeProdutoID <> 0) then
       begin
          edtCodigo.Text := IntToStr(frmUnidadeProdutoPesq.mUnidadeProdutoID);
          vEstadoTela    := etConsultar;
          ProcessaConsulta;
       end
       else
       begin
          vEstadoTela := etPadrao;
          DefineEstadoTela;
       end;

       frmUnidadeProdutoPesq.mUnidadeProdutoID := 0;
       frmUnidadeProdutoPesq.mUnidadeProdutoDescricao := EmptyStr;

       if edtUnidade.CanFocus then
          edtUnidade.SetFocus;

     end;
  end;
end;


procedure TfrmUnidadeProdutos.btnIncluirClick(Sender: TObject);
begin
      vEstadoTela := etIncluir;
      DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.btnAlterarClick(Sender: TObject);
begin
      vEstadoTela := etAlterar;
      DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.btnExcluirClick(Sender: TObject);
begin
      vEstadoTela := etExcluir;
      DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.btnConsultarClick(Sender: TObject);
begin
      vEstadoTela := etConsultar;
      DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.btnPesquisarClick(Sender: TObject);
begin
      vEstadoTela := etPesquisar;
      DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.btnCancelarClick(Sender: TObject);
begin
      vEstadoTela := etPadrao;
      DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.LimpaTela;
var
  i: Integer;
begin
  for i:= 0 to pred(ComponentCount)do
  begin
       // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Text := EmptyStr;
      // Se o compo for do tipo CHECKBOX
      if (Components[i] is TCheckBox)  then
      // Ent?o , define seu padr?o desmarcado
      (Components[i] as TCheckBox).Checked := False;
  end;
    if(vObjUnidade <> nil) then
   FreeAndNil(vObjUnidade);
   if(vObjColProduto <> nil) then
   FreeAndNil(vObjColProduto);
end;

procedure TfrmUnidadeProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   frmUnidadeProdutos := nil;
end;

procedure TfrmUnidadeProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := Key;

   case vKey of
      VK_RETURN: // Correspondente a tecla <enter>
      begin
        //Comando respons?vel para passar para o pr?ximo campo do formul?rio
        Perform(WM_NextDlgCtl, 0, 0);
      end;

      VK_ESCAPE:  // Correpodente a tecla <esc>
      begin
        if (vEstadoTela <> etPadrao) then
        begin
          if (TMessageUtil.Pergunta('Deseja realmente abortar esta opera??o?'))then
          begin
            vEstadoTela := etPadrao;
            DefineEstadoTela;
           end;
        end
        else
        begin
          if (TMessageUtil.Pergunta(
             'Deseja sair da rotina?'))then
             Close; // Fechar o formul?rio
        end;
      end;
   end;
end;

procedure TfrmUnidadeProdutos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := VK_CLEAR;
end;

procedure TfrmUnidadeProdutos.FormCreate(Sender: TObject);
begin
   vEstadoTela := etPadrao;
end;

procedure TfrmUnidadeProdutos.FormShow(Sender: TObject);
begin
    DefineEstadoTela;
end;

procedure TfrmUnidadeProdutos.edtCodigoExit(Sender: TObject);
begin
  if vKey = VK_RETURN then
   ProcessaConsulta;

   vKey := VK_CLEAR;
end;

procedure TfrmUnidadeProdutos.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

function TfrmUnidadeProdutos.ProcessaConfirmacao: Boolean;
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

function TfrmUnidadeProdutos.ProcessaInclusao: Boolean;
begin
   try

     Result := False;

     if ProcessaProduto then
     begin
       TMessageUtil.Informacao('Produto cadastrado com sucesso.'#13+
       'C?digo cadastrado: '+ IntToStr(vObjUnidade.Id));
       vEstadoTela := etPadrao;
       DefineEstadoTela;
       DefineEstadoTela;

       Result  := True;
     end;
   except
      on E: Exception do
      begin
          Raise Exception.Create(
          'Falha ao incluir os dados do produto [View]: '#13+
          e.Message);
      end;

   end;
end;

function TfrmUnidadeProdutos.ProcessaProduto: Boolean;
begin
  try
       Result := False;
     if(ProcessaUnidade) then
      begin
          // Grava??o no BD
          TUnidadeProdutoController.getInstancia.GravaProduto(
                                      vObjUnidade, vObjColProduto);

          Result := True;
      end;

  except
       on E : Exception do
       begin
         Raise Exception.Create(
              'Falha ao gravar os dados do produto [View]: '#13+
              e.Message);
       end;
  end;
end;

function TfrmUnidadeProdutos.ProcessaUnidade: Boolean;
begin
   try
       Result := False;

     if not ValidaUnidade then
            Exit;
     if (vObjColProduto <> nil) then
        FreeAndNil(vObjColProduto);

      vObjColProduto := TColUnidadeProduto.Create;
      if vEstadoTela = etIncluir then
      begin
        if vObjUnidade = nil then
           vObjUnidade := TUnidade.Create;
      end
      else
      if  vEstadoTela = etAlterar then
      begin
         if vObjUnidade = nil then
            Exit;
      end;

      if (vObjUnidade = nil) then
         Exit;

        vObjUnidade.Unidade                      := edtUnidade.Text;
        vObjUnidade.Ativo                        := chkAtivo.Checked;
        vObjUnidade.Descricao                    := edtDescricao.Text;

       Result := True;
   except
       on E : Exception do
       begin
          Raise Exception.Create(
          'Falha ao processar os dados do Produto [View]'#13+
          e.Message);
       end;

   end;
end;

function TfrmUnidadeProdutos.ValidaUnidade: Boolean;
begin
   Result := False;

   if (edtUnidade.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Unidade n?o pode ficar em branco.');

     if edtUnidade.CanFocus  then
        edtUnidade.SetFocus;

     Exit;

   end;

   if (edtDescricao.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Descri??o n?o pode ficar em branco.');

     if edtDescricao.CanFocus  then
        edtDescricao.SetFocus;

     Exit;
   end;

   Result := True;
end;

function TfrmUnidadeProdutos.ProcessaConsulta: Boolean;
begin
   try
       Result := False;

       if (edtCodigo.Text = EmptyStr) then
       begin
            TMessageUtil.Alerta('C?digo do produto n?o pode ficar em branco');

            if (edtCodigo.CanFocus) then
                edtCodigo.SetFocus;

            Exit;
       end;

      vObjUnidade :=
         TUnidade(TUnidadeProdutoController.getInstancia.BuscaProduto(
            StrToIntDef(edtCodigo.Text, 0)));


          if (vObjUnidade <> nil) then
            CarregaDadosTela
          else
          begin
            TMessageUtil.Alerta(
                'Nenhum cliente encontrado para o c?digo informado.');
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

procedure TfrmUnidadeProdutos.carregaDadosTela;
begin
     if (vObjUnidade = nil) then
        Exit;
        edtCodigo.Text          := IntToStr(vObjUnidade.Id);
        chkAtivo.Checked        := vObjUnidade.Ativo;
        edtUnidade.Text         := vObjUnidade.Unidade;
        edtDescricao.Text       := vObjUnidade.Descricao;
end;

function TfrmUnidadeProdutos.ProcessaExclusao: Boolean;
begin
  try
    Result := False;

     if (vObjUnidade = nil) then

     begin
       TMessageUtil.Alerta(
        'N?o foi possivel carregar todos os dados cadastrados do produto');

       LimpaTela;
       vEstadoTela := etPadrao;
       DefineEstadoTela;
       Exit;
     end;
     try
       if TMessageUtil.Pergunta('Confirma a exclus?o do produto?') then
       begin
          carregaDadosTela;
          Screen.Cursor := crHourGlass;
          TUnidadeProdutoController.getInstancia.ExcluiProduto(vObjUnidade);
          TMessageUtil.Informacao('Produto exluido com sucesso.');
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

function TfrmUnidadeProdutos.ProcessaAlteracao: Boolean;
begin
  try
    Result := False;

    if ProcessaProduto  then
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
        'Falha ao alterar os dados do produto [View]: '#13+
        e.Message);
      end;
  end;
end;
end.
