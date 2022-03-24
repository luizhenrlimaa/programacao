unit UUnidade;

interface

uses SysUtils, Classes, UUnidadeProduto;

type
  TUnidade = Class(TUnidadeProduto)
    private
      vBloqueado : Boolean;
    public
      constructor Create;

    published
      property Bloqueado : Boolean read vBloqueado write vBloqueado;

    end;
implementation


{ TCliente }

constructor TUnidade.Create;
begin
    vBloqueado := False;
end;

end.
