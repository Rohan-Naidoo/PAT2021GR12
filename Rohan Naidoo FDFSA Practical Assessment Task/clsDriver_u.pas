unit clsDriver_u;

interface
uses
  System.SysUtils, DateUtils, FMX.Dialogs;
type
  TDriver = class(TObject)

  Private
    fFirstName, fSurname, fCountry, fCurrentSeries, fGender : String;
    fNumber, fRaces, fVictories, fPoles, fNumOfTitles,
    fFDARaces, fFDAVictories, fFDAPoles: Integer;
    fISFDA : Boolean;
    fDOB : TDateTime;
  Public
    Constructor Create(sFirstName, sSurname, sCountry, sCurrentSeries,
                sGender : String;
                iNumber, iRaces, iVictories, iPoles, iNumOfTitles : Integer;
                dDOB : TDateTime);
                Overload;
    Constructor Create(sFirstName, sSurname, sCountry, sCurrentSeries,
                sGender : String;
                iNumber, iRaces, iVictories, iPoles, iNumOfTitles,
                iFDARaces, iFDAVictories, iFDAPoles : Integer;
                dDOB : TDateTime);
                Overload;
    Function GetFirstName : String;
    Function GetSurname : String;
    Function GetCountry : String;
    Function GetGender : String;
    Function GetCurrentSeries : String;
    Function GetNumber : Integer;
    Function GetRaces : Integer;
    Function GetPoles : Integer;
    Function GetNumOfTitles : Integer;
    Function GetVictories : Integer;

    Function GetFDARaces : Integer;
    Function GetFDAVictories : Integer;
    Function GetFDAPoles : Integer;

    Function GetIsFDA : Boolean;
    Function GetAge : Integer;
    Function GetDOB : TDateTime;

  end;
implementation

{ TDriver }

constructor TDriver.Create(sFirstName, sSurname, sCountry,
  sCurrentSeries, sGender: String; iNumber, iRaces, iVictories, iPoles, iNumOfTitles,
  iFDARaces, iFDAVictories, iFDAPoles: Integer;
  dDOB : TDateTime);
begin
  fisFDA := True;

  fFirstName := sFirstName;
  fSurname := sSurname;
  fDOB := dDOB;
  fCountry := sCountry;
  fCurrentSeries := sCurrentSeries;
  fNumber := iNumber;
  fRaces := iRaces;
  fVictories := iVictories;
  fPoles := iPoles;
  fNumOfTitles := iNumOfTitles;
  fFDARaces := iFDARaces;
  fFDAVictories := iFDAVictories;
  fFDAPoles := iFDAVictories;

end;

function TDriver.GetAge: Integer;
Var
  iDays : Integer;
begin
  iDays := DaysBetween(Now, fDOB);
  Result := Trunc(iDays/365.2425);
end;

function TDriver.GetCountry: String;
begin
  Result := fCountry;
end;

function TDriver.GetCurrentSeries: String;
begin
  Result := fCurrentSeries;
end;

function TDriver.GetDOB: TDateTime;
begin
  Result := fDOB;
end;

function TDriver.GetFDAPoles: Integer;
begin
  Result := fFDAPoles;
end;

function TDriver.GetFDARaces: Integer;
begin
  Result := fFDARaces;
end;

function TDriver.GetFDAVictories: Integer;
begin
  Result := fFDAVictories;
end;

function TDriver.GetFirstName: String;
begin
  Result := fFirstName;
end;


function TDriver.GetGender: String;
begin
  Result := fGender;
end;

function TDriver.GetIsFDA: Boolean;
begin
  Result := fIsFDA;
end;

function TDriver.GetNumber: Integer;
begin
  Result := fNumber;
end;

function TDriver.GetNumOfTitles: Integer;
begin
  Result := fNumOfTitles;
end;

function TDriver.GetPoles: Integer;
begin
  Result := fPoles;
end;

function TDriver.GetRaces: Integer;
begin
    Result := fRaces;
end;

function TDriver.GetSurname: String;
begin
  Result := fSurname;
end;

function TDriver.GetVictories: Integer;
begin
  Result := fVictories;
end;

constructor TDriver.Create(sFirstName, sSurname, sCountry,
  sCurrentSeries, sGender: String; iNumber, iRaces, iVictories, iPoles,
  iNumOfTitles: Integer;
  dDOB : TDateTime);
begin
  fisFDA := False; //FDFSA driver
  fDOB := dDOB;
  fFirstName := sFirstName;
  fSurname := sSurname;
  fCountry := sCountry;
  fCurrentSeries := sCurrentSeries;
  fNumber := iNumber;
  fRaces := iRaces;
  fVictories := iVictories;
  fPoles := iPoles;
  fNumOfTitles := iNumOfTitles;
  fGender := sGender;

  fFDARaces := 0;
  fFDAVictories := 0;
  fFDAPoles := 0;
end;

end.
