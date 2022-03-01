unit UProdutosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask, UEnumerationUtil,
  DB;

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

  private
       { Private declarations }
    vKey : Word;
   // Variaveis de Classes
   vEstadoTela : TEstadoTela;


   procedure CamposEnabled(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;

  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}
Uses
  uMessageUtil, StrUtils, UClassFuncoes, UClientesView;


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
//        ProcessaExclusao;
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
//   ProcessaConsulta;

   vKey := VK_CLEAR;
end;

end.
