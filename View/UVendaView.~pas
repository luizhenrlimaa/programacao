unit UVendaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, DBClient, Grids, DBGrids,
  UEnumerationUtil, Buttons, DBTables, UClientesView, UCliente, UPessoaController,
  UVenda_Item , UVenda_ItemController, UVenda_ItemCad, UVenda, UVendaController,
  UVendaCad;

type
  TfrmVenda = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlPrincipal: TPanel;
    lblVenda: TLabel;
    lblData: TLabel;
    lblCliente: TLabel;
    edtVenda: TEdit;
    edtData: TEdit;
    Produtos: TGroupBox;
    dbgVenda: TDBGrid;
    cdsVenda: TClientDataSet;
    dtsVenda: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    lblFinalizar: TLabel;
    edtTotal: TEdit;
    btnConfirmarVenda: TBitBtn;
    btnLimpar: TBitBtn;
    pnlBotoes: TPanel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnConsultar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnSair: TBitBtn;
    edtCodCliente: TEdit;
    btnCancelar: TBitBtn;
    cdsVendaID: TIntegerField;
    cdsVendaDescricao: TStringField;
    cdsVendaQtde: TIntegerField;
    cdsVendaPreco: TFloatField;
    cdsVendaTotal: TFloatField;
    btnIncluirCliente: TSpeedButton;
    edtCliente: TEdit;
    cdsVendaUnidade: TStringField;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodClienteChange(Sender: TObject);
    procedure edtClienteEnter(Sender: TObject);
    procedure edtCodClienteEnter(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClienteClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure dbgVendaKeyPress(Sender: TObject; var Key: Char);
    procedure carregaDadosTela;

    function ProcessaConfirmacao        : Boolean;
    function ProcessaInclusao           : Boolean;
    function ProcessaVenda_Item         : Boolean;
    function ProcessaItem               : Boolean;
    function ProcessaVenda              : Boolean;

    function ProcessaConsultaCliente    : Boolean;
    function CodClienteExit2            : Boolean;
    function CodProdutoExit2            : Boolean;
    procedure btnConfirmarVendaClick(Sender: TObject);

//    procedure edtTotalChange(Sender: TObject);

  private
    { Private declarations }

   vKey           : Word;
   vObjCliente    : TCliente;
   vObjItem_Venda : TVenda_ItemCad;
   vObjVenda      : TVendaCad;
   vObjColVenda   : TColVenda_Item;
   vObjCol        : TColVenda;


//    Variaveis de Classes
   vEstadoTela : TEstadoTela;
//   edCodCliente: TEdit;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimparTela;
   procedure DefineEstadoTela;


  public

  end;

var
  frmVenda: TfrmVenda;

implementation

{$R *.dfm}
Uses
   uMessageUtil, StrUtils, UClientesPesqView, UProdutosPesqView;

procedure TfrmVenda.DefineEstadoTela;
begin
  btnIncluir.Enabled          := (vEstadoTela in [etPadrao]);
  btnAlterar.Enabled          := (vEstadoTela in [etPadrao]);
  btnCancelar.Enabled         := (vEstadoTela in [etPadrao]);
  btnAlterar.Enabled          := (vEstadoTela in [etPadrao]);
  btnConsultar.Enabled        := (vEstadoTela in [etPadrao]);
  btnPesquisar.Enabled        := (vEstadoTela in [etPadrao]);
  btnIncluirCliente.Enabled   := (vEstadoTela in [etPadrao]);

  btnConfirmarVenda.Enabled :=
     vEstadoTela in [etIncluir, etAlterar, etExcluir, etConsultar];
  btnCancelar.Enabled :=
     vEstadoTela in [etIncluir, etAlterar, etExcluir, etConsultar];

 case vEstadoTela of
    etPadrao:
    begin
        CamposEnabled(False);
        LimparTela;
        edtData.Text := DateToStr(Date());
        stbBarraStatus.Panels[0].Text := EmptyStr;
        stbBarraStatus.Panels[1].Text := EmptyStr;
        btnIncluirCliente.Enabled := False;
        dbgVenda.Enabled := False;

        if (frmVenda <> nil) and
            (frmVenda.Active) and
            (btnIncluir.CanFocus) then
             btnIncluir.SetFocus;

       Application.ProcessMessages;
    end;

    etIncluir:
    begin
        stbBarraStatus.Panels[0].Text := 'Inclusão';
        CamposEnabled(True);
        edtVenda.Enabled := False;
        edtData.Enabled  := False;
        edtTotal.Enabled := False;
        btnIncluirCliente.Enabled := True;
        dbgVenda.Enabled := True;
        if edtCodCliente.CanFocus then
           edtCodCliente.SetFocus;
    end;

    etAlterar:
    begin
      stbBarraStatus.Panels[0].Text := 'Alteração';

     if (edtVenda.Text <> EmptyStr) then
     begin
        CamposEnabled(True);

        edtVenda.Enabled      := False;
        btnAlterar.Enabled     := False;
        btnConfirmarVenda.Enabled   := True;
        btnIncluirCliente.Enabled := True;
        dbgVenda.Enabled := True;
     end
     else
     begin

       lblVenda.Enabled := True;
       edtVenda.Enabled := True;


       if(edtVenda.CanFocus) then
          edtVenda.SetFocus;
     end;
    end;

    etExcluir:
    begin
      stbBarraStatus.Panels[0].Text := 'Exclusão';
      if (edtVenda.Text <> EmptyStr) then
//        ProcessaExclusao;
      begin
        lblVenda.Enabled := True;
        edtVenda.Enabled := True;

        if(edtVenda.CanFocus) then
           edtVenda.SetFocus;

      end;
    end;

    etConsultar:
    begin
     stbBarraStatus.Panels[0].Text := 'Consulta';
     CamposEnabled(False);
    

     if (edtVenda.Text <> EmptyStr) then
     begin
       edtVenda.Enabled    := False;
       btnAlterar.Enabled   := True;
       btnCancelar.Enabled   := True;
       btnConfirmarVenda.Enabled := False;
       btnIncluirCliente.Enabled := True;

        if(btnAlterar.CanFocus) then
          btnAlterar.SetFocus;
     end
     else
     begin
       lblVenda.Enabled := True;
       edtVenda.Enabled := True;

       if edtVenda.CanFocus then
          edtVenda.SetFocus;
     end;
    end;
    etPesquisar:
    begin
//       stbBarraStatus.Panels[0].Text := 'Pesquisa';

       if (frmClientesPesq = nil) then
         frmClientesPesq := TfrmClientesPesq.Create(Application);
         frmClientesPesq.ShowModal;

    end;
 end;
end;

procedure TfrmVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   frmVenda := nil;
end;

procedure TfrmVenda.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmVenda.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmVenda.CamposEnabled(pOpcao: Boolean);
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

procedure TfrmVenda.FormShow(Sender: TObject);
begin
   DefineEstadoTela;
//   edtData.Text := DateToStr(Date());
  
//   btnIncluirCliente.Enabled := False;
   if(btnIncluir.CanFocus) then
       btnIncluir.SetFocus;

end;

procedure TfrmVenda.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := VK_CLEAR;
end;

procedure TfrmVenda.btnIncluirClick(Sender: TObject);
begin
   vEstadoTela := etIncluir;
   DefineEstadoTela;
end;

procedure TfrmVenda.btnAlterarClick(Sender: TObject);
begin
   vEstadoTela := etAlterar;
   DefineEstadoTela;
end;

procedure TfrmVenda.btnConsultarClick(Sender: TObject);
begin
   vEstadoTela := etConsultar;
   DefineEstadoTela;
end;

procedure TfrmVenda.btnPesquisarClick(Sender: TObject);
begin
   vEstadoTela := etPesquisar;
   DefineEstadoTela;
end;

procedure TfrmVenda.btnCancelarClick(Sender: TObject);
begin
   vEstadoTela := etPadrao;
   DefineEstadoTela;
   LimparTela;
end;

procedure TfrmVenda.edtCodClienteChange(Sender: TObject);
begin
    if edtCodCliente.Text = '' Then
      edtCliente.Clear;
end;

procedure TfrmVenda.edtClienteEnter(Sender: TObject);
begin
 stbBarraStatus.Panels[1].Text := 'Clique no botão ao lado para incluir um Cliente.';
end;

procedure TfrmVenda.edtCodClienteEnter(Sender: TObject);
begin
 stbBarraStatus.Panels[1].Text := 'Clique no botão ao lado para incluir um Cliente.';
end;

procedure TfrmVenda.edtCodClienteExit(Sender: TObject);
begin
   if vKey = VK_RETURN then
   CodClienteExit2;
   ProcessaConsultaCliente;

   vKey := VK_CLEAR;
end;

function TfrmVenda.CodClienteExit2: Boolean;
begin
   Result := False;
   if edtCodCliente.Enabled then
   begin

      if (edtCodCliente.Text = '')  then
      begin
         begin
             if frmClientesPesq = nil then
                frmClientesPesq := TfrmClientesPesq.Create(Application);
//             pCentralizaFormulario(FFiltroFabr);
                frmClientesPesq.ShowModal;

                if (frmClientesPesq.mClienteID <> 0) then
                begin
                   edtCodCliente.Text     := IntToStr(frmClientesPesq.mClienteID);
                   edtCliente.Text        := frmClientesPesq.mClienteNome;
                   ProcessaConsultaCliente;
                end;

                vKey := 0;
         end;
      end;
      stbBarraStatus.Panels[1].Text := '';
      if (dbgVenda.CanFocus) then
          dbgVenda.SetFocus;
      Result := True;
   end;
end;

procedure TfrmVenda.edtClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
   begin
    if (vKey = VK_F2) And (btnIncluirCliente.Enabled) then
      btnIncluirCliente.Click;
   end;

procedure TfrmVenda.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_F2) and (btnIncluirCliente.Enabled) Then
      btnIncluirCliente.Click;
end;

procedure TfrmVenda.btnIncluirClienteClick(Sender: TObject);
begin
    CodClienteExit2;
end;

function TfrmVenda.ProcessaConsultaCliente: Boolean;
begin
   try
       Result := False;

       if (edtCodCliente.Text = EmptyStr) then
       begin
            TMessageUtil.Alerta('Código do cliente não pode ficar em branco');

            if (edtCodCliente.CanFocus) then
                edtCodCliente.SetFocus;
            Exit;
       end;

       vObjCliente :=
         TCliente(TPessoaController.getInstancia.BuscaPessoa(
            StrToIntDef(edtCodCliente.Text, 0)));

       if (vObjCliente <> nil) then
            CarregaDadosTela
       else
       begin
            TMessageUtil.Alerta(
                'Nenhum cliente encontrado para o código informado.');
            LimparTela;

            if (edtCodCliente.CanFocus) then
                edtCodCliente.SetFocus;

            Exit;
       end;

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

procedure TfrmVenda.btnLimparClick(Sender: TObject);
begin
   LimparTela;
   edtData.Text := DateToStr(Date());
end;

procedure TfrmVenda.LimparTela;
var
i: Integer;
begin
 for i:= 0 to pred(ComponentCount) do
  begin
    if (Components[i] is TEdit) then
       (Components[i] as TEdit).Text := EmptyStr;

  end;

    if(not cdsVenda.IsEmpty) then
       cdsVenda.EmptyDataSet;

    if(vObjCliente <> nil) then
      FreeAndNil(vObjCliente);

   if (edtCodCliente.CanFocus) then
      edtCodCliente.SetFocus ;
end;


function TfrmVenda.CodProdutoExit2: Boolean;
begin
 begin

     if frmProdutosPesq = nil then
      frmProdutosPesq := TfrmProdutosPesq.Create(Application);
  //   pCentralizaFormulario(FFiltroFabr);
      frmProdutosPesq.ShowModal;

     if (frmProdutosPesq.mProdutoID <> 0) then
     begin
        cdsVenda.Insert;
        cdsVendaID.Text            := IntToStr(frmProdutosPesq.mProdutoID);
        cdsVendaDescricao.Text     := frmProdutosPesq.mProdutoDescricao;
        cdsVendaUnidade.Text       := 'UND';
        cdsVendaQtde.Value         := 1;
        cdsVendaPreco.Text         := FloatToStr(frmProdutosPesq.mProdutoPreco);
        cdsVendaTotal.Value        := cdsVendaPreco.Value * cdsVendaQtde.Value;

        cdsVenda.Post;
  //      edtCliente.Text          := frmClientesPesq.mClienteNome;
  //      ProcessaConsulta;

     end;

     vKey := 0;
 
 end;
end;

procedure TfrmVenda.dbgVendaKeyPress(Sender: TObject; var Key: Char);
begin
   if (vKey = 13) and (dbgVenda.SelectedIndex = 0)  then
   begin
      CodProdutoExit2;
   end;


   if (vKey = 13) and (dbgVenda.SelectedIndex = 3) then
   begin
     if (cdsVendaQtde.Value >= 1) then

       cdsVendaTotal.Value  := cdsVendaQtde.Value * cdsVendaPreco.Value

     else
       cdsVendaTotal.Value  := cdsVendaPreco.Value;
   end;


   edtTotal.Text :=  cdsVendaTotal.Text;

   vKey := VK_CLEAR;

end;

procedure TfrmVenda.carregaDadosTela;
var
  i : Integer;

begin
  if (vObjCliente = nil) then
     Exit;

  edtCodCliente.Text          := IntToStr(vObjCliente.Id);
  edtCliente.Text             := vObjCliente.Nome;
end;

procedure TfrmVenda.btnConfirmarVendaClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

function TfrmVenda.ProcessaConfirmacao: Boolean;
begin
 Result := False;

  try
      case vEstadoTela of
          etIncluir:   Result := ProcessaInclusao;
//        etAlterar:   Result := ProcessaAlteracao;
//        etExcluir:   Result := ProcessaExclusao;
//        etConsultar: Result := ProcessaConsulta;
      end;

      if not Result then
        Exit;
  except
      on E: Exception do
      TMessageUtil.Alerta(E.Message);
  end;

   Result := True;
end;

function TfrmVenda.ProcessaInclusao: Boolean;
begin
   try

     Result := False;

     if ProcessaVenda_Item then
     begin
       TMessageUtil.Informacao('Venda realizada com sucesso.'#13+
       'Venda cadastrada: '+ IntToStr(vObjVenda.Id));
       vEstadoTela := etPadrao;
       DefineEstadoTela;
       DefineEstadoTela;


       Result  := True;
     end;
   except
      on E: Exception do
      begin
          Raise Exception.Create(
          'Falha ao realizar a venda [View]: '#13+
          e.Message);
      end;

   end;
end;

function TfrmVenda.ProcessaVenda_Item: Boolean;
begin
   try
       Result := False;
     if(ProcessaItem) then
      begin
//           Gravação no BD
          TVenda_ItemController.getInstancia.GravaVenda_Item(vObjItem_Venda, vObjColVenda);

         
      end;

      if(ProcessaVenda) then
      begin
//           Gravação no BD
          TVendaController.getInstancia.GravaVenda(vObjVenda, vObjCol);

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

function TfrmVenda.ProcessaItem: Boolean;
begin
   try
       Result := False;

//     if not ValidaCliente then
//            Exit;
     if (vObjColVenda <> nil) then
        FreeAndNil(vObjColVenda);

      vObjColVenda := TColVenda_Item.Create;

      if vEstadoTela = etIncluir then
      begin
        if vObjItem_Venda = nil then
           vObjItem_Venda := TVenda_ItemCad.Create;
      end;

      if (vObjItem_Venda = nil) then
         Exit;

       
        vObjItem_Venda.Id_Produto                   := cdsVendaID.Value;
        vObjItem_Venda.Quantidade                   := cdsVendaQtde.Value;
        vObjItem_Venda.UnidadeSaida                 := cdsVendaUnidade.Value;
        vObjItem_Venda.ValorUnitario                := cdsVendaPreco.Value;
        vObjItem_Venda.TotalItem                    := cdsVendaTotal.Value;


       Result := True;
   except
       on E : Exception do
       begin
          Raise Exception.Create(
          'Falha ao processar os dados da Venda [View]'#13+
          e.Message);
       end;

   end;
end;

function TfrmVenda.ProcessaVenda: Boolean;
begin
   try
       Result := False;

//     if not ValidaCliente then
//            Exit;
     if (vObjCol <> nil) then
        FreeAndNil(vObjCol);

      vObjCol := TColVenda.Create;

      if vEstadoTela = etIncluir then
      begin
        if vObjVenda = nil then
           vObjVenda := TVendaCad.Create;
      end;

      if (vObjVenda = nil) then
         Exit;

        vObjVenda.Id_Cliente                   := StrToInt(edtCodCliente.Text);
        vObjVenda.DataVenda                    := edtData.Text;
        vObjVenda.TotalVenda                   := StrToFloat(edtTotal.Text);

       Result := True;
   except
       on E : Exception do
       begin
          Raise Exception.Create(
          'Falha ao processar os dados da Venda [View]'#13+
          e.Message);
       end;

   end;

end;

end.




