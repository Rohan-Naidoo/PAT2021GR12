unit ViewDrivers_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Objects, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, clsDriver_u, Data.DB;
CONST
  OBJECTYOFFSET = 30;
  OBJECTXOFFSET = 30;
  OBJECTYDIFF = 90;
  LABELXOFFSET = 8;
  RECTINCREASE = 5;
  RECTFONTINCREASE = 1;
type
  TfrmViewDrivers = class(TForm)
    sclayViewDrivers: TScaledLayout;
    lblCmb: TLabel;
    lblDriver: TLabel;
    memDriverInfo: TMemo;
    rectDriverInfo: TRectangle;
    rectPersonalDetails: TRectangle;
    lblAge: TLabel;
    lblCountry: TLabel;
    lblBorn: TLabel;
    lblAgeOut: TLabel;
    lblBornOut: TLabel;
    lblCountryOut: TLabel;
    rectDriverStats: TRectangle;
    lblRaces: TLabel;
    lblVictories: TLabel;
    lblPoles: TLabel;
    rectlblDriverstats: TRectangle;
    lblDriverStats: TLabel;
    lblVictoriesOut: TLabel;
    lblRacesOut: TLabel;
    lblPolesOut: TLabel;
    rectINFDA: TRectangle;
    lblINFDA: TLabel;
    rectCurrent: TRectangle;
    lblCurrentSeries: TLabel;
    lblCurrentSeriesOut: TLabel;
    lblDriverStatus: TLabel;
    lblDriverStatusOut: TLabel;
    rectImage: TRectangle;
    imgDriver: TImage;
    lblImage: TLabel;
    cmbSelectDriver: TComboBox;
    StyleBook1: TStyleBook;
    Circle1: TCircle;
    imgExit: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure cmbSelectDriverChange(Sender: TObject);
    procedure rectINFDAMouseEnter(Sender: TObject);
    procedure rectINFDAMouseLeave(Sender: TObject);
    procedure rectINFDAClick(Sender: TObject);
    procedure cmbSelectDriverClick(Sender: TObject);
    procedure lblINFDAClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }

    procedure RepositionObjects;

  public
    { Public declarations }
    arrDrivers : array of String;
    arrSupportedFiles : array[1..9] of String;
    objDriver : TDriver;
    bShown : Boolean;
    iCount : Integer;
    procedure PopDriverArray;

  end;

var
  frmViewDrivers: TfrmViewDrivers;



implementation
Uses
Background_u, dmDrivers_u, Home_u ;

{$R *.fmx}

procedure TfrmViewDrivers.cmbSelectDriverChange(Sender: TObject);
var
  sDriver, sFile, sID, sLine  : String;
  iPos : Integer;
  F : TextFile;
  bFound : Boolean;

begin

  //array population
  arrSupportedFiles[1] := '.bmp';
  arrSupportedFiles[2] := '.jpg';
  arrSupportedFiles[3] := '.jpeg';
  arrSupportedFiles[4] := '.png';
  arrSupportedFiles[5] := '.gif';
  arrSupportedFiles[6] := '.tif';
  arrSupportedFiles[7] := '.tiff';
  arrSupportedFiles[8] := '.ico';
  arrSupportedFiles[9] := '.hdp';
  arrSupportedFiles[9] := '.jfif';

  //Initial Declarations
  if cmbSelectDriver.ItemIndex = -1 then exit;
  lblDriver.Font.Size := 55;
  bShown := False;

  memDriverInfo.Lines.Clear;
  imgDriver.Visible := True;
  lblImage.Visible := False;
  lblCmb.Text := 'Select Another Driver';
  sDriver := cmbSelectDriver.Items[cmbSelectDriver.ItemIndex];
  iPos := POS('-', sDriver);
  Delete(sDriver,1, iPos);
  lblDriver.Text := sDriver;
  rectInFda.Visible := False;
  iCount := 0;

  //String handling to obtain a file name from the drivers name
  iPos := Pos('-', sDriver);
  Delete(sDriver, 1, iPos);
  iPos := Pos(' ',sDriver);
  sFile := Copy(sDriver, 1, iPos-1);
  Delete(sDriver, 1, iPos);
  sFile := sFile + '_' + sDriver;


   var bFile : Boolean;
   bFile := True;
  //loading driver info
  AssignFile(F, 'DriverInfo/' +sFile + '.txt');
  Try
    Reset(F);
  Except
    memDriverInfo.Lines.Add('The file for ' + lblDriver.Text +
    ' cannot be found');
    imgDriver.Bitmap.Clear($00ffffff);
    lblImage.BringToFront;
    bFile := False;
    PopDriverArray;
  End;

  if bFile = True then
  Begin
  while Not EOF(F) do
  Begin
    ReadLn(F,sLine);
    memDriverInfo.Lines.Add(sLine);
  End;
  CloseFile(F);

  PopDriverArray;
  End;

  var iNum, iFDAVictories, iFDARaces, iFDAPoles : Integer;
  var sFirstname, sSurname, sSql : String;
  //Creating Driver Object for ease of access
  sLine := lblDriver.text;
  iPos := POS(' ', sLine);
  sFirstName := Copy(sLine, 1, iPos-1);
  Delete(sLine, 1, iPos);
  sSurname := sLine;
  dmDrivers.tblDrivers.Locate('Firstname; Surname',
  VarArrayOF([sFirstName,sSurname]),
  [loCaseInsensitive]);

  Var bValidDriver : Boolean;
  bValidDriver := True;
  with dmDrivers.tblDrivers do
  Begin
    iNum := FieldByName('DriverNumber').AsInteger;

    if NOT(FieldByName('DriverStatus').Text = 'FDA') AND
       NOT(FieldByName('DriverStatus').Text = 'FDFSA') then
       bValidDriver := False;


    if (FieldByName('DriverStatus').Text = 'FDA') AND bValidDriver then
    Begin
      rectInFda.Visible := True;
      with dmDrivers.tblFDADrivers do
      Begin
        First;
        Locate('DriverNumber', iNum, [loCaseInsensitive]);
        iFDAVictories := FieldByName('FDAVictories').AsInteger;
        iFDARaces := FieldByName('FDARaces').AsInteger;
        iFDAPoles := FieldByName('FDAPoles').AsInteger;
      End;

    objDriver := TDriver.Create(FieldByName('FirstName').Text,
                                FieldByName('Surname').Text,
                                FieldByName('Country').Text,
                                FieldByName('CurrentSeries').Text,
                                FieldByName('Gender').Text,
                                iNum,
                                FieldByName('Races').AsInteger,
                                FieldByName('Victories').AsInteger,
                                FieldByName('Poles').AsInteger,
                                FieldByName('NumOfTitles').AsInteger,
                                iFDARaces, iFDAVictories, iFDAPoles,
                                FieldByName('DateOfBirth').AsDateTime);
    End
    else if bValidDriver then
    Begin
      objDriver := TDriver.Create(FieldByName('FirstName').Text,
                                  FieldByName('Surname').Text,
                                  FieldByName('Country').Text,
                                  FieldByName('CurrentSeries').Text,
                                  FieldByName('Gender').Text,
                                  iNum,
                                  FieldByName('Races').AsInteger,
                                  FieldByName('Victories').AsInteger,
                                  FieldByName('Poles').AsInteger,
                                  FieldByName('NumOfTitles').AsInteger,
                                  FieldByName('DateOfBirth').AsDateTime);
    End;
  End;


  //Assigning Obj values to components
  With objDriver do
  Begin
    lblAgeOut.Text := IntToStr(GetAge);
    lblBornOut.Text := DateToStr(GetDOB);
    lblCountryOut.Text := GetCountry;
    lblRacesOut.Text := IntToStr(GetRaces);
    lblPolesOut.Text := IntToStr(GetPoles);
    lblVictoriesOut.Text := IntToStr(GetVictories);
    lblCurrentSeriesOut.Text := GetCurrentSeries + '  ';
    if GetIsFDA = True
    then lblDriverStatusOut.Text := 'FDA Driver' + '  '
    else lblDriverStatusOut.Text := 'FDFSA Driver' + '  ';
  End;
  Var sDriverLine : String;
    bFound := False;
  //loading driver image
  if (objDriver.GetIsFDA = True) then
  for var I := 1 to 10 do
  Begin
  Try
  if FileExists('Drivers/' +sFile + arrSupportedFiles[I]) then
    Begin
      imgDriver.Bitmap.LoadFromFile('Drivers/' +sFile + arrSupportedFiles[I]);
      bFound := True;
    End;
  Except

  End;
  End
  else
  Begin
  sDriverLine := lblDriver.Text;
  iPos := POS(' ',sDriverLine);

  sFirstName := copy(sDriverLine,1, iPos-1);
  Delete(sDriverLine,1,iPos);
  sSurname := sDriverLine;

  with dmDrivers.tblApplicants do
    Begin
      Locate('Firstname; Surname; DateOfBirth',
      VarArrayOF([sFirstName,sSurname, DateToStr(ObjDriver.GetDOB)]),
      [loCaseInsensitive]);
      iNum := FieldByName('DriverNumber').AsInteger;

      with dmDrivers.tblID do
      Begin
        Locate('DriverNumber', iNum, [loCaseInsensitive]);
        sID := FieldByName('ID').AsString;
      End;
    End;
  End;


  sFile := 'Drivers/' + sFirstname + '_' + sSurname + sID;

  for Var I := 1 to 10 do
  Begin
    Try
    if FileExists(sFile + arrSupportedFiles[I]) then
      Begin
        imgDriver.Bitmap.LoadFromFile(sFile + arrSupportedFiles[I]);
        bFound := True;
      End;
    Except

    End;
  End;

  if bFound = False then
  Begin
    lblImage.Text := 'There is no image for ' + lblDriver.Text;
    lblImage.Visible := True;
  End;


end;

procedure TfrmViewDrivers.cmbSelectDriverClick(Sender: TObject);
begin
  PopDriverArray;
end;

procedure TfrmViewDrivers.FormCreate(Sender: TObject);
begin

//Form Adjustments
  With frmViewDrivers do
  Begin
    Parent := frmBackground;
    left := 0;
    Top := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Transparency := True;
  End;

  //Layout Adjustments
  With sclayViewDrivers do
  Begin
    Parent := PANEL;
    Position.X := 0;
    Position.Y := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Visible := False;
    BringToFront;
  End;

  //Label for Driver's Name
  With lblDriver do
  Begin
    Parent := sclayViewDrivers;
    Height := 100;
    Width := sclayViewDrivers.OriginalWidth;
    StyledSettings := lblDriver.StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET -0.25*lblDriver.height;
    Text := 'Please Select a driver to view';
    Font.Family := 'Century Gothic';
    Font.Size := 30;
    TextSettings.HorzAlign := TTextAlign.Center;
    Font.Style := Font.Style + [TFontStyle.fsBold];
  End;

  //rectangle that holds image
  With rectImage do
  Begin
    Parent := sclayViewDrivers;
    Position.X := sclayViewDrivers.OriginalWidth -rectImage.Width
                  - OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET + OBJECTYDIFF;
    Fill.Color := OBJECTCOLOR;

  End;

  //rectangle that holds driver info
  With rectDriverInfo do
  Begin
    Parent := sclayViewDrivers;
    Width := 300;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds personal Details
  With rectPersonalDetails do
  Begin
    Parent := sclayViewDrivers;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds DriverStats
  With rectDriverStats do
  Begin
    Parent := sclayViewDrivers;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds more current DriverStats
  With rectCurrent do
  Begin
    Parent := sclayViewDrivers;
    Fill.Color := OBJECTCOLOR;
  End;



  //memo that holds driver info
  With memDriverInfo do
  Begin
    Parent := rectDriverInfo;
    Width := 290;
    Position.X := 0.5*(rectDriverInfo.Width - memDriverInfo.Width);
    if bDarkmode then memDriverInfo.StyleLookup := 'DarkMemo'
    else memDriverInfo.StyleLookup := 'LightMemo';
    Align := TAlignLayout.Center;

    StyledSettings := memDriverInfo.StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;

  End;

  //Combobox to select a driver
  With cmbSelectDriver do
  Begin
    Parent := sclayViewDrivers;
    Position.X := rectImage.Position.X +
                  0.5*(rectImage.Width - cmbSelectDriver.Width);
    Position.Y := scLayViewDrivers.Height - cmbSelectDriver.height
                  - OBJECTYOFFSET ;
    if bDarkmode then cmbSelectDriver.StyleLookup := 'cmbSelectDriverDark'
    else cmbSelectDriver.StyleLookup := 'cmbSelectDriverLight';
  End;



  //label to display information if image is not loaded
  with lblImage do
  Begin
    Align := TalignLayout.Center;
    StyledSettings := lblImage.StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Font.Size := 20;
    Height := rectImage.Height;
    Width := rectImage.Width;
    TextSettings.WordWrap := True;
    TextSettings.HorzAlign := TTextAlign.Center;
    Visible := False;
  End;

  //Exit Image
  With imgExit do
  Begin
    Position.X := sclayViewDrivers.OriginalWidth - imgExit.Width
    - OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET;
  End;

  //Image to display Driver
  with imgDriver do
  begin
    Parent := rectImage;
    Align := TAlignLayout.Center;
    Visible := True;
    WrapMode := TImageWrapMode.Fit;
    MarginWrapMode := TImageWrapMode.Fit;
  end;

  //label inside of combobox
  with lblCmb do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Text := 'Select a Driver';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Position.X := 7;
    FontColor := TEXTCOLOR;
    Visible := True;
  End;

  //label indicating Age
  with lblAge do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label indicating Birthdate
  with lblBorn do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label indicating Country
  with lblCountry do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label Outputting Age
  with lblAgeOut do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Text := '';
    FontColor := TEXTCOLOR;
    Position.X := rectPersonalDetails.Width - Width - LABELXOFFSET;
  End;

  //label Outputting BirthDtae
  with lblBornOut do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectPersonalDetails.Width - Width - LABELXOFFSET;
    Text := '';
  End;

  //label Outputting Country
  with lblCountryOut do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectPersonalDetails.Width - Width - LABELXOFFSET;
    Text := '';
  End;

  //label indicating Races
  with lblRaces do
  Begin
    Parent := rectdriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label indicating Victories
  with lblVictories do
  Begin
    Parent := rectdriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label indicating Poles
  with lblPoles do
  Begin
    Parent := rectdriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label Outputting Races
  with lblRacesOut do
  Begin
    Parent := rectdriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectdriverStats.Width - Width - LABELXOFFSET;
    Text := '';
  End;

  //label Outputting Victories
  with lblVictoriesOut do
  Begin
    Parent := rectdriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectdriverStats.Width - Width - LABELXOFFSET;
    Text := '';
  End;

  //label Outputting Poles
  with lblPolesOut do
  Begin
    Parent := rectdriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectdriverStats.Width - Width - LABELXOFFSET;
    Text := '';
  End;

  //rectangle button to toggle FDA stats
  With rectInFDA do
  Begin
    Parent := rectDriverStats;
    Fill.Color := OBJECTCOLOR;
    Visible := False;
  End;

  //label for FDA button/rectangle
  with lblInFDA do
  Begin
    Parent := rectInFDA;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Align := TAlignLayout.Center;
    Text := 'IN FDA';
  End;

  //rectangle that indicates overall driver stats
  With rectlblDriverStats do
  Begin
    Parent := rectDriverStats;
    Fill.Color := OBJECTCOLOR;
  End;

  //label that indicates overall driver stats
  with lblDriverStats do
  Begin
    Parent := rectlblDriverStats;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Align := TAlignLayout.Center;
    Text := 'Overall Driver Stats';
  End;

  //label that indicates current series
  with lblCurrentSeries do
  Begin
    Parent := rectCurrent;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label that indicates current driver Status
  with lblDriverStatus do
  Begin
    Parent := rectCurrent;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELXOFFSET;
  End;

  //label Outputting Driver Series
  with lblCurrentSeriesOut do
  Begin
    Parent := rectCurrent;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectCurrent.Width - Width - LABELXOFFSET;
    Text := '';
  End;


  //label Outputting Driver Series
  with lblDriverStatusOut do
  Begin
    Parent := rectCurrent;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := rectCurrent.Width - Width - LABELXOFFSET;
    Text := '';
  End;

  //Declarations
  cmbSelectDriver.ItemIndex := -1;
end;

procedure TfrmViewDrivers.FormHide(Sender: TObject);
begin
  scLayViewDrivers.Visible := False;
end;

procedure TfrmViewDrivers.FormResize(Sender: TObject);
begin
  RepositionObjects;
end;

procedure TfrmViewDrivers.FormShow(Sender: TObject);
Var iCount : integer;
begin
  RepositionObjects;
  iCount := dmDrivers.tblDrivers.RecordCount;
  SetLength(arrDrivers, iCount);
  PopDriverArray;
  bShown := True;
end;

procedure TfrmViewDrivers.imgExitClick(Sender: TObject);
begin
if MessageDlg('Are you sure you want to exit to home page?',
     TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],0)
     = 6 then
  Begin
  ShownForm.Hide;
  frmHome.Show;
  ShownForm := frmHome;
  End;
end;

procedure TfrmViewDrivers.lblINFDAClick(Sender: TObject);
begin
  rectInFDA.OnClick(Self);
end;

procedure TfrmViewDrivers.PopDriverArray;
Var
   i : Integer;
begin
  i := -1;
  cmbSelectDriver.Clear;

  with dmDrivers do
  Begin
    tblDrivers.First;
    while not (tblDrivers.EOF) do
    Begin
      Inc(i);
      arrDrivers[i] := tblDrivers.FieldByName('FirstName').Text + ' ' +
                 tblDrivers.FieldByName('Surname').Text;
      cmbSelectDriver.Items.Add(tblDrivers.FieldByName('DriverNumber').AsString +
                                '-' + arrDrivers[i]);
      tblDrivers.Next;
    End;

  End;
end;

procedure TfrmViewDrivers.rectINFDAClick(Sender: TObject);
begin
inc(iCount);
  if iCount MOD 2 = 1 then
  Begin
    lblRaces.FontColor := ACCENTCOLOR;
    lblVictories.FontColor := ACCENTCOLOR;
    lblPoles.FontColor := ACCENTCOLOR;

    lblRacesOut.FontColor := ACCENTCOLOR;
    lblVictoriesOut.FontColor := ACCENTCOLOR;
    lblPolesOut.FontColor := ACCENTCOLOR;

    With ObjDriver do
    Begin
      lblRacesOut.Text := IntToStr(GetFDARaces);
      lblPolesOut.Text := IntToStr(GetFDAPoles);
      lblVictoriesOut.Text := IntToStr(GetFDAVictories);
    End;

    lblINFDA.Font.Style := lblINFDA.Font.Style + [TFontStyle.fsBold];
    rectINFDA.Hint := 'View Overall Driver Stats';
    lblInFDa.FontColor := TAlphaColors.White;
    rectINFDA.Fill.Color := ACCENTCOLOR;
  End
  else
  Begin
    lblRaces.FontColor := TEXTCOLOR;
    lblVictories.FontColor := TEXTCOLOR;
    lblPoles.FontColor := TEXTCOLOR;

    lblRacesOut.FontColor := TEXTCOLOR;
    lblVictoriesOut.FontColor := TEXTCOLOR;
    lblPolesOut.FontColor := TEXTCOLOR;

    With ObjDriver do
    Begin
      lblRacesOut.Text := IntToStr(GetRaces);
      lblPolesOut.Text := IntToStr(GetPoles);
      lblVictoriesOut.Text := IntToStr(GetVictories);
    End;



    lblINFDA.Font.Style := lblINFDA.Font.Style - [TFontStyle.fsBold];
    rectINFDA.Hint := 'View Ferrari Driver Academy Driver Stats';
    rectINFDA.Fill.Color := OBJECTCOLOR;
    lblInFDa.FontColor := TEXTCOLOR;
  End;

end;

procedure TfrmViewDrivers.rectINFDAMouseEnter(Sender: TObject);

begin
  with rectINFDA do
  Begin
    Height := rectINFDA.Height + RECTINCREASE;
    Position.Y := Position.Y - RECTINCREASE/2;
//    lblINFDA.Position.Y := lblINFDA.Position.Y + RECTINCREASE/2;
    lblINFDA.Font.Size := lblINFDA.Font.Size + RECTFONTINCREASE;
  End;
end;

procedure TfrmViewDrivers.rectINFDAMouseLeave(Sender: TObject);
begin
  with rectINFDA do
  Begin
    Height := rectINFDA.Height - RECTINCREASE;
    Position.Y := Position.Y + RECTINCREASE/2;
//    lblINFDA.Position.Y := lblINFDA.Position.Y - RECTINCREASE/2;
    lblINFDA.Font.Size := lblINFDA.Font.Size - RECTFONTINCREASE;
  End;
end;

procedure TfrmViewDrivers.RepositionObjects;
begin
  With sclayViewDrivers do
  Begin
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
  End;

  With imgExit do
  Begin
    Position.X := sclayViewDrivers.OriginalWidth -imgExit.Width - OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET;
  End;

  With lblDriver do
  Begin
    Position.X := OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET -0.25*lblDriver.height
  End;

  With rectImage do
  Begin
    Position.X := sclayViewDrivers.OriginalWidth -rectImage.Width
                  - OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET + OBJECTYDIFF;
  End;


  With cmbSelectDriver do
  Begin
    Clear;
  End;

end;

end.
