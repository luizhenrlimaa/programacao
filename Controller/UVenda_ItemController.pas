unit UVenda_ItemController;

interface

uses SysUtils, Math, StrUtils, UConexao, UVenda_Item;

type                                         
  TVenda_ItemController = class
      public
        constructor Create;
        function GravaVenda_Item(
                      pVenda_Item : TVenda_Item;
                      pColVenda_Item : TColVenda_Item) : Boolean;
        function ExcluiVenda_Item(
                      pVenda_Item : TVenda_Item) : Boolean;
        function BuscaVenda_Item(pID_Venda : Integer) : TColVenda_Item;
        function PesquisaVenda_Item(pNome : string) : TColVenda_Item;
        function RetornaCondicaoVenda_Item(
                   pID_Venda: Integer;
                   pRelacionada : Boolean = False) : String;

      published
        class function getInstancia : TVenda_ItemController;
  end;

implementation

uses UVenda_ItemDAO;

var
  _instance: TVenda_ItemController;


function TVenda_ItemController.BuscaVenda_Item(pID_Venda: Integer): TColVenda_Item;
var
  XVenda_ItemDAO : TVenda_ItemDAO;
begin
  try
    try
       Result := nil;

       XVenda_ItemDAO := TVenda_ItemDAO.Create(TConexao.getInstance.getConn);
       Result         := XVenda_ItemDAO.RetornaLista(RetornaCondicaoVenda_Item(pID_Venda));

    finally
      if(XVenda_ItemDAO <> nil) then
       FreeAndNil(XVenda_ItemDAO);


    end;
  except
        on E : Exception do
        begin
          Raise Exception.Create(
            'Falha ao buscar os dados do item da venda. [Controller]'#13+
            e.Message);
        end;
  end;
end;

constructor TVenda_ItemController.Create;
begin
   inherited Create;
end;

function TVenda_ItemController.ExcluiVenda_Item(pVenda_Item: TVenda_Item): Boolean;
var
  XVenda_ItemDAO   : TVenda_ItemDAO;
begin
  try
    try
       Result := False;

       TConexao.get.iniciaTransacao;

       XVenda_ItemDAO := TVenda_ItemDAO.Create(TConexao.get.getConn);


       if(pVenda_Item.Id =0) then
            Exit
       else
       begin
         XVenda_ItemDAO.Deleta(RetornaCondicaoVenda_Item(pVenda_Item.Id));
       end;

       TConexao.get.confirmaTransacao;

       Result := True;

    finally
      if (XVenda_ItemDAO <> nil) then
          FreeAndNil(XVenda_ItemDAO);

    end;
  except
    on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
         'Falha ao excluir os dados do item da venda [Controller]. '#13+
          e.Message);
      end;
  end;
end;

class function TVenda_ItemController.getInstancia: TVenda_ItemController;
begin
   if _instance = nil then
      _instance := TVenda_ItemController.Create;

   Result := _instance;
end;

function TVenda_ItemController.GravaVenda_Item(
                      pVenda_Item : TVenda_Item;
                      pColVenda_Item : TColVenda_Item) : Boolean;
var
   XVenda_ItemDAO   : TVenda_ItemDAO;
   xAux          : Integer;
begin
    try
        try
            TConexao.get.iniciaTransacao;

            Result := False;

            XVenda_ItemDAO   :=
              TVenda_ItemDAO.Create(TConexao.get.getConn);


            if pVenda_Item.Id = 0 then
            begin
               XVenda_ItemDAO.Insere(pVenda_Item);

             for xAux := 0 to pred(pColVenda_Item.Count) do
                pColVenda_Item.Retorna(xAux).Id := pVenda_Item.Id;
                XVenda_ItemDAO.InsereLista(pColVenda_Item)
            end
            else
            begin
               XVenda_ItemDAO.Atualiza(pVenda_Item, RetornaCondicaoVenda_Item(pVenda_Item.Id));
            end;

            TConexao.get.confirmaTransacao;
        finally
             if (XVenda_ItemDAO <> nil) then
             FreeAndNil(XVenda_ItemDAO);
        end;
    except
        on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao gravar os dados do item da venda [Controller]. '#13+
            e.Message);
        end;
    end;
end;

function TVenda_ItemController.PesquisaVenda_Item(pNome: string): TColVenda_Item;
var
  XVenda_ItemDAO  : TVenda_ItemDAO;
  xCondicao   : string;
begin
  try
      try
        Result := nil;
        XVenda_ItemDAO := TVenda_ItemDAO.Create(TConexao.get.getConn);

        xCondicao :=  IfThen(pNome <> EmptyStr,
                  'WHERE                                        '#13+
                  '    (DESCRICAO LIKE UPPER(''%'+ pNome +'%''))'#13+
                  'ORDER BY DESCRICAO, ID', EmptyStr);

        Result := XVenda_ItemDAO.RetornaLista(xCondicao);

      finally
          if (XVenda_ItemDAO <> nil) then
          FreeAndNil(XVenda_ItemDAO);

      end;
  except
     on E : Exception do
        begin
          TConexao.get.cancelaTransacao;
          Raise Exception.Create(
            'Falha ao buscar os dados do item da venda [Controller]. '#13+
            e.Message);
        end;
  end;

end;

function TVenda_ItemController.RetornaCondicaoVenda_Item(
  pID_Venda: Integer; pRelacionada : Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID_VENDA'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                                  '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID_Venda))+         ' '#13;
end;

end.
