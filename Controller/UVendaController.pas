unit UVendaController;

interface

uses SysUtils, Math, StrUtils, UConexao, UVenda;

type
  TVendaController = class
      public
        constructor Create;
        function GravaVenda(
                      pVenda : TVenda;
                      pColVenda : TColVenda) : Boolean;
        function ExcluiVenda(
                      pVenda : TVenda) : Boolean;
        function BuscaVenda(pID : Integer) : TVenda;
        function PesquisaVenda(pNome : string) : TColVenda;
        function RetornaCondicaoVenda(
                   pID: Integer;
                   pRelacionada : Boolean = False) : String;

      published
        class function getInstancia : TVendaController;
  end;

implementation

uses UVendaDAO;

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
       Result         := XVendaDAO.Retorna(RetornaCondicaoVenda(pID));

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
                      pColVenda : TColVenda) : Boolean;
var
   XVendaDAO   : TVendaDAO;
   xAux          : Integer;
begin
    try
        try
            TConexao.get.iniciaTransacao;

            Result := False;

            XVendaDAO   :=
              TVendaDAO.Create(TConexao.get.getConn);


            if pVenda.Id = 0 then
            begin
               XVendaDAO.Insere(pVenda);

             for xAux := 0 to pred(pColVenda.Count) do
                pColVenda.Retorna(xAux).Id := pVenda.Id;
                XVendaDAO.InsereLista(pColVenda)
            end
            else
            begin
               XVendaDAO.Atualiza(pVenda, RetornaCondicaoVenda(pVenda.Id));
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

function TVendaController.PesquisaVenda(pNome: string): TColVenda;
var
  XVendaDAO  : TVendaDAO;
  xCondicao   : string;
begin
  try
      try
        Result := nil;
        XVendaDAO := TVendaDAO.Create(TConexao.get.getConn);

        xCondicao :=  IfThen(pNome <> EmptyStr,
                  'WHERE                                        '#13+
                  '    (DESCRICAO LIKE UPPER(''%'+ pNome +'%''))'#13+
                  'ORDER BY DESCRICAO, ID', EmptyStr);

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

end.