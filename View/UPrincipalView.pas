unit UPrincipalView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, ExtCtrls, jpeg, pngimage ;

type
  TfrmPrincipal = class(TForm)  // Nome da Classe
    { Lista de componentes visuais que s�o adicionados no pr�totiopo da tela
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

    // M�todos do formul�rio
    procedure menSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menClientesClick(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  UConexao , UClientesView;

{$R *.dfm}



procedure TfrmPrincipal.menSairClick(Sender: TObject);
begin
   Close; //Fecha a aplica��o
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


end.
