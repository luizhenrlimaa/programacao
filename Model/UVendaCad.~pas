unit UVendaCad;

interface

uses SysUtils, Classes, UVenda;

type
  TVendaCad = Class(TVenda)
    private
      vBloqueado : Boolean;
    public
      constructor Create;

    published
      property Bloqueado : Boolean read vBloqueado write vBloqueado;

    end;
implementation


{ TCliente }

constructor TVendaCad.Create;
begin
    vBloqueado := False;
end;

end.
