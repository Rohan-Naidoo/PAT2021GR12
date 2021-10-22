unit Home_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts, FMX.Media, FMX.Controls.Presentation, FMX.StdCtrls;
CONST
  XOFFSET = 30;
  LOGOHEIGHT = 300;
  IMGYOFFSET = 10;
  IMGXOFFSET = 600;
type
  TfrmHome = class(TForm)
    imgLogo: TImage;
    floatAniLogo: TFloatAnimation;
    sclayHome: TScaledLayout;
    imgSponsor: TImage;
    imgView: TImage;
    imgStatus: TImage;
    rectLogin: TRectangle;
    lblLogin: TLabel;
    rectManage: TRectangle;
    lblManageDrivers: TLabel;
    lblWelcome: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure floatAniLogoFinish(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sclayHomeResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSponsorClick(Sender: TObject);
    procedure lblManageDriversClick(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure rectLoginClick(Sender: TObject);
    procedure rectManageClick(Sender: TObject);
    procedure imgViewClick(Sender: TObject);
    procedure imgStatusClick(Sender: TObject);
  private
    { Private declarations }
    procedure RepositionObjects;
  public
    { Public declarations }
    bShown : boolean;
  end;

var
  frmHome: TfrmHome;

implementation
Uses
  Background_u, SponsorDriver_u, ManageDrivers_u, AdmitDrivers_u, Login_u,
  ViewDrivers_u;

{$R *.fmx}

procedure TfrmHome.floatAniLogoFinish(Sender: TObject);
begin
  frmBackGround.Show;
  bShown := True;
  ShownForm := frmHome;
  sclayHome.Visible := True;
  With imgLogo do
  Begin
    Parent := scLayHome;
    imgLogo.Opacity := 1;
    Height := LOGOHEIGHT;
    Width := imgLogo.Height/1.15;
//    Align := TAlignLayout.Center;
  End;


  RepositionObjects;

end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin

  //Ferrari Logo
  with imgLogo do
  begin
    Parent := frmHome;
    Width := 600;
    Height := 600;
    Bitmap.LoadFromFile('Images/ferrari.png');
    Position.X := 0;
    Position.Y := 0;
    Opacity := 0;
    Visible := True;
    WrapMode := TImageWrapMode.Fit;
    MarginWrapMode := TImageWrapMode.Fit;
  end;

  //Form Adjustments
  With frmHome do
  Begin
    Position := TformPosition.ScreenCenter;
    WindowState := TWindowState.wsNormal;
    FullScreen := False;
    Height := Round(imgLogo.Height);
    Width := Round(imgLogo.Width);
    FormStyle := TFormStyle.StayOnTop;
    Transparency := True;
    BringToFront;
  End;

  //Float Animation for Logo Creation
  floatAniLogo.Parent := imgLogo;
  With floatAniLogo do
  Begin
    AnimationType := TAnimationType.InOut;
    AutoReverse := True;
    Delay := 0;
    Duration := 0.5;
    Enabled := True;
    InterPolation := TInterPolationType.Quintic;
    PropertyName := 'Opacity';
    StartValue := 0;
    StopValue := 1;
  End;



  //Layout Adjustments
  With sclayHome do
  Begin
    Parent := PANEL;
    Position.X := 0;
    Position.Y := 0;
    Height := PANEL.Height;
    Width := PANEL.Width;
    Visible := False;
    BringToFront;
  End;

  //Image for selecting sponsor driver button
  with imgSponsor do
  begin
    Parent := frmHome;
    Parent := scLayHome;

    if bDarkMode then Bitmap.LoadFromFile('Icons/SponsorDriverDM.png')
    else Bitmap.LoadFromFile('Icons/SponsorDriverLM.png');
    Position.Y := 50;
    Position.X := IMGXOFFSET;
    Visible := True;
    WrapMode := TImageWrapMode.Fit;
    MarginWrapMode := TImageWrapMode.Fit;
  end;

  //Image for selecting sponsor driver button
  with imgView do
  begin
    Parent := frmHome;
    Parent := scLayHome;

    if bDarkMode then Bitmap.LoadFromFile('Icons/ViewDriversDM.png')
    else Bitmap.LoadFromFile('Icons/ViewDriversLM.png');
    Position.Y := imgSponsor.Position.Y + imgSponsor.Height + IMGYOFFSET;
    Position.X := IMGXOFFSET;
    Visible := True;
    WrapMode := TImageWrapMode.Fit;
    MarginWrapMode := TImageWrapMode.Fit;
  end;

  //Image for selecting sponsor driver button
  with imgStatus do
  begin
    Parent := frmHome;
    Parent := scLayHome;

    if bDarkMode then Bitmap.LoadFromFile('Icons/ApplicationStatusDM.png')
    else Bitmap.LoadFromFile('Icons/ApplicationStatusLM.png');
    Position.Y := imgView.Position.Y + imgView.Height + IMGYOFFSET;
    Position.X := IMGXOFFSET;
    Visible := True;
    WrapMode := TImageWrapMode.Fit;
    MarginWrapMode := TImageWrapMode.Fit;
  end;

  imgLogo.Height := 600;
  imgLogo.Width := 600;
  rectManage.Visible := False;

  //label indicating Admin Login
  with lblLogin do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    TextSettings.HorzAlign := TTextAlign.Center;
    Visible := True;
  End;

  //label indicating manage drivers
  with lblManageDrivers do
  Begin
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    TextSettings.HorzAlign := TTextAlign.Center;
    Visible := True;
  End;

  With lblWelcome do
  Begin
    Parent := scLayHome;
    Height := 100;
    Width := sclayHome.OriginalWidth;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := 0;
    Position.Y := 30;
    Text := 'Welcome';
    Font.Family := 'Century Gothic';
    Font.Style := [TFontStyle.fsBold];
    Font.Size := 40;
    TextSettings.HorzAlign := TTextAlign.Center;
    Visible := True;
  End;

  //Final Declarations
  bShown := False;

end;

procedure TfrmHome.FormHide(Sender: TObject);
begin
  sclayHome.Visible := False;
end;

procedure TfrmHome.FormResize(Sender: TObject);
begin
  RepositionObjects;
end;



procedure TfrmHome.FormShow(Sender: TObject);
begin
  if bShown = False then
  Begin
    floatAniLogo.Start;
  End
  else
  scLayHome.Visible := True;
  RepositionObjects;
  if bAdmin then
  rectManage.Visible := True;
  if bAdmin or bModerator then
  Begin
    imgstatus.Hint := 'Admit and decline drivers';
  End;
end;

procedure TfrmHome.imgSponsorClick(Sender: TObject);
begin
  ShownForm.Hide;
  frmSponsorDriver.Show;
  ShownForm := frmSponsorDriver;
  frmSponsorDriver.sclaySponsorDriver.Visible := True;
end;

procedure TfrmHome.imgStatusClick(Sender: TObject);
begin
  ShownForm.Hide;
  frmAdmitDrivers.Show;
  ShownForm := frmAdmitDrivers;
  frmAdmitDrivers.scLayAdmitDrivers.Visible := True;

  With frmAdmitDrivers do
  begin
  if (bAdmin = True) or (bModerator = True) then
  Begin
    rectDecline.Visible := True;
    stgDrivers.Visible := True;
    cirPersonal.Visible := True;
    cirFinance.Visible := True;
  End;
  end;
end;

procedure TfrmHome.imgViewClick(Sender: TObject);
begin
  ShownForm.Hide;
  frmViewDrivers.Show;
  ShownForm := frmViewDrivers;
  frmViewDrivers.sclayViewDrivers.Visible := True;
  frmViewDrivers.PopDriverArray;
end;

procedure TfrmHome.lblLoginClick(Sender: TObject);
begin
  rectLogin.OnClick(rectLogin);
end;

procedure TfrmHome.lblManageDriversClick(Sender: TObject);
begin
  rectManage.OnClick(rectManage);
end;

procedure TfrmHome.rectLoginClick(Sender: TObject);
begin
  ShownForm.Hide;
  frmLogin.Show;
  ShownForm := frmLogin;
  frmLogin.sclayLogin.Visible := True;
end;

procedure TfrmHome.rectManageClick(Sender: TObject);
begin
  ShownForm.Hide;
  frmManageDrivers.Show;
  ShownForm := frmManageDrivers;
  frmManageDrivers.scLayManage.Visible := True;
end;

procedure TfrmHome.RepositionObjects;
begin
  With sclayHome do
  Begin
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
  End;

  if bShown = true then
  Begin
  with imgLogo do
  Begin
    Position.X := XOFFSET;
    Position.Y := 0.5*(scLayHome.OriginalHeight - imgLogo.Height);
  End;
  End;



end;

procedure TfrmHome.sclayHomeResize(Sender: TObject);
begin
  if bShown = true then
  Begin
    with imgLogo do
    Begin
      Parent := scLayHome;

      Position.X := XOFFSET;
      Position.Y := 0.5*(PANEL.Height - imgLogo.Height);
    //0.5*(scLayHome.OriginalHeight - imgLogo.Height);

    End;
  End;
end;

end.
