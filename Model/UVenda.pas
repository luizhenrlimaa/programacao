unit UVenda;

interface

uses SysUtils, Classes;

type
    TVenda = Class(TPersistent)

    private
      vId                    : Integer;
      vId_Cliente            : Integer;
      vDataVenda             : TDateTime;
      vTotalVenda            : Double;



    public
      constructor Create;

    published
        property  Id                  : Integer       read vId            write  vId;
        property  Id_Cliente          : Integer       read vId_Cliente    write  vId_Cliente;
        property  DataVenda           : TDateTime     read vDataVenda     write  vDataVenda;
        property  TotalVenda          : Double        read vTotalVenda    write  vTotalVenda;


    end;

    TColVenda = class(TList)
      public
           function   Retorna (pIndex : Integer) : TVenda;
           procedure  Adiciona(pVenda : TVenda);
    end;
implementation

{ TProduto }

constructor TVenda.Create;
begin
  Self.Id                      := 0;
  Self.Id_Cliente              := 0;
  Self.DataVenda               := 0;
  Self.TotalVenda              := 0;
end;

procedure TColVenda.Adiciona(pVenda: TVenda);
begin
    Self.Add(TVenda(pVenda));
end;

function TColVenda.Retorna(pIndex: Integer): TVenda;
begin
   Result := TVenda(Self[pIndex]);
end;

end.
