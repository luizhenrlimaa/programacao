unit UProduto;

interface

uses SysUtils, Classes;

type
    TProduto = Class(TPersistent)

    private
      vId                 : Integer;
      vDescricao          : String;
      vEstoque            : Integer;
      vPrecoVenda         : Double;


    public
      constructor Create;

    published
        property  Id                  : Integer read vId write vId;
        property  Descricao           : String  read vDescricao write vDescricao;
        property  Estoque             : Integer read vEstoque write vEstoque;
        property  PrecoVenda          : Double  read vPrecoVenda write vPrecoVenda;

    end;

    TColProduto = class(TList)
      public
           function   Retorna (pIndex : Integer) : TProduto;
           procedure  Adiciona(pProduto : TProduto);
    end;
implementation

{ TProduto }

constructor TProduto.Create;
begin
  Self.vId                  := 0;
  Self.vDescricao           := EmptyStr;
  Self.vEstoque             := 0;
  Self.vPrecoVenda          := 0;
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
