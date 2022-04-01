unit UVenda_ItemCad;

interface

uses SysUtils, Classes, UVenda_Item;

type
  TVenda_ItemCad = Class(TVenda_Item)
    private
      vBloqueado : Boolean;
    public
      constructor Create;

    published
      property Bloqueado : Boolean read vBloqueado write vBloqueado;

    end;
implementation


{ TCliente }

constructor TVenda_ItemCad.Create;
begin
    vBloqueado := False;
end;

end.
