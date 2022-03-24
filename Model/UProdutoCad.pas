unit UProdutoCad;

interface

uses SysUtils, Classes, UProduto;

type
  TProdutoCad = Class(TProduto)
    private
      vBloqueado : Boolean;
    public
      constructor Create;

    published
      property Bloqueado : Boolean read vBloqueado write vBloqueado;

    end;
implementation


{ TCliente }

constructor TProdutoCad.Create;
begin
    vBloqueado := False;
end;

end.
