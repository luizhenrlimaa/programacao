unit UVendaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, DBClient, Grids, DBGrids,
  UEnumerationUtil, Buttons, DBTables, UClientesView, UCliente,
  UPessoaController, UProduto, UVendaCad, UVenda_Item, UVendaController,
  UProdutoController;

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
    cdsVendaID_Venda: TIntegerField;

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
    procedure btnConfirmarVendaClick(Sender: TObject);
    procedure dbgVendaKeyDown(Sender: TObject; var vKey: Word;
      Shift: TShiftState);
    procedure edtVendaExit(Sender: TObject);
    procedure dbgVendaTitleClick(Column: TColumn);
    procedure dbgVendaCellClick(Column: TColumn);


  private

//    Variaveis de Classes
   vEstadoTela    : TEstadoTela;
   vKey           : Word;
   vObjCliente    : TCliente;
   vObjProduto    : TProduto;
   vObjVenda      : TVendaCad;
   vObjColVenda   : TColVenda_Item;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimparTela;
   procedure DefineEstadoTela;

   procedure carregaDadosTela;
   procedure carregaDadosCliente;
   procedure carregaDadosProduto;
   procedure carregaValorTotal;

   function ProcessaConfirmacao        : Boolean;
   function ProcessaAlteracao          : Boolean;
   function ProcessaInclusao           : Boolean;
   function ProcessaConsulta           : Boolean;
   function ProcessaVenda_Item         : Boolean;
   function ProcessaItem               : Boolean;
   function ProcessaVenda              : Boolean;

   function ProcessaConsultaCliente    : Boolean;
   function CodClienteExit2            : Boolean;
   function ProcessaConsultaProduto    : Boolean;
   function CodProdutoExit2            : Boolean;

  public
  end;

var
  frmVenda: TfrmVenda;


implementation

{$R *.dfm}
Uses
   uMessageUtil, StrUtils, UClientesPesqView, UProdutosPesqView,
   UVendaPesqView;

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
       btnLimpar.Enabled     := False;

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
       btnLimpar.Enabled  := True;
       if edtCodCliente.CanFocus then
           edtCodCliente.SetFocus;
    end;

    etAlterar:
    begin
      stbBarraStatus.Panels[0].Text := 'Alteração';

     if (edtVenda.Text <> EmptyStr) then
     begin
        CamposEnabled(True);

        edtVenda.Enabled          := False;
        btnAlterar.Enabled        := False;
        btnConfirmarVenda.Enabled := True;
        btnIncluirCliente.Enabled := True;
        dbgVenda.Enabled          := True;
        edtData.Enabled           := False;
        edtTotal.Enabled          := False;
        edtCodCliente.Enabled     := False;
        edtCliente.Enabled        := False;
     end
     else
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
       btnLimpar.Enabled     := False;
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
       stbBarraStatus.Panels[0].Text := 'Pesquisa';

       if (frmVendaPesq = nil) then
           frmVendaPesq := TfrmVendaPesq.Create(Application);

       frmVendaPesq.ShowModal;

       if (frmVendaPesq.mVendaID <> 0) then
       begin
          edtVenda.Text := IntToStr(frmVendaPesq.mVendaID);
          vEstadoTela    := etConsultar;
          ProcessaConsulta;
       end
       else
       begin
          vEstadoTela := etPadrao;
          DefineEstadoTela;
       end;

       frmVendaPesq.mVendaID            := 0;
       frmVendaPesq.mVendaCliente       := EmptyStr;
       frmVendaPesq.mVendaData          := EmptyStr;
       frmVendaPesq.mVendaTotal         := 0;
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
   edtData.Text := DateToStr(Date());
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
   edtData.Text := DateToStr(Date());
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
            carregaDadosCliente
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

   if(vObjColVenda <> nil) then
      FreeAndNil(vObjColVenda);

   if(vObjVenda <> nil) then
      FreeAndNil(vObjVenda);

end;

function TfrmVenda.CodProdutoExit2: Boolean;
begin
 begin

     // Abrir formulário de produto ao pressionar enter no código no Grid
     if (vKey = 13) and (dbgVenda.SelectedIndex = 0)  then
     begin
        if frmProdutosPesq = nil then
        frmProdutosPesq := TfrmProdutosPesq.Create(Application);
        frmProdutosPesq.ShowModal;
     end;

     if (frmProdutosPesq.mProdutoID <> 0) then
     begin
        cdsVenda.Insert;

        cdsVendaID.Text            := IntToStr(frmProdutosPesq.mProdutoID);
        cdsVendaDescricao.Text     := frmProdutosPesq.mProdutoDescricao;
        cdsVendaUnidade.Text       := 'UN';
        cdsVendaQtde.Value         := 1;
        cdsVendaPreco.Text         := FloatToStr(frmProdutosPesq.mProdutoPreco);
        cdsVendaTotal.Value        := cdsVendaPreco.Value * cdsVendaQtde.Value;

        cdsVenda.Post;

     end;

     carregaValorTotal;
     
     Result := True;
 end;
end;

procedure TfrmVenda.dbgVendaKeyPress(Sender: TObject; var Key: Char);
begin

// Chamando função  CodProdutoExit2  ao pressionar enter no código no Grid de Venda
   if (vKey = 13) and (dbgVenda.SelectedIndex = 0)  then
   begin
      CodProdutoExit2;
   end;

// Alterando a quantidade no Grid de Venda


   if (vKey = 13) and (dbgVenda.SelectedIndex = 3)  then
   begin
      cdsVenda.First;
      while not cdsVenda.Eof do
      if (cdsVendaQtde.Value >= 1) then
         begin
            cdsVenda.Edit;
            cdsVendaTotal.Value  := cdsVendaQtde.Value * cdsVendaPreco.Value;
            cdsVenda.Next;
            carregaValorTotal;
         end
      else
         cdsVendaTotal.Value  := cdsVendaPreco.Value;
         cdsVenda.Next;
         carregaValorTotal;
   end;
end;

procedure TfrmVenda.carregaDadosTela;
var
  i : Integer;
begin
   // Carregando dados do cabecalho referente a Venda e ao Cliente
   if (vObjVenda <> nil) then

      edtCodCliente.Text :=   IntToStr(vObjVenda.Id_Cliente);
      edtVenda.Text      :=   IntToStr(vObjVenda.Id);
      edtData.Text       :=   DateToStr(vObjVenda.DataVenda);
      edtTotal.Text      :=   FormatFloat('##0.00',vObjVenda.TotalVenda);

      ProcessaConsultaCliente;

  // Carregando dados do Grid referende ao produto 
   if (vObjColVenda <> nil) then
      begin
         cdsVenda.First;
         for  i:= 0 to pred(vObjColVenda.Count) do
         begin
            cdsVenda.Edit;

            cdsVendaID_Venda.Value :=  vObjColVenda.Retorna(i).Id;
            cdsVendaID.Value       :=  vObjColVenda.Retorna(i).Id_Produto;
            cdsVendaUnidade.Text   :=  vObjColVenda.Retorna(i).UnidadeSaida;
            cdsVendaQtde.Text      :=  FloatToStr(vObjColVenda.Retorna(i).Quantidade);
            cdsVendaPreco.Value    :=  vObjColVenda.Retorna(i).ValorUnitario;
            cdsVendaTotal.Value    :=  cdsVendaPreco.Value * cdsVendaQtde.Value;
            ProcessaConsultaProduto;

            cdsVenda.Append;
         end;
      end;
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
         etAlterar:   Result := ProcessaAlteracao;
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

     if(ProcessaVenda) and
        (ProcessaItem) then
      begin
//           Gravação no BD
         TVendaController.getInstancia.GravaVenda(vObjVenda, vObjColVenda);

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

function TfrmVenda.ProcessaVenda: Boolean;
begin
   try
       Result := False;

      if vEstadoTela = etIncluir then
      begin
         if vObjVenda = nil then
         vObjVenda := TVendaCad.Create;
      end
      else
      if  vEstadoTela = etAlterar then
      begin
         if (vObjVenda = nil) then
            Exit;
      end;

      if (vObjVenda = nil) then
         Exit;

      vObjVenda.Id_Cliente                   := StrToInt(edtCodCliente.Text);
      vObjVenda.DataVenda                    := StrToDate(edtData.Text);
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

function TfrmVenda.ProcessaItem: Boolean;
var
   xVenda_Item : TVenda_Item;
   xID_Item : Integer;
begin
   try
       xID_Item := 0;


     if (vObjColVenda <> nil) then

        FreeAndNil(vObjColVenda);

       vObjColVenda := TColVenda_Item.Create;

      if vEstadoTela = etIncluir then
      begin

         cdsVenda.First;
         while not cdsVenda.Eof Do
         begin
            xVenda_Item                   := TVenda_Item.Create;

            xVenda_Item.Id                := cdsVendaID_Venda.Value;
            xVenda_Item.Id_Venda          := xID_Item;
            xVenda_Item.Id_Produto        := cdsVendaID.Value;
            xVenda_Item.Quantidade        := cdsVendaQtde.Value;
            xVenda_Item.UnidadeSaida      := cdsVendaUnidade.Value;
            xVenda_Item.ValorUnitario     := cdsVendaPreco.Value;
            xVenda_Item.TotalItem         := cdsVendaTotal.Value;
            vObjColVenda.Add(xVenda_Item);
          
            cdsVenda.Next;
         end;
      end;

      if vEstadoTela = etAlterar then
      begin

         xID_Item := StrToIntDef(edtVenda.Text , 0);

         cdsVenda.First;

         while not cdsVenda.Eof Do

         begin

            xVenda_Item                 := TVenda_Item.Create;
            xVenda_Item.Id_Venda        := xID_Item;
            cdsVenda.Edit;
            xVenda_Item.Id              := cdsVendaID_Venda.Value;
            xVenda_Item.Id_Produto      := cdsVendaID.Value;
            xVenda_Item.Quantidade      := cdsVendaQtde.Value;
            xVenda_Item.UnidadeSaida    := cdsVendaUnidade.Value;
            xVenda_Item.ValorUnitario   := cdsVendaPreco.Value;
            xVenda_Item.TotalItem       := cdsVendaTotal.Value;

            if (xVenda_Item.Id = 0) then
                begin
                 vObjColVenda.Add(xVenda_Item);
                end;

            cdsVenda.Next;
         end;
      end;

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

procedure TfrmVenda.dbgVendaKeyDown(Sender: TObject; var vKey: Word;
  Shift: TShiftState);
begin
   if vKey = VK_DELETE then
   begin
      if MessageDlg('Deseja excluir esse item?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
//         while not cdsVenda.Eof do
//         for vI:= 0 to cdsVenda.RecordCount - 1 do
         begin
//            cdsVenda.Edit;
            cdsVenda.Delete;
            carregaValorTotal;
//            cdsVenda.Append;
         end;
      end;
   end;
end;

procedure TfrmVenda.carregaDadosCliente;
begin
   if (vObjCliente = nil) then
     Exit;

   edtCodCliente.Text          := IntToStr(vObjCliente.Id);
   edtCliente.Text             := vObjCliente.Nome;
end;

function TfrmVenda.ProcessaConsulta: Boolean;
begin
   try
      Result := False;

       if (edtVenda.Text = EmptyStr) then
       begin
            TMessageUtil.Alerta('Código da venda não pode ficar em branco');

            if (btnConfirmarVenda.CanFocus) then
                btnConfirmarVenda.SetFocus;

            Exit;
       end;

      vObjVenda :=
       TVendaCad(TVendaController.getInstancia.BuscaVenda(
            StrToIntDef(edtVenda.Text, 0)));


      vObjColVenda :=
        TVendaController.getInstancia.BuscaVenda_Item(
              StrToIntDef(edtVenda.Text, 0));


       if (vObjVenda <> nil)  then
          CarregaDadosTela
       else
       begin
          TMessageUtil.Alerta(
            'Nenhuma venda encontrado para o código informado.');
          LimparTela;

          if (edtVenda.CanFocus) then
            edtVenda.SetFocus;

         Exit;
       end;
          DefineEstadoTela;
          Result := True;
   except
      on E:Exception do
      begin
         Raise Exception.Create(
         'Falha ao consultar os dados da Venda [View]: '#13+
         e.Message);
      end;
   end;
end;

procedure TfrmVenda.edtVendaExit(Sender: TObject);
begin
   if vKey = VK_RETURN then
   ProcessaConsulta;

   vKey := VK_CLEAR;
end;

function TfrmVenda.ProcessaAlteracao: Boolean;
begin
   try
      Result := False;

      if ProcessaVenda_Item  then
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

function TfrmVenda.ProcessaConsultaProduto: Boolean;
begin
   try
      Result := False;

      vObjProduto :=
         TProduto(TProdutoController.getInstancia.BuscaProduto(
            StrToIntDef(IntToStr(cdsVendaID.Value) , 0)));

      if (vObjProduto <> nil) then
         carregaDadosProduto
      else
      begin
         TMessageUtil.Alerta(
         'Nenhum produto encontrado para o código informado.');
         LimparTela;
      end;

   except
      on E:Exception do
      begin
         Raise Exception.Create(
         'Falha ao consultar os dados do produto [View]: '#13+
         e.Message);
      end;
   end;
end;

procedure TfrmVenda.carregaDadosProduto;
begin
   if (vObjProduto = nil) then
     Exit;

   cdsVendaDescricao.Text     := vObjProduto.Descricao;
end;

procedure TfrmVenda.dbgVendaTitleClick(Column: TColumn);
begin
   cdsVenda.IndexFieldNames := Column.FieldName;
end;

procedure TfrmVenda.dbgVendaCellClick(Column: TColumn);
begin
   dbgVenda.ReadOnly := False;
   if dbgVenda.SelectedIndex = 3 then
      begin
         dbgVenda.Options := dbgVenda.Options + [dgEditing]
      end
   else
      dbgVenda.Options := dbgVenda.Options - [dgEditing];
end;

procedure TfrmVenda.carregaValorTotal;
var
  vValor : Real;
begin
   try
//  Calculando valor total da Venda
      vValor := 0;
      cdsVenda.First;
      while not cdsVenda.Eof Do
      begin
         cdsVenda.Edit;
         vValor := vValor + cdsVenda.FieldByName('Total').AsFloat;
         cdsVenda.Next;
      end;
      edtTotal.Text := FormatFloat('##0.00',vValor);

   except
      on E:Exception do
      begin
         Raise Exception.Create(
         'Falha ao calcular o valor total geral [View]: '#13+
         e.Message);
      end;
   end;


end;

end.




