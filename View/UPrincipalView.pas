unit UPrincipalView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, ExtCtrls, jpeg, pngimage, UVendaPesqView ;

type
  TfrmPrincipal = class(TForm)  // Nome da Classe
    { Lista de componentes visuais que são adicionados no prótotiopo da tela
      * Importante renomear TODOS os componentes adicionados
    }
    menMenu: TMainMenu;
    menCadastros: TMenuItem;
    menClientes: TMenuItem;
    menProdutos: TMenuItem;
    menRelatorios: TMenuItem;
    menRelVendas: TMenuItem;
    menMovimentos: TMenuItem;
    menVendas: TMenuItem;
    menSair: TMenuItem;
    imgLogo: TImage;
    stbBarraStatus: TStatusBar;
    mainUtilitarios: TMenuItem;
    menGenesis: TMenuItem;
    menApocalipse: TMenuItem;
    P1: TMenuItem;
    U1: TMenuItem;

    // Métodos do formulário
    procedure menSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menClientesClick(Sender: TObject);
    procedure menGenesisClick(Sender: TObject);
    procedure menApocalipseClick(Sender: TObject);
    procedure U1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure menVendasClick(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  UConexao , UClientesView , UGenesisView, UApocalipseView, UUnidadeProdutosView,
  UProdutosView, UVendaView;

{$R *.dfm}



procedure TfrmPrincipal.menSairClick(Sender: TObject);
begin
   Close; //Fecha a aplicação
end;


procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  stbBarraStatus.Panels[0].Text :=
  ':Caminho do BD: '+ TConexao.get.getCaminhoBanco;


end;

procedure TfrmPrincipal.menClientesClick(Sender: TObject);
begin
   try
       Screen.Cursor := crHourGlass;

       if frmClientes  = nil then
          frmClientes := TfrmClientes.Create(Application);

       frmClientes.Show;
   finally
        Screen.Cursor := crDefault;
   end;
end;


procedure TfrmPrincipal.menGenesisClick(Sender: TObject);
begin
  try
       Screen.Cursor := crHourGlass;

       if frmGenesis  = nil then
          frmGenesis := TfrmGenesis.Create(Application);

       frmGenesis.Show;
   finally
        Screen.Cursor := crDefault;
   end;
end;

procedure TfrmPrincipal.menApocalipseClick(Sender: TObject);
begin
   try
       Screen.Cursor := crHourGlass;

       if frmApocalipse  = nil then
          frmApocalipse := TfrmApocalipse.Create(Application);

       frmApocalipse.Show;
   finally
        Screen.Cursor := crDefault;
   end;
end;

procedure TfrmPrincipal.U1Click(Sender: TObject);
begin
   try
       Screen.Cursor := crHourGlass;

       if frmUnidadeProdutos  = nil then
          frmUnidadeProdutos := TfrmUnidadeProdutos.Create(Application);

       frmUnidadeProdutos.Show;
   finally
        Screen.Cursor := crDefault;
   end;
end;

procedure TfrmPrincipal.P1Click(Sender: TObject);
begin
   try
       Screen.Cursor := crHourGlass;

       if frmProdutos  = nil then
          frmProdutos := TfrmProduto.Create(Application);

       frmProdutos.Show;
   finally
        Screen.Cursor := crDefault;
   end;
end;

procedure TfrmPrincipal.menVendasClick(Sender: TObject);
begin
  try
       Screen.Cursor := crHourGlass;

       if frmVenda  = nil then
          frmVenda := TfrmVenda.Create(Application);

       frmVenda.Show;
  finally
        Screen.Cursor := crDefault;
  end;
end;
end.
