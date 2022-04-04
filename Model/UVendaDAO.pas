unit UVendaDAO;

interface

uses  SqlExpr, DBXpress, SimpleDS, Db , Classes, SysUtils, DateUtils,
      StdCtrls, UGenericDAO, UVenda;

type

    TVendaDAO = class(TGenericDAO)
        public
           constructor Create( pConexao : TSQLConnection);
           function Insere(pVenda : TVenda) : Boolean;
           function InsereLista(pColVenda : TColVenda) : Boolean;
           function Atualiza(pVenda : TVenda; pCondicao : String) : Boolean;
           function Retorna(pCondicao : String) : TVenda;
           function RetornaLista(pCondicao : String = '') : TColVenda;
    end;

implementation

{ TProdutoDAO }

function TVendaDAO.Atualiza(pVenda: TVenda;
  pCondicao: String): Boolean;
begin
  Result := inherited Atualiza(pVenda, pCondicao);
end;

constructor TVendaDAO.Create(pConexao: TSQLConnection);
begin
    inherited Create;
    vEntidade := 'VENDA';
    vConexao  := pConexao;
    vClass    := TVenda;
end;

function TVendaDAO.Insere(pVenda: TVenda): Boolean;
begin
    Result := inherited Insere(pVenda, 'ID');
end;

function TVendaDAO.InsereLista(pColVenda: TColVenda): Boolean;
begin
    Result := inherited InsereLista(pColVenda);
end;

function TVendaDAO.Retorna(pCondicao: String): TVenda;
begin
    Result := TVenda(inherited Retorna(pCondicao));
end;

function TVendaDAO.RetornaLista(pCondicao: String): TColVenda;
begin
    Result := TColVenda(inherited RetornaLista(pCondicao));
end;

end.

