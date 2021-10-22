unit AdmitDrivers_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  Data.Bind.Components, Data.Bind.DBScope, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid,
  Data.DB, Datasnap.DBClient;

type
  TfrmAdmitDrivers = class(TForm)
    scLayAdmitDrivers: TScaledLayout;
    imgExit: TImage;
    lblDriver: TLabel;
    rectImage: TRectangle;
    imgDriver: TImage;
    rectStatus: TRectangle;
    lblPersonalDetails: TLabel;
    lblLapTime: TLabel;
    lblFinance: TLabel;
    lblPersonalDetailsOut: TLabel;
    lblFinanceOut: TLabel;
    lblLapTimeOut: TLabel;
    lblStatus: TLabel;
    lblStatusOut: TLabel;
    rectAdmit: TRectangle;
    rectDecline: TRectangle;
    lblDecline: TLabel;
    stgDrivers: TStringGrid;
    StyleBook1: TStyleBook;
    lblImage: TLabel;
    rectID: TRectangle;
    edtID: TEdit;
    rectSave: TRectangle;
    lblSave: TLabel;
    cirPersonal: TCircle;
    cirFinance: TCircle;
    lblAdmit: TLabel;
    Circle1: TCircle;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtIDClick(Sender: TObject);
    procedure edtIDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure rectConfirmClick(Sender: TObject);
    procedure lblSaveClick(Sender: TObject);
    procedure rectSaveClick(Sender: TObject);
    procedure stgDriversCellClick(const Column: TColumn; const Row: Integer);
    procedure cirFinanceClick(Sender: TObject);
    procedure cirPersonalClick(Sender: TObject);
    procedure rectAdmitClick(Sender: TObject);
    procedure lblAdmitClick(Sender: TObject);
    procedure rectDeclineClick(Sender: TObject);
    procedure lblDeclineClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }
    iTogPersonal, iTogFinance : Integer;
    sTime, sDriverID : String;
    Procedure CheckAdmit;
    Procedure Display;
  public
    { Public declarations }
    bAdminUser, bModUser : Boolean;
  end;

var
  frmAdmitDrivers: TfrmAdmitDrivers;

implementation
  Uses
  Background_u, dmDrivers_u, ViewDrivers_u, clsDriver_u, Home_u;
{$R *.fmx}


procedure TfrmAdmitDrivers.CheckAdmit;
begin
  if (lblPersonalDetailsOut.FontColor = $FF008C45) AND
     (lblFinanceOut.FontColor = $FF008C45) AND
     (lblLapTimeOut.FontColor = $FF008C45) then
     rectAdmit.Visible := True
     else rectAdmit.Visible := False;

     if lblStatusOut.FontColor <> $FFFFF200 then
     rectAdmit.Visible := False;
     if lblStatusOut.FontColor = $FFD40000 then rectDecline.Visible := False;


end;

procedure TfrmAdmitDrivers.cirFinanceClick(Sender: TObject);
begin
  if NOT(bAdmin) And NOT(bModerator) then exit;
  inc(iTogFinance);
  With lblFinanceOut do
  Begin
  case iTogFinance MOD 3 of
  0 :
    Begin
    Text := 'Pending';
    FontColor := $FFFFF200;
    End;
  1 :
    Begin
    Text := 'Verified';
    FontColor := $FF008C45;
    End;
  2 :
    Begin
    Text := 'Incorrect';
    FontColor := $FFD40000;
    End;
  end;
  End;
  if rectSave.Visible = False then rectSave.Visible := True;
  CheckAdmit;
end;

procedure TfrmAdmitDrivers.cirPersonalClick(Sender: TObject);
begin
if NOT(bAdmin) And NOT(bModerator) then exit;

  inc(iTogPersonal);
  With lblPersonalDetailsOut do
  Begin
  case iTogPersonal MOD 3 of
  0 :
    Begin
    Text := 'Pending';
    FontColor := $FFFFF200;
    End;
  1 :
    Begin
    Text := 'Verified';
    FontColor := $FF008C45;
    End;
  2 :
    Begin
    Text := 'Incorrect';
    FontColor := $FFD40000;
    End;
  end;
  End;
  if rectSave.Visible = False then rectSave.Visible := True;

  CheckAdmit;
end;

procedure TfrmAdmitDrivers.Display;
Var
  strCol : TStringColumn;
  Word, WMax : Real;
begin




  With dmDrivers.qryDrivers do
  Begin
  Open;

    for Var iCol := 1 to 4 do
      begin
        strCol := TStringColumn.Create(stgDrivers);
        strCol.Header := Fields[iCol-1].FieldName;
        stgDrivers.AddObject(strCol);
        Wmax := strCol.Header.Length *7;
        First;
        for Var iRow := 1 to RecordCount do
          Begin
            stgDrivers.Cells[iCol-1, iRow-1] := Fields[iCol-1].AsString;
            Word :=
            stgDrivers.Canvas.TextWidth(stgDrivers.Cells[iCol-1, iRow-1]);
            if Word > WMax then
            WMax := Word;
            Next;
          End;
          strCol.Width := WMax + 15;


      end;

  End;


end;

procedure TfrmAdmitDrivers.edtIDClick(Sender: TObject);
begin
  if edtID.Text[1] = 'P' then edtID.Text := '';

end;

procedure TfrmAdmitDrivers.edtIDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
Var
  iDNum : Integer;
  sDBTime : String;
begin
  if NOT (KeyChar in ['0'..'9', Chr(8), chr(127)]) then KeyChar := #0;
  if edtID.Text.Length = 13 then
  Begin
  edtID.Enabled := False;
  With dmDrivers.tblID do
  Begin
    Locate('ID', edtID.Text, [loCaseInsensitive]);
    iDNum := FieldByName('DriverNumber').AsInteger;
  End;

  With dmDrivers.tblID do
  Begin
  Locate('DriverNumber', iDNum, [loCaseInsensitive]);
  lblStatusOut.text := FieldByName('Status').AsString;

      if lblStatusOut.Text = 'Pending' then
        lblStatusOut.FontColor := $FFFFF200 else
        if lblStatusOut.Text = 'Admitted' then
        lblStatusOut.FontColor := $FF008C45 else
        if lblStatusOut.Text = 'Declined' then
        Begin
        lblStatusOut.FontColor := $FFD40000;
        rectAdmit.Visible := False;
        End;

      sDriverID := edtID.Text;
  End;

  Var bFound : Boolean;
  Var sFile : String;
  bFound := False;

  With DmDrivers.tblApplicants do
  Begin
    First;
    while Not DmDrivers.tblApplicants.Eof do
    Begin
      if (iDNum = FieldByName('DriverNumber').AsInteger) then
      Begin
        lblPersonalDetailsOut.Text := FieldByName('PersonalDetails').AsString;
        lblFinanceOut.Text := FieldByName('FinancialAid').AsString;
        lblLapTimeOut.Text := FieldByName('KyalamiLapTime').AsString;
        lblDriver.Text := FieldByName('FirstName').AsString + ' ' +
                          FieldByName('Surname').AsString;

        for Var I := 1 to 9 do
        begin
          sFile := 'Drivers/' + FieldByName('FirstName').AsString + '_' +
                        FieldByName('Surname').AsString + sDriverID +
                        frmViewDrivers.arrSupportedFiles[i];
          if FileExists(sFile) then
          Begin
            bFound := True;
            imgDriver.Bitmap.LoadFromFile(sFile);
          End;
        end;
        if bFound = False then lblImage.Visible := True;

        if lblPersonalDetailsOut.Text = 'Pending' then
        lblPersonalDetailsOut.FontColor := $FFFFF200 else
        if lblPersonalDetailsOut.Text = 'Verified' then
        lblPersonalDetailsOut.FontColor := $FF008C45 else
        if lblPersonalDetailsOut.Text = 'Incorrect' then
        lblPersonalDetailsOut.FontColor := $FFD40000;

        if lblFinanceOut.Text = 'Pending' then
        lblFinanceOut.FontColor := $FFFFF200 else
        if lblFinanceOut.Text = 'Verified' then
        lblFinanceOut.FontColor := $FF008C45 else
        if lblFinanceOut.Text = 'Incorrect' then
        lblFinanceOut.FontColor := $FFD40000;

        if lblStatusOut.Text = 'Pending' then
        lblStatusOut.FontColor := $FFFFF200 else
        if lblStatusOut.Text = 'Accepted' then
        lblStatusOut.FontColor := $FF008C45 else
        if lblStatusOut.Text = 'Declined' then
        lblStatusOut.FontColor := $FFD40000;

        sDBTime := lblLapTimeOut.Text;
        if StrToTime(Copy(sDBTime,1,Length(sDBTime)-1)) > StrToTime(sTime) then
        lblLapTimeOut.FontColor := $FFD40000 else
        if StrToTime(Copy(sDBTime,1,Length(sDBTime)-1)) <= StrToTime(sTime) then
        lblLapTimeOut.FontColor := $FF008C45;
        CheckAdmit;
      End;
      Next;
    End;
  End;
  End;
  edtID.Enabled := True;
end;



procedure TfrmAdmitDrivers.FormCreate(Sender: TObject);
begin
  //Declarations
  iTogPersonal := 0;
  iTogFinance := 0;

  //Form Adjustments
  With frmAdmitDrivers do
  Begin
    Parent := frmBackground;
    left := 0;
    Top := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Transparency := True;
  End;

  //Layout Adjustments
  With sclayAdmitDrivers do
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
      Parent := sclayAdmitDrivers;
      Height := 100;
      Width := sclayAdmitDrivers.OriginalWidth;
      StyledSettings := lblDriver.StyledSettings -
                               [TStyledSetting.FontColor] -
                               [TStyledSetting.Family] -
                               [TStyledSetting.Style] -
                               [TStyledSetting.Size] -
                               [TStyledSetting.Other];
      FontColor := TEXTCOLOR;
      Text := 'Please select a driver to manage';
      Font.Family := 'Century Gothic';
      Font.Size := 30;
      TextSettings.HorzAlign := TTextAlign.Center;
      Font.Style := Font.Style + [TFontStyle.fsBold];
    End;

  //String Grid for Selecting Drivers
  With stgDrivers do
  Begin
    Parent := scLayAdmitDrivers;
    for Var I := 0 to 2 do
    Begin
      AddObject(TStringColumn.Create(stgDrivers));
    End;

    for Var I := 0 to 2 do
      Columns[I].Width := 12;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;

    if bDarkMode then
    Begin
      StyleLookup := 'stgDark';
    End
    else StyleLookup := 'stgLight';
    Options := Options + [TGridOption.RowSelect];
    Visible := False;

  End;

  //rectangle that holds image
  With rectImage do
  Begin
    Parent := scLayAdmitDrivers;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that indicates status details
  With rectStatus do
  Begin
    Parent := scLayAdmitDrivers;
    Fill.Color := OBJECTCOLOR;
  End;

  //Label Indicating Personal Details
  with lblPersonalDetails do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
  End;

  //Label Indicating Financial aAd
  with lblFinance do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];

    FontColor := TEXTCOLOR;
  End;

  //label Indicating Lap Time
  with lblLapTime do
  Begin
    StyledSettings := styledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
  End;

  //Label Indicating Application Status
  with lblStatus do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
  End;

  //Label Outputting Personal Details
  with lblPersonalDetailsOut do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Text := '';
    BringToFront;
    FontColor := TEXTCOLOR;
  End;

  //Label Outputting Financial Aid
  with lblFinanceOut do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    BringToFront;
    Text := '';
    FontColor := TEXTCOLOR;
  End;


  //Label Outputting Lap Time
  with lblLapTimeOut do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Text := '';
    FontColor := TEXTCOLOR;
  End;

  //Label Outputting Application Status
  with lblStatusOut do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Text := '';
    FontColor := TEXTCOLOR;
  End;

  //Label displaying 'not found' message
  with lblImage do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    TextSettings.HorzAlign := TTextAlign.Center;
    Text := 'An image for this driver could not be found';
    FontColor := TEXTCOLOR;
    Visible := False;
  End;

  //rectangle that will admit the driver
  With rectAdmit do
  Begin
    Parent := scLayAdmitDrivers;
    Visible := False;
  End;

  //rectangle that will decline the driver
  With rectDecline do
  Begin
    Parent := scLayAdmitDrivers;
    Visible := False;
  End;

  //rectangle that will save changes to database
  With rectSave do
  Begin
    Parent := scLayAdmitDrivers;
    Visible := False;
  End;

  //label indicating to save progress
  with lblSave do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    TextSettings.HorzAlign := TTextAlign.Center;
    Text := 'Save Changes';
    FontColor := TEXTCOLOR;
  End;

  //Edit for entering ID
  With edtID do
  Begin
    FontColor := TEXTCOLOR;
    Text := 'Please type in driver''s ID number';
  End;

  //circle for toggling status of personal details
  with cirPersonal do
  Begin
    Visible := False;
  End;

  //circle for toggling status of Financial Aid;
  with cirFinance do
  Begin
    Visible := False;
  End;
end;

procedure TfrmAdmitDrivers.FormHide(Sender: TObject);
begin
  scLayAdmitDrivers.Visible := False;
end;

procedure TfrmAdmitDrivers.FormResize(Sender: TObject);
begin
  scLayAdmitDrivers.Width := PANEL.Width;
  scLayAdmitDrivers.Height := PANEL.Height;
end;

procedure TfrmAdmitDrivers.FormShow(Sender: TObject);
Var F : TextFile;
begin
  if dmDrivers.tblApplicants.RecordCount >= dmDrivers.tblDrivers.RecordCount
    then stgDrivers.RowCount := dmDrivers.tblApplicants.RecordCount
    else stgDrivers.RowCount := dmDrivers.tblDrivers.RecordCount;

    if frmAdmitDrivers.bAdminUser then bAdmin := True;
    if frmAdmitDrivers.bModUser then bModerator := True;




  AssignFile(F,'AppData.txt');
  try
    Reset(F);
  Except
    MessageDlg('Application Data File cannot be found, please consult an ' +
    'FDFSA Administrator',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  end;

  for var I := 1 to 4 do
    readLn(F);

  ReadLn(F, sTime);
  sTime := Copy(sTime,1,Length(sTime)-1);
  CloseFile(F);

  if (bAdmin) or (bModerator) then
  Begin
  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT tblApplicants.DriverNumber, ' +
                       'tblApplicants.FirstName, ' +
                       'tblApplicants.Surname, tblID.ID ' +
                       'FROM tblApplicants, tblID ' +
                       'WHERE tblApplicants.DriverNumber = tblID.DriverNumber '+
                       'ORDER BY tblApplicants.DriverNumber ASC');
    qryDrivers.ExecSQL;
  End;

  stgDrivers.ClearColumns;

  Display;
  End;
end;

procedure TfrmAdmitDrivers.imgExitClick(Sender: TObject);
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

procedure TfrmAdmitDrivers.lblDeclineClick(Sender: TObject);
begin
  rectDecline.OnClick(rectDecline);
end;

procedure TfrmAdmitDrivers.lblAdmitClick(Sender: TObject);
begin
  rectAdmit.OnClick(rectAdmit);
end;

procedure TfrmAdmitDrivers.lblSaveClick(Sender: TObject);
begin
  rectSave.OnClick(rectSave);
end;

procedure TfrmAdmitDrivers.rectAdmitClick(Sender: TObject);
Var
  iDNum : Integer;
  ObjDriver : TDriver;
begin

  With DmDrivers.tblID do
  Begin
    First;
    while Not EOF do
    Begin
      if sDriverID = FieldByName('ID').AsString then
      Begin
        iDNum := FieldByName('DriverNumber').AsInteger;

        with dmDrivers do
        Begin
          qryDrivers.SQL.Clear;
          qryDrivers.SQL.Add('UPDATE tblID ' +
                         'SET Status = "Admitted" ' +
                         'WHERE DriverNumber = ' + IntToStr(iDNum));
          qryDrivers.ExecSQL;
          qryDrivers.SQL.Clear;
          qryDrivers.SQL.Add('UPDATE tblApplicants ' +
                         'SET PersonalDetails = "Verified", ' +
                         'FinancialAid = "Verified" ' +
                         'WHERE DriverNumber = ' + IntToStr(iDNum));
          qryDrivers.ExecSQL;
        End;
      End;
      Next;
    End;
  End;
  var sFirstName, sSurname, sLine, sSql : String;
  var iPos, iRecCount : Integer;
  with dmDrivers do
  Begin
  sLine := lblDriver.Text;

  iPos := POS(' ',sLine);
  sFirstName := Copy(sLine,1, IPos -1);
  Delete(sLine, 1, iPos);
  sSurname := sLine;

  dmDrivers.tblApplicants.Locate('Firstname; Surname',
  VarArrayOF([sFirstName,sSurname]),
  [loCaseInsensitive]);
  iRecCount := tblDrivers.RecordCount;
  With tblApplicants do
  Begin
  objDriver := TDriver.Create(FieldByName('FirstName').Text,
                                  FieldByName('Surname').Text,
                                  'South Africa',
                                  'None',
                                  FieldByName('Gender').Text,
                                  iRecCount+1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  FieldByName('DateOfBirth').AsDateTime);
  End;

    qryDrivers.SQL.Clear;
    sSql := 'INSERT INTO tblDrivers (DriverNumber, FirstName, ' +
                      'Surname, DateOfBirth, Country, Races, ' +
                      'Victories, Poles, CurrentSeries, ' +
                      'NumOfTitles, DriverStatus, Gender) ' +
                      'VALUES (' + IntToStr(iRecCount+1) + ', ' +
                                   '"' + sFirstName + '", ' +
                                   '"' + sSurname + '", ' +
                                   '#' + DateToStr(objDriver.GetDOB) + '#, ' +
                                   '"South Africa", ' +
                                   '0, ' +
                                   '0, ' +
                                   '0, ' +
                                   '"None", ' +
                                   '0, ' +
                                   '"FDFSA",' +
                                   '"' + objDriver.GetGender + '")';
    qryDrivers.SQL.Add(sSql);
    qryDrivers.ExecSQL;
  End;

   MessageDlg('Admission successful!',
   TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK],0);

end;

procedure TfrmAdmitDrivers.rectConfirmClick(Sender: TObject);
Var
  sID, sDBTime : String;
  iDNum : Integer;
begin

end;

procedure TfrmAdmitDrivers.rectDeclineClick(Sender: TObject);
Var
  iDNum : Integer;
begin
  With DmDrivers.tblID do
  Begin
    First;
    while Not EOF do
    Begin
      if sDriverID = FieldByName('ID').AsString then
      iDNum := FieldByName('DriverNumber').AsInteger;
      with DmDrivers do
      Begin
      qryDrivers.SQL.Clear;
      qryDrivers.SQL.Add('UPDATE tblID ' +
                       'SET Status = "Declined"' +
                       'WHERE ID = "' + sDriverID + '"');
      qryDrivers.ExecSQL;
      End;
      Next;
    End;
  End;

  With DmDrivers.tblApplicants do
  Begin
    First;
    if iDNum = FieldByName('DriverNumber').AsInteger then
    Begin
      with dmDrivers do
      Begin
        qryDrivers.SQL.Clear;
        qryDrivers.SQL.Add('UPDATE tblApplicants ' +
                       'SET PersonalDetails = "' + lblPersonalDetailsout.Text
                       +'", '+
                       'FinancialAid = "' + lblFinanceOut.Text +'" '+
                       'WHERE DriverNumber = ' + IntToStr(iDNum));
        qryDrivers.ExecSQL;

        qryDrivers.SQL.Clear;
        qryDrivers.SQL.Add('INSERT INTO tblDeniedIDs(ID) ' +
                           'VALUES("' + sDriverID + '")');
        qryDrivers.ExecSQL;
      End;
    End;

  End;
end;

procedure TfrmAdmitDrivers.rectSaveClick(Sender: TObject);
Var
iDNum : Integer;
begin
  With DmDrivers.tblID do
  Begin
    First;
    while Not EOF do
    Begin
      if sDriverID = FieldByName('ID').AsString then
      iDNum := FieldByName('DriverNumber').AsInteger;
      Next;
    End;
  End;

  With DmDrivers.tblApplicants do
  Begin
    First;
    if iDNum = FieldByName('DriverNumber').AsInteger then
    Begin
      with dmDrivers do
      Begin
        qryDrivers.SQL.Clear;
        qryDrivers.SQL.Add('UPDATE tblApplicants ' +
                       'SET PersonalDetails = "' + lblPersonalDetailsout.Text
                       +'", '+
                       'FinancialAid = "' + lblFinanceOut.Text +'" '+
                       'WHERE DriverNumber = ' + IntToStr(iDNum));
        qryDrivers.ExecSQL;
      End;
    End;

  End;
end;

procedure TfrmAdmitDrivers.stgDriversCellClick(const Column: TColumn;
  const Row: Integer);
Var
  sID, sDBTime : String;
  iDNum : Integer;
begin
if NOT (stgDrivers.Row IN[0..stgDrivers.RowCount-1]) then
  Begin
    MessageDlg('Please select a driver to manage',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;
  sID := stgDrivers.Cells[3,Stgdrivers.Row];

  with dmDrivers.tblID do
  Begin
    First;
    while Not Eof do
    Begin
      if FieldByName('ID').AsString = sID
      then
      Begin
      iDNum := FieldByName('DriverNumber').AsInteger;
      lblStatusOut.text := FieldByName('Status').AsString;

      if lblStatusOut.Text = 'Pending' then
        lblStatusOut.FontColor := $FFFFF200 else
        if lblStatusOut.Text = 'Admitted' then
        lblStatusOut.FontColor := $FF008C45 else
        if lblStatusOut.Text = 'Declined' then
        Begin
        lblStatusOut.FontColor := $FFD40000;
        rectAdmit.Visible := False;
        End;

      sDriverID := sID;
      edtID.Text := sDriverID;
      End;
      Next;
    End;
  End;

  Var bFound : Boolean;
  Var sFile : String;
  bFound := False;

  With DmDrivers.tblApplicants do
  Begin
    First;
    while Not DmDrivers.tblApplicants.Eof do
    Begin
      if (iDNum = FieldByName('DriverNumber').AsInteger) then
      Begin
        lblPersonalDetailsOut.Text := FieldByName('PersonalDetails').AsString;
        lblFinanceOut.Text := FieldByName('FinancialAid').AsString;
        lblLapTimeOut.Text := FieldByName('KyalamiLapTime').AsString;
        lblDriver.Text := FieldByName('FirstName').AsString + ' ' +
                          FieldByName('Surname').AsString;

        for Var I := 1 to 9 do
        begin
          sFile := 'Drivers/' + FieldByName('FirstName').AsString + '_' +
                        FieldByName('Surname').AsString + sDriverID +
                        frmViewDrivers.arrSupportedFiles[i];
          if FileExists(sFile) then
          Begin
            bFound := True;
            imgDriver.Bitmap.LoadFromFile(sFile);
          End;
        end;
        if bFound = False then lblImage.Visible := True;

        if lblPersonalDetailsOut.Text = 'Pending' then
        lblPersonalDetailsOut.FontColor := $FFFFF200 else
        if lblPersonalDetailsOut.Text = 'Verified' then
        lblPersonalDetailsOut.FontColor := $FF008C45 else
        if lblPersonalDetailsOut.Text = 'Incorrect' then
        lblPersonalDetailsOut.FontColor := $FFD40000;

        if lblFinanceOut.Text = 'Pending' then
        lblFinanceOut.FontColor := $FFFFF200 else
        if lblFinanceOut.Text = 'Verified' then
        lblFinanceOut.FontColor := $FF008C45 else
        if lblFinanceOut.Text = 'Incorrect' then
        lblFinanceOut.FontColor := $FFD40000;

        if lblStatusOut.Text = 'Pending' then
        lblStatusOut.FontColor := $FFFFF200 else
        if lblStatusOut.Text = 'Accepted' then
        lblStatusOut.FontColor := $FF008C45 else
        if lblStatusOut.Text = 'Declined' then
        lblStatusOut.FontColor := $FFD40000;

        sDBTime := lblLapTimeOut.Text;
        if StrToTime(Copy(sDBTime,1,Length(sDBTime)-1)) > StrToTime(sTime) then
        lblLapTimeOut.FontColor := $FFD40000 else
        if StrToTime(Copy(sDBTime,1,Length(sDBTime)-1)) <= StrToTime(sTime) then
        lblLapTimeOut.FontColor := $FF008C45;
        CheckAdmit;
      End;
      Next;
    End;
  End;
end;

end.
