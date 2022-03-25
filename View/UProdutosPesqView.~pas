unit UProdutosPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, uMessageUtil,
  UProduto, UProdutoController, UClassFuncoes,OleServer, DB, DBClient;

type
  TfrmProdutosPesq = class(TForm)
    grbFiltrar: TGroupBox;
    lblNome: TLabel;
    lblInfo: TLabel;
    edtNome: TEdit;
    btnFiltrar: TBitBtn;
    grbGrid: TGroupBox;
    Panel1: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    StatusBar1: TStatusBar;
    dbgProduto: TDBGrid;
    cdsProduto: TClientDataSet;
    dtsProduto: TDataSource;
    cdsProdutoID: TIntegerField;
    cdsProdutoDescricao: TStringField;
    cdsProdutoEstoque: TIntegerField;
    cdsProdutoPrecoVenda: TFloatField;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgProdutoDblClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cdsProdutoBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
     vKey : Word;


     procedure LimparTela;
     procedure ProcessaPesquisa;
     procedure ProcessaConfirmacao;


  public
    { Public declarations }

    mProdutoID               : Integer;
    mProdutoDescricao        : string;
    mProdutoEstoque          : Integer;
    mProdutoPreco            : Double;

  end;

var
  frmProdutosPesq: TfrmProdutosPesq;

implementation

{$R *.dfm}

procedure TfrmProdutosPesq.FormKeyDown(Sender: TObject; var Key: Word;
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

        if (ActiveControl = dbgProduto ) then
        Exit;

        Perform(WM_NEXTDLGCTL, 1, 0);
      end;
   end;
end;

procedure TfrmProdutosPesq.dbgProdutoDblClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmProdutosPesq.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;


procedure TfrmProdutosPesq.btnSairClick(Sender: TObject);
begin
   LimparTela;
   Close;
end;

procedure TfrmProdutosPesq.btnLimparClick(Sender: TObject);
begin
    mProdutoID        := 0;
    mProdutoDescricao := EmptyStr;
    mProdutoEstoque   := 0;
    mProdutoPreco     := 0;
    LimparTela;
end;

procedure TfrmProdutosPesq.LimparTela;
var
    i: Integer;
begin
 for i:= 0 to pred(ComponentCount) do
  begin
    if (Components[i] is TEdit) then
       (Components[i] as TEdit).Text := EmptyStr;
  end;

   if(not cdsProduto.IsEmpty) then
       cdsProduto.EmptyDataSet;

   if (edtNome.CanFocus) then
      edtNome.SetFocus ;
end;

procedure TfrmProdutosPesq.ProcessaConfirmacao;
begin
begin
   if not (cdsProduto.IsEmpty) then
   begin
      mProdutoID            := cdsProdutoID.Value;
      mProdutoDescricao     := cdsProdutoDescricao.Value;
      mProdutoEstoque       := cdsProdutoEstoque.Value;
      mProdutoPreco         := cdsProdutoPrecoVenda.Value;

      Self.ModalResult      := mrOk;
      LimparTela;
      Close;
   end
   else
   begin
        TMessageUtil.Alerta('Nenhum produto selecionado.');

       if (edtNome.CanFocus) then
           edtNome.SetFocus;
   end;
end;
end;


procedure TfrmProdutosPesq.ProcessaPesquisa;
var
  xListaProduto : TColProduto;
  xAux          : Integer;

begin
 begin
    try
        try
          xListaProduto := TColProduto.Create;
          xListaProduto :=
              TProdutoController.getInstancia.PesquisaProduto(Trim(edtNome.Text));

          cdsProduto.EmptyDataSet;


          if xListaProduto <> nil then
          begin
            for xAux := 0 to pred(xListaProduto.Count) do
            begin
               cdsProduto.Append;
               cdsProdutoID.Value             := xListaProduto.Retorna(xAux).Id;
               cdsProdutoDescricao.Value      := xListaProduto.Retorna(xAux).Descricao;
               cdsProdutoEstoque.Value        := xListaProduto.Retorna(xAux).Estoque;
               cdsProdutoPrecoVenda.Value     := xListaProduto.Retorna(xAux).PrecoVenda;
               cdsProduto.Post;
             end;
          end;

          if (cdsProduto.RecordCount = 0) then
          begin
           TMessageUtil.Alerta('Nenhum produto encontrado para este filtro.');
           if edtNome.CanFocus then
              edtNome.SetFocus;
          end
          else
          begin
            cdsProduto.First;
            if dbgProduto.CanFocus then
               dbgProduto.SetFocus;
          end;
        finally
          if (xListaProduto <> nil) then
             FreeAndNil(xListaProduto);
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
end;
procedure TfrmProdutosPesq.btnFiltrarClick(Sender: TObject);
begin
    mProdutoID        := 0;
    mProdutoDescricao := EmptyStr;
    mProdutoEstoque   := 0;
    mProdutoPreco     := 0;
    ProcessaPesquisa;
end;

procedure TfrmProdutosPesq.cdsProdutoBeforeDelete(DataSet: TDataSet);
begin
   Abort;
end;

end.
