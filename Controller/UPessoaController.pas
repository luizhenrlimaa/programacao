unit UPessoaController;

interface

uses SysUtils, Math, StrUtils, UConexao, UPessoa, UEndereco, UVenda;

type
  TPessoaController = class
      public
        constructor Create;
        function GravaPessoa(
                      pPessoa : TPessoa;
                      pColEndereco : TColEndereco) : Boolean;
        function ExcluiPessoa(
                      pPessoa : TPessoa) : Boolean;

        function BuscaPessoa(pID : Integer) : TPessoa;
        function PesquisaPessoa(pNome : string) : TColPessoa;
        function BuscaEnderecoPessoa (pID_Pessoa : Integer) : TColEndereco;
        function BuscaPessoaCliente  (pID_Cliente: Integer) : TColPessoa;
        function RetornaCondicaoPessoa(
                   pID_Pessoa: Integer;
                   pRelacionada : Boolean = False) : String;
        function RetornaCondicaoCliente(
                   pID_Cliente: Integer;
                   pRelacionada : Boolean = False) : String;

      published
        class function getInstancia : TPessoaController;
  end;



implementation

uses UPessoaDAO , UEnderecoDAO , UVendaDAO;

var
  _instance: TPessoaController;

{ TPessoaController }

function TPessoaController.BuscaEnderecoPessoa(
  pID_Pessoa: Integer): TColEndereco;
var
  xEnderecoDAO : TEnderecoDAO;
begin
  try
    try
       Result := nil;

       xEnderecoDAO :=
            TEnderecoDAO.Create(TConexao.getInstance.getConn);

       Result :=
            xEnderecoDAO.RetornaLista(RetornaCondicaoPessoa(pID_Pessoa, True));

    finally
      if(xEnderecoDAO <> nil) then
       FreeAndNil(xEnderecoDAO);


    end;
  except
    on E : Exception do
    begin
      Raise Exception.Create(
        'Falha ao retornar dados do endereço da pessoa [Controller]'#13+
        e.Message);
    end;
  end;

end;

function TPessoaController.BuscaPessoa(pID: Integer): TPessoa;
var
  XPessoaDAO : TPessoaDAO;
begin
  try
    try
       Result := nil;

       xPessoaDAO := TPessoaDAO.Create(TConexao.getInstance.getConn);
       Result := XPessoaDAO.Retorna(RetornaCondicaoPessoa(pID));

    finally
      if(xPessoaDAO <> nil) then
       FreeAndNil(XPessoaDAO);


    end;
  except
        on E : Exception do
        begin
          Raise Exception.Create(
            'Falha ao buscar os dados da pessoa. [Controller]'#13+
            e.Message);
        end;
  end;
end;

function TPessoaController.BuscaPessoaCliente(
  pID_Cliente: Integer): TColPessoa;
var
  XVendaDAO : TVendaDAO;
begin
  try
    try
       Result := nil;

       XVendaDAO :=
            TVendaDAO.Create(TConexao.getInstance.getConn);

       Result :=
            XVendaDAO.RetornaLista(RetornaCondicaoCliente(pID_Cliente, True));

    finally
      if(XVendaDAO <> nil) then
       FreeAndNil(XVendaDAO);


    end;
  except
    on E : Exception do
    begin
      Raise Exception.Create(
        'Falha ao retornar dados do endereço da pessoa [Controller]'#13+
        e.Message);
    end;
  end;

end;

constructor TPessoaController.Create;
begin
   inherited Create;
end;

function TPessoaController.ExcluiPessoa(pPessoa: TPessoa): Boolean;
var
  XPessoaDAO   : TPessoaDAO;
  XEnderecoDAO : TEnderecoDAO;
begin
  try
    try
       Result := False;

       TConexao.get.iniciaTransacao;

       XPessoaDAO := TPessoaDAO.Create(TConexao.get.getConn);

       XEnderecoDAO := TEnderecoDAO.Create(TConexao.get.getConn);

       if(pPessoa.Id =0) then
            Exit
       else
       begin
         XPessoaDAO.Deleta(RetornaCondicaoPessoa(pPessoa.Id));

         XEnderecoDAO.Deleta(RetornaCondicaoPessoa(pPessoa.Id, True));

       end;

       TConexao.get.confirmaTransacao;

       Result := True;

    finally
      if (XPessoaDAO <> nil) then
          FreeAndNil(XPessoaDAO);

      if (XEnderecoDAO <> nil) then
          FreeAndNil(XEnderecoDAO);
    end;
  except
    on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
         'Falha ao excluir os dados da pessoa [Controller]. '#13+
          e.Message);
      end;
  end;
end;

class function TPessoaController.getInstancia: TPessoaController;
begin
   if _instance = nil then
      _instance := TPessoaController.Create;

   Result := _instance;
end;

function TPessoaController.GravaPessoa(
           pPessoa : TPessoa;
                      pColEndereco : TColEndereco) : Boolean;
var
   xPessoaDAO   : TPessoaDAO;
   xEnderecoDAO : TEnderecoDAO;
   xAux         : Integer;
begin
     try
        try
            TConexao.get.iniciaTransacao;

            Result := False;

            xPessoaDAO   :=
              TPessoaDAO.Create(TConexao.get.getConn);

            xEnderecoDAO :=
              TEnderecoDAO.Create(TConexao.get.getConn);

            if pPessoa.Id = 0 then
            begin
               xPessoaDAO.Insere(pPessoa);

              for xAux := 0 to pred(pColEndereco.Count) do
                pColEndereco.Retorna(xAux).ID_pessoa := pPessoa.Id;


               xEnderecoDAO.InsereLista(pColEndereco)
            end
            else
            begin
               xPessoaDAO.Atualiza(pPessoa, RetornaCondicaoPessoa(pPessoa.Id));
               xEnderecoDAO.Deleta(RetornaCondicaoPessoa(pPessoa.Id, True));
               xEnderecoDAO.InsereLista(pColEndereco);
            end;

            TConexao.get.confirmaTransacao;
        finally
             if (xPessoaDAO <> nil) then
             FreeAndNil(xPessoaDAO);
        end;
     except
        on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao gravar os dados da pessoa [Controller]. '#13+
            e.Message);
        end;
    end;
end;

function TPessoaController.PesquisaPessoa(pNome: string): TColPessoa;
var
  xPessoaDAO  : TPessoaDAO;
  xCondicao   : string;
begin
   try
      try

        Result := nil;
        xPessoaDAO := TPessoaDAO.Create(TConexao.get.getConn);

        xCondicao :=  IfThen(pNome <> EmptyStr,
                  'WHERE                                   '#13+
                  '    (NOME LIKE UPPER(''%'+ pNome +'%''))'#13+
                  'ORDER BY NOME, ID', EmptyStr);

        Result := xPessoaDAO.RetornaLista(xCondicao);
        
      finally
          if (xPessoaDAO <> nil) then
          FreeAndNil(xPessoaDAO);

      end;
   except
     on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao buscar os dados da pessoa [Controller]. '#13+
            e.Message);
        end;
   end;

end;

function TPessoaController.RetornaCondicaoCliente(pID_Cliente: Integer;
  pRelacionada: Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID_Cliente'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                                 '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID_Cliente))+ ' '#13;
end;


function TPessoaController.RetornaCondicaoPessoa(
  pID_Pessoa: Integer; pRelacionada : Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID_PESSOA'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                                 '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID_Pessoa))+ ' '#13;
end;

end.
