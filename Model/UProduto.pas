unit UProduto;

interface

uses SysUtils, Classes;

type
  TProduto = Class(TPersistent)

    private
      vId                 : Integer;
      vAtivo              : Boolean;
      vUnidade            : String;
      vDescricao          : String;

    public
        constructor Create;
    published
        property  Id                  : Integer read vId write vId;
        property  Ativo               : Boolean read vAtivo write vAtivo;
        property  Unidade             : String  read vUnidade write vUnidade;
        property  Descricao           : String  read vDescricao write vDescricao;
    end;

    TColProduto = class(TList)
      public
           function   Retorna (pIndex : Integer) : TProduto;
           procedure  Adiciona(pProduto : TProduto);
  end;
implementation


constructor TProduto.Create;
begin

  Self.vId                  := 0;
  Self.vAtivo               := False;
  Self.vUnidade             := EmptyStr;
  Self.vDescricao := EmptyStr;


end;


{ TColProduto }

procedure TColProduto.Adiciona(pProduto: TProduto);
begin
     Self.Add(TProduto(pProduto));
end;

function TColProduto.Retorna(pIndex: Integer): TProduto;
begin
     Result := TProduto(Self[pIndex]);
end;

end.

