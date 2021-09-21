unit ManageDrivers_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfrmManageDrivers = class(TForm)
    StyleBook1: TStyleBook;
    scLayManage: TScaledLayout;
    Image2: TImage;
    lblManage: TLabel;
    Rectangle14: TRectangle;
    rectINFDA: TRectangle;
    lblINFDA: TLabel;
    stgManage: TStringGrid;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    Procedure RepositionObjects;
  public
    { Public declarations }
  end;

var
  frmManageDrivers: TfrmManageDrivers;

implementation
Uses
  Background_u, dmDrivers_u;

{$R *.fmx}

procedure TfrmManageDrivers.FormCreate(Sender: TObject);
begin
  with frmManagedrivers do
  Begin
    Parent := PANEL;
    Transparency := True;

  End;

  with scLayManage do
  Begin
    Parent := PANEL;
    Visible := False;
    BringToFront;
  End;


  With lblManage do
  Begin
    Parent := scLayManage;
    Height := 100;
    Width := sclayManage.OriginalWidth;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := 0;
    Position.Y := 30;
    Text := 'Manage Drivers';
    Font.Family := 'Century Gothic';
    Font.Style := [TFontStyle.fsBold];
    TextSettings.HorzAlign := TTextAlign.Center;
    Visible := True
  End;

  //Change
  With stgManage do
  Begin
    Parent := scLayManage;
    RowCount := 10;
    for Var I := 1 to 8 do
    Begin
      AddObject(tStringColumn.Create(stgManage));
    End;

    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;

    Width := 600;
    Height := 300;
  End;
end;

procedure TfrmManageDrivers.FormHide(Sender: TObject);
begin
  scLayManage.Visible := False;
end;

procedure TfrmManageDrivers.FormResize(Sender: TObject);
begin
  RepositionObjects;
end;

procedure TfrmManageDrivers.FormShow(Sender: TObject);
begin
  RepositionObjects;
end;

procedure TfrmManageDrivers.RepositionObjects;
begin
  scLayManage.Width := PANEL.Width;
  scLayManage.Height := PANEL.Height;
end;

end.
