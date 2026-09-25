unit uEditControlForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  uDataModule;

type
  TFormEditControl = class(TForm)
    pnlHeader: TPanel;
    lblTitle: TLabel;
    lblSub: TLabel;
    pnlContent: TPanel;
    lblCat: TLabel;
    cboCategory: TComboBox;
    lblName: TLabel;
    edtControlName: TEdit;
    lblUnit: TLabel;
    edtUnitName: TEdit;
    lblInherit: TLabel;
    edtInheritance: TEdit;
    lblDesc: TLabel;
    mmoDescription: TMemo;
    lblBestUse: TLabel;
    mmoRecommendedUse: TMemo;
    pnlBottom: TPanel;
    btnSimpan: TButton;
    btnBatal: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
  private
    FControlID: Integer;
    procedure LoadCategoriesToCombo;
  public
    procedure InitAdd;
    procedure InitEdit(AControlID: Integer);
  end;

var
  FormEditControl: TFormEditControl;

implementation

{$R *.dfm}

procedure TFormEditControl.FormCreate(Sender: TObject);
begin
  FControlID := -1;
  LoadCategoriesToCombo;
end;

procedure TFormEditControl.LoadCategoriesToCombo;
begin
  cboCategory.Items.BeginUpdate;
  try
    cboCategory.Items.Clear;
    DM.FDQueryCategories.Close;
    DM.FDQueryCategories.Open;
    while not DM.FDQueryCategories.Eof do
    begin
      cboCategory.Items.AddObject(
        DM.FDQueryCategories.FieldByName('name').AsString,
        TObject(NativeInt(DM.FDQueryCategories.FieldByName('id').AsInteger))
      );
      DM.FDQueryCategories.Next;
    end;
    if cboCategory.Items.Count > 0 then
      cboCategory.ItemIndex := 0;
  finally
    cboCategory.Items.EndUpdate;
  end;
end;

procedure TFormEditControl.InitAdd;
begin
  FControlID := -1;
  Caption := 'Tambah Referensi Kontrol VCL Baru';
  lblTitle.Caption := 'Input Referensi Kontrol Baru / Custom';
  lblSub.Caption := 'Dokumentasikan pola baru atau trik komponen yang Anda temukan';
  edtControlName.Clear;
  edtUnitName.Clear;
  edtInheritance.Clear;
  mmoDescription.Clear;
  mmoRecommendedUse.Clear;
  if cboCategory.Items.Count > 0 then
    cboCategory.ItemIndex := 0;
end;

procedure TFormEditControl.InitEdit(AControlID: Integer);
var
  Q: TFDQuery;
  I: Integer;
  CatID: Integer;
begin
  FControlID := AControlID;
  Caption := 'Ubah / Edit Referensi Kontrol VCL';
  lblTitle.Caption := 'Ubah Data Referensi Kontrol';
  lblSub.Caption := 'Perbarui deskripsi, rekomendasi, atau unit dari komponen ini';

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.FDConnection1;
    Q.SQL.Text := 'SELECT * FROM controls WHERE id = :id';
    Q.ParamByName('id').AsInteger := AControlID;
    Q.Open;
    if not Q.IsEmpty then
    begin
      CatID := Q.FieldByName('category_id').AsInteger;
      for I := 0 to cboCategory.Items.Count - 1 do
      begin
        if NativeInt(cboCategory.Items.Objects[I]) = CatID then
        begin
          cboCategory.ItemIndex := I;
          Break;
        end;
      end;
      edtControlName.Text := Q.FieldByName('control_name').AsString;
      edtUnitName.Text := Q.FieldByName('unit_name').AsString;
      edtInheritance.Text := Q.FieldByName('inheritance').AsString;
      mmoDescription.Text := Q.FieldByName('description').AsString;
      mmoRecommendedUse.Text := Q.FieldByName('recommended_use').AsString;
    end;
  finally
    Q.Free;
  end;
end;

procedure TFormEditControl.btnSimpanClick(Sender: TObject);
var
  CatID: Integer;
begin
  if Trim(edtControlName.Text) = '' then
  begin
    ShowMessage('Nama kontrol tidak boleh kosong!');
    edtControlName.SetFocus;
    Exit;
  end;

  if cboCategory.ItemIndex < 0 then
  begin
    ShowMessage('Pilih kategori terlebih dahulu!');
    cboCategory.SetFocus;
    Exit;
  end;

  CatID := NativeInt(cboCategory.Items.Objects[cboCategory.ItemIndex]);

  try
    if FControlID <= 0 then
    begin
      // INSERT MODE
      DM.FDConnection1.ExecSQL(
        'INSERT INTO controls (category_id, control_name, unit_name, inheritance, description, recommended_use) ' +
        'VALUES (:category_id, :control_name, :unit_name, :inheritance, :description, :recommended_use)',
        [CatID,
         Trim(edtControlName.Text),
         Trim(edtUnitName.Text),
         Trim(edtInheritance.Text),
         Trim(mmoDescription.Text),
         Trim(mmoRecommendedUse.Text)]
      );
    end
    else
    begin
      // UPDATE MODE
      DM.FDConnection1.ExecSQL(
        'UPDATE controls SET category_id = :category_id, control_name = :control_name, ' +
        'unit_name = :unit_name, inheritance = :inheritance, description = :description, ' +
        'recommended_use = :recommended_use WHERE id = :id',
        [CatID,
         Trim(edtControlName.Text),
         Trim(edtUnitName.Text),
         Trim(edtInheritance.Text),
         Trim(mmoDescription.Text),
         Trim(mmoRecommendedUse.Text),
         FControlID]
      );
    end;

    ModalResult := mrOk;
  except
    on E: Exception do
      ShowMessage('Gagal menyimpan kontrol: ' + E.Message);
  end;
end;

end.
