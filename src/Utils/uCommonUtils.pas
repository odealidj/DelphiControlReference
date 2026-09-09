unit uCommonUtils;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Clipbrd,
  System.IOUtils;

function GetDatabasePath: string;
procedure CopyTextToClipboard(const AText: string);
function FormatCurrencyIDR(const AValue: Double): string;

implementation

function GetDatabasePath: string;
var
  AppDir: string;
  CandidatePath: string;
begin
  AppDir := ExtractFilePath(ParamStr(0));
  // 1. Cek di folder ../database/ (saat dijalankan dari bin/ atau src/)
  CandidatePath := TPath.Combine(TPath.Combine(AppDir, '..\database'), 'control_ref.db');
  if TFile.Exists(CandidatePath) then
    Exit(TPath.GetFullPath(CandidatePath));

  // 2. Cek di subfolder database/ (saat dijalankan dari root DelphiControlReference)
  CandidatePath := TPath.Combine(TPath.Combine(AppDir, 'database'), 'control_ref.db');
  if TFile.Exists(CandidatePath) then
    Exit(TPath.GetFullPath(CandidatePath));

  // 3. Cek di direktori kerja saat ini (Current Working Directory)
  CandidatePath := TPath.Combine('database', 'control_ref.db');
  if TFile.Exists(CandidatePath) then
    Exit(TPath.GetFullPath(CandidatePath));

  // Default fallback di direktori aplikasi
  Result := TPath.Combine(AppDir, 'control_ref.db');
end;

procedure CopyTextToClipboard(const AText: string);
begin
  Clipboard.AsText := AText;
end;

function FormatCurrencyIDR(const AValue: Double): string;
begin
  Result := 'Rp ' + FormatCurr('#,##0', AValue);
end;

end.
