unit uMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  uDataModule,
  uCommonUtils;

type
  TMainForm = class(TForm)
    pnlHeader: TPanel;
    lblAppTitle: TLabel;
    lblAppSubtitle: TLabel;
    lblSearch: TLabel;
    edtSearch: TEdit;
    btnNewRecord: TButton;
    pnlLeftNav: TPanel;
    lblNavHeader: TLabel;
    tvControls: TTreeView;
    splMain: TSplitter;
    pnlClientArea: TPanel;
    pnlControlCard: TPanel;
    lblCardTitle: TLabel;
    lblCardUnit: TLabel;
    lblCardDesc: TLabel;
    pnlCardActions: TPanel;
    btnEditControl: TButton;
    btnDeleteControl: TButton;
    pcDetails: TPageControl;
    tsMembers: TTabSheet;
    lvMembers: TListView;
    tsSnippets: TTabSheet;
    pnlSnippetToolbar: TPanel;
    lblPilihSnippet: TLabel;
    cboSnippets: TComboBox;
    btnCopySnippet: TButton;
    btnDeleteSnippet: TButton;
    lblSnippetMeta: TLabel;
    mmoSnippetCode: TMemo;
    pnlSnippetFooter: TPanel;
    lblExplanation: TLabel;
    mmoExplanation: TMemo;
    tsBestPractices: TTabSheet;
    pnlBPToolbar: TPanel;
    lblPilihBP: TLabel;
    cboBestPractices: TComboBox;
    btnCopyBP: TButton;
    btnDeleteBP: TButton;
    pnlBPContent: TPanel;
    lblBPProblemTitle: TLabel;
    mmoBPProblem: TMemo;
    lblBPSolutionTitle: TLabel;
    mmoBPSolution: TMemo;
    tsSandbox: TTabSheet;
    pnlSandboxDesc: TPanel;
    lblSandboxNote: TLabel;
    gbDemoEdit: TGroupBox;
    lblDemoEditPrompt: TLabel;
    lblDemoEditResult: TLabel;
    edtDemoRupiah: TEdit;
    gbDemoAsyncButton: TGroupBox;
    lblDemoAsyncStatus: TLabel;
    btnDemoAsync: TButton;
    pbDemoAsync: TProgressBar;
    gbDemoComboBox: TGroupBox;
    lblDemoComboPrompt: TLabel;
    lblDemoComboResult: TLabel;
    cboDemoKeyValue: TComboBox;
    tmrSearchDebounce: TTimer;
    tmrAsyncSim: TTimer;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSearchChange(Sender: TObject);
    procedure tmrSearchDebounceTimer(Sender: TObject);
    procedure tvControlsChange(Sender: TObject; Node: TTreeNode);
    procedure cboSnippetsChange(Sender: TObject);
    procedure btnCopySnippetClick(Sender: TObject);
    procedure btnDeleteSnippetClick(Sender: TObject);
    procedure cboBestPracticesChange(Sender: TObject);
    procedure btnCopyBPClick(Sender: TObject);
    procedure btnDeleteBPClick(Sender: TObject);
    procedure btnNewRecordClick(Sender: TObject);
    procedure btnEditControlClick(Sender: TObject);
    procedure btnDeleteControlClick(Sender: TObject);
    procedure edtDemoRupiahChange(Sender: TObject);
    procedure btnDemoAsyncClick(Sender: TObject);
    procedure tmrAsyncSimTimer(Sender: TObject);
    procedure cboDemoKeyValueChange(Sender: TObject);
  private
    FCurrentControlID: Integer;
    FIsFormattingRupiah: Boolean;
    FAsyncStep: Integer;
    procedure PopulateTree(const ASearchKeyword: string = '');
    procedure SelectControlInTree(AControlID: Integer);
    procedure LoadControlDetailView(AControlID: Integer);
    procedure InitSandboxDemos;
  public
  end;

var
  MainForm: TMainForm;

implementation

uses
  uEditControlForm;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCurrentControlID := -1;
  FIsFormattingRupiah := False;
  FAsyncStep := 0;

  InitSandboxDemos;
  PopulateTree;

  // Pilih node kontrol pertama secara otomatis jika ada
  if tvControls.Items.Count > 0 then
  begin
    if (tvControls.Items[0].Count > 0) then
      tvControls.Selected := tvControls.Items[0].Item[0]
    else
      tvControls.Selected := tvControls.Items[0];
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrSearchDebounce.Enabled := False;
  tmrAsyncSim.Enabled := False;
  Action := caFree;
  Application.Terminate;
end;

procedure TMainForm.InitSandboxDemos;
begin
  // Isi demo ComboBox dengan pasangan Label & ID
  cboDemoKeyValue.Items.BeginUpdate;
  try
    cboDemoKeyValue.Items.Clear;
    cboDemoKeyValue.Items.AddObject('Platinum Enterprise Customer', TObject(NativeInt(1001)));
    cboDemoKeyValue.Items.AddObject('Gold Business Partner', TObject(NativeInt(1002)));
    cboDemoKeyValue.Items.AddObject('Silver Regular Member', TObject(NativeInt(1003)));
    cboDemoKeyValue.Items.AddObject('Trial Account', TObject(NativeInt(1004)));
    cboDemoKeyValue.ItemIndex := 0;
  finally
    cboDemoKeyValue.Items.EndUpdate;
  end;
  cboDemoKeyValueChange(nil);
end;

procedure TMainForm.PopulateTree(const ASearchKeyword: string);
var
  CatNode, CtrlNode: TTreeNode;
  CatDict: TStringList;
  CatName: string;
  CtrlID: Integer;
  Idx: Integer;
begin
  tvControls.Items.BeginUpdate;
  CatDict := TStringList.Create;
  try
    tvControls.Items.Clear;
    CatDict.Duplicates := dupIgnore;
    CatDict.Sorted := False;

    DM.FilterControls(ASearchKeyword);

    while not DM.FDQueryControls.Eof do
    begin
      CatName := DM.FDQueryControls.FieldByName('category_name').AsString;
      CtrlID := DM.FDQueryControls.FieldByName('id').AsInteger;

      // Cari atau buat parent category node
      Idx := CatDict.IndexOf(CatName);
      if Idx = -1 then
      begin
        CatNode := tvControls.Items.Add(nil, CatName);
        CatNode.Data := Pointer(NativeInt(-1)); // Parent node
        CatDict.AddObject(CatName, CatNode);
      end
      else
        CatNode := TTreeNode(CatDict.Objects[Idx]);

      // Buat child control node
      CtrlNode := tvControls.Items.AddChild(CatNode, DM.FDQueryControls.FieldByName('control_name').AsString);
      CtrlNode.Data := Pointer(NativeInt(CtrlID));

      DM.FDQueryControls.Next;
    end;

    tvControls.FullExpand;
  finally
    CatDict.Free;
    tvControls.Items.EndUpdate;
  end;

  StatusBar1.Panels[0].Text := Format('Total Kontrol Terdaftar: %d', [DM.FDQueryControls.RecordCount]);
end;

procedure TMainForm.SelectControlInTree(AControlID: Integer);
var
  I: Integer;
  Node: TTreeNode;
begin
  for I := 0 to tvControls.Items.Count - 1 do
  begin
    Node := tvControls.Items[I];
    if Assigned(Node.Data) and (NativeInt(Node.Data) = AControlID) then
    begin
      tvControls.Selected := Node;
      Node.MakeVisible;
      Break;
    end;
  end;
end;

procedure TMainForm.tvControlsChange(Sender: TObject; Node: TTreeNode);
var
  CtrlID: Integer;
begin
  if not Assigned(Node) or not Assigned(Node.Data) then Exit;
  CtrlID := NativeInt(Node.Data);
  if CtrlID > 0 then
    LoadControlDetailView(CtrlID);
end;

procedure TMainForm.LoadControlDetailView(AControlID: Integer);
var
  ListItem: TListItem;
  SnippetID, BPID: Integer;
begin
  FCurrentControlID := AControlID;

  // 1. Ambil data utama kontrol
  DM.FDQueryControls.Locate('id', AControlID, []);
  lblCardTitle.Caption := DM.FDQueryControls.FieldByName('control_name').AsString;
  lblCardUnit.Caption := Format('Unit: %s   |   Hirarki: %s',
    [DM.FDQueryControls.FieldByName('unit_name').AsString,
     DM.FDQueryControls.FieldByName('inheritance').AsString]);
  lblCardDesc.Caption := DM.FDQueryControls.FieldByName('description').AsString;

  // 2. Muat tabel relasi via DataModule
  DM.LoadControlDetails(AControlID);

  // 3. Tab Members (ListView)
  lvMembers.Items.BeginUpdate;
  try
    lvMembers.Items.Clear;
    while not DM.FDQueryMembers.Eof do
    begin
      ListItem := lvMembers.Items.Add;
      ListItem.Caption := DM.FDQueryMembers.FieldByName('member_type').AsString;
      ListItem.SubItems.Add(DM.FDQueryMembers.FieldByName('member_name').AsString);
      ListItem.SubItems.Add(DM.FDQueryMembers.FieldByName('data_type').AsString);
      ListItem.SubItems.Add(DM.FDQueryMembers.FieldByName('description').AsString);
      ListItem.SubItems.Add(DM.FDQueryMembers.FieldByName('production_tip').AsString);
      DM.FDQueryMembers.Next;
    end;
  finally
    lvMembers.Items.EndUpdate;
  end;

  // 4. Tab Code Snippets
  cboSnippets.Items.BeginUpdate;
  try
    cboSnippets.Items.Clear;
    while not DM.FDQuerySnippets.Eof do
    begin
      SnippetID := DM.FDQuerySnippets.FieldByName('id').AsInteger;
      cboSnippets.Items.AddObject(DM.FDQuerySnippets.FieldByName('title').AsString,
                                  TObject(NativeInt(SnippetID)));
      DM.FDQuerySnippets.Next;
    end;
    if cboSnippets.Items.Count > 0 then
    begin
      cboSnippets.ItemIndex := 0;
      cboSnippetsChange(nil);
    end
    else
    begin
      mmoSnippetCode.Clear;
      mmoExplanation.Clear;
      lblSnippetMeta.Caption := '[Tidak ada snippet]';
    end;
  finally
    cboSnippets.Items.EndUpdate;
  end;

  // 5. Tab Best Practices & Gotchas
  cboBestPractices.Items.BeginUpdate;
  try
    cboBestPractices.Items.Clear;
    while not DM.FDQueryBestPractices.Eof do
    begin
      BPID := DM.FDQueryBestPractices.FieldByName('id').AsInteger;
      cboBestPractices.Items.AddObject(DM.FDQueryBestPractices.FieldByName('title').AsString,
                                       TObject(NativeInt(BPID)));
      DM.FDQueryBestPractices.Next;
    end;
    if cboBestPractices.Items.Count > 0 then
    begin
      cboBestPractices.ItemIndex := 0;
      cboBestPracticesChange(nil);
    end
    else
    begin
      mmoBPProblem.Text := 'Belum ada catatan khusus untuk kontrol ini.';
      mmoBPSolution.Text := '';
    end;
  finally
    cboBestPractices.Items.EndUpdate;
  end;
end;

procedure TMainForm.cboSnippetsChange(Sender: TObject);
var
  SnippetID: Integer;
begin
  if cboSnippets.ItemIndex < 0 then Exit;
  SnippetID := NativeInt(cboSnippets.Items.Objects[cboSnippets.ItemIndex]);

  if DM.FDQuerySnippets.Locate('id', SnippetID, []) then
  begin
    mmoSnippetCode.Text := DM.FDQuerySnippets.FieldByName('snippet_code').AsString;
    mmoExplanation.Text := DM.FDQuerySnippets.FieldByName('explanation').AsString;
    lblSnippetMeta.Caption := Format('[Skenario: %s | Level: %s | Target: %s]',
      [DM.FDQuerySnippets.FieldByName('scenario_type').AsString,
       DM.FDQuerySnippets.FieldByName('complexity').AsString,
       DM.FDQuerySnippets.FieldByName('delphi_version').AsString]);
  end;
end;

procedure TMainForm.btnCopySnippetClick(Sender: TObject);
begin
  if Trim(mmoSnippetCode.Text) = '' then Exit;
  CopyTextToClipboard(mmoSnippetCode.Text);
  StatusBar1.Panels[0].Text := 'Kode snippet berhasil disalin ke Clipboard!';
  ShowMessage('Kode snippet berhasil disalin ke Clipboard!');
end;

procedure TMainForm.btnDeleteSnippetClick(Sender: TObject);
var
  SnippetID: Integer;
  SnippetTitle: string;
begin
  if cboSnippets.ItemIndex < 0 then
  begin
    ShowMessage('Pilih snippet yang ingin dihapus terlebih dahulu.');
    Exit;
  end;

  SnippetID := NativeInt(cboSnippets.Items.Objects[cboSnippets.ItemIndex]);
  SnippetTitle := cboSnippets.Text;

  if MessageDlg(Format('Apakah Anda yakin ingin menghapus snippet "%s"?', [SnippetTitle]),
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      DM.FDConnection1.ExecSQL('DELETE FROM snippets WHERE id = :id', [SnippetID]);
      ShowMessage('Snippet berhasil dihapus!');
      if FCurrentControlID > 0 then
        LoadControlDetailView(FCurrentControlID);
    except
      on E: Exception do
        ShowMessage('Gagal menghapus snippet: ' + E.Message);
    end;
  end;
end;

procedure TMainForm.cboBestPracticesChange(Sender: TObject);
var
  BPID: Integer;
begin
  if cboBestPractices.ItemIndex < 0 then Exit;
  BPID := NativeInt(cboBestPractices.Items.Objects[cboBestPractices.ItemIndex]);

  if DM.FDQueryBestPractices.Locate('id', BPID, []) then
  begin
    mmoBPProblem.Text := DM.FDQueryBestPractices.FieldByName('problem_description').AsString;
    mmoBPSolution.Text := DM.FDQueryBestPractices.FieldByName('solution_code').AsString;
  end;
end;

procedure TMainForm.btnCopyBPClick(Sender: TObject);
begin
  if Trim(mmoBPSolution.Text) = '' then Exit;
  CopyTextToClipboard(mmoBPSolution.Text);
  StatusBar1.Panels[0].Text := 'Kode solusi berhasil disalin ke Clipboard!';
  ShowMessage('Kode solusi best practice berhasil disalin ke Clipboard!');
end;

procedure TMainForm.btnDeleteBPClick(Sender: TObject);
var
  BPID: Integer;
  BPTitle: string;
begin
  if cboBestPractices.ItemIndex < 0 then
  begin
    ShowMessage('Pilih best practice yang ingin dihapus terlebih dahulu.');
    Exit;
  end;

  BPID := NativeInt(cboBestPractices.Items.Objects[cboBestPractices.ItemIndex]);
  BPTitle := cboBestPractices.Text;

  if MessageDlg(Format('Apakah Anda yakin ingin menghapus catatan masalah "%s"?', [BPTitle]),
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      DM.FDConnection1.ExecSQL('DELETE FROM best_practices WHERE id = :id', [BPID]);
      ShowMessage('Catatan best practice berhasil dihapus!');
      if FCurrentControlID > 0 then
        LoadControlDetailView(FCurrentControlID);
    except
      on E: Exception do
        ShowMessage('Gagal menghapus best practice: ' + E.Message);
    end;
  end;
end;

procedure TMainForm.edtSearchChange(Sender: TObject);
begin
  // Reset debounce timer
  tmrSearchDebounce.Enabled := False;
  tmrSearchDebounce.Enabled := True;
end;

procedure TMainForm.tmrSearchDebounceTimer(Sender: TObject);
begin
  tmrSearchDebounce.Enabled := False;
  PopulateTree(edtSearch.Text);
end;

procedure TMainForm.btnNewRecordClick(Sender: TObject);
var
  EditDlg: TFormEditControl;
begin
  EditDlg := TFormEditControl.Create(Self);
  try
    EditDlg.InitAdd;
    if EditDlg.ShowModal = mrOk then
    begin
      PopulateTree(edtSearch.Text);
      ShowMessage('Catatan kontrol baru berhasil ditambahkan!');
    end;
  finally
    EditDlg.Free;
  end;
end;

procedure TMainForm.btnEditControlClick(Sender: TObject);
var
  EditDlg: TFormEditControl;
  TargetID: Integer;
begin
  if FCurrentControlID <= 0 then
  begin
    ShowMessage('Pilih kontrol yang ingin diubah terlebih dahulu.');
    Exit;
  end;

  TargetID := FCurrentControlID;
  EditDlg := TFormEditControl.Create(Self);
  try
    EditDlg.InitEdit(TargetID);
    if EditDlg.ShowModal = mrOk then
    begin
      PopulateTree(edtSearch.Text);
      SelectControlInTree(TargetID);
      ShowMessage('Data referensi kontrol berhasil diperbarui!');
    end;
  finally
    EditDlg.Free;
  end;
end;

procedure TMainForm.btnDeleteControlClick(Sender: TObject);
var
  CtrlName: string;
begin
  if FCurrentControlID <= 0 then
  begin
    ShowMessage('Pilih kontrol yang ingin dihapus terlebih dahulu.');
    Exit;
  end;

  CtrlName := lblCardTitle.Caption;
  if MessageDlg(Format('Apakah Anda yakin ingin menghapus referensi kontrol "%s"?' + sLineBreak +
                       'Semua rincian anggota, snippet, dan best practice terkait akan ikut terhapus.',
                       [CtrlName]),
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      DM.FDConnection1.ExecSQL('DELETE FROM controls WHERE id = :id', [FCurrentControlID]);
      ShowMessage(Format('Kontrol "%s" berhasil dihapus!', [CtrlName]));
      FCurrentControlID := -1;
      PopulateTree(edtSearch.Text);
      if tvControls.Items.Count > 0 then
      begin
        if tvControls.Items[0].Count > 0 then
          tvControls.Selected := tvControls.Items[0].Item[0]
        else
          tvControls.Selected := tvControls.Items[0];
      end
      else
      begin
        lblCardTitle.Caption := 'Tidak Ada Kontrol';
        lblCardUnit.Caption := '';
        lblCardDesc.Caption := 'Pustaka kosong. Tambahkan kontrol baru menggunakan tombol di atas.';
        lvMembers.Items.Clear;
        cboSnippets.Items.Clear;
        mmoSnippetCode.Clear;
        mmoExplanation.Clear;
        cboBestPractices.Items.Clear;
        mmoBPProblem.Clear;
        mmoBPSolution.Clear;
      end;
    except
      on E: Exception do
        ShowMessage('Gagal menghapus kontrol: ' + E.Message);
    end;
  end;
end;

// ==========================================
// Sandbox Interactive Live Demos
// ==========================================

procedure TMainForm.edtDemoRupiahChange(Sender: TObject);
var
  CleanStr: string;
  ValDouble: Double;
begin
  if FIsFormattingRupiah then Exit;
  FIsFormattingRupiah := True;
  try
    CleanStr := StringReplace(edtDemoRupiah.Text, '.', '', [rfReplaceAll]);
    CleanStr := StringReplace(CleanStr, 'Rp', '', [rfReplaceAll]);
    CleanStr := StringReplace(CleanStr, ' ', '', [rfReplaceAll]);

    if TryStrToFloat(CleanStr, ValDouble) then
    begin
      edtDemoRupiah.Text := FormatCurr('#,##0', ValDouble);
      edtDemoRupiah.SelStart := Length(edtDemoRupiah.Text);
      lblDemoEditResult.Caption := 'Hasil Nilai: ' + FormatCurrencyIDR(ValDouble);
    end
    else if CleanStr = '' then
    begin
      edtDemoRupiah.Text := '';
      lblDemoEditResult.Caption := 'Hasil Nilai: Rp 0';
    end;
  finally
    FIsFormattingRupiah := False;
  end;
end;

procedure TMainForm.btnDemoAsyncClick(Sender: TObject);
begin
  btnDemoAsync.Enabled := False;
  pbDemoAsync.Position := 0;
  lblDemoAsyncStatus.Caption := 'Status: Memproses di background...';
  FAsyncStep := 0;
  tmrAsyncSim.Enabled := True;
end;

procedure TMainForm.tmrAsyncSimTimer(Sender: TObject);
begin
  Inc(FAsyncStep, 5);
  pbDemoAsync.Position := FAsyncStep;
  if FAsyncStep >= 100 then
  begin
    tmrAsyncSim.Enabled := False;
    btnDemoAsync.Enabled := True;
    lblDemoAsyncStatus.Caption := 'Status: Selesai! (UI tetap responsif)';
    ShowMessage('Simulasi pemrosesan asinkron berhasil selesai!');
  end;
end;

procedure TMainForm.cboDemoKeyValueChange(Sender: TObject);
var
  SelectedID: Integer;
begin
  if cboDemoKeyValue.ItemIndex >= 0 then
  begin
    SelectedID := NativeInt(cboDemoKeyValue.Items.Objects[cboDemoKeyValue.ItemIndex]);
    lblDemoComboResult.Caption := Format('Selected ID Database: %d (%s)',
      [SelectedID, cboDemoKeyValue.Text]);
  end
  else
    lblDemoComboResult.Caption := 'Selected ID Database: -';
end;

end.
