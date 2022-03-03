unit UProdutoPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
