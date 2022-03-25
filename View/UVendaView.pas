unit UVendaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, DBClient, Grids, DBGrids,
  UEnumerationUtil, Buttons;

type
  TfrmVenda = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlPrincipal: TPanel;
    lblVenda: TLabel;
    lblData: TLabel;
    lblCliente: TLabel;
    edtVenda: TEdit;
    edtData: TEdit;
    edtCliente: TEdit;
    btnIncluirCliente: TBitBtn;
    Produtos: TGroupBox;
    DBGrid1: TDBGrid;
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
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSair: TBitBtn;
    edtCodCliente: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarVendaClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);

  private
    { Private declarations }

   vKey : Word;

//    Variaveis de Classes
   vEstadoTela : TEstadoTela;

   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;


  public
    { Public declarations }
  end;

var
  frmVenda: TfrmVenda;

implementation

{$R *.dfm}
Uses
   uMessageUtil, StrUtils;

procedure TfrmVenda.DefineEstadoTela;
begin
  btnIncluir.Enabled          := (vEstadoTela in [etPadrao]);
  btnAlterar.Enabled          := (vEstadoTela in [etPadrao]);
//  btnCancelarVenda.Enabled    := (vEstadoTela in [etPadrao]);
  btnAlterar.Enabled          := (vEstadoTela in [etPadrao]);
  btnConsultar.Enabled        := (vEstadoTela in [etPadrao]);
  btnPesquisar.Enabled        := (vEstadoTela in [etPadrao]);

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

        if (frmVenda <> nil) and
            (frmVenda.Active) and
            (btnIncluir.CanFocus) then
            btnIncluir.SetFocus;

       Application.ProcessMessages;
    end;

    etIncluir:
    begin
        stbBarraStatus.Panels[0].Text := 'Inclus�o';
        CamposEnabled(True);
        edtVenda.Enabled := False;

        if edtCodCliente.CanFocus then
           edtCodCliente.SetFocus;
    end;

    etAlterar:
    begin
      stbBarraStatus.Panels[0].Text := 'Altera��o';

     if (edtVenda.Text <> EmptyStr) then
     begin
        CamposEnabled(True);

        edtVenda.Enabled      := False;
        btnAlterar.Enabled     := False;
        btnConfirmar.Enabled   := True;

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
      stbBarraStatus.Panels[0].Text := 'Exclus�o';
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
       btnConfirmar.Enabled := False;

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
//    etPesquisar:
//    begin
//       stbBarraStatus.Panels[0].Text := 'Pesquisa';
//
//       if (frmProdutosPesq = nil) then
//           frmProdutosPesq := TfrmProdutosPesq.Create(Application);
//
//       frmProdutosPesq.ShowModal;
//
//       if (frmProdutosPesq.mProdutoID <> 0) then
//       begin
//          edtVenda.Text := IntToStr(frmProdutosPesq.mProdutoID);
//          vEstadoTela    := etConsultar;
//          ProcessaConsulta;
//       end
//       else
//       begin
//          vEstadoTela := etPadrao;
//          DefineEstadoTela;
//       end;
//
//       frmProdutosPesq.mProdutoID := 0;
//       frmProdutosPesq.mProdutoDescricao := EmptyStr;
//
//       if edtDescricao.CanFocus then
//          edtDescricao.SetFocus;
//
//    end;
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

procedure TfrmVenda.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmVenda.CamposEnabled(pOpcao: Boolean);
var
  i : Integer; // Varia�vel para auxiliar o comando de repeti��o
begin
   for i := 0 to pred(ComponentCount) do
   begin
      // Se o compo for do tipo EDIT
      if (Components[i] is TEdit)  then
      (Components[i] as TEdit).Enabled := pOpcao;
   end;
end;

procedure TfrmVenda.LimpaTela;
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

procedure TfrmVenda.FormShow(Sender: TObject);
begin
   DefineEstadoTela;
   edtData.Text := DateToStr(Date());
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

procedure TfrmVenda.btnCancelarVendaClick(Sender: TObject);
begin
   vEstadoTela := etExcluir;
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
end;
end.