unit UProdutoDAO;

interface

uses  SqlExpr, DBXpress, SimpleDS, Db , Classes, SysUtils, DateUtils,
      StdCtrls, UGenericDAO, UProduto;

type

    TProdutoDAO = class(TGenericDAO)
        public
           constructor Create( pConexao : TSQLConnection);
           function Insere(pProduto : TProduto) : Boolean;
           function InsereLista(pColProduto : TColProduto) : Boolean;
           function Atualiza(pProduto : TProduto; pCondicao : String) : Boolean;
           function Retorna(pCondicao : String) : TProduto;
           function RetornaLista(pCondicao : String = '') : TColProduto;
    end;

implementation

{ TProdutoDAO }

function TProdutoDAO.Atualiza(pProduto: TProduto;
  pCondicao: String): Boolean;
begin
  Result := inherited Atualiza(pProduto, pCondicao);
end;

constructor TProdutoDAO.Create(pConexao: TSQLConnection);
begin
    inherited Create;
    vEntidade := 'PRODUTO';
    vConexao  := pConexao;
    vClass    := TProduto;
end;

function TProdutoDAO.Insere(pProduto: TProduto): Boolean;
begin
    Result := inherited Insere(pProduto, 'ID');
end;

function TProdutoDAO.InsereLista(pColProduto: TColProduto): Boolean;
begin
    Result := inherited InsereLista(pColProduto);
end;

function TProdutoDAO.Retorna(pCondicao: String): TProduto;
begin
    Result := TProduto(inherited Retorna(pCondicao));
end;

function TProdutoDAO.RetornaLista(pCondicao: String): TColProduto;
begin
    Result := TColProduto(inherited RetornaLista(pCondicao));
end;

end.

