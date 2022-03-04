unit UProdutoPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, uMessageUtil,
  UProduto, UProdutoController, UClassFuncoes,OleServer;

type
  TfrmProdutoPesq = class(TForm)
    grbFiltrar: TGroupBox;
    lblNome: TLabel;
    lblInfo: TLabel;
    edtNome: TEdit;
    btnFiltrar: TBitBtn;
    grbGrid: TGroupBox;
    dbgCliente: TDBGrid;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    stbBarraStatus: TStatusBar;
    procedure btnSairClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
     vKey : Word;
     procedure LimparTela;
  public
    { Public declarations }
  end;

var
  frmProdutoPesq: TfrmProdutoPesq;

implementation

uses Math, StrUtils, ComObj;

{$R *.dfm}

procedure TfrmProdutoPesq.btnSairClick(Sender: TObject);
begin
     LimparTela;
     Close;
end;

procedure TfrmProdutoPesq.LimparTela;
var
    i: Integer;
begin
 for i:= 0 to pred(ComponentCount) do
  begin
    if (Components[i] is TEdit) then
       (Components[i] as TEdit).Text := EmptyStr;
  end;

//   if(not cdsCliente.IsEmpty) then
//   cdsCliente.EmptyDataSet;

  if (edtNome.CanFocus) then
      edtNome.SetFocus ;
end;

procedure TfrmProdutoPesq.btnLimparClick(Sender: TObject);
begin
   LimparTela;
end;

procedure TfrmProdutoPesq.FormKeyDown(Sender: TObject; var Key: Word;
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

//        if (ActiveControl = dbgCliente ) then
//        Exit;

        Perform(WM_NEXTDLGCTL, 1, 0);
      end;
   end;
end;

end.
