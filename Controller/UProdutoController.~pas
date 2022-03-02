unit UProdutoController;

interface

uses SysUtils, Math, StrUtils, UConexao, UProduto;

type
  TProdutoController = class
      public
        constructor Create;
        function GravaProduto(
                      pProduto : TProduto) : Boolean;
//        function ExcluiProduto(
//                      pProduto : TProduto) : Boolean;
//
        function BuscaProduto(pID : Integer) : TProduto;
//        function PesquisaPessoa(pNome : string) : TColPessoa;
//        function BuscaEnderecoPessoa(pID_Pessoa : Integer) : TColEndereco;
//        function RetornaCondicaoProduto(
//                   pID_Pessoa: Integer;
//                   pRelacionada : Boolean = False) : String;

      published
        class function getInstancia : TProdutoController;
  end;



implementation

uses UProdutoDAO ;

var
  _instance: TProdutoController;

{ TPessoaController }

//function TPessoaController.BuscaEnderecoPessoa(
//  pID_Pessoa: Integer): TColEndereco;
//var
//  xEnderecoDAO : TEnderecoDAO;
//begin
//  try
//    try
//       Result := nil;
//
//       xEnderecoDAO :=
//            TEnderecoDAO.Create(TConexao.getInstance.getConn);
//
//       Result :=
//            xEnderecoDAO.RetornaLista(RetornaCondicaoProduto(pID_Pessoa, True));
//
//    finally
//      if(xEnderecoDAO <> nil) then
//       FreeAndNil(xEnderecoDAO);
//
//
//    end;
//  except
//    on E : Exception do
//    begin
//      Raise Exception.Create(
//        'Falha ao retornar dados do endereço da pessoa [Controller]'#13+
//        e.Message);
//    end;
//  end;
//
//end;

function TProdutoController.BuscaProduto(pID: Integer): TProduto;
var
  XProdutoDAO : TProdutoDAO;
begin
  try
    try
       Result := nil;

       XProdutoDAO := TProdutoDAO.Create(TConexao.getInstance.getConn);
       Result := XProdutoDAO.Retorna(RetornaCondicaoProduto(pID));

    finally
      if(XProdutoDAO <> nil) then
       FreeAndNil(XProdutoDAO);


    end;
  except
        on E : Exception do
        begin
          Raise Exception.Create(
            'Falha ao buscar os dados do produto. [Controller]'#13+
            e.Message);
        end;
  end;
end;

constructor TProdutoController.Create;
begin
   inherited Create;
end;

//function TProdutoController.ExcluiProduto(pProduto: TProduto): Boolean;
//var
//  XProdutoaDAO   : TPessoaDAO;
//begin
//  try
//    try
//       Result := False;
//
//       TConexao.get.iniciaTransacao;
//
//       XProdutoaDAO := TPessoaDAO.Create(TConexao.get.getConn);
//
//
//       if(pProduto.Id =0) then
//            Exit
//       else
//       begin
//         XProdutoaDAO.Deleta(RetornaCondicaoProduto(pProduto.Id));
//       end;
//
//       TConexao.get.confirmaTransacao;
//
//       Result := True;
//
//    finally
//      if (XProdutoaDAO <> nil) then
//          FreeAndNil(XProdutoaDAO);
//
//    end;
//  except
//    on E : Exception do
//      begin
//         TConexao.get.cancelaTransacao;
//         Raise Exception.Create(
//         'Falha ao excluir os dados do produto [Controller]. '#13+
//          e.Message);
//      end;
//  end;
//end;

class function TProdutoController.getInstancia: TProdutoController;
begin
   if _instance = nil then
      _instance := TProdutoController.Create;

   Result := _instance;
end;

function TProdutoController.GravaProduto(
           pProduto : TProduto) : Boolean;
var
   xProdutoDAO   : TProdutoDAO;
   xAux          : Integer;
begin
    try
        try
            TConexao.get.iniciaTransacao;

            Result := False;

            xProdutoDAO   :=
              TProdutoDAO.Create(TConexao.get.getConn);


            if pProduto.Id = 0 then
            begin
               xProdutoDAO.Insere(pProduto);

//              for xAux := 0 to pred(pColEndereco.Count) do
//                pColEndereco.Retorna(xAux).ID_pessoa := pProduto.Id;
//
//
//               xEnderecoDAO.InsereLista(pColEndereco)
            end;
//            else
//            begin
//               xProdutoDAO.Atualiza(pProduto, RetornaCondicaoProduto(pProduto.Id));
//               xEnderecoDAO.Deleta(RetornaCondicaoProduto(pProduto.Id, True));
//               xEnderecoDAO.InsereLista(pColEndereco);
//            end;

            TConexao.get.confirmaTransacao;
        finally
             if (xProdutoDAO <> nil) then
             FreeAndNil(xProdutoDAO);
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

//function TPessoaController.PesquisaPessoa(pNome: string): TColPessoa;
//var
//  xPessoaDAO  : TPessoaDAO;
//  xCondicao   : string;
//begin
//   try
//      try
//
//        Result := nil;
//        xPessoaDAO := TPessoaDAO.Create(TConexao.get.getConn);
//
//        xCondicao :=  IfThen(pNome <> EmptyStr,
//                  'WHERE                                   '#13+
//                  '    (NOME LIKE UPPER(''%'+ pNome +'%''))'#13+
//                  'ORDER BY NOME, ID', EmptyStr);
//
//        Result := xPessoaDAO.RetornaLista(xCondicao);
//
//      finally
//          if (xPessoaDAO <> nil) then
//          FreeAndNil(xPessoaDAO);
//
//      end;
//   except
//     on E : Exception do
//        begin
//          TConexao.get.cancelaTransacao;
//          Raise Exception.Create(
//            'Falha ao buscar os dados da pessoa [Controller]. '#13+
//            e.Message);
//        end;
//   end;
//
//end;

//function TPessoaController.RetornaCondicaoProduto(
//  pID_Pessoa: Integer; pRelacionada : Boolean): String;
//var
//  xChave : string;
//
//begin
//  if (pRelacionada) then
//      xChave := 'ID_PESSOA'
//
//  else
//      xChave := 'ID';
//
//  Result :=
//  'WHERE                                                 '#13+
//  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID_Pessoa))+ ' '#13;
//end;

end.
