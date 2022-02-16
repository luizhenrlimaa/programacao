unit UApocalipseView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, UMessageUtil, UPessoa, UConexao, SqlExpr;

type
  TfrmApocalipse = class(TForm)
    grbErros: TGroupBox;
    btnAccessViolation: TButton;
    btnListIndex: TButton;
    btnConversaoInteiro: TButton;
    grbAuxiliares: TGroupBox;
    cmbItens: TComboBox;
    grbBDouSQL: TGroupBox;
    btnConexaoBD: TButton;
    btnFaltaCampoSQL: TButton;
    btnTabelaSQL: TButton;
    btnParametroSQL: TButton;
    procedure btnAccessViolationClick(Sender: TObject);
    procedure btnListIndexClick(Sender: TObject);
    procedure btnConversaoInteiroClick(Sender: TObject);
    procedure btnFaltaCampoSQLClick(Sender: TObject);
    procedure btnTabelaSQLClick(Sender: TObject);
    procedure btnParametroSQLClick(Sender: TObject);
    procedure btnConexaoBDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmApocalipse: TfrmApocalipse;

implementation

{$R *.dfm}

procedure TfrmApocalipse.btnAccessViolationClick(Sender: TObject);
var
   xObjPessoa: TPessoa; // Declara a variável da classe desejada
   xMensagem : String;
begin
   try
      // Define um padrão para o objeto e variáveis
      xObjPessoa := nil;
      try
         // Instancia o objeto para poder acessar suas propriedades
         // xObjPessoa := TPessoa.Create;

         // Valida se o ojeto está criado ou se não ocorreu erro em sua criação
         // evitando erro Access Violation
         // if (xObjPessoa <> nil) then
         begin
            xObjPessoa.Id                  := 1;
            xObjPessoa.Nome                := 'Adão';
            xObjPessoa.Fisica_Juridica     := 0;
            xObjPessoa.IdentificadorPessoa := '000.000.000-01';
            xObjPessoa.Ativo               := False;
         end;

         {
          ############ Como evitar o erro Access Violation ###################
          O objeto em questão sempre deve ser:
          - Iniciado com o valor nil
          - Criado antes de acessar seus atributos
          - Validado se está <> de nil antes de acessar seus atributos
         }
      except
         on E: Exception do
         begin
            // Caso ocorra algum erro no processo, será apresentado uma exceção
            // com as informações do erro em questão
            Raise Exception.Create(
               'Falha ao carregar os dados do objeto Pessoa: '#13+
               'EXCEÇÃO DO ACCESS VIOLATION'#13+
               e.Message);
         end;
      end;
   finally
      // Sempre que terminar de usar um objeto, é preciso liberar o espaço na
      // memória, ou seja, destruir o objeto, para isso utilizamos o comando:
      if (xObjPessoa <> nil) then
         FreeAndNil(xObjPessoa);
      // Muito cuidado ao destruir um objeto, caso ele for utilizado fora do
      // método, ao tentar acessar suas propriedades ocorrerá erro
      // Access Violation
   end;
end;

procedure TfrmApocalipse.btnListIndexClick(Sender: TObject);
var
   i,
   xInteiro : Integer;
   xString  : String;
begin
   xString := cmbItens.Items.ValueFromIndex[4];

   xString := xString;
end;

procedure TfrmApocalipse.btnConversaoInteiroClick(Sender: TObject);
var
   xInteiro : Integer;
   xString  : String;
begin
   xInteiro := 0;
   xString  := '';

   // Erro ocorre quando tentamos converter uma String que está vazia para um
   // Inteiro.
   xInteiro := StrToInt(xString);

   // Uma forma de validar e eviar que esse ocorrá, seria verificar se o valor
   // está em branco/vazio antes de converter.
   // Exemplo:
   if (xString <> EmptyStr) then
   begin
      // Só executa a conversão se xString estiver preenchido
      xInteiro := StrToInt(xString);
   end;

   // Outra forma de fazer isso, seria:
   xInteiro := StrToIntDef(xString, 0);
   // Ao utilizar o comando StrToIntDef caso ocorra algum erro na conversão o
   // sistema vai preencher com um valor DEFAULT (Def) que no caso acima foi
   // informado o valor 0;
end;

procedure TfrmApocalipse.btnFaltaCampoSQLClick(Sender: TObject);
var
   xQryPessoa : TSQLQuery;
begin
   xQryPessoa := TSQLQuery.Create(nil);
   xQryPessoa.SQLConnection := TConexao.getInstance.getConn;

   xQryPessoa.Close;
   xQryPessoa.SQL.Clear;
   xQryPessoa.SQL.Text :=
      'SELECT CAMPO_QUE_NAO_EXISTE '#13+
      '  FROM PESSOA               '#13;
   xQryPessoa.Open;
end;

procedure TfrmApocalipse.btnTabelaSQLClick(Sender: TObject);
var
   xQryPessoa : TSQLQuery;
begin
   xQryPessoa := TSQLQuery.Create(nil);
   xQryPessoa.SQLConnection := TConexao.getInstance.getConn;

   xQryPessoa.Close;
   xQryPessoa.SQL.Clear;
   xQryPessoa.SQL.Text :=
      'SELECT *                '#13+
      '  FROM TABELA_INCORRETA '#13;
   xQryPessoa.Open;
end;

procedure TfrmApocalipse.btnParametroSQLClick(Sender: TObject);
var
   xQryPessoa : TSQLQuery;
begin
   xQryPessoa := TSQLQuery.Create(nil);
   xQryPessoa.SQLConnection := TConexao.getInstance.getConn;

   xQryPessoa.Close;
   xQryPessoa.SQL.Clear;
   xQryPessoa.SQL.Text :=
      'SELECT *      '#13+
      '  FROM PESSOA '#13;
   xQryPessoa.ParamByName('PARAMETRO_INCORRETO').AsString := '00001';
   xQryPessoa.Open;
end;

procedure TfrmApocalipse.btnConexaoBDClick(Sender: TObject);
var
   xQryPessoa : TSQLQuery;
begin
   xQryPessoa := TSQLQuery.Create(nil);
   // Sem conexão com o BD ou conexão incorreta
//   xQryPessoa.SQLConnection := TConexao.getInstance.getConn;

   xQryPessoa.Close;
   xQryPessoa.SQL.Clear;
   xQryPessoa.SQL.Text :=
      'SELECT *      '#13+
      '  FROM PESSOA '#13;
   xQryPessoa.Open;
end;

end.
