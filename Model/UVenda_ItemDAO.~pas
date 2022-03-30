unit UVenda_ItemDAO;

interface

uses  SqlExpr, DBXpress, SimpleDS, Db , Classes, SysUtils, DateUtils,
      StdCtrls, UGenericDAO, UVenda_Item;

type

    TVenda_ItemDAO = class(TGenericDAO)
        public
           constructor Create( pConexao : TSQLConnection);
           function Insere(pVenda_Item : TVenda_Item) : Boolean;
           function InsereLista(pColVenda_Item : TColVenda_Item) : Boolean;
           function Atualiza(pVenda_Item : TVenda_Item; pCondicao : String) : Boolean;
           function Retorna(pCondicao : String) : TVenda_Item;
           function RetornaLista(pCondicao : String = '') : TColVenda_Item;
    end;

implementation

{ TProdutoDAO }

function TVenda_ItemDAO.Atualiza(pVenda_Item: TVenda_Item;
  pCondicao: String): Boolean;
begin
  Result := inherited Atualiza(pVenda_Item, pCondicao);
end;

constructor TVenda_ItemDAO.Create(pConexao: TSQLConnection);
begin
    inherited Create;
    vEntidade := 'VENDA_ITEM';
    vConexao  := pConexao;
    vClass    := TVenda_Item;
end;

function TVenda_ItemDAO.Insere(pVenda_Item: TVenda_Item): Boolean;
begin
    Result := inherited Insere(pVenda_Item, 'ID');
end;

function TVenda_ItemDAO.InsereLista(pColVenda_Item: TColVenda_Item): Boolean;
begin
    Result := inherited InsereLista(pColVenda_Item);
end;

function TVenda_ItemDAO.Retorna(pCondicao: String): TVenda_Item;
begin
    Result := TVenda_Item(inherited Retorna(pCondicao));
end;

function TVenda_ItemDAO.RetornaLista(pCondicao: String): TColVenda_Item;
begin
    Result := TColVenda_Item(inherited RetornaLista(pCondicao));
end;

end.

