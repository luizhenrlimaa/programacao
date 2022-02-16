unit UPessoaDAO;

interface

uses  SqlExpr, DBXpress, SimpleDS, Db , Classes, SysUtils, DateUtils,
      StdCtrls, UGenericDAO, UPessoa;

type

    TPessoaDAO = class(TGenericDAO)
        public
           constructor Create( pConexao : TSQLConnection);
           function Insere(pPessoa : TPessoa) : Boolean;
           function InsereLista(pColPessoa : TColPessoa) : Boolean;
           function Atualiza(pPessoa : TPessoa; pCondicao : String) : Boolean;
           function Retorna(pCondicao : String) : TPessoa;
           function RetornaLista(pCondicao : String = '') : TColPessoa;
    end;

implementation

{ TPessoaDAO }

function TPessoaDAO.Atualiza(pPessoa: TPessoa; pCondicao: string): Boolean;
begin
   Result := inherited Atualiza(pPessoa, pCondicao);
end;

constructor TPessoaDAO.Create(pConexao: TSQLConnection);
begin
    inherited Create;
    vEntidade := 'PESSOA';
    vConexao  := pConexao;
    vClass    := TPessoa;
end;

function TPessoaDAO.Insere(pPessoa: TPessoa): Boolean;
begin
    Result := inherited Insere(pPessoa, 'ID');
end;

function TPessoaDAO.InsereLista(pColPessoa: TColPessoa): Boolean;
begin
    Result := inherited InsereLista(pColPessoa);
end;

function TPessoaDAO.Retorna(pCondicao: String): TPessoa;
begin
   Result := TPessoa(inherited Retorna(pCondicao));
end;

function TPessoaDAO.RetornaLista(pCondicao: String): TColPessoa;
begin
   Result := TColPessoa(inherited RetornaLista(pCondicao));
end;

end.
