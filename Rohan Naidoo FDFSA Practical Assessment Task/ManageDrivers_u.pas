unit ManageDrivers_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope;

type
  TfrmManageDrivers = class(TForm)
    StyleBook1: TStyleBook;
    scLayManage: TScaledLayout;
    lblManage: TLabel;
    rectConfirm: TRectangle;
    rectReset: TRectangle;
    lblReset: TLabel;
    stgManage: TStringGrid;
    lblConfirm: TLabel;
    rectSort: TRectangle;
    lblSort: TLabel;
    rectShowFDA: TRectangle;
    lblShowFDA: TLabel;
    rectMax: TRectangle;
    lblMax: TLabel;
    rectMin: TRectangle;
    lblMin: TLabel;
    S: TCircle;
    imgExit: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lblConfirmClick(Sender: TObject);
    procedure rectSortClick(Sender: TObject);
    procedure lblShowClick(Sender: TObject);
    procedure rectShowFDAClick(Sender: TObject);
    procedure lblShowFDAClick(Sender: TObject);
    procedure lblMinClick(Sender: TObject);
    procedure lblMaxClick(Sender: TObject);
    procedure rectMinClick(Sender: TObject);
    procedure rectResetClick(Sender: TObject);
    procedure lblResetClick(Sender: TObject);
    procedure rectMaxClick(Sender: TObject);
    procedure rectConfirmClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }
    Procedure RepositionObjects;
    Procedure Display; Overload;
    Procedure Display(Colcount:Integer); Overload;
  public
    { Public declarations }
  end;

var
  frmManageDrivers: TfrmManageDrivers;

implementation
Uses
  Background_u, dmDrivers_u;

{$R *.fmx}

procedure TfrmManageDrivers.Display;
Var
  strCol : TStringColumn;
  Word, WMax : Real;
begin
  With dmDrivers.qryDrivers do
  Begin
  Open;

    for Var ICol := 1 to 8 do
      begin
        strCol := TStringColumn.Create(stgManage);
        strCol.Width := 50;
        strCol.Header := Fields[iCol-1].FieldName;
        stgManage.AddObject(strCol);
        Wmax := strCol.Header.Length *7;
        First;
        for Var iRow := 1 to RecordCount do
          Begin
            stgManage.Cells[iCol-1, iRow-1] := Fields[iCol-1].AsString;
            Word :=
            stgManage.Canvas.TextWidth(stgManage.Cells[iCol-1, iRow-1]);
            if Word > WMax then
            WMax := Word;
            Next;
          End;
          StrCol.Width := wMax + 15;
      end;

  End;
end;

procedure TfrmManageDrivers.Display(Colcount: Integer);
Var
  strCol : TStringColumn;
  Word, WMax : Real;
begin
  With dmDrivers.qryDrivers do
  Begin
  Open;

    for Var ICol := 1 to ColCount do
      begin
        strCol := TStringColumn.Create(stgManage);
        strCol.Width := 50;
        strCol.Header := Fields[iCol-1].FieldName;
        stgManage.AddObject(strCol);
        Wmax := strCol.Header.Length *7;
        First;
        for Var iRow := 1 to RecordCount do
          Begin
            stgManage.Cells[iCol-1, iRow-1] := Fields[iCol-1].AsString;
            Word :=
            stgManage.Canvas.TextWidth(stgManage.Cells[iCol-1, iRow-1]);
            if Word > WMax then
            WMax := Word;
            Next;
          End;
          StrCol.Width := wMax + 15;
      end;

  End;
end;

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
    Visible := True;
  End;

  //Change
  With stgManage do
  Begin
    Parent := scLayManage;
    RowCount := 10;
    Width := 800;
    Height := 300;
    Position.X := (scLayManage.OriginalWidth- stgManage.width)*0.5;
    StyledSettings := StyledSettings -
                             [TStyledSetting.FontColor] -
                             [TStyledSetting.Family] -
                             [TStyledSetting.Style] -
                             [TStyledSetting.Size] -
                             [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;

    if bDarkMode then
    Begin
    StyleLookup := 'stgManageDark';

    End
    else StyleLookup := 'stgManageLight';
    Options := Options + [TGridOption.RowSelect];
  End;


  //label indicating sorting rectangle
  with lblSort do
  Begin
    StyledSettings:= StyledSettings -
                     [TStyledSetting.FontColor] -
                     [TStyledSetting.Family] -
                     [TStyledSetting.Style] -
                     [TStyledSetting.Size] -
                     [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;
  End;

  //label indicating minimum rectangle
  with lblMin do
  Begin
    StyledSettings:= StyledSettings -
                     [TStyledSetting.FontColor] -
                     [TStyledSetting.Family] -
                     [TStyledSetting.Style] -
                     [TStyledSetting.Size] -
                     [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;
  End;

  //label indicating maximum rectangle
  with lblMax do
  Begin
    StyledSettings:= StyledSettings -
                     [TStyledSetting.FontColor] -
                     [TStyledSetting.Family] -
                     [TStyledSetting.Style] -
                     [TStyledSetting.Size] -
                     [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;
  End;

  //label indicating FDA rectangle
  with lblShowFDA do
  Begin
    StyledSettings:= StyledSettings -
                     [TStyledSetting.FontColor] -
                     [TStyledSetting.Family] -
                     [TStyledSetting.Style] -
                     [TStyledSetting.Size] -
                     [TStyledSetting.Other];
    TextSettings.FontColor := TEXTCOLOR;
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
  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT * FROM tblDrivers');
    qryDrivers.ExecSQL;
  End;

  stgManage.ClearColumns;

  Display;
end;

procedure TfrmManageDrivers.imgExitClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to exit to home page?',
     TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],0)
     = 6 then
end;

procedure TfrmManageDrivers.lblConfirmClick(Sender: TObject);
begin
  rectConfirm.OnClick(Self);
end;

procedure TfrmManageDrivers.lblMaxClick(Sender: TObject);
begin
  rectMax.OnClick(rectMax);
end;

procedure TfrmManageDrivers.lblMinClick(Sender: TObject);
begin
  rectMin.OnClick(rectMin);
end;

procedure TfrmManageDrivers.lblResetClick(Sender: TObject);
begin
  rectReset.OnClick(rectReset);
end;

procedure TfrmManageDrivers.lblShowClick(Sender: TObject);
begin
  rectSort.OnClick(rectSort);
end;

procedure TfrmManageDrivers.lblShowFDAClick(Sender: TObject);
begin
  rectShowFda.OnClick(rectShowFDA);
end;

procedure TfrmManageDrivers.rectResetClick(Sender: TObject);
begin
  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT * FROM tblDrivers');
    qryDrivers.ExecSQL;
  End;

  stgManage.ClearColumns;

  Display;
end;

procedure TfrmManageDrivers.rectConfirmClick(Sender: TObject);
Var
  iDNum : Integer;
begin
  with dmDrivers.tblDrivers do
  Begin
  Edit;
    for Var iRow := 0 to RecordCount-1 do
      Begin
        for Var iCol := 3 to stgManage.ColumnCount-1 do
        Begin
          Var iNum : Integer;
          iNum := StrToInt(stgManage.Cells[0,iRow]);
           if locate('DriverNumber', iNum, []) then
            Begin
              Edit;
              FieldByName(stgManage.Columns[iCol].Header).AsString
              := stgManage.Cells[icol,iRow];
              Post;
            End;
        End;
      End;
  End;

  MessageDlg('Changes made!',
  TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK],0);
end;

procedure TfrmManageDrivers.rectMaxClick(Sender: TObject);
Var
  sField : String;
begin
  sField := InputBox('Maximum Field', 'Please type in a field to find ' +
                     'the Maximum of','Races');

  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT MAX('+sField+') AS ["Maximum of '+sField+'"]'+
                       'FROM tblDrivers');
    qryDrivers.ExecSQL;
  End;
  stgManage.ClearColumns;
  Display(1);
end;

procedure TfrmManageDrivers.rectMinClick(Sender: TObject);
Var
  sField : String;
begin
  sField := InputBox('Minimum Field', 'Please type in a field to find ' +
                     'the minimum of','Poles');

  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT MIN('+sField+') AS ["Minimum of '+sField+'"]'+
                       'FROM tblDrivers');
    qryDrivers.ExecSQL;
  End;
  stgManage.ClearColumns;
  Display(1);

end;

procedure TfrmManageDrivers.rectShowFDAClick(Sender: TObject);
begin
  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT * FROM tblDrivers ' +
                       'WHERE (DriverStatus = "FDA") ' +
                       'AND (Races > 1)');
    qryDrivers.ExecSQL;
  End;
  stgManage.ClearColumns;
  Display;
end;

procedure TfrmManageDrivers.rectSortClick(Sender: TObject);
Var
  sSort, sType : String;
  bValid : Boolean;
begin
  bValid := False;
  sSort := InputBox('Sorting','Which field would you like to sort?',
                    'DriverNumber');

  sType := InputBox('Sorting type','Ascending(ASC) or Descending(DESC)?',
                    'ASC');
  for Var I := 0 to 7 do
  if stgManage.Columns[I].Header = sSort then bValid := True;
  if (UPPERCASE(sType) ='ASC') or (UPPERCASE(sType) ='DESC') then
  bValid := True else
  bValid := False;

  if bValid = false then
  Begin
    MessageDlg('Some entries are incorrect',
    TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Exit;
  End;


  With DmDrivers do
  Begin
    qryDrivers.SQL.Clear;
    qryDrivers.SQL.Add('SELECT * FROM tblDrivers ORDER BY ' +
    sSort + ' ' + Uppercase(sType));
    qryDrivers.ExecSQL;
  End;
  stgManage.ClearColumns;
  Display;
end;

procedure TfrmManageDrivers.RepositionObjects;
begin
  scLayManage.Width := PANEL.Width;
  scLayManage.Height := PANEL.Height;
end;

end.
