unit UUnidadeProdutoDAO;

interface

uses  SqlExpr, DBXpress, SimpleDS, Db , Classes, SysUtils, DateUtils,
      StdCtrls, UGenericDAO, UUnidadeProduto;
type

    TUnidadeProdutoDAO = class(TGenericDAO)

        public
           constructor Create( pConexao : TSQLConnection);
           function Insere(pUnidadeProduto : TUnidadeProduto) : Boolean;
           function InsereLista(pColUnidadeProduto : TColUnidadeProduto) : Boolean;
           function Atualiza(pUnidadeProduto : TUnidadeProduto; pCondicao : String) : Boolean;
           function Retorna(pCondicao : String) : TUnidadeProduto;
           function RetornaLista(pCondicao : String = '') : TColUnidadeProduto;
    end;

implementation

{ TProdutoDAO }

function TUnidadeProdutoDAO.Atualiza(pUnidadeProduto: TUnidadeProduto;
  pCondicao: String): Boolean;
begin
  Result := inherited Atualiza(pUnidadeProduto, pCondicao);
end;

constructor TUnidadeProdutoDAO.Create(pConexao: TSQLConnection);
begin
    inherited Create;
    vEntidade := 'UNIDADEPRODUTO';
    vConexao  := pConexao;
    vClass    := TUnidadeProduto;
end;

function TUnidadeProdutoDAO.Insere(pUnidadeProduto: TUnidadeProduto): Boolean;
begin
    Result := inherited Insere(pUnidadeProduto, 'ID');
end;

function TUnidadeProdutoDAO.InsereLista(pColUnidadeProduto: TColUnidadeProduto): Boolean;
begin
    Result := inherited InsereLista(pColUnidadeProduto);
end;

function TUnidadeProdutoDAO.Retorna(pCondicao: String): TUnidadeProduto;
begin
    Result := TUnidadeProduto(inherited Retorna(pCondicao));
end;

function TUnidadeProdutoDAO.RetornaLista(pCondicao: String): TColUnidadeProduto;
begin
    Result := TColUnidadeProduto(inherited RetornaLista(pCondicao));
end;

end.
 