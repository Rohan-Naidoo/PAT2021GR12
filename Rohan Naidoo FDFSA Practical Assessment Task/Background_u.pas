unit Background_u;
//Dev Notes
//Strange glitches with mouse enterS
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.Filter.Effects, System.Math, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Ani, FMX.Grid;
CONST
  CIRCLEDIAMETER = 400;
  TIMERINTERVAL = 10;
  CIRCLESCALERATE = 0.005;
  CIRCLEMAXNUM = 10;   //Can't be less than 3
  MAXCIRCLEINCREASE = 150;
  CIRCLEMAXSCALE = 5;
  RECTXYRADIUS = 50;
  RECTWIDTH = 40;
  TOOLBARHEIGHT = 30;
  IMAGESIDE = 15;
  PANELXOFFSET = 200;
  PANELYOFFSET = 100;
type
  TfrmBackground = class(TForm)
    rectToolbar: TRectangle;
    tmrCircles: TTimer;
    imgMin: TImage;
    imgClose: TImage;
    imgMaxRes: TImage;
    rectMin: TRectangle;
    rectMaxRes: TRectangle;
    rectClose: TRectangle;
    imgDark: TImage;
    rectDarkMode: TRectangle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tmrCirclesTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure rectToolbarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rectMaxResClick(Sender: TObject);
    procedure imgMaxResClick(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure imgMinClick(Sender: TObject);
    procedure imgCloseMouseEnter(Sender: TObject);
    procedure imgMaxResMouseEnter(Sender: TObject);
    procedure imgMinMouseEnter(Sender: TObject);
    procedure rectCloseClick(Sender: TObject);
    procedure rectMinClick(Sender: TObject);
    procedure imgCloseMouseLeave(Sender: TObject);
    procedure imgMaxResMouseLeave(Sender: TObject);
    procedure imgMinMouseLeave(Sender: TObject);
    procedure rectToolbarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure imgDarkClick(Sender: TObject);
    procedure rectDarkModeClick(Sender: TObject);
  private
    { Private declarations }
    arrCircles : array[1..CIRCLEMAXNUM] of TCircle;
    iCircleIncrease, iCircleXStart, iFormSection : Integer;
    rTotIncrease : Real;
    CIRCLECOLOR : TAlphaColor;
    bGrowing, bMaximised, bMouseDown  : Boolean;
    procedure RepositionObjects; overload;
    procedure CloseApp;
    procedure RepositionObjects(form : TForm); overload;
    procedure ReloadTheme;
  public
    { Public declarations }
    rectPanel : TRectangle;
  end;

var
  frmBackground: TfrmBackground;
  ShownForm : Tform;
  STROKECOLOR, ACCENTCOLOR, OBJECTCOLOR, COLOR1,
  TOOLBARCOLOR, TOOLBARCOLORCLICK, TEXTCOLOR   : TAlphaColor;
  PANEL : TRectangle;
  bDarkMode, bAdmin, bModerator : Boolean;

implementation
Uses
  Login_u, ViewDrivers_u, Home_u, SponsorDriver_u, dmDrivers_u, ManageDrivers_u,
  AdmitDrivers_u;

{$R *.fmx}


procedure TfrmBackground.CloseApp;
begin
  tmrCircles.Enabled := False;
  if frmViewDrivers.bShown = True then
    SetLength(frmViewDrivers.arrDrivers, 0);
  frmManageDrivers.stgManage.Selected := -1;
  for var i := 1 to CIRCLEMAXNUM do  arrCircles[i].Destroy;
  With dmDrivers Do
  Begin
    conDrivers.Connected := False;
    tblDrivers.Close;
    tblFDADrivers.Close;
    tblApplicants.Close;
  End;
  Application.Terminate;
end;

procedure TfrmBackground.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseApp;
end;

procedure TfrmBackground.FormCreate(Sender: TObject);
Var
  i : Integer;
  F : TextFile;
begin
  //testing componenets (DBHI)
  AssignFile(F, 'AppData.txt');
  Try
    Reset(F);
  Except
    MessageDlg('Application Data File cannot be found, please consult an ' +
    'FDFSA Administrator',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;

  for I := 1 to 5 do
    ReadLn(F);
  Var sTheme : String;
  ReadLn(F, sTheme);
  if UpperCase(sTheme) = 'D' then bDarkMode := True
                             else bDarkMode := False;
  CloseFile(F);

  //Dark Mode Coding
  if bDarkMode then
  Begin
    STROKECOLOR := $FFFFF200;  //yellow
    OBJECTCOLOR := $FF141414; //black
    ACCENTCOLOR := $FFD40000; //red
    COLOR1 := TAlphaColors.Black;
    TOOLBARCOLOR := $A5161616;
    TOOLBARCOLORCLICK := $B5000000;
    TEXTCOLOR := TAlphaColors.White;
  End

  else
  //Light Mode Coding
  Begin
    STROKECOLOR := $FFD40000; //Red
    OBJECTCOLOR := $FFF4F5F0; //Italian White
    ACCENTCOLOR := $FFD40000; //Red
    COLOR1 := TAlphaColors.White;
    TOOLBARCOLOR := $A5E0E0E0;
    TOOLBARCOLORCLICK := $B5F0F0F0;
    TEXTCOLOR := TAlphaColors.Black;
  End;



   //Form Adjustments
  With frmBackground do
  Begin
    Position := TformPosition.ScreenCenter;
    ClientHeight := 600;
    ClientWidth := 1100;
    Caption := 'The FDFSA';
    BorderStyle := TFmxFormBorderStyle.None;
    WindowState := TWindowState.wsMaximized;
    FullScreen := False;
    Fill.Color := OBJECTCOLOR;
    Fill.Kind := TBrushKind.Solid;

//    SendToBack;
    Visible := False;
  End;

  //Custom Tool bar coding
  rectToolBar.Parent := frmBackGround;
  With rectToolBar do
  Begin
    Width := frmBackground.Width;
    Height := TOOLBARHEIGHT;
    Fill.Color := TOOLBARCOLOR;
    Stroke.Color := TAlphaColors.Null;
    Position.X := 0;
    Position.Y := -1;
    BringToFront;
  End;

  //Dynamic circles
  iFormSection := frmBackground.ClientWidth DIV CIRCLEMAXNUM;
  iCircleXStart := 0;

  for i := 1 to CIRCLEMAXNUM do
  Begin
    arrCircles[i] := Tcircle.Create(frmBackground); //create circle
    With arrCircles[i] do
      Begin
        Parent := frmBackground;          //display on form
        iCircleIncrease := RandomRange(0,MAXCIRCLEINCREASE);
        Width  := CIRCLEDIAMETER + iCircleIncrease;
        Height := CIRCLEDIAMETER + iCircleIncrease;
        Position.X := iCircleXStart;
        Position.Y :=
          RandomRange(0,frmBackground.Height -
          (CIRCLEDIAMETER + iCircleIncrease)) +  rectToolBar.Height;
        iCircleXStart := iCircleXStart + iFormSection;

        Fill.Gradient.Style := TGradientStyle.Linear;
        if bDarkMode = True then
          CIRCLECOLOR := $FFD40000
        else
          case i MOD 3 of
          1 : CIRCLECOLOR := $FF008C45; //Green
          2 : CIRCLECOLOR := $FFCD212A;
          0 : CIRCLECOLOR := $FFFFF200; //Yellow
          end;

        Fill.Gradient.Color := CIRCLECOLOR;
        Fill.Gradient.Color1 := COLOR1;
        Fill.Kind := TBrushKind.Gradient;
        Stroke.Color := TAlphaColors.Null;
        Opacity := 1;
      End;
  End;

  //Circle Timer
  With tmrCircles do
  Begin
    Interval := TIMERINTERVAL;
    Enabled := False;
  End;

  //Dynamic Rectangular panel
  rectPanel := TRectangle.Create(frmBackground);
  with rectPanel do
  Begin
    Parent := frmBackground;
    Visible := True;
    Width := frmBackground.Width - PANELXOFFSET;
    Height := frmBackground.Height - PANELYOFFSET;
    Position.X := 0.5*(frmBackground.ClientWidth-rectPanel.Width);
    Position.Y := 0.5*(frmBackground.ClientHeight-rectPanel.Height);
    Fill.Kind := TBrushKind.Solid;
    Fill.Color := OBJECTCOLOR;
    Stroke.Color := STROKECOLOR;
    Stroke.Thickness := 7;
    CornerType := TCornerType.Round;
    XRadius := RECTXYRADIUS;
    YRadius := RECTXYRADIUS;
    BringTofront;
  End;

  //Close Button
  With rectClose do
  Begin
    Width := RECTWIDTH;
    Height := TOOLBARHEIGHT;
    Fill.Color := TAlphaColors.Null;
    Stroke.Color := TAlphaColors.Null;
    Position.Y := 0;
    Position.X := frmBackground.Width - Width;
  End;
  With imgClose do
  Begin
    Width := IMAGESIDE;
    Height := IMAGESIDE;
    if bDarkMode = True
    then Bitmap.LoadfromFile('Icons/Close.png')
    else Bitmap.LoadfromFile('Icons/CloseLM.png');
    Position.X := (rectClose.Width-Width)/2;
    Position.Y := (rectClose.Height-Height)/2;
  End;

  //Maximise/Restore Button
  With rectMaxRes do
  Begin
    Width := RECTWIDTH;
    Height := TOOLBARHEIGHT;
    Fill.Color := TAlphaColors.Null;
    Stroke.Color := TAlphaColors.Null;
    Position.Y := 0;
    Position.X := rectClose.Position.X - Width;
  End;
  With imgMaxRes do
  Begin
    Width := IMAGESIDE;
    Height := IMAGESIDE;
    if bDarkMode
      then Bitmap.LoadfromFile('Icons/Restore.png')
      else Bitmap.LoadfromFile('Icons/RestoreLM.png');
    Position.X := (rectMaxRes.Width-Width)/2;
    Position.Y := (rectMaxRes.Height-Height)/2;
  End;

  //Minimise Button
  With rectMin do
  Begin
    Width := RECTWIDTH;
    Height := TOOLBARHEIGHT;
    Fill.Color := TAlphaColors.Null;
    Stroke.Color := TAlphaColors.Null;
    Position.Y := 0;
    Position.X := rectMaxRes.Position.X - Width;
  End;

  With imgMin do
  Begin
    Width := IMAGESIDE;
    Height := IMAGESIDE;
    if bDarkMode = True
      then Bitmap.LoadfromFile('Icons/Minimise.png')
      else Bitmap.LoadfromFile('Icons/MinimiseLM.png');

    Position.X := (rectMin.Width-Width)/2;
    Position.Y := (rectMin.Height-Height)/2;
  End;



  
  with imgdark do
  Begin
    Parent := rectDarkMode;
    BitMap.LoadFromFile('Icons/DarkMode.png');
    Hint := rectDarkMode.hint;
  End;

  //Final Declarations
  rTotincrease := 0;
  bGrowing := True;
  bMaximised := true;
  PANEL := rectPanel;
  ShownForm := frmBackground;
  
end;

procedure TfrmBackground.FormResize(Sender: TObject);
begin
  RepositionObjects;
  if NOT (ShownForm = frmBackground) then RepositionObjects(ShownForm);
  rectToolbar.Width := frmBackground.Width;

end;

procedure TfrmBackground.FormShow(Sender: TObject);
begin
  if frmHome.bShown = False then
  Begin
    frmBackGround.Hide;
    frmHome.Show;
    frmHome.FloatAniLogo.Start;
  End;

  tmrCircles.Enabled := True;
  RepositionObjects;
end;

procedure TfrmBackground.imgDarkClick(Sender: TObject);
begin
  rectDarkMode.OnClick(rectDarkMode);
end;

procedure TfrmBackground.imgCloseClick(Sender: TObject);
begin
  rectClose.OnClick(rectClose);
end;

procedure TfrmBackground.imgCloseMouseEnter(Sender: TObject);
begin
//rectClose.OnMouseEnter(Self);
end;

procedure TfrmBackground.imgCloseMouseLeave(Sender: TObject);
begin
//  rectClose.OnMouseLeave(rectClose);
end;

procedure TfrmBackground.imgMaxResClick(Sender: TObject);
begin
  rectMaxRes.OnClick(rectMaxRes);
end;

procedure TfrmBackground.imgMaxResMouseEnter(Sender: TObject);
begin
//rectMaxRes.OnMouseEnter(rectMaxRes);
end;

procedure TfrmBackground.imgMaxResMouseLeave(Sender: TObject);
begin
//  rectMaxRes.OnMouseLeave(rectMaxRes);
end;

procedure TfrmBackground.imgMinClick(Sender: TObject);
begin
  rectMin.OnClick(rectMin);
end;

procedure TfrmBackground.imgMinMouseEnter(Sender: TObject);
begin
//  rectmin.OnMouseEnter(rectMin);
end;

procedure TfrmBackground.imgMinMouseLeave(Sender: TObject);
begin
//  rectmin.OnMouseLeave(rectMin);
end;

procedure TfrmBackground.rectCloseClick(Sender: TObject);
begin
  CloseApp;
end;

procedure TfrmBackground.rectDarkModeClick(Sender: TObject);
Var F : TextFile;
Slist : TStringlist;
begin
  if bDarkmode = True then bDarkMode := False
  else bDarkMode := True;
  ReloadTheme;
  AssignFile(F, 'AppData.txt');
  Try
    Reset(F);
  Except
    MessageDlg('Application Data File cannot be found, please consult an ' +
    'FDFSA Administrator',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;
  CloseFile(F);
  sList := TStringList.Create;
  sList.LoadFromFile('AppData.txt');
  sList.Delete(5);
  sList.SaveToFile('AppData.txt');
  sList.Free;

  Append(F);
  if bDarkMode then WriteLn(F, 'D')
               else WriteLn(F, 'L');
  CloseFile(F);
end;

procedure TfrmBackground.rectMaxResClick(Sender: TObject);
CONST
  imgWidth = 200;
begin
  if bMaximised = True then
  Begin
    frmHome.imgLogo.Parent := frmHome.scLayHome;
    with frmBackground do
      begin
        Width  := 1000;
        Height := 600;
      end;
    rectPanel.Width := 800;
    rectPanel.Height := 500;
    if bDarkMode = True
      then imgMaxRes.Bitmap.LoadFromFile('Icons/Maximise.png')
      else imgMaxRes.Bitmap.LoadFromFile('Icons/MaximiseLM.png');

    frmBackground.WindowState := TWindowState.wsNormal;
    bMaximised := False;

  End
  else
  Begin


    if bDarkMode = True
      then imgMaxRes.Bitmap.LoadFromFile('Icons/Restore.png')
      else imgMaxRes.Bitmap.LoadFromFile('Icons/RestoreLM.png');

    frmBackground.WindowState := TWindowState.wsMaximized;
    bMaximised := True;
  End

end;

procedure TfrmBackground.rectMinClick(Sender: TObject);
begin
//  rectMaxres.OnClick(RectMaxRes);
//  ShownForm.Hide;
  frmBackground.WindowState := TWindowState.wsMinimized;
end;

procedure TfrmBackground.rectToolbarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  begin
    if Button = TMouseButton.mbLeft then bMouseDown := True;
    if bMouseDown then
    Begin
      if bMaximised = True then rectMaxRes.OnClick(rectMaxRes);
      StartWindowDrag;
//      if NOT (ShownForm = frmBackGround) then ShownForm.Hide;
      rectToolBar.Fill.Color := TOOLBARCOLORCLICK;
    End;
  end;
end;

procedure TfrmBackground.rectToolbarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  rectToolBar.Fill.Color := TOOLBARCOLOR;
end;

procedure TfrmBackground.ReloadTheme;
Var
  i : integer;
begin
  //Dark Mode Coding
  if bDarkMode then
  Begin
    STROKECOLOR := $FFFFF200;  //yellow
    OBJECTCOLOR := $FF141414; //black
    ACCENTCOLOR := $FFD40000; //red
    COLOR1 := TAlphaColors.Black;
    TOOLBARCOLOR := $A5161616;
    TOOLBARCOLORCLICK := $B5000000;
    TEXTCOLOR := TAlphaColors.White;
  End

  else
  //Light Mode Coding
  Begin
    STROKECOLOR := $FFD40000; //Yellow
    OBJECTCOLOR := $FFF4F5F0;
    ACCENTCOLOR := $FFD40000; //Red
    COLOR1 := TAlphaColors.White;
    TOOLBARCOLOR := $A5E0E0E0;
    TOOLBARCOLORCLICK := $B5F0F0F0;
    TEXTCOLOR := TAlphaColors.Black;
  End;

  //implementation and reloading of objects
  //frmBackground
  //////////////////////////////////////////////////////////////////////////////
  frmBackground.Fill.Color := OBJECTCOLOR;
  PANEL.Fill.Color := OBJECTCOLOR;
  PANEL.Stroke.Color := STROKECOLOR;
  rectToolBar.Fill.Color := TOOLBARCOLOR;

  for i := 1 to CIRCLEMAXNUM do
  Begin
    if bDarkMode = True
    then
      CIRCLECOLOR := $FFD40000
    else
      case i MOD 3 of
      1 : CIRCLECOLOR := $FF008C45;
      2 : CIRCLECOLOR := $FFCD212A;
      0 : CIRCLECOLOR := $FFFFF200;
      end;

    arrCircles[i].Fill.Gradient.Color := CIRCLECOLOR;
    arrCircles[i].Fill.Gradient.Color1 := COLOR1;
  End;


  with imgClose do
  Begin
  if bDarkMode = True
    then Bitmap.LoadfromFile('Icons/Close.png')
    else Bitmap.LoadfromFile('Icons/CloseLM.png');
  End;

  with imgMaxRes do
  Begin
  if bMaximised = True then //form is maximised
    Begin
    if bDarkMode = True
    then Bitmap.LoadfromFile('Icons/Restore.png')
    else Bitmap.LoadfromFile('Icons/RestoreLM.png');
    End
  else //form is not maximised
    Begin
    if bDarkMode = True
    then Bitmap.LoadfromFile('Icons/Maximise.png')
    else Bitmap.LoadfromFile('Icons/MaximiseLM.png');
    End
  End;

  with imgMin do
  Begin
  if bDarkMode = True
    then Bitmap.LoadfromFile('Icons/Minimise.png')
    else Bitmap.LoadfromFile('Icons/MinimiseLM.png');
  End;

  //////////////////////////////////////////////////////////////////////////////


  //View Drivers form
  with frmViewDrivers do
  Begin
    lblDriver.FontColor := TEXTCOLOR;
    rectDriverInfo.Fill.Color := OBJECTCOLOR;
    rectPersonalDetails.Fill.Color := OBJECTCOLOR;
    rectImage.Fill.Color := OBJECTCOLOR;
    rectInFDA.Fill.Color := OBJECTCOLOR;
    rectlblDriverStats.Fill.Color := OBJECTCOLOR;
    rectDriverStats.Fill.Color := OBJECTCOLOR;
    rectDriverInfo.Fill.Color := OBJECTCOLOR;
    rectCurrent.Fill.Color := OBJECTCOLOR;

    lblAge.FontColor := TEXTCOLOR;
    lblAgeOut.FontColor := TEXTCOLOR;
    lblBorn.FontColor := TEXTCOLOR;
    lblBornOut.FontColor := TEXTCOLOR;
    lblCountry.FontColor := TEXTCOLOR;
    lblCountryOut.FontColor := TEXTCOLOR;
    lblDriverStats.FontColor := TEXTCOLOR;
    lblInFDA.FontColor := TEXTCOLOR;
    lblCurrentSeries.FontColor := TEXTCOLOR;
    lblCurrentSeriesOut.FontColor := TEXTCOLOR;
    lblDriverStatus.FontColor := TEXTCOLOR;
    lblDriverStatusOut.FontColor := TEXTCOLOR;
    lblCmb.FontColor := TEXTCOLOR;

    with memDriverInfo do
      Begin
        if bDarkmode = True then memDriverInfo.StyleLookup := 'DarkMemo'
        else memDriverInfo.StyleLookup := 'LightMemo';
        TextSettings.FontColor := TEXTCOLOR;
      End;

  if iCount MOD 2 = 1 then
    Begin
    lblRaces.FontColor := ACCENTCOLOR;
    lblVictories.FontColor := ACCENTCOLOR;
    lblPoles.FontColor := ACCENTCOLOR;

    lblRacesOut.FontColor := ACCENTCOLOR;
    lblVictoriesOut.FontColor := ACCENTCOLOR;
    lblPolesOut.FontColor := ACCENTCOLOR;

    lblINFDA.Font.Style := lblINFDA.Font.Style + [TFontStyle.fsBold];
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
    lblINFDA.Font.Style := lblINFDA.Font.Style - [TFontStyle.fsBold];
    rectINFDA.Fill.Color := OBJECTCOLOR;
    lblInFDa.FontColor := TEXTCOLOR;

    if bDarkmode then
      Begin
      cmbSelectDriver.StyleLookup := 'cmbSelectDriverDark';
      memDriverInfo.StyleLookup := 'DarkMemo';
      End
      else
      Begin
      cmbSelectDriver.StyleLookup := 'cmbSelectDriverLight';
      memDriverInfo.StyleLookup := 'LightMemo';
      End;

    End;
  memDriverInfo.FontColor := TEXTCOLOR;
  lblImage.TextSettings.FontColor := TEXTCOLOR;

  End;
  //////////////////////////////////////////////////////////////////////////////
  //Sponsor a driver form

  //label indicating upload
  With frmSponsorDriver do
  Begin

  //Combobox for Gender
  With cmbGender do
  Begin
    if bDarkmode then StyleLookup := 'ComboBoxStyleDark'
    else StyleLookup := 'ComboBoxStyleLight';
  End;

  //label inside combobox
  with lblcmbGender do
  Begin
  FontColor := TEXTCOLOR;
  End;

  lblgender.FontColor := TEXTCOLOR;

  lblSource.TextSettings.FontColor := TEXTCOLOR;
  //label indicating upload of driver's picture
  With lblUpload do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label for displaying message
  With lblApply do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label for KYALAMI LAP TIME
  With lblKyalami do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating first name
  With lblFirstName do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating surname
  With lblSurname do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating date of birth
  With lblDOB do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating ID
  With lblID do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating email
  With lblEmail do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating number
  With lblNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating number
  With lblNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating pg email
  With lblpgEmail do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating pg number
  With lblpgNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating sponsorship
  With lblSponsorship do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating company name
  With lblCompanyName do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating ref name
  With lblRefName do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating ref num
  With lblRefNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //rectangle that holds kyalami label
  With rectlblKyalami do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds kyalami lap time input
  With rectKyalami do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds selected image
  With rectImage do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds personal details label
  With rectlblPersonalDetails do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;

  //label that indicates personal details
  With lblPersonalDetails do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //rectangle that holds personal details label
  With rectlblSponsorshipDetails do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;

  //label that indicates personal details
  With lblSponsorshipDetails do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Rectangle that holds personal details
  With rectPersonalDetails do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;

  //Rectangle that holds sponsorship details
  With rectSponsorshipDetails do
  Begin
    Fill.Color := OBJECTCOLOR;
  End;


  //time edit for recording lap time;
  with tedtLapTime do
  Begin
    if bDarkmode then tEdtLapTime.StyleLookup := 'DarkTimeEdit'
    else tEdtLapTime.StyleLookup := 'LightTimeEdit';
    TextSettings.FontColor := TEXTCOLOR;
  End;

  // Date edit for DOB Input
  with dedtDOB do
  Begin
    if bDarkmode then StyleLookup := 'DateEditDark'
    else StyleLookup := 'DateEditLight';
  End;

  //edit for inputting first name
  With edtFirstName do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting surname
  With edtSurname do
  Begin
    FontColor := TEXTCOLOR;
  End;


  //edit for inputting ID Number
  With edtID do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //combobox for selecting sponsorship source
  with cmbSource do
  Begin
    if bDarkmode then StyleLookup := 'ComboBoxStyleDark'
    else StyleLookup := 'ComboBoxStyleLight';
  End;

  //edit for inputting email
  With edtEmail do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting contact number
  With edtNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting PG Number
  With edtPGNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting PG Email
  With edtPGEmail do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting company name
  With edtComName do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting Reference name
  With edtRefName do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //edit for inputting Ref Number
  With edtRefNum do
  Begin
    FontColor := TEXTCOLOR;
  End;

  End;
  //////////////////////////////////////////////////////////////////////////////
  //Admin Login Form
  With frmLogin do
  Begin
   //Label Heading adjustments
  With lblAdMod do
  Begin
    FontColor := TEXTCOLOR;
  End;

  With rectUSPA do
  Begin
    Fill.Color := OBJECTCOLOR;
    Stroke.Color := ACCENTCOLOR;
  End;
  //Label Username adjustments
  With lblUsername do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Label Password adjustments
  With lblPassword do
  Begin
    FontColor := TEXTCOLOR;
  End;

  edtUsername.TextSettings.FontColor := TEXTCOLOR;
  edtPassword.TextSettings.FontColor := TEXTCOLOR;
  End;
  //////////////////////////////////////////////////////////////////////////////
  //admit drivers form
  with frmAdmitDrivers do
  Begin
    //Label for Driver's Name
    With lblDriver do
    Begin
      FontColor := TEXTCOLOR;
    End;

  //String Grid for Selecting Drivers
  With stgDrivers do
  Begin
    if bDarkMode then
    Begin
      StyleLookup := 'stgDark';
    End
    else StyleLookup := 'stgLight';
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
    FontColor := TEXTCOLOR;
  End;

  //Label Indicating Financial Aid
  with lblFinance do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label Indicating Lap Time
  with lblLapTime do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Label Indicating Application Status
  with lblStatus do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Label Outputting Personal Details
  with lblPersonalDetailsOut do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Label Outputting Financial Aid
  with lblFinanceOut do
  Begin
    FontColor := TEXTCOLOR;
  End;


  //Label Outputting Lap Time
  with lblLapTimeOut do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Label Outputting Application Status
  with lblStatusOut do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Label displaying 'not found' message
  with lblImage do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating to save progress
  with lblSave do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Edit for entering ID
  With edtID do
  Begin
    FontColor := TEXTCOLOR;
  End;
  End;
  //////////////////////////////////////////////////////////////////////////////
  //Manage Drivers form
  With frmManageDrivers do
  Begin


  With lblManage do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //Change
  With stgManage do
  Begin
    TextSettings.FontColor := TEXTCOLOR;

    if bDarkMode then
    Begin
    StyleLookup := 'stgManageDark';

    End
    else StyleLookup := 'stgManageLight';
  End;


  //label indicating sorting rectangle
  with lblSort do
  Begin
    TextSettings.FontColor := TEXTCOLOR;
  End;

  //label indicating minimum rectangle
  with lblMin do
  Begin
    TextSettings.FontColor := TEXTCOLOR;
  End;

  //label indicating maximum rectangle
  with lblMax do
  Begin
    TextSettings.FontColor := TEXTCOLOR;
  End;

  //label indicating FDA rectangle
  with lblShowFDA do
    Begin
    TextSettings.FontColor := TEXTCOLOR;
    End;
  End;
  //////////////////////////////////////////////////////////////////////////////
  //Home form
  With frmHome do
  Begin
     //Image for selecting sponsor driver button
  with imgSponsor do
  begin
    if bDarkMode then Bitmap.LoadFromFile('Icons/SponsorDriverDM.png')
    else Bitmap.LoadFromFile('Icons/SponsorDriverLM.png');
  end;

  //Image for selecting sponsor driver button
  with imgView do
  begin
    if bDarkMode then Bitmap.LoadFromFile('Icons/ViewDriversDM.png')
    else Bitmap.LoadFromFile('Icons/ViewDriversLM.png');
  end;

  //Image for selecting sponsor driver button
  with imgStatus do
  begin
    if bDarkMode then Bitmap.LoadFromFile('Icons/ApplicationStatusDM.png')
    else Bitmap.LoadFromFile('Icons/ApplicationStatusLM.png');
  end;


  //label indicating Admin Login
  with lblLogin do
  Begin
    FontColor := TEXTCOLOR;
  End;

  //label indicating manage drivers
  with lblManageDrivers do
  Begin
    FontColor := TEXTCOLOR;
  End;

  With lblWelcome do
  Begin
    FontColor := TEXTCOLOR;
  End;

  End;

end;

procedure TfrmBackground.RepositionObjects(form: TForm);
begin
  form.Width := form.Width + 1;
end;

procedure TfrmBackground.RepositionObjects;
begin
  RectToolBar.Width := frmBackground.Width;
  rectClose.Position.X := frmBackground.Width - rectClose.Width;
  rectMaxRes.Position.X := rectClose.Position.X-rectMaxRes.Width;
  rectMin.Position.X := rectMaxRes.Position.X-rectMin.Width;

  With rectPanel do
  Begin
    Height := frmBackground.Height - PANELYOFFSET;
    Width := rectPanel.Height*1.6;

    Position.X := 0.5*(frmBackground.Width-rectPanel.Width);
    Position.Y := 0.5*(frmBackground.Height-rectPanel.Height)
                  + 0.5*(rectToolBar.Height);

  End;
end;



procedure TfrmBackground.tmrCirclesTimer(Sender: TObject);
begin
  if rTotIncrease >=  CIRCLEMAXSCALE then
  Begin
    bGrowing := False;
  End;

  if rTotIncrease <= 0 then bGrowing := True;

  if bGrowing = True then
  Begin
  for var i := 1 to CIRCLEMAXNUM do
  Begin
    arrCircles[i].Scale.X := arrCircles[i].Scale.X + CIRCLESCALERATE;
    arrCircles[i].Scale.Y := arrCircles[i].Scale.Y + CIRCLESCALERATE;
  End;
  rTotIncrease := rTotIncrease + CIRCLESCALERATE;
  End;

  if bGrowing = False then
  Begin
  for var i := 1 to CIRCLEMAXNUM do
  Begin
    arrCircles[i].Scale.X := arrCircles[i].Scale.X - CIRCLESCALERATE;
    arrCircles[i].Scale.Y := arrCircles[i].Scale.Y - CIRCLESCALERATE;
  End;
  rTotIncrease := rTotIncrease - CIRCLESCALERATE;
  End;

end;

end.
