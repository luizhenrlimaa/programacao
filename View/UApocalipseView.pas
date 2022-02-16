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
   xObjPessoa: TPessoa; // Declara a vari�vel da classe desejada
   xMensagem : String;
begin
   try
      // Define um padr�o para o objeto e vari�veis
      xObjPessoa := nil;
      try
         // Instancia o objeto para poder acessar suas propriedades
         // xObjPessoa := TPessoa.Create;

         // Valida se o ojeto est� criado ou se n�o ocorreu erro em sua cria��o
         // evitando erro Access Violation
         // if (xObjPessoa <> nil) then
         begin
            xObjPessoa.Id                  := 1;
            xObjPessoa.Nome                := 'Ad�o';
            xObjPessoa.Fisica_Juridica     := 0;
            xObjPessoa.IdentificadorPessoa := '000.000.000-01';
            xObjPessoa.Ativo               := False;
         end;

         {
          ############ Como evitar o erro Access Violation ###################
          O objeto em quest�o sempre deve ser:
          - Iniciado com o valor nil
          - Criado antes de acessar seus atributos
          - Validado se est� <> de nil antes de acessar seus atributos
         }
      except
         on E: Exception do
         begin
            // Caso ocorra algum erro no processo, ser� apresentado uma exce��o
            // com as informa��es do erro em quest�o
            Raise Exception.Create(
               'Falha ao carregar os dados do objeto Pessoa: '#13+
               'EXCE��O DO ACCESS VIOLATION'#13+
               e.Message);
         end;
      end;
   finally
      // Sempre que terminar de usar um objeto, � preciso liberar o espa�o na
      // mem�ria, ou seja, destruir o objeto, para isso utilizamos o comando:
      if (xObjPessoa <> nil) then
         FreeAndNil(xObjPessoa);
      // Muito cuidado ao destruir um objeto, caso ele for utilizado fora do
      // m�todo, ao tentar acessar suas propriedades ocorrer� erro
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

   // Erro ocorre quando tentamos converter uma String que est� vazia para um
   // Inteiro.
   xInteiro := StrToInt(xString);

   // Uma forma de validar e eviar que esse ocorr�, seria verificar se o valor
   // est� em branco/vazio antes de converter.
   // Exemplo:
   if (xString <> EmptyStr) then
   begin
      // S� executa a convers�o se xString estiver preenchido
      xInteiro := StrToInt(xString);
   end;

   // Outra forma de fazer isso, seria:
   xInteiro := StrToIntDef(xString, 0);
   // Ao utilizar o comando StrToIntDef caso ocorra algum erro na convers�o o
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
   // Sem conex�o com o BD ou conex�o incorreta
//   xQryPessoa.SQLConnection := TConexao.getInstance.getConn;

   xQryPessoa.Close;
   xQryPessoa.SQL.Clear;
   xQryPessoa.SQL.Text :=
      'SELECT *      '#13+
      '  FROM PESSOA '#13;
   xQryPessoa.Open;
end;

end.
