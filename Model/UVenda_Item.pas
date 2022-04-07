unit UVenda_Item;

interface

uses SysUtils, Classes , UVenda;

type
    TVenda_Item = Class(TPersistent)

    private
      vId                    : Integer;
      vId_Venda              : Integer;
      vId_Produto            : Integer;
      vQuantidade            : Double;
      vUnidadeSaida          : String;
      vValorUnitario         : Double;
      vTotalItem             : Double;


    public
      constructor Create;

    published
        property  Id                  : Integer  read vId            write  vId;
        property  Id_Venda            : Integer  read vId_Venda      write  vId_Venda;
        property  Id_Produto          : Integer  read vId_Produto    write  vId_Produto;
        property  Quantidade          : Double   read vQuantidade    write  vQuantidade;
        property  UnidadeSaida        : String   read vUnidadeSaida  write  vUnidadeSaida;
        property  ValorUnitario       : Double   read vValorUnitario write  vValorUnitario;
        property  TotalItem           : Double   read vTotalItem     write  vTotalItem;

    end;

    TColVenda_Item = class(TList)
      public
        
           function   Retorna (pIndex : Integer) : TVenda_Item;
           procedure  Adiciona(pVenda_Item : TVenda_Item);
    end;
implementation

{ TProduto }

constructor TVenda_Item.Create;
begin
  Self.Id                      := 0;
  Self.Id_Venda                := 0;
  Self.Id_Produto              := 0;
  Self.Quantidade              := 0;
  Self.UnidadeSaida            := EmptyStr;
  Self.ValorUnitario           := 0;
end;

procedure TColVenda_Item.Adiciona(pVenda_Item: TVenda_Item);
begin
    Self.Add(TVenda_Item(pVenda_Item));
end;

function TColVenda_Item.Retorna(pIndex: Integer): TVenda_Item;
begin
   Result := TVenda_Item(Self[pIndex]);
end;

end.
