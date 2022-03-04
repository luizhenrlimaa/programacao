unit UProdutosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask, UEnumerationUtil,
  UUnidade, UProduto, UProdutoController;

type
  TfrmProdutos = class(TForm)
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
   vObjColProduto : TColProduto;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;

     // Carrega dados padrão na tela

   procedure carregaDadosTela;


   function ProcessaConfirmacao : Boolean;
   function ProcessaAlteracao   : Boolean;
   function ProcessaConsulta    : Boolean;
   function ProcessaExclusao    : Boolean;
   function ProcessaInclusao    : Boolean;
   function ProcessaProduto     : Boolean; //ProcessaCliente


   function ProcessaUnidade     : Boolean; //ProcessaPessoa

   
   function ValidaUnidade       : Boolean;

  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}
Uses
  uMessageUtil, StrUtils, UClassFuncoes, UClientesView, UProdutoPesqView;


procedure TfrmProdutos.btnSairClick(Sender: TObject);
begin
    if (vEstadoTela <> etPadrao) then
    begin
       if (TMessageUtil.Pergunta('Deseja realmente abortar esta operação?'))then
       begin
         vEstadoTela := etPadrao;
         DefineEstadoTela;
       end;
    end
    else
      Close;
end;

procedure TfrmProdutos.CamposEnabled(pOpcao: Boolean);
var
  i : Integer; // Variaável para auxiliar o comando de repetição
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
procedure TfrmProdutos.DefineEstadoTela;
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

        if (frmProdutos <> nil) and
            (frmProdutos.Active) and
            (btnIncluir.CanFocus) then
            btnIncluir.SetFocus;

       Application.ProcessMessages;
    end;

    etIncluir:
    begin
      stbBarraStatus.Panels[0].Text := 'Inclusão';
      CamposEnabled(True);
      edtCodigo.Enabled := False;
      chkAtivo.Checked := True;

      if edtUnidade.CanFocus then
         edtUnidade.SetFocus;
    end;

    etAlterar:
    begin
      stbBarraStatus.Panels[0].Text := 'Alteração';

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
      stbBarraStatus.Panels[0].Text := 'Exclusão';
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

       if (frmProdutoPesq = nil) then
           frmProdutoPesq := TfrmProdutoPesq.Create(Application);

       frmProdutoPesq.ShowModal;

       if (frmProdutoPesq.mProdutoID <> 0) then
       begin
          edtCodigo.Text := IntToStr(frmProdutoPesq.mProdutoID);
          vEstadoTela    := etConsultar;
          ProcessaConsulta;
       end
       else
       begin
          vEstadoTela := etPadrao;
          DefineEstadoTela;
       end;

       frmProdutoPesq.mProdutoID := 0;
       frmProdutoPesq.mProdutoDescricao := EmptyStr;

       if edtUnidade.CanFocus then
          edtUnidade.SetFocus;

     end;
  end;



  end;


procedure TfrmProdutos.btnIncluirClick(Sender: TObject);
begin
      vEstadoTela := etIncluir;
      DefineEstadoTela;
end;

procedure TfrmProdutos.btnAlterarClick(Sender: TObject);
begin
      vEstadoTela := etAlterar;
      DefineEstadoTela;
end;

procedure TfrmProdutos.btnExcluirClick(Sender: TObject);
begin
      vEstadoTela := etExcluir;
      DefineEstadoTela;
end;

procedure TfrmProdutos.btnConsultarClick(Sender: TObject);
begin
      vEstadoTela := etConsultar;
      DefineEstadoTela;
end;

procedure TfrmProdutos.btnPesquisarClick(Sender: TObject);
begin
      vEstadoTela := etPesquisar;
      DefineEstadoTela;
end;

procedure TfrmProdutos.btnCancelarClick(Sender: TObject);
begin
      vEstadoTela := etPadrao;
      DefineEstadoTela;
end;

procedure TfrmProdutos.LimpaTela;
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
      // Então , define seu padrão desmarcado
      (Components[i] as TCheckBox).Checked := False;
  end;
    if(vObjUnidade <> nil) then
   FreeAndNil(vObjUnidade);
   if(vObjColProduto <> nil) then
   FreeAndNil(vObjColProduto);
end;


procedure TfrmProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   frmProdutos := nil;
end;

procedure TfrmProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := Key;

   case vKey of
      VK_RETURN: // Correspondente a tecla <enter>
      begin
        //Comando responsável para passar para o próximo campo do formulário
        Perform(WM_NextDlgCtl, 0, 0);
      end;

      VK_ESCAPE:  // Correpodente a tecla <esc>
      begin
        if (vEstadoTela <> etPadrao) then
        begin
          if (TMessageUtil.Pergunta('Deseja realmente abortar esta operação?'))then
          begin
            vEstadoTela := etPadrao;
            DefineEstadoTela;
           end;
        end
        else
        begin
          if (TMessageUtil.Pergunta(
             'Deseja sair da rotina?'))then
             Close; // Fechar o formulário
        end;
      end;
   end;
end;

procedure TfrmProdutos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     vKey := VK_CLEAR;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
   vEstadoTela := etPadrao;
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
    DefineEstadoTela;
end;

procedure TfrmProdutos.edtCodigoExit(Sender: TObject);
begin
  if vKey = VK_RETURN then
   ProcessaConsulta;

   vKey := VK_CLEAR;
end;

procedure TfrmProdutos.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

function TfrmProdutos.ProcessaConfirmacao: Boolean;
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

function TfrmProdutos.ProcessaInclusao: Boolean;
begin
   try

     Result := False;

     if ProcessaProduto then
     begin
       TMessageUtil.Informacao('Produto cadastrado com sucesso.'#13+
       'Código cadastrado: '+ IntToStr(vObjUnidade.Id));
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

function TfrmProdutos.ProcessaProduto: Boolean;
begin
  try
       Result := False;
     if(ProcessaUnidade) then
      begin
          // Gravação no BD
          TProdutoController.getInstancia.GravaProduto(
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

function TfrmProdutos.ProcessaUnidade: Boolean;
begin
  try
       Result := False;

     if not ValidaUnidade then
            Exit;
     if (vObjColProduto <> nil) then
        FreeAndNil(vObjColProduto);

      vObjColProduto := TColProduto.Create;
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

function TfrmProdutos.ValidaUnidade: Boolean;
begin
   Result := False;

   if (edtUnidade.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Unidade não pode ficar em branco.');

     if edtUnidade.CanFocus  then
        edtUnidade.SetFocus;

     Exit;

   end;

   if (edtDescricao.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Descrição não pode ficar em branco.');

     if edtDescricao.CanFocus  then
        edtDescricao.SetFocus;

     Exit;
   end;

   Result := True;
end;

function TfrmProdutos.ProcessaConsulta: Boolean;
begin
   try
       Result := False;

       if (edtCodigo.Text = EmptyStr) then
       begin
            TMessageUtil.Alerta('Código do produto não pode ficar em branco');

            if (edtCodigo.CanFocus) then
                edtCodigo.SetFocus;

            Exit;
       end;

      vObjUnidade :=
         TUnidade(TProdutoController.getInstancia.BuscaProduto(
            StrToIntDef(edtCodigo.Text, 0)));


          if (vObjUnidade <> nil) then
            CarregaDadosTela
          else
          begin
            TMessageUtil.Alerta(
                'Nenhum cliente encontrado para o código informado.');
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

procedure TfrmProdutos.carregaDadosTela;
//var
//  i : Integer;
   begin
     if (vObjUnidade = nil) then
        Exit;
        edtCodigo.Text          := IntToStr(vObjUnidade.Id);
        chkAtivo.Checked        := vObjUnidade.Ativo;
        edtUnidade.Text         := vObjUnidade.Unidade;
        edtDescricao.Text       := vObjUnidade.Descricao;
   end;

function TfrmProdutos.ProcessaExclusao: Boolean;
begin
  try
    Result := False;

     if (vObjUnidade = nil) then

     begin
       TMessageUtil.Alerta(
        'Não foi possivel carregar todos os dados cadastrados do produto');

       LimpaTela;
       vEstadoTela := etPadrao;
       DefineEstadoTela;
       Exit;
     end;
     try
       if TMessageUtil.Pergunta('Confirma a exclusão do produto?') then
       begin
          carregaDadosTela;
          Screen.Cursor := crHourGlass;
          TProdutoController.getInstancia.ExcluiProduto(vObjUnidade);
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

function TfrmProdutos.ProcessaAlteracao: Boolean;

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
