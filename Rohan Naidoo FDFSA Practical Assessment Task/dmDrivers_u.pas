unit dmDrivers_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmDrivers = class(TDataModule)
    conDrivers: TADOConnection;
    tblDrivers: TADOTable;
    tblFDADrivers: TADOTable;
    tblApplicants: TADOTable;
    tblID: TADOTable;
    ADOTable5: TADOTable;
    qryDrivers: TADOQuery;
    dsDrivers: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDrivers: TdmDrivers;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmDrivers.DataModuleCreate(Sender: TObject);
begin
  With conDrivers do
  Begin
  ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
  'Data Source=Drivers.mdb;Persist Security Info=False';
  Connected := True;
  LoginPrompt := False;
  End;

  With tblDrivers do
  Begin
    Connection := conDrivers;
    TableName := 'tblDrivers';
    Active := True;
    Open;
  End;

  With tblFDADrivers do
  Begin
    Connection := conDrivers;
    TableName := 'tblFDADrivers';
    Open;
    Active := True;
  End;

  With qryDrivers do
  Begin
    Connection := conDrivers;
    Sql.Clear;
    Sql.Add('');
  End;

  With tblApplicants do
  Begin
    Connection := conDrivers;
    TableName := 'tblApplicants';
    Active := True;
    Open;
  End;

  With tblID do
  Begin
    Connection := conDrivers;
    TableName := 'tblID';
    Active := True;
    Open;
  End;

  With dsDrivers do
  Begin
    DataSet := qryDrivers;
  End;
end;

end.
