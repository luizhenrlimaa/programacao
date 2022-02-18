unit UEndereco;

interface

uses SysUtils, Classes;

type
  TEndereco = class(TPersistent)
    private
      vID                    : Integer;
      vID_pessoa             : Integer;
      vTipo_Endereco         : Integer;
      vEndereco              : string;
      vNumero                : string;
      vComplemento           : string;
      vBairro                : string;
      vUF                    : string;
      vCidade                : string;
    public
      constructor Create;
    published
      property ID            : Integer  read vID            write vID;
      property ID_pessoa     : Integer  read vID_Pessoa     write vID_Pessoa;
      property Tipo_Endereco : Integer  read vTipo_Endereco write vTipo_Endereco;
      property Endereco      : string   read vEndereco      write vEndereco;
      property Numero        : string   read vNumero        write vNumero;
      property Complemento   : string   read vComplemento   write vComplemento;
      property Bairro        : string   read vBairro        write vBairro;
      property UF            : string   read vUF            write vUF;
      property Cidade        : string   read vCidade        write vCidade;

  end;

    TColEndereco = class(TList)
      public
        function  Retorna (pIndex : Integer) : TEndereco;
        procedure Adiciona (pEndereco : TEndereco);

    end;

implementation

{ TEndereco }

constructor TEndereco.Create;
begin
    Self.vID              := 0;
    Self.vID_pessoa       := 0;
    Self.vTipo_Endereco   := 0;
    Self.vEndereco        := EmptyStr;
    Self.vNumero          := EmptyStr;
    Self.vComplemento     := EmptyStr;
    Self.vBairro          := EmptyStr;
    Self.vUF              := EmptyStr;
    Self.vCidade          := EmptyStr;
end;

{ TColEndereco }

procedure TColEndereco.Adiciona(pEndereco: TEndereco);
begin
   Self.Add(TEndereco(pEndereco));
end;

function TColEndereco.Retorna(pIndex: Integer): TEndereco;
begin
   Result := TEndereco(Self[pIndex]);
end;

end.

