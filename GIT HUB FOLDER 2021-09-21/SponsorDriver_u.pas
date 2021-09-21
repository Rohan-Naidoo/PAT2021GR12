unit SponsorDriver_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.DateTimeCtrls, FMX.Edit, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Styles, FMX.ListBox, FMX.Styles.Objects;

CONST
  OBJECTYOFFSET = 25;
  OBJECTXOFFSET = 30;
  OBJECTYDIFF = 90;
  LABELOFFSET = 8;
type
  TfrmSponsorDriver = class(TForm)
    scLaySponsorDriver: TScaledLayout;
    imgExit: TImage;
    lblApply: TLabel;
    rectConfirm: TRectangle;
    rectKyalami: TRectangle;
    rectlblKyalami: TRectangle;
    Rectangle18: TRectangle;
    rectChoosePic: TRectangle;
    lblChoosePic: TLabel;
    rectImage: TRectangle;
    Image1: TImage;
    rectReset: TRectangle;
    lblINFDA: TLabel;
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
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RepositionObjects;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure cmbSourceChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSponsorDriver: TfrmSponsorDriver;

implementation
Uses
  Background_u, dmDrivers_u;

{$R *.fmx}

procedure TfrmSponsorDriver.cmbSourceChange(Sender: TObject);
begin
  lblSource.Text := cmbSource.Items[cmbSource.ItemIndex];
end;

procedure TfrmSponsorDriver.edtIDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if NOT (KeyChar in ['0'..'9', Chr(8)]) then
  KeyChar := #0;
end;

procedure TfrmSponsorDriver.FormCreate(Sender: TObject);
begin


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
    Text := '';
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
    Text := 'Choose Another Picture';
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

procedure TfrmSponsorDriver.RepositionObjects;
begin
  With sclaySponsorDriver do
  Begin
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
  End;

  With imgExit do
  Begin
    Position.X := sclaySponsorDriver.OriginalWidth -imgExit.Width - OBJECTXOFFSET;
    Position.Y := OBJECTYOFFSET;
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
