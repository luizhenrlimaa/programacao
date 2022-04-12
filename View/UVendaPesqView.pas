unit UVendaPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  uMessageUtil, UVenda , UVendaController, UClassFuncoes,OleServer, UCliente,
  UPessoaController;

type
  TfrmVendaPesq = class(TForm)
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    grbGrid: TGroupBox;
    grbFiltrar: TGroupBox;
    lblNome: TLabel;
    lblInfo: TLabel;
    edtNome: TEdit;
    btnFiltrar: TBitBtn;
    dbgVenda: TDBGrid;
    dtsVenda: TDataSource;
    cdsVenda: TClientDataSet;
    cdsVendaID: TIntegerField;
    cdsVendaData: TDateField;
    cdsVendaTotal: TFloatField;
    cdsVendaCliente: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure dbgVendaDblClick(Sender: TObject);
    procedure dbgVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgVendaTitleClick(Column: TColumn);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cdsVendaBeforeDelete(DataSet: TDataSet);

  private

    vKey : Word;
    vObjCliente    : TCliente;


    procedure LimparTela;
    procedure ProcessaPesquisa;
    procedure ProcessaConfirmacao;

    procedure carregaDadosCliente;

    function ProcessaConsultaCliente    : Boolean;

  public
    { Public declarations }

    mVendaID               : Integer;
    mVendaCliente          : string;
    mVendaData             : string;
    mVendaTotal            : Double;

  end;
var
  frmVendaPesq: TfrmVendaPesq;

implementation

uses Math, StrUtils, ComObj;

{$R *.dfm}

procedure TfrmVendaPesq.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
vKey := Key;

   case vKey of
      VK_RETURN:
      begin
        Perform(WM_NEXTDLGCTL, 0, 0);
      end;

      VK_ESCAPE:
      begin
        if TMessageUtil.Pergunta('Deseja sair da rotina?')then
           Close;
      end;

      VK_UP:
      begin
        vKey :=  VK_CLEAR;

        if (ActiveControl = dbgVenda ) then
        Exit;

        Perform(WM_NEXTDLGCTL, 1, 0);
      end;
   end;
end;

procedure TfrmVendaPesq.btnSairClick(Sender: TObject);
begin
     LimparTela;
     Close;
end;

procedure TfrmVendaPesq.btnLimparClick(Sender: TObject);
begin
   LimparTela;
end;

procedure TfrmVendaPesq.dbgVendaDblClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmVendaPesq.dbgVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (vKey = VK_RETURN) and
     (btnConfirmar.CanFocus) then
      btnConfirmar.SetFocus;
end;

procedure TfrmVendaPesq.dbgVendaTitleClick(Column: TColumn);
begin
   cdsVenda.IndexFieldNames := Column.FieldName;
end;

procedure TfrmVendaPesq.LimparTela;
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

  if (edtNome.CanFocus) then
      edtNome.SetFocus ;

end;

procedure TfrmVendaPesq.ProcessaConfirmacao;
begin
   if not (cdsVenda.IsEmpty) then
   begin
      mVendaID         := cdsVendaID.Value;
      mVendaCliente    := cdsVendaCliente.Text;
      mVendaData       := cdsVendaData.Text;
      mVendaTotal      := cdsVendaTotal.Value;

      Self.ModalResult      := mrOk;
      LimparTela;
      Close;
   end
   else
   begin
        TMessageUtil.Alerta('Nenhuma venda selecionada.');

       if (edtNome.CanFocus) then
           edtNome.SetFocus;
   end;
end;

procedure TfrmVendaPesq.btnConfirmarClick(Sender: TObject);
begin

   mVendaID                := 0;
   mVendaCliente           := EmptyStr;
   mVendaData              := EmptyStr;
   mVendaTotal             := 0;
   ProcessaConfirmacao;
end;

procedure TfrmVendaPesq.btnFiltrarClick(Sender: TObject);
begin
    mVendaID                := 0;
    mVendaCliente           := EmptyStr;
    mVendaData              := EmptyStr;
    mVendaTotal             := 0;

    ProcessaPesquisa;
end;

procedure TfrmVendaPesq.ProcessaPesquisa;
var
  xListaVenda   : TColVenda;
  xAux          : Integer;

begin
    try
        try
          xListaVenda := TColVenda.Create;
          xListaVenda :=
              TVendaController.getInstancia.PesquisaVenda(Trim(edtNome.Text));

          cdsVenda.EmptyDataSet;


          if xListaVenda <> nil then
          begin
            for xAux := 0 to pred(xListaVenda.Count) do
            begin
               cdsVenda.Append;

               cdsVendaID.Value             := xListaVenda.Retorna(xAux).Id;
               cdsVendaCliente.Value        := IntToStr(xListaVenda.Retorna(xAux).Id_Cliente);
               cdsVendaData.Value           := xListaVenda.Retorna(xAux).DataVenda;
               cdsVendaTotal.Value          :=  xListaVenda.Retorna(xAux).TotalVenda;
               ProcessaConsultaCliente;

               cdsVenda.Post;
             end;
          end;

          if (cdsVenda.RecordCount = 0) then
          begin
           TMessageUtil.Alerta('Nenhuma venda encontrada para este filtro.');
           if edtNome.CanFocus then
              edtNome.SetFocus;
          end
          else
          begin
            cdsVenda.First;
            if dbgVenda.CanFocus then
               dbgVenda.SetFocus;
          end;
        finally
          if (xListaVenda <> nil) then
             FreeAndNil(xListaVenda);
        end;
    except
        on E:Exception do
      begin
        Raise Exception.Create(
        'Falha ao pesquisar os dados do produto [View]: '#13+
        e.Message);
      end;

    end;

end;

procedure TfrmVendaPesq.cdsVendaBeforeDelete(DataSet: TDataSet);
begin
   Abort;
end;

procedure TfrmVendaPesq.carregaDadosCliente;
begin
   if (vObjCliente = nil) then
     Exit;

   cdsVendaCliente.Text := vObjCliente.Nome;

end;

function TfrmVendaPesq.ProcessaConsultaCliente: Boolean;
begin
   try
       Result := False;


       vObjCliente :=
         TCliente(TPessoaController.getInstancia.BuscaPessoa(
              StrToIntDef(cdsVendaCliente.Text, 0)));

       if (vObjCliente <> nil) then
            carregaDadosCliente
       else
       begin
            TMessageUtil.Alerta(
                'Nenhuma venda encontrada para o código informado.');
            LimparTela;

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

end.
