unit UUnidadeProdutoPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, uMessageUtil,
  UUnidadeProduto, UUnidadeProdutoController, UClassFuncoes,OleServer, DB, DBClient;

type
  TfrmUnidadeProdutoPesq = class(TForm)
    grbFiltrar: TGroupBox;
    lblNome: TLabel;
    lblInfo: TLabel;
    edtNome: TEdit;
    btnFiltrar: TBitBtn;
    grbGrid: TGroupBox;
    dbgProduto: TDBGrid;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    stbBarraStatus: TStatusBar;
    cdsProduto: TClientDataSet;
    dtsProduto: TDataSource;
    cdsProdutoID: TIntegerField;
    cdsProdutoAtivo: TIntegerField;
    cdsProdutoUnidade: TStringField;
    cdsProdutoDescricao: TStringField;
    cdsProdutoDescricaoAtivo: TStringField;
    procedure btnSairClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsProdutoBeforeDelete(DataSet: TDataSet);
    procedure dbgProdutoDblClick(Sender: TObject);
  private
    { Private declarations }
     vKey : Word;


     procedure LimparTela;
     procedure ProcessaPesquisa;
     procedure ProcessaConfirmacao;

     
  public
    { Public declarations }
    mUnidadeProdutoID   : Integer;
    mUnidadeProdutoDescricao : string;
    mProdutoUnidade : string;
  end;

var
  frmUnidadeProdutoPesq: TfrmUnidadeProdutoPesq;

implementation

uses Math, StrUtils, ComObj;

{$R *.dfm}

procedure TfrmUnidadeProdutoPesq.btnSairClick(Sender: TObject);
begin
     LimparTela;
     Close;
end;

procedure TfrmUnidadeProdutoPesq.LimparTela;
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

procedure TfrmUnidadeProdutoPesq.btnLimparClick(Sender: TObject);
begin
    mUnidadeProdutoID        := 0;
    mUnidadeProdutoDescricao := EmptyStr;
    mProdutoUnidade   := EmptyStr;
    LimparTela;
end;

procedure TfrmUnidadeProdutoPesq.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmUnidadeProdutoPesq.ProcessaPesquisa;
var
  xListaProduto : TColUnidadeProduto;
  xAux          : Integer;
begin
 begin
    try
        try
          xListaProduto := TColUnidadeProduto.Create;
          xListaProduto :=
              TUnidadeProdutoController.getInstancia.PesquisaProduto(Trim(edtNome.Text));

          cdsProduto.EmptyDataSet;

          if xListaProduto <> nil then
          begin
            for xAux := 0 to pred(xListaProduto.Count) do
            begin
               cdsProduto.Append;
               cdsProdutoID.Value             := xListaProduto.Retorna(xAux).Id;
               cdsProdutoUnidade.Value        := xListaProduto.Retorna(xAux).Unidade;
               cdsProdutoDescricao.Value      := xListaProduto.Retorna(xAux).Descricao;
               cdsProdutoAtivo.Value          :=
                      Ifthen(xListaProduto.Retorna(xAux).Ativo, 1, 0);
               cdsProdutoDescricaoAtivo.Value :=
                      IfThen(xListaProduto.Retorna(xAux).Ativo,  'Sim', 'Não');
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

procedure TfrmUnidadeProdutoPesq.ProcessaConfirmacao;
begin
begin
   if not (cdsProduto.IsEmpty) then
   begin
      mUnidadeProdutoID            := cdsProdutoID.Value;
      mUnidadeProdutoDescricao     := cdsProdutoDescricao.Value;
      mProdutoUnidade       := cdsProdutoUnidade.Value;
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

procedure TfrmUnidadeProdutoPesq.btnFiltrarClick(Sender: TObject);
begin
    mUnidadeProdutoID        := 0;
    mUnidadeProdutoDescricao := EmptyStr;
    mProdutoUnidade   := EmptyStr;
    ProcessaPesquisa;
end;

procedure TfrmUnidadeProdutoPesq.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmUnidadeProdutoPesq.cdsProdutoBeforeDelete(DataSet: TDataSet);
begin
    Abort;
end;

procedure TfrmUnidadeProdutoPesq.dbgProdutoDblClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

end.
