unit UUnidadeProduto;

interface

uses SysUtils, Classes;

type
    TUnidadeProduto = Class(TPersistent)

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

    TColUnidadeProduto = class(TList)
      public
           function   Retorna (pIndex : Integer) : TUnidadeProduto;
           procedure  Adiciona(pUnidadeProduto : TUnidadeProduto);
    end;
implementation

{ TProduto }

constructor TUnidadeProduto.Create;
begin
  Self.vId                  := 0;
  Self.vAtivo               := False;
  Self.vUnidade             := EmptyStr;
  Self.vDescricao           := EmptyStr;
end;

{ TColProduto }

procedure TColUnidadeProduto.Adiciona(pUnidadeProduto: TUnidadeProduto);
begin
    Self.Add(TUnidadeProduto(pUnidadeProduto));
end;

function TColUnidadeProduto.Retorna(pIndex: Integer): TUnidadeProduto;
begin
   Result := TUnidadeProduto(Self[pIndex]);
end;

end.
