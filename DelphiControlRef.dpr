program DelphiControlRef;

uses
  Vcl.Forms,
  uCommonUtils in 'src\Utils\uCommonUtils.pas',
  uModels in 'src\Models\uModels.pas',
  uDataModule in 'src\Data\uDataModule.pas' {DM: TDataModule},
  uMainForm in 'src\Forms\uMainForm.pas' {MainForm},
  uEditControlForm in 'src\Forms\uEditControlForm.pas' {FormEditControl};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Delphi Control Reference & Cheat Sheet';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
