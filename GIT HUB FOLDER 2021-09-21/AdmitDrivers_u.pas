unit AdmitDrivers_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox;

type
  TfrmAdmitDrivers = class(TForm)
    scLayAdmitDrivers: TScaledLayout;
    ComboBox1: TComboBox;
    Label10: TLabel;
    Image2: TImage;
    Label1: TLabel;
    rectImage: TRectangle;
    imgDriver: TImage;
    rectStatus: TRectangle;
    lblPersonalDetails: TLabel;
    Label3: TLabel;
    lblFinance: TLabel;
    lblPersonalDetailsOut: TLabel;
    lblFinanceOut: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    lblAppStatus: TLabel;
    rectConfirm: TRectangle;
    rectChoosePic: TRectangle;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmitDrivers: TfrmAdmitDrivers;

implementation
  Uses
  Background_u, dmDrivers_u;
{$R *.fmx}

procedure TfrmAdmitDrivers.FormCreate(Sender: TObject);
begin
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


end;

end.
