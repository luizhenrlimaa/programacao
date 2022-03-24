unit UUnidadeProdutoController;

interface

uses SysUtils, Math, StrUtils, UConexao, UUnidadeProduto;

type
  TUnidadeProdutoController = class
      public
        constructor Create;
        function GravaProduto(
                      pUnidadeProduto : TUnidadeProduto;
                      pColUnidadeProduto : TColUnidadeProduto) : Boolean;
        function ExcluiProduto(
                      pUnidadeProduto : TUnidadeProduto) : Boolean;
        function BuscaProduto(pID : Integer) : TUnidadeProduto;
        function PesquisaProduto(pNome : string) : TColUnidadeProduto;
        function RetornaCondicaoProduto(
                   pID: Integer;
                   pRelacionada : Boolean = False) : String;

      published
        class function getInstancia : TUnidadeProdutoController;
  end;

implementation

uses UUnidadeProdutoDAO ;

var
  _instance: TUnidadeProdutoController;


function TUnidadeProdutoController.BuscaProduto(pID: Integer): TUnidadeProduto;
var
  XUnidadeProdutoDAO : TUnidadeProdutoDAO;
begin
  try
    try
       Result := nil;

       XUnidadeProdutoDAO := TUnidadeProdutoDAO.Create(TConexao.getInstance.getConn);
       Result      := XUnidadeProdutoDAO.Retorna(RetornaCondicaoProduto(pID));

    finally
      if(XUnidadeProdutoDAO <> nil) then
       FreeAndNil(XUnidadeProdutoDAO);


    end;
  except
        on E : Exception do
        begin
          Raise Exception.Create(
            'Falha ao buscar os dados do produto. [Controller]'#13+
            e.Message);
        end;
  end;
end;

constructor TUnidadeProdutoController.Create;
begin
   inherited Create;
end;

function TUnidadeProdutoController.ExcluiProduto(pUnidadeProduto: TUnidadeProduto): Boolean;
var
  XUnidadeProdutoDAO   : TUnidadeProdutoDAO;
begin
  try
    try
       Result := False;

       TConexao.get.iniciaTransacao;

       XUnidadeProdutoDAO := TUnidadeProdutoDAO.Create(TConexao.get.getConn);


       if(pUnidadeProduto.Id =0) then
            Exit
       else
       begin
         XUnidadeProdutoDAO.Deleta(RetornaCondicaoProduto(pUnidadeProduto.Id));
       end;

       TConexao.get.confirmaTransacao;

       Result := True;

    finally
      if (XUnidadeProdutoDAO <> nil) then
          FreeAndNil(XUnidadeProdutoDAO);

    end;
  except
    on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
         'Falha ao excluir os dados do produto [Controller]. '#13+
          e.Message);
      end;
  end;
end;

class function TUnidadeProdutoController.getInstancia: TUnidadeProdutoController;
begin
   if _instance = nil then
      _instance := TUnidadeProdutoController.Create;

   Result := _instance;
end;

function TUnidadeProdutoController.GravaProduto(
           pUnidadeProduto : TUnidadeProduto;
                      pColUnidadeProduto : TColUnidadeProduto) : Boolean;
var
   XUnidadeProdutoDAO   : TUnidadeProdutoDAO;
   xAux          : Integer;
begin
    try
        try
            TConexao.get.iniciaTransacao;

            Result := False;

            XUnidadeProdutoDAO   :=
              TUnidadeProdutoDAO.Create(TConexao.get.getConn);


            if pUnidadeProduto.Id = 0 then
            begin
               XUnidadeProdutoDAO.Insere(pUnidadeProduto);

             for xAux := 0 to pred(pColUnidadeProduto.Count) do
                pColUnidadeProduto.Retorna(xAux).Id := pUnidadeProduto.Id;
                XUnidadeProdutoDAO.InsereLista(pColUnidadeProduto)
            end
            else
            begin
               XUnidadeProdutoDAO.Atualiza(pUnidadeProduto, RetornaCondicaoProduto(pUnidadeProduto.Id));
            end;

            TConexao.get.confirmaTransacao;
        finally
             if (XUnidadeProdutoDAO <> nil) then
             FreeAndNil(XUnidadeProdutoDAO);
        end;
    except
        on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao gravar os dados do produto [Controller]. '#13+
            e.Message);
        end;
    end;
end;

function TUnidadeProdutoController.PesquisaProduto(pNome: string): TColUnidadeProduto;
var
  XUnidadeProdutoDAO  : TUnidadeProdutoDAO;
  xCondicao   : string;
begin
  try
      try
        Result := nil;
        XUnidadeProdutoDAO := TUnidadeProdutoDAO.Create(TConexao.get.getConn);

        xCondicao :=  IfThen(pNome <> EmptyStr,
                  'WHERE                                        '#13+
                  '    (DESCRICAO LIKE UPPER(''%'+ pNome +'%''))'#13+
                  'ORDER BY DESCRICAO, ID', EmptyStr);

        Result := XUnidadeProdutoDAO.RetornaLista(xCondicao);

      finally
          if (XUnidadeProdutoDAO <> nil) then
          FreeAndNil(XUnidadeProdutoDAO);

      end;
  except
     on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao buscar os dados do produto [Controller]. '#13+
            e.Message);
        end;
  end;

end;

function TUnidadeProdutoController.RetornaCondicaoProduto(
  pID: Integer; pRelacionada : Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                          '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID))+ ' '#13;
end;

end.
