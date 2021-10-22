unit Login_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit;

type
  TfrmLogin = class(TForm)
    lblAdMod: TLabel;
    sclayLogin: TScaledLayout;
    rectUSPA: TRectangle;
    lblUserName: TLabel;
    lblPassword: TLabel;
    Rectangle8: TRectangle;
    edtPassword: TEdit;
    Rectangle9: TRectangle;
    edtUsername: TEdit;
    rectLogin: TRectangle;
    lblLogin: TLabel;
    Circle1: TCircle;
    imgExit: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure rectLoginClick(Sender: TObject);
    procedure rectUSPAClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }
    arrAlphabet : array[1..26] of String;
    sType : String;
    Procedure RepositionObjects;
    Function Encrypt(sPassword, sType : String) : String;
    Function Decrypt(sENCPassword : String) : String;
    Function DetermineType (sENCPassword : String) : String;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  bAdmin, bModerator : Boolean;

implementation
Uses
  Background_u, Home_u, AdmitDrivers_u;

{$R *.fmx}

function TfrmLogin.Decrypt(sENCPassword: String): String;
Var
  sLine, sType, sDecPassword : String;
  iPos, I, iNum, iAsc, iPassNum : Integer;
begin
  sLine := sENCPassword;
  sDecPassword := '';
  sType := DetermineType(sLine);

  for I := 1 to Length(sLine) do
    if sLine[i] In ['A'..'Z'] then iPos := i; //Eliminate Type
  Delete(sLine, iPos, Length(sLine) - iPos + 1);

  for I := 1 to Length(sLine) do
    if sLine[i] In ['A'..'Z'] then iPos := i; //Eliminate Passnum
  iPassNum := StrToInt(Copy(sLine, iPos+1, Length(sLine)- iPos+1 +1));
  Delete(sLine, iPos, Length(sLine)-iPos +1);

  //Password now does not indicate type or Passnum
  repeat
  iPos := 0;
  for I := Length(sLine) downto 1 do
    if sLine[i] in ['A'..'Z'] then iPos := i;

    if iPos = 0
    then iNum := StrToInt(sLine)
    else iNum := StrToInt(Copy(sLine, 1, iPos-1));
    iAsc := (iNum - (2*iPassNum)) DIV iPassNum;
    sDecPassword := sDecPassword + Chr(iAsc);
    Delete(sLine, 1, iPos);
  until (iPos = 0);

  Result := sDecPassword + ' ' + sType;
end;

function TfrmLogin.DetermineType(sENCPassword: String): String;
Var
  iPos, iCopy, I : integer;
begin
  iPos := 0;                 //Determines which user password this is
  for I := 1 to Length(sEncPassword) do
    if sEncPassword[i] in ['A'..'Z'] then iPos := i;
  iCopy := Length(sENCPassword) - iPos + 1;
  Result := Chr(StrToInt(Copy(sEncPassword, iPos + 1,iCopy)));
end;

Function TfrmLogin.Encrypt(sPassword, sType : string) : String;
Var
  sLine, sAdd : string;
  iAsc, i, iPassNum : integer;
begin
  iAsc := 0;
  sLine := '';
  iPassNum := Random(8) + 2;
  for i := 1 to Length(sPassword) do
  Begin
    iAsc := Ord(sPassword[i]);
    sAdd := IntToStr(iAsc*iPassNum +(2*iPassNum))
    + arrAlphabet[Random(26)+1];
    sLine := sLine + sAdd;
  End;

  sLine := sLine + IntToStr(iPassNum) + arrAlphabet[random(26)+1] +
           IntToStr(Ord(UPCASE(sType[1])));
  Result := sLine;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
Var
  cLetter : char;
begin
  cLetter := 'A';
  for Var i := 1 to 26 do
  Begin
    arrAlphabet[i] := cLetter;
    Inc(cLetter);
  End;

  //Form Adjustments
  With frmLogin do
  Begin
    Parent := frmBackground;
    left := 0;
    Top := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Transparency := True;
  End;

  //Layout Adjustments
  With sclayLogin do
  Begin
    Parent := PANEL;
    Position.X := 0;
    Position.Y := 0;
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
    Visible := False;
    BringToFront;
  End;

  //Label Heading adjustments
  With lblAdMod do
  Begin
    Parent := scLayLogin;
    Height := 100;
    Width := scLayLogin.OriginalWidth;
    StyledSettings := lblAdMod.StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Position.X := 0;
    Position.Y := 20;//100;
    Font.Family := 'Century Gothic';
    Text := 'Admin or Moderator Login';
    Font.Size := 35;
    TextSettings.HorzAlign := TTextAlign.Center;
    Font.Style := Font.Style + [TFontStyle.fsBold];
  End;

  //rect button for login
  with rectLogin do
  Begin
    Position.X := 0.5*(scLaylogin.OriginalWidth - rectLogin.Width);
  End;

  //rect holding components
  With rectUSPA do
  Begin
    Parent := scLayLogin;
    Width := 300;
    Height := 90;
    Fill.Color := OBJECTCOLOR;
    Stroke.Color := ACCENTCOLOR;
    Position.X := 0.5*(scLaylogin.OriginalWidth - rectUSPA.Width);
    Position.Y := 0.5*(scLaylogin.OriginalHeight - rectUSPA.Height);
//    BringToFront;
  End;


  //Label Username adjustments
  With lblUsername do
  Begin
    Parent := rectUSPA;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Username';
    Font.Family := 'Century Gothic';
    Font.Style := [TFontStyle.fsBold, TFontStyle.fsItalic];
    TextSettings.HorzAlign := TTextAlign.Leading;
  End;


  //Label Password adjustments
  With lblPassword do
  Begin
    Parent := rectUSPA;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    FontColor := TEXTCOLOR;
    Text := 'Password';
    Font.Family := 'Century Gothic';
    Font.Style := [TFontStyle.fsBold ,TFontStyle.fsItalic];
    TextSettings.HorzAlign := TTextAlign.Leading;
  End;

  //edit for username input
  With edtUsername do
  Begin
  StyledSettings :=   StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
  TextSettings.FontColor := TEXTCOLOR;
  End;

  //edit for password input
  With edtPassword do
  Begin
  StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
  TextSettings.FontColor := TEXTCOLOR;
  End;
end;

procedure TfrmLogin.FormHide(Sender: TObject);
begin
  sclayLogin.Visible := False;
end;

procedure TfrmLogin.FormResize(Sender: TObject);
begin
  RepositionObjects;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  sclayLogin.Visible := True;
  RepositionObjects;
end;

procedure TfrmLogin.imgExitClick(Sender: TObject);
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

procedure TfrmLogin.lblLoginClick(Sender: TObject);
begin
  rectLogin.OnClick(Self);
end;

procedure TfrmLogin.rectLoginClick(Sender: TObject);
Var
  sEntUsername, sEntPassword, sUsername, sPassword, sLine : String;
  F : TextFile;
  iPos, iLine : Integer;
  cLogin : Char;
  bAdLogin, bValid : Boolean;
begin
  bAdLogin := False;
  bValid := False;
  iLine := 0;
  sEntUsername := edtUsername.Text;
  sEntPassword := edtPassword.Text;

  AssignFile(F,'AppData.txt');
  try
    Reset(F);
  Except
    MessageDlg('Application Data File cannot be found, please consult an ' +
    'FDFSA Administrator',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  end;

  while Not EOF(F) do
  Begin
    inc(iLine);
    readLn(F, sLine);
    if (iLine = 1) or (iLine = 3)
    then
    Begin
    sUsername := sLine;
    sUsername := Decrypt(sUsername);
    for Var I := 1 to Length(sUsername) do
    Begin
      iPos := Pos(' ', sUsername);
    End;
    cLogin := sUsername[Length(sUsername)];
    Delete(sUsername,iPos,2);

    if sEntUsername = sUsername then
      if cLogin = 'M' then bAdLogin := False
                      else bAdLogin := True;
    End
    else
    if (bAdLogin = True) AND (iLine = 4) then
    Begin
      sPassword := sLine;
      sPassword := Decrypt(sPassword);
      for Var I := 1 to Length(sPassword) do
      Begin
      iPos := Pos(' ', sPassword);
      End;
      Delete(sPassword,iPos,2);

    if sEntPassword = sPassword then 
      Begin
      bValid := True;
      bAdmin := True;
      frmAdmitdrivers.bAdminUser := true;
      End;
    End
    else 
    if (bAdLogin = False) AND (iLine = 2) then
    Begin
      sPassword := sLine;
      sPassword := Decrypt(sPassword);
      for Var I := 1 to Length(sPassword) do
      Begin
      iPos := Pos(' ', sPassword);
      End;
      Delete(sPassword,iPos,2);

    if sEntPassword = sPassword then 
      Begin
      bValid := True;
      bModerator := True;
      frmAdmitdrivers.bModUser := true;
      End;  
    End;
  End;

  if bValid = False then
  Begin
     MessageDlg('Username or password is incorrect',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;
  
  Var sType : String;
  if bAdLogin then sType := 'Admin'
  else sType := 'Moderator';

  MessageDlg(sType + ' login successful!',
    TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK],0);


  ShownForm.Hide;
  frmHome.Show;
  ShownForm := frmHome;
  
  CloseFile(F);
  
end;

procedure TfrmLogin.rectUSPAClick(Sender: TObject);
begin
  {var s : String;
    s := InputBox('','',Encrypt('MODERATOR#$!42','M'));

      s := InputBox('','',Encrypt('iatM#Aai2u','M'));
        s := InputBox('','',Encrypt('ADMIN#$!84','A'));
          s := InputBox('','',Encrypt('iatsa#Ama2c!','A'));
          }
end;

procedure TfrmLogin.RepositionObjects;
begin
  With sclayLogin do
  Begin
    Height := Round(PANEL.Height);
    Width := Round(PANEL.Width);
  End;
end;

end.
