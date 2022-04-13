unit UVendaController;

interface

uses SysUtils, Math, StrUtils, UConexao, UVenda, UVenda_Item, UPessoa;

type
  TVendaController = class
      public
        constructor Create;
        function GravaVenda(
                       pVenda : TVenda;
                       pColVenda_Item : TColVenda_Item) : Boolean;
        function ExcluiVenda(
                      pVenda : TVenda) : Boolean;
        function BuscaVenda(pID : Integer) : TVenda;
        function BuscaVenda_Item(pID_Venda : Integer) : TColVenda_Item;
        function PesquisaVenda(pVenda : string) : TColVenda;
        function RetornaCondicaoVenda(
                   pID: Integer;
                   pRelacionada : Boolean = False) : String;
        function RetornaCondicaoVenda_Item(
                   pID_Venda: Integer;
                   pRelacionada : Boolean = False) : String;


      published
        class function getInstancia : TVendaController;
  end;

implementation

uses UVendaDAO, UVenda_ItemDAO, UPessoaDAO;

var
  _instance: TVendaController;


function TVendaController.BuscaVenda(pID: Integer): TVenda;
var
  XVendaDAO : TVendaDAO;
begin
  try
    try
       Result := nil;

       XVendaDAO := TVendaDAO.Create(TConexao.getInstance.getConn);
       Result    := XVendaDAO.Retorna(RetornaCondicaoVenda(pID));

    finally
      if(XVendaDAO <> nil) then
       FreeAndNil(XVendaDAO);


    end;
  except
        on E : Exception do
        begin
          Raise Exception.Create(
            'Falha ao buscar os dados da venda. [Controller]'#13+
            e.Message);
        end;
  end;
end;

function TVendaController.BuscaVenda_Item(pID_Venda: Integer): TColVenda_Item;
var
  XVenda_ItemDAO : TVenda_ItemDAO;

begin
   try
    try
       Result := nil;

       XVenda_ItemDAO := TVenda_ItemDAO.Create(TConexao.getInstance.getConn);
       Result         := XVenda_ItemDAO.RetornaLista(RetornaCondicaoVenda_Item(pID_Venda, True));

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

constructor TVendaController.Create;
begin
   inherited Create;
end;

function TVendaController.ExcluiVenda(pVenda: TVenda): Boolean;
var
   XVendaDAO   : TVendaDAO;
begin
  try
    try
       Result := False;

       TConexao.get.iniciaTransacao;

       XVendaDAO := TVendaDAO.Create(TConexao.get.getConn);


       if(pVenda.Id =0) then
            Exit
       else
       begin
         XVendaDAO.Deleta(RetornaCondicaoVenda(pVenda.Id));
       end;

       TConexao.get.confirmaTransacao;

       Result := True;

    finally
      if (XVendaDAO <> nil) then
          FreeAndNil(XVendaDAO);

    end;
  except
    on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
         'Falha ao excluir os dados da venda [Controller]. '#13+
          e.Message);
      end;
  end;
end;

class function TVendaController.getInstancia: TVendaController;
begin
   if _instance = nil then
      _instance := TVendaController.Create;

   Result := _instance;
end;

function TVendaController.GravaVenda(
           pVenda : TVenda;
                     pColVenda_Item : TColVenda_Item) : Boolean;
var
   XVendaDAO      : TVendaDAO;
   XVenda_ItemDAO : TVenda_ItemDAO;
   xAux           : Integer;
begin
    try
        try
            TConexao.get.iniciaTransacao;

            Result := False;

            XVendaDAO   :=
              TVendaDAO.Create(TConexao.get.getConn);

            XVenda_ItemDAO :=
              TVenda_ItemDAO.Create(TConexao.get.getConn);


            if pVenda.Id = 0 then
            begin
               XVendaDAO.Insere(pVenda);

             for xAux := 0 to pred(pColVenda_Item.Count) do
                pColVenda_Item.Retorna(xAux).Id_Venda := pVenda.Id;


                XVenda_ItemDAO.InsereLista(pColVenda_Item)
            end
            else
            begin
               XVendaDAO.Atualiza(pVenda, RetornaCondicaoVenda(pVenda.id));
               XVenda_ItemDAO.Deleta(RetornaCondicaoVenda(pVenda.Id, True));
               XVenda_ItemDAO.InsereLista(pColVenda_Item);
            end;

            TConexao.get.confirmaTransacao;
        finally
             if (XVendaDAO <> nil) then
             FreeAndNil(XVendaDAO);
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

function TVendaController.PesquisaVenda(pVenda: string): TColVenda;
var
  XVendaDAO  : TVendaDAO;
  xCondicao  : string;
begin
  try
      try
        Result := nil;
        XVendaDAO := TVendaDAO.Create(TConexao.get.getConn);

        xCondicao :=  IfThen(pVenda <> EmptyStr,
                  'WHERE                                        '#13+
                  '    (ID LIKE UPPER(''%'+ pVenda +'%''))'#13+
                  'ORDER BY ID, ID', EmptyStr);

        Result := XVendaDAO.RetornaLista(xCondicao);

      finally
          if (XVendaDAO <> nil) then
          FreeAndNil(XVendaDAO);

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

function TVendaController.RetornaCondicaoVenda(
  pID: Integer; pRelacionada : Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                                  '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID))+         ' '#13;
end;

function TVendaController.RetornaCondicaoVenda_Item(pID_Venda: Integer;
  pRelacionada: Boolean): String;
var
  xChave : string;

begin
  if (pRelacionada) then
      xChave := 'ID_VENDA'

  else
      xChave := 'ID';

  Result :=
  'WHERE                                                        '#13+
  '  '+xChave+ ' = '+ QuotedStr(IntToStr(pID_Venda))+         ' '#13;
end;

end.
