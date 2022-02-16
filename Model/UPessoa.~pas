unit UPessoa;

interface

uses SysUtils, Classes;

type
  TPessoa = Class(TPersistent)

    private
      vId                 : Integer;
      vTipo_Pessoa        : Integer;
      vNome               : String;
      vFisica_Juridica    : Integer;
      vIdentificadorPessoa: String; //Número CPF , CNPJ , PASSPORTE
      vAtivo              : Boolean;

    public
        constructor Create;
    published
        property  Id                  : Integer read vId write vId;
        property  Tipo_Pessoa         : Integer read vTipo_Pessoa write vTipo_Pessoa;
        property  Nome                : String  read vNome write vNome;
        property  Fisica_Juridica     : Integer read vFisica_Juridica write vFisica_Juridica;
        property  IdentificadorPessoa : String  read vIdentificadorPessoa write vIdentificadorPessoa;
        property  Ativo               : Boolean read vAtivo write vAtivo;

    end;

    TColPessoa = class(TList)
      public
           function   Retorna (pIndex : Integer) : TPessoa;
           procedure  Adiciona(pPessoa : TPessoa);
  end;
implementation

{ TPessoa }




//procedure TPessoa.Adiciona(pPessoa: TPessoa);
//begin

//end;

constructor TPessoa.Create;
begin

  Self.vId                  := 0;
  Self.vTipo_Pessoa         := 0;
  Self.vNome                := EmptyStr;
  Self.vFisica_Juridica     := 0;
  Self.vIdentificadorPessoa := EmptyStr;
  Self.vAtivo               := False;

end;



{ TColPessoa }

procedure TColPessoa.Adiciona(pPessoa: TPessoa);
begin
   Self.Add(TPessoa(pPessoa));
end;

function TColPessoa.Retorna(pIndex: Integer): TPessoa;
begin
    Result := TPessoa(Self[pIndex]);
end;

end.

