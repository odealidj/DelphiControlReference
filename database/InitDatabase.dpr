program InitDatabase;
{$APPTYPE CONSOLE}
uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script,
  FireDAC.VCLUI.Wait;

var
  Con: TFDConnection;
  Script: TFDScript;
  BaseDir, DBPath, SchemaPath, SeedPath: string;
begin
  try
    Writeln('=== Inisialisasi Basis Data Delphi Control Reference ===');
    BaseDir := ExtractFilePath(ParamStr(0));
    if not TFile.Exists(TPath.Combine(BaseDir, 'schema.sql')) then
      BaseDir := TPath.GetFullPath(TPath.Combine(BaseDir, '..\database'));

    DBPath := TPath.Combine(BaseDir, 'control_ref.db');
    SchemaPath := TPath.Combine(BaseDir, 'schema.sql');
    SeedPath := TPath.Combine(BaseDir, 'seed_data.sql');

    if TFile.Exists(DBPath) then
    begin
      TFile.Delete(DBPath);
      Writeln('Menghapus database lama: ' + DBPath);
    end;

    Con := TFDConnection.Create(nil);
    Script := TFDScript.Create(nil);
    try
      Con.DriverName := 'SQLite';
      Con.Params.Database := DBPath;
      Con.Connected := True;
      Writeln('Koneksi SQLite aktif: ' + DBPath);

      Script.Connection := Con;

      Writeln('Mengeksekusi skema (schema.sql)...');
      Script.SQLScripts.Clear;
      Script.SQLScripts.Add.SQL.LoadFromFile(SchemaPath, TEncoding.UTF8);
      Script.ValidateAll;
      Script.ExecuteAll;

      Writeln('Mengeksekusi data awal (seed_data.sql)...');
      Script.SQLScripts.Clear;
      Script.SQLScripts.Add.SQL.LoadFromFile(SeedPath, TEncoding.UTF8);
      Script.ValidateAll;
      Script.ExecuteAll;

      Writeln('SUKSES: Basis data control_ref.db berhasil diinisialisasi dan diisi!');
    finally
      Script.Free;
      Con.Free;
    end;
  except
    on E: Exception do
      Writeln('ERROR: ' + E.Message);
  end;
end.
