unit Home_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts, FMX.Media;
CONST
  XOFFSET = 30;
  LOGOHEIGHT = 300;
type
  TfrmHome = class(TForm)
    imgLogo: TImage;
    floatAniLogo: TFloatAnimation;
    sclayHome: TScaledLayout;
    procedure FormCreate(Sender: TObject);
    procedure floatAniLogoFinish(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sclayHomeResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  Background_u;

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
  {//Layout Adjustments for ferrari logo
  With layimgLogo do
  Begin
    Parent := sclayHome;
    Position.X := XOFFSET;
    Position.Y := 0.5*(scLayHome.OriginalHeight - imgLogo.Height);
    Height := imgLogo.Height;
    Width := imgLogo.Width;
    BringToFront;
  End;
   }
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
