program FDFSA_p;

uses
  System.StartUpCopy,
  FMX.Forms,
  Background_u in 'Background_u.pas' {frmBackground},
  dmDrivers_u in 'dmDrivers_u.pas' {dmDrivers: TDataModule},
  Login_u in 'Login_u.pas' {frmLogin},
  ViewDrivers_u in 'ViewDrivers_u.pas' {frmViewDrivers},
  Home_u in 'Home_u.pas' {frmHome},
  SponsorDriver_u in 'SponsorDriver_u.pas' {frmSponsorDriver},
  AdmitDrivers_u in 'AdmitDrivers_u.pas' {frmAdmitDrivers},
  clsDriver_u in 'clsDriver_u.pas',
  ManageDrivers_u in 'ManageDrivers_u.pas' {frmManageDrivers};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBackground, frmBackground);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmViewDrivers, frmViewDrivers);
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmSponsorDriver, frmSponsorDriver);
  Application.CreateForm(TfrmAdmitDrivers, frmAdmitDrivers);
  Application.CreateForm(TdmDrivers, dmDrivers);
  Application.CreateForm(TfrmManageDrivers, frmManageDrivers);
  Application.Run;
end.
