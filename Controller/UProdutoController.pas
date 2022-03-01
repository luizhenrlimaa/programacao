unit UProdutoController;

interface

uses SysUtils, Math, StrUtils, UConexao, UProduto;

type
  TPessoaController = class
      public
        constructor Create;
        function GravaProduto(
                      pProduto : TProduto;
                      pColEndereco : TColEndereco) : Boolean;
        function ExcluiProduto(
                      pProduto : TProduto) : Boolean;

        function BuscaProduto(pID : Integer) : TProduto;
        function PesquisaProduto(pNome : string) : TColProduto;
        function RetornaCondicaoProduto(
                   pID_Produto: Integer;
                   pRelacionada : Boolean = False) : String;

      published
        class function getInstancia : TPessoaController;
  end;



implementation

uses UProdutoDAO;

var
  _instance: TProdutoController;

{ TPessoaController }



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

function TProdutoController.ExcluiProduto(pProduto: TProduto): Boolean;
var
  XProdutoDAO   : TProdutoDAO;
begin
  try
    try
       Result := False;

       TConexao.get.iniciaTransacao;

       XProdutoDAO := TProdutoDAO.Create(TConexao.get.getConn);


       if(pProduto.Id =0) then
            Exit
       else
       begin
         XProdutoDAO.Deleta(RetornaCondicaoProduto(pProduto.Id));

         XEnderecoDAO.Deleta(RetornaCondicaoProduto(pProduto.Id, True));

       end;

       TConexao.get.confirmaTransacao;

       Result := True;

    finally
      if (XProdutoDAO <> nil) then
          FreeAndNil(XProdutoDAO);

    end;
  except
    on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
         'Falha ao excluir os dados do produto [Controller]. '#13+
          e.Message);
      end;
  end;
end;

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
   xAux         : Integer;
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
            end
            else
            begin
               xProdutoDAO.Atualiza(pProduto, RetornaCondicaoProduto(pProduto.Id));
            end;

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
            'Falha ao gravar os dados do produto [Controller]. '#13+
            e.Message);
        end;
    end;
end;

function TProdutoController.PesquisaProduto(pNome: string): TColProduto;
var
  xProdutoDAO  : TProdutoDAO;
  xCondicao   : string;
begin
   try
      try

        Result := nil;
        xProdutoDAO := TProdutoDAO.Create(TConexao.get.getConn);

        xCondicao :=  IfThen(pNome <> EmptyStr,
                  'WHERE                                   '#13+
                  '    (NOME LIKE UPPER(''%'+ pNome +'%''))'#13+
                  'ORDER BY NOME, ID', EmptyStr);

        Result := xProdutoDAO.RetornaLista(xCondicao);
        
      finally
          if (xProdutoDAO <> nil) then
          FreeAndNil(xProdutoDAO);

      end;
   except
     on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao buscar os dados do produto [Controller]. '#13+
            e.Message);
        end;
   end;

end;

function TProdutoController.RetornaCondicaoProduto(
  pID_Produto: Integer; pRelacionada : Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID_PRODUTO'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                                 '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID_Produto))+ ' '#13;
end;

end.