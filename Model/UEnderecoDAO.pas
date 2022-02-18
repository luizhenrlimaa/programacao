unit UEnderecoDAO;

interface

uses  SqlExpr, DBXpress, SimpleDS, Db , Classes, SysUtils, DateUtils,
      StdCtrls, UGenericDAO, UEndereco;

type

    TEnderecoDAO = class(TGenericDAO)
        public
           constructor Create( pConexao : TSQLConnection);
           function Insere(pEndereco : TEndereco) : Boolean;
           function InsereLista(pColEndereco : TColEndereco) : Boolean;
           function Atualiza(pEndereco : TEndereco; pCondicao : String) : Boolean;
           function Retorna(pCondicao : String) : TEndereco;
           function RetornaLista(pCondicao : String = '') : TColEndereco;
    end;

implementation

{ TEnderecoDAO }

function TEnderecoDAO.Atualiza(pEndereco: TEndereco;
  pCondicao: String): Boolean;
begin
    Result := inherited Atualiza(pEndereco, pCondicao);
end;

constructor TEnderecoDAO.Create(pConexao: TSQLConnection);
begin
    inherited Create;
    vEntidade := 'ENDERECO';
    vConexao  := pConexao;
    vClass    := TEndereco;
end;

function TEnderecoDAO.Insere(pEndereco: TEndereco): Boolean;
begin
    Result := inherited Insere(pEndereco, 'ID');
end;

function TEnderecoDAO.InsereLista(pColEndereco: TColEndereco): Boolean;
begin
    Result := inherited InsereLista(pColEndereco);
end;

function TEnderecoDAO.Retorna(pCondicao: String): TEndereco;
begin
    Result := TEndereco(inherited Retorna(pCondicao));
end;

function TEnderecoDAO.RetornaLista(pCondicao: String): TColEndereco;
begin
   Result := TColEndereco(inherited RetornaLista(pCondicao));
end;

end.
