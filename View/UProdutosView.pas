unit UProdutosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, UEnumerationUtil, UProdutoCad,
  UProduto, UProdutoController, UClassFuncoes;

type
  TfrmProduto = class(TForm)
    pnlPrincipal: TPanel;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblEstoque: TLabel;
    lblPreco: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtPreco: TEdit;
    edtEstoque: TEdit;
    stbBarraStatus: TStatusBar;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  

  private
    { Private declarations }
    
     vKey : Word;
  // Variaveis de Classes
   vEstadoTela : TEstadoTela;
   vObjProdutoCad : TProdutoCad;
   vObjColProduto : TColProduto;


   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;


   procedure carregaDadosTela;

   function ProcessaConfirmacao : Boolean;
   function ProcessaAlteracao   : Boolean;
   function ProcessaConsulta    : Boolean;
   function ProcessaExclusao    : Boolean;
   function ProcessaInclusao    : Boolean;
   function ProcessaProduto     : Boolean;

   function ProcessaProdutoCad    : Boolean;


   function ValidaProdutoCad      : Boolean;
 

  public

  end;

var
  frmProdutos: TfrmProduto;

implementation

{$R *.dfm}
Uses
  uMessageUtil, StrUtils;


procedure TfrmProduto.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmProduto.DefineEstadoTela;
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
       

        if edtDescricao.CanFocus then
           edtDescricao.SetFocus;
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
//    etPesquisar:
//     begin
//       stbBarraStatus.Panels[0].Text := 'Pesquisa';
//
//       if (frmUnidadeProdutoPesq = nil) then
//           frmUnidadeProdutoPesq := TfrmUnidadeProdutoPesq.Create(Application);
//
//       frmUnidadeProdutoPesq.ShowModal;
//
//       if (frmUnidadeProdutoPesq.mUnidadeProdutoID <> 0) then
//       begin
//          edtCodigo.Text := IntToStr(frmUnidadeProdutoPesq.mUnidadeProdutoID);
//          vEstadoTela    := etConsultar;
//          ProcessaConsulta;
//       end
//       else
//       begin
//          vEstadoTela := etPadrao;
//          DefineEstadoTela;
//       end;
//
//       frmUnidadeProdutoPesq.mUnidadeProdutoID := 0;
//       frmUnidadeProdutoPesq.mUnidadeProdutoDescricao := EmptyStr;
//
//       if edtUnidade.CanFocus then
//          edtUnidade.SetFocus;
//
//     end;
   end;
end;

procedure TfrmProduto.FormKeyDown(Sender: TObject; var Key: Word;
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



procedure TfrmProduto.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
   Action := caFree;
   frmProdutos := nil;
end;

procedure TfrmProduto.CamposEnabled(pOpcao: Boolean);
var
  i : Integer; // Variaável para auxiliar o comando de repetição
begin
   for i := 0 to pred(ComponentCount) do
   begin
      // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Enabled := pOpcao;
   end;
end;

procedure TfrmProduto.LimpaTela;
var
  i: Integer;
begin
   for i:= 0 to pred(ComponentCount)do
  begin
       // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Text := EmptyStr;
  end;
end;

procedure TfrmProduto.FormShow(Sender: TObject);
begin
   DefineEstadoTela;
end;

procedure TfrmProduto.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := VK_CLEAR;
end;

procedure TfrmProduto.btnIncluirClick(Sender: TObject);
begin
   vEstadoTela := etIncluir;
   DefineEstadoTela;
end;

procedure TfrmProduto.btnAlterarClick(Sender: TObject);
begin
   vEstadoTela := etAlterar;
   DefineEstadoTela;
end;

procedure TfrmProduto.btnExcluirClick(Sender: TObject);
begin
   vEstadoTela := etExcluir;
   DefineEstadoTela;
end;

procedure TfrmProduto.btnConsultarClick(Sender: TObject);
begin
   vEstadoTela := etConsultar;
   DefineEstadoTela;
end;

procedure TfrmProduto.btnPesquisarClick(Sender: TObject);
begin
   vEstadoTela := etPesquisar;
   DefineEstadoTela;
end;

procedure TfrmProduto.btnCancelarClick(Sender: TObject);
begin
   vEstadoTela := etPadrao;
   DefineEstadoTela;
end;

procedure TfrmProduto.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

function TfrmProduto.ProcessaConfirmacao: Boolean;
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

function TfrmProduto.ProcessaInclusao: Boolean;
begin
   try

     Result := False;

     if ProcessaProduto then
     begin
       TMessageUtil.Informacao('Produto cadastrado com sucesso.'#13+
       'Código cadastrado: '+ IntToStr(vObjProdutoCad.Id));
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

function TfrmProduto.ProcessaAlteracao: Boolean;
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

function TfrmProduto.ProcessaConsulta: Boolean;
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

      vObjProdutoCad :=
         TProdutoCad(TProdutoController.getInstancia.BuscaProduto(
            StrToIntDef(edtCodigo.Text, 0)));


          if (vObjProdutoCad <> nil) then
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

procedure TfrmProduto.edtCodigoExit(Sender: TObject);
begin
   if vKey = VK_RETURN then
   ProcessaConsulta;

   vKey := VK_CLEAR;
end;

function TfrmProduto.ProcessaExclusao: Boolean;
begin
   try
    Result := False;

     if (vObjProdutoCad = nil) then

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
          TProdutoController.getInstancia.ExcluiProduto(vObjProdutoCad);
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

function TfrmProduto.ProcessaProduto: Boolean;
begin
   try
       Result := False;
     if(ProcessaProdutoCad) then
      begin
          // Gravação no BD
          TProdutoController.getInstancia.GravaProduto(
                                      vObjProdutoCad, vObjColProduto);

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

function TfrmProduto.ProcessaProdutoCad: Boolean;
begin
   try
       Result := False;

     if not ValidaProdutoCad then
            Exit;
     if (vObjColProduto <> nil) then
        FreeAndNil(vObjColProduto);

      vObjColProduto := TColProduto.Create;
      if vEstadoTela = etIncluir then
      begin
        if vObjProdutoCad = nil then
           vObjProdutoCad := TProdutoCad.Create;
      end
      else
      if  vEstadoTela = etAlterar then
      begin
         if vObjProdutoCad = nil then
            Exit;
      end;

      if (vObjProdutoCad = nil) then
         Exit;

        vObjProdutoCad.Descricao                    := edtDescricao.Text;
        vObjProdutoCad.Estoque                      := StrToInt(edtEstoque.Text);
        vObjProdutoCad.PrecoVenda                   := StrToFloat(edtPreco.Text);

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

procedure TfrmProduto.carregaDadosTela;
begin
   if (vObjProdutoCad = nil) then
        Exit;
        edtDescricao.Text       := vObjProdutoCad.Descricao;
        edtEstoque.Text         := IntToStr(vObjProdutoCad.Estoque);
        edtPreco.Text           := FloatToStr(vObjProdutoCad.PrecoVenda);
end;

function TfrmProduto.ValidaProdutoCad: Boolean;
begin
 Result := False;

   if (edtDescricao.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Descrição não pode ficar em branco.');

     if edtDescricao.CanFocus  then
        edtDescricao.SetFocus;

     Exit;

   end;

   if (edtEstoque.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Estoque não pode ficar em branco.');

     if edtEstoque.CanFocus  then
        edtEstoque.SetFocus;

     Exit;
   end;

   if (edtPreco.Text = EmptyStr)  then
   begin
     TMessageUtil.Alerta('Preço de Venda não pode ficar em branco.');

     if edtPreco.CanFocus  then
        edtPreco.SetFocus;

     Exit;
   end;

   Result := True;
end;

end.
