unit SponsorDriver_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.DateTimeCtrls, FMX.Edit, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Styles, FMX.ListBox, FMX.Styles.Objects, System.IOUtils,
  FMX.Platform, DateUtils;

CONST
  OBJECTYOFFSET = 25;
  OBJECTXOFFSET = 30;
  OBJECTYDIFF = 90;
  LABELOFFSET = 8;
type
  TfrmSponsorDriver = class(TForm)
    scLaySponsorDriver: TScaledLayout;
    lblApply: TLabel;
    rectConfirm: TRectangle;
    rectKyalami: TRectangle;
    rectlblKyalami: TRectangle;
    Rectangle18: TRectangle;
    rectChoosePic: TRectangle;
    lblChoosePic: TLabel;
    rectImage: TRectangle;
    imgDriver: TImage;
    rectReset: TRectangle;
    lblReset: TLabel;
    rectPersonalDetails: TRectangle;
    lblFirstName: TLabel;
    lblSurname: TLabel;
    lblDOB: TLabel;
    rectlblPersonalDetails: TRectangle;
    rectDOB: TRectangle;
    rectSurname: TRectangle;
    edtSurname: TEdit;
    lblEmail: TLabel;
    lblNum: TLabel;
    lblPGNum: TLabel;
    lblPGEmail: TLabel;
    Rectangle11: TRectangle;
    edtNum: TEdit;
    Rectangle12: TRectangle;
    edtPGNum: TEdit;
    rectFirstName: TRectangle;
    edtFirstName: TEdit;
    lblID: TLabel;
    Rectangle20: TRectangle;
    edtID: TEdit;
    rectSponsorshipDetails: TRectangle;
    lblSponsorship: TLabel;
    lblCompanyName: TLabel;
    lblRefName: TLabel;
    lblRefNum: TLabel;
    rectlblSponsorshipDetails: TRectangle;
    Rectangle8: TRectangle;
    edtComName: TEdit;
    rectSource: TRectangle;
    Rectangle7: TRectangle;
    edtRefName: TEdit;
    Rectangle4: TRectangle;
    edtRefNum: TEdit;
    StyleBook1: TStyleBook;
    tedtLapTime: TTimeEdit;
    Rectangle1: TRectangle;
    edtPGEmail: TEdit;
    Rectangle10: TRectangle;
    edtEmail: TEdit;
    lblPersonalDetails: TLabel;
    lblSponsorshipDetails: TLabel;
    dedtDOB: TDateEdit;
    lblKyalami: TLabel;
    lblUpload: TLabel;
    cmbSource: TComboBox;
    lblSource: TLabel;
    odPic: TOpenDialog;
    lblConfirm: TLabel;
    lblGender: TLabel;
    cmbGender: TComboBox;
    rectGender: TRectangle;
    lblcmbGender: TLabel;
    Circle1: TCircle;
    imgExit: TImage;
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RepositionObjects;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure cmbSourceChange(Sender: TObject);
    procedure lblChoosePicClick(Sender: TObject);
    procedure rectChoosePicClick(Sender: TObject);
    procedure rectConfirmClick(Sender: TObject);
    procedure edtNumKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtPGNumKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtRefNumKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtFirstNameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtSurnameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtRefNameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure lblConfirmClick(Sender: TObject);
    procedure rectResetClick(Sender: TObject);
    procedure cmbGenderChange(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }
    Function NumbersOnly(Key : Char) : Boolean;
    Function LettersOnly(Key : Char) : Boolean;
  public
    { Public declarations }
  end;

var
  frmSponsorDriver: TfrmSponsorDriver;

implementation
Uses
  Background_u, dmDrivers_u, Home_u;

{$R *.fmx}

procedure TfrmSponsorDriver.cmbGenderChange(Sender: TObject);
begin
  if cmbGender.ItemIndex < 0 then Exit;

  lblcmbGender.Text := cmbGender.Items[cmbGender.ItemIndex];
  if NOT(lblcmbGender.FontColor = TEXTCOLOR)
  then lblcmbGender.FontColor := TEXTCOLOR;
end;

procedure TfrmSponsorDriver.cmbSourceChange(Sender: TObject);
begin
  if cmbSource.ItemIndex < 0 then Exit;

  lblSource.Text := cmbSource.Items[cmbSource.ItemIndex];
  if NOT(lblSource.FontColor = TEXTCOLOR)
  then lblSource.FontColor := TEXTCOLOR;
end;

procedure TfrmSponsorDriver.edtFirstNameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if LettersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.edtIDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 if NumbersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.edtNumKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if NumbersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.edtPGNumKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if NumbersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.edtRefNameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if LettersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.edtRefNumKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if NumbersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.edtSurnameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if LettersOnly(KeyChar) = False then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.FormCreate(Sender: TObject);
begin
  imgExit.BringToFront;
//Form Adjustments
  With frmSponsorDriver do
  Begin
    Parent := frmBackground;
    left := 0;
    Top := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Transparency := True;
  End;

  //Layout Adjustments
  With sclaySponsorDriver do
  Begin
    Parent := PANEL;
    Position.X := 0;
    Position.Y := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Visible := False;
    BringToFront;
  End;

  //label indicating upload
  With lblUpload do
  Begin
    Parent := rectImage;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Upload a picture of your driver here';
    TextSettings.HorzAlign := TTextAlign.Center;
  End;

  //label for displaying message
  With lblApply do
  Begin
    Parent := sclaySponsorDriver;
    Height := 100;
    Width := sclaySponsorDriver.OriginalWidth;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET - 0.25*height;
    Text := 'Apply for the FDP';
    Font.Family := 'Century Gothic';
    Font.Size := 30;
    TextSettings.HorzAlign := TTextAlign.Center;
    Font.Style := Font.Style + [TFontStyle.fsBold];
  End;

  //label for KYALAMI LAP TIME
  With lblKyalami do
  Begin
    Parent := rectlblKyalami;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'KYALAMI LAP TIME';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Center;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label for displaying combobox item
  With lblSource do
  Begin
    Parent := cmbSource;
    Height := cmbSource.Height;
    Width := cmbSource.Width;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := 0;
    Position.Y := 0;
    Text := 'Select a Source';
    FontColor := TAlphacolors.Dimgray;
    TextSettings.HorzAlign := TTextAlign.Leading;
  End;

  //label indicating first name
  With lblFirstName do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELOFFSET;
    Text := 'First Name';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating surname
  With lblSurname do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELOFFSET;
    Text := 'Surname';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating date of birth
  With lblDOB do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELOFFSET;
    Text := 'Date of Birth';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating ID
  With lblID do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := LABELOFFSET;
    Text := 'ID Number';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating email
  With lblEmail do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Email Address';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating number
  With lblNum do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Contact Number';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating number
  With lblNum do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Contact Number';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating pg email
  With lblpgEmail do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Parent/Guardian Email Address';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating pg number
  With lblpgNum do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Parent/Guardian Contact Number';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating sponsorship
  With lblSponsorship do
  Begin
    Parent := rectSponsorshipDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Sponsorship Details';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating company name
  With lblCompanyName do
  Begin
    Parent := rectSponsorshipDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Company Name';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating ref name
  With lblRefName do
  Begin
    Parent := rectSponsorshipDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Full Name of Person of Reference';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //label indicating ref num
  With lblRefNum do
  Begin
    Parent := rectSponsorshipDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Reference Contact Number';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Leading;
    Font.Style := Font.Style + [TFontStyle.fsBold] + [TFontStyle.fsItalic];
  End;

  //rectangle that holds kyalami label
  With rectlblKyalami do
  Begin
    Parent := rectKyalami;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds kyalami lap time input
  With rectKyalami do
  Begin
    Parent := sclaySponsorDriver;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds selected image
  With rectImage do
  Begin
    Parent := sclaySponsorDriver;
    Fill.Color := OBJECTCOLOR;
  End;

  //rectangle that holds personal details label
  With rectlblPersonalDetails do
  Begin
    Parent := rectPersonalDetails;
    Fill.Color := OBJECTCOLOR;
  End;

  //label that indicates personal details
  With lblPersonalDetails do
  Begin
    Parent := rectlblPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Personal Details';
    TextSettings.HorzAlign := TTextAlign.Center;
  End;

  //rectangle that holds personal details label
  With rectlblSponsorshipDetails do
  Begin
    Parent := rectSponsorshipDetails;
    Fill.Color := OBJECTCOLOR;
  End;

  //label that indicates personal details
  With lblSponsorshipDetails do
  Begin
    Parent := rectlblSponsorshipDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Sponsorship Details';
    TextSettings.HorzAlign := TTextAlign.Center;
  End;

  //Rectangle that holds personal details
  With rectPersonalDetails do
  Begin
    Position.X := OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET + OBJECTYDIFF;
    Fill.Color := OBJECTCOLOR;
  End;

  //Rectangle Button for choosing another picture
  With rectChoosePic do
  Begin
    Position.X := rectImage.Position.X +
    0.5*(rectImage.Width-rectChoosePic.Width);
    Position.Y := rectImage.Position.Y + rectImage.Height + 30;
  End;

  //Rectangle that holds sponsorship details
  With rectSponsorshipDetails do
  Begin
    Position.X := OBJECTXOFFSET;
    Position.Y := rectPersonalDetails.Position.Y + rectPersonalDetails.Height
                  + OBJECTYOFFSET;
    Fill.Color := OBJECTCOLOR;
  End;

  //Rectangle Button for resetting contents of forms
  With rectReset do
  Begin
    Position.X := rectKyalami.Position.X +
    0.5*(rectKyalami.Width-rectReset.Width);
  End;

  //Rectangle Button for confirming application
  With rectConfirm do
  Begin
    Position.X := rectKyalami.Position.X +
    0.5*(rectKyalami.Width-rectConfirm.Width);
  End;

  //time edit for recording lap time;
  with tedtLapTime do
  Begin
    if bDarkmode then tEdtLapTime.StyleLookup := 'DarkTimeEdit'
    else tEdtLapTime.StyleLookup := 'LightTimeEdit';
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Format := 'n:ss:zzz';
    TextSettings.FontColor := TEXTCOLOR;
  End;

  // Date edit for DOB Input
  with dedtDOB do
  Begin
    Parent := rectPersonalDetails;
    Parent := rectDOB;
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
    Parent := rectSponsorshipDetails;
    Parent := rectSource;
    ItemIndex := -1;
    if bDarkmode then StyleLookup := 'ComboBoxStyleDark'
    else StyleLookup := 'ComboBoxStyleLight';
  End;

  //label for indicating the choice of another Picture
  With lblChoosePic do
  Begin
    Parent := rectChoosePic;
    Height := rectChoosePic.Height;
    Width := rectChoosePic.Width;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    Position.X := 0;
    PosiTion.Y := 0;
    Text := 'Choose a Picture';
    Font.Family := 'Century Gothic';
    TextSettings.HorzAlign := TTextAlign.Center;
    TextSettings.VertAlign := TTextAlign.Center;
    Font.Style := Font.Style + [TFontStyle.fsBold];
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

  //gender label
  With lblGender do
  Begin
    Parent := rectPersonalDetails;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
  End;

  //Combobox for Gender
  With cmbGender do
  Begin
    Parent := rectPersonalDetails;
    Parent := rectGender;
    ItemIndex := -1;
    if bDarkmode then StyleLookup := 'ComboBoxStyleDark'
    else StyleLookup := 'ComboBoxStyleLight';
  End;

  //label inside combobox
  with lblcmbGender do
  Begin
  StyledSettings := StyledSettings -
                           [TStyledSetting.FontColor] -
                           [TStyledSetting.Family] -
                           [TStyledSetting.Style] -
                           [TStyledSetting.Size] -
                           [TStyledSetting.Other];
  FontColor := TEXTCOLOR;
  Text := 'Select a Gender';
  FontColor := TAlphacolors.Dimgray;
  End;
end;

procedure TfrmSponsorDriver.FormHide(Sender: TObject);
begin
  scLaySponsorDriver.Visible := False;
end;

procedure TfrmSponsorDriver.FormResize(Sender: TObject);
begin
  RepositionObjects;
end;

procedure TfrmSponsorDriver.FormShow(Sender: TObject);
begin
  RepositionObjects;
end;

procedure TfrmSponsorDriver.imgExitClick(Sender: TObject);
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

procedure TfrmSponsorDriver.lblChoosePicClick(Sender: TObject);
begin
  rectChoosePic.OnClick(Self);
end;

procedure TfrmSponsorDriver.lblConfirmClick(Sender: TObject);
begin
rectConfirm.OnClick(Self);
end;

function TfrmSponsorDriver.LettersOnly(Key: Char): Boolean;
begin
  Result := True;
  if (Key in ['!'..'@', '['..'@','{'..'~']) then Result := False;
end;

function TfrmSponsorDriver.NumbersOnly(Key: Char): Boolean;
begin
  Result := True;
  if NOT (Key in ['0'..'9', Chr(8), chr(127)]) then Result := False;
end;

procedure TfrmSponsorDriver.rectChoosePicClick(Sender: TObject);
Var
  btmPic : TBitMap;
begin
  odPic.Filter := TBitmapCodecManager.GetFilterString;
  odPic.Execute;
  try
    btmPic := TBitmap.CreateFromFile(odPic.FileName);
  except
    Exit;
  end;

  try
    imgDriver.Bitmap := btmPic;
  finally
    btmPic.Free;
  end;

  lblChoosePic.Text := 'Choose Another Picture';
  lblUpload.Visible := False;

end;

procedure TfrmSponsorDriver.rectConfirmClick(Sender: TObject);
Var
  sDrivername : String;
  iDays : Integer;
begin
  //gender verification
  if cmbgender.ItemIndex =-1 then
  Begin
    MessageDlg('Please select a gender',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;

//Age Verification
  iDays := DaysBetween(Now,dedtDOB.Date);
  if iDays/365 < 12.0 then
  Begin
    MessageDlg('Applicant drivers must be at least 12 to apply',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End
  else if iDays/365 >= 21.0 then
  Begin
    MessageDlg('Applicant drivers must be younger than 21 to apply',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;


  //Sponsorship source validation
  if cmbSource.ItemIndex = -1 then
  Begin
    Begin
    MessageDlg('Please select a sponsorship source',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
    End;
  End;

  //ID Length Verification
  if Length(edtID.Text) <> 13 then
  Begin
    MessageDlg('ID must be 13 digits long',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;

//  Entry Validation
  if (edtFirstName.Text = '') OR
  (edtSurname.Text = '') OR
  (dedtDOB.Text = '') OR
  (edtEmail.Text = '') OR
  (edtNum.Text = '') OR
  (edtPGEmail.Text = '') OR
  (edtPGNum.Text = '') OR
  (edtComName.Text = '') OR
  (edtRefName.Text = '') OR
  (edtRefNum.Text = '') OR
  (tedtLapTime.Text = '05:00:000')
  then
  Begin
    MessageDlg('Some fields are missing or incomplete',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    edtFirstName.SetFocus;
    Exit;
  End;

  //checking if driver has already applied
  With dmDrivers do
  Begin
    with tblID do
    Begin
      First;
      while Not (tblID.EOF) do
      Begin
        if (edtID.Text = FieldByName('ID').text)
        And (FieldByName('Status').Text <> 'Denied') then
        Begin
          MessageDlg('This driver has already applied',
          TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
          edtFirstName.SetFocus;
          Exit;
        end
        else
        if (edtID.Text = FieldByName('ID').text)
        And (FieldByName('Status').Text = 'Denied') then
        Begin
          MessageDlg('This driver has been denied by the program',
          TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
          edtFirstName.SetFocus;
          Exit;
        end;
        Next;
      End;
    End;
  End;


  Var sSql : String;
  Var iRecCount : Integer;
  //Insert Into Database
  With dmDrivers do
  Begin
    iRecCount := tblApplicants.RecordCount;

    qryDrivers.SQL.Clear;
    sSql := 'INSERT INTO tblApplicants (DriverNumber, FirstName, ' +
                      'Surname, DateOfBirth, EmailAddress, ContactNumber, ' +
                      'PGEmailAddress, PGContactNumber, SponsorshipSource, ' +
                      'SponsorshipSourceName, PersonOfRef, RefContactNumber, '
                      +
                      'KyalamiLapTime, PersonalDetails, ' +
                      'FinancialAid, Gender) ' +
                      'VALUES (' + IntToStr(iRecCount+1) + ', ' +
                                   '"' + edtFirstName.Text + '", ' +
                                   '"' + edtSurname.Text + '", ' +
                                   '#' + DateToStr(dedtDOB.Date)+ '#, ' +
                                   '"' + edtEmail.Text + '", ' +
                                   '"' + edtNum.Text + '", ' +
                                   '"' + edtPGEmail.Text + '", ' +
                                   '"' + edtPGNum.Text + '", ' +
                                   '"' + lblSource.Text + '", ' +
                                   '"' + edtComName.Text + '", ' +
                                   '"' + edtRefName.Text + '", ' +
                                   '"' + edtRefNum.Text + '", ' +
                                   '"' + TimeToStr(tedtLapTime.Time) + '", ' +
                                   '"Pending",' + '"Pending", ' +
                                   '"' + lblGender.Text[1] +'")';
    qryDrivers.SQL.Add(sSql);
    qryDrivers.ExecSQL;
    qryDrivers.SQL.Clear;
    sSql := 'INSERT INTO tblID(DriverNumber, ID, Status) ' +
            'VALUES(' + IntToStr(iRecCount+1) + ', ' +
            '"' + edtID.Text + '", ' +
            '"Pending")';
    qryDrivers.SQL.Add(sSql);
    qryDrivers.ExecSQL;
  End;



  //saving driver image
  sDrivername := edtFirstName.Text + '_' + edtSurname.Text;
  imgDriver.Bitmap.SaveToFile('Drivers/' + sDriverName + edtID.Text + '.bmp');
  MessageDlg('Application Successful',
    TMsgDlgType.mtWarning,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],0)
end;

procedure TfrmSponsorDriver.rectResetClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you would like to reset all fields?' + #13 +
                'Note, ALL entered Data will be lost.',
    TMsgDlgType.mtWarning,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],0) = mrYes then
    Begin
      edtFirstName.Text := '';
      edtSurname.Text := '';
      dedtDOB.Date := Date;
      edtEmail.Text := '';
      edtNum.Text := '';
      edtPGEmail.Text := '';
      edtPGNum.Text := '';
      edtComName.Text := '';
      edtID.Text := '';
      edtRefName.Text := '';
      edtRefNum.Text := '';
      tedtLapTime.Time := (5/1440);

      cmbSource.ItemIndex := -1;
      lblSource.FontColor := TAlphacolors.Dimgray;
      lblSource.Text := 'Select a Source';
      edtFirstName.SetFocus;
      imgDriver.Bitmap.Clear(OBJECTCOLOR);
      lblUpload.Visible := True;
      lblChoosePic.Text := 'Choose a Picture';
     End;

end;

procedure TfrmSponsorDriver.RepositionObjects;
begin
  With sclaySponsorDriver do
  Begin
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
  End;


  With lblApply do
  Begin
    Position.X := OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET -0.25*lblApply.height
  End;

  With rectImage do
  Begin
    Position.X := sclaySponsorDriver.OriginalWidth -rectImage.Width
                  - OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET + OBJECTYDIFF;
  End;

  With rectChoosePic do
  Begin
    Position.X := rectImage.Position.X +
    0.5*(rectImage.Width-rectChoosePic.Width);
    Position.Y := rectImage.Position.Y + rectImage.Height + 30;
  End;


end;

end.
