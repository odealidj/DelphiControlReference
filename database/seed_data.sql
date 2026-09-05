-- =====================================================================
-- Delphi Control Reference: Initial Production-Grade Seed Data
-- =====================================================================

-- 1. Kategori
INSERT INTO categories (id, name, description, sort_order) VALUES
(1, 'Standard', 'Komponen antarmuka dasar VCL (Edit, Button, Label, ComboBox, Memo, CheckBox, ActionList)', 1),
(2, 'Additional', 'Komponen tambahan visual (BitBtn, SpeedButton, Image, Shape, ScrollBox, StringGrid)', 2),
(3, 'Win32', 'Kontrol sistem operasi modern Windows (ListView, TreeView, PageControl, ProgressBar, DateTimePicker)', 3),
(4, 'Data-Aware', 'Kontrol berbasis koneksi dataset dan basis data (DBGrid, DBEdit, DBComboBox, DBNavigator)', 4),
(5, 'Dialogs', 'Kotak dialog standar sistem (OpenDialog, SaveDialog, FontDialog, ColorDialog)', 5);

-- 2. Daftar Kontrol
INSERT INTO controls (id, category_id, control_name, unit_name, inheritance, description, recommended_use) VALUES
(1, 1, 'TEdit', 'Vcl.StdCtrls', 'TCustomEdit -> TWinControl -> TControl', 
 'Kotak input teks satu baris standar untuk formulir entri data.',
 'Selalu terapkan validasi sanitasi input (angka/rupiah/email) dan trim spasi sebelum validasi simpan.'),

(2, 1, 'TButton', 'Vcl.StdCtrls', 'TCustomButton -> TButtonControl -> TWinControl', 
 'Tombol perintah aksi pengguna standar Windows.',
 'Gunakan TAction untuk mengikat tombol, cegah double-click submission, dan gunakan thread async untuk proses panjang.'),

(3, 1, 'TComboBox', 'Vcl.StdCtrls', 'TCustomComboBox -> TCustomCombo -> TWinControl', 
 'Daftar pilihan drop-down kombinasi teks dan daftar opsi.',
 'Gunakan csDropDownList agar input konsisten, dan simpan ID database di dalam Items.Objects[].'),

(4, 4, 'TDBGrid', 'Vcl.DBGrids', 'TCustomDBGrid -> TCustomGrid -> TWinControl', 
 'Tabel visual untuk menampilkan dan mengedit data dari TDataSet/TDataSource.',
 'Terapkan warna baris selang-seling (zebra striping) di OnDrawColumnCell dan auto-fit lebar kolom.'),

(5, 3, 'TListView', 'Vcl.ComCtrls', 'TCustomListView -> TWinControl -> TControl', 
 'Tampilan daftar item dengan opsi ikon, list, atau tabel kolom (vsReport).',
 'Gunakan mode OwnerData (Virtual List) jika menampilkan data > 1.000 baris agar performa instan.'),

(6, 1, 'TActionList', 'Vcl.ActnList', 'TCustomActionList -> TComponent -> TPersistent',
 'Komponen pemusat logika perintah, hak akses, dan sinkronisasi status UI (Enabled, Visible, Checked).',
 'Gunakan event Action.OnUpdate untuk mengontrol Enabled tombol secara reaktif tanpa logika berulang.'),

(7, 3, 'TDateTimePicker', 'Vcl.ComCtrls', 'TCommonCalendar -> TWinControl -> TControl',
 'Kontrol pemilih tanggal dan waktu terintegrasi kalender drop-down Windows.',
 'Gunakan DateOf() untuk membuang komponen jam liar, dan gunakan ShowCheckbox untuk mendukung tanggal null/kosong.'),

(8, 2, 'TStringGrid', 'Vcl.Grids', 'TDrawGrid -> TCustomGrid -> TWinControl',
 'Tabel grid matriks sel teks dua dimensi mandiri tanpa ketergantungan dataset database.',
 'Gunakan untuk entri data keranjang belanja in-memory, matriks tarif, kalkulasi cepat, dan ekspor CSV.'),

(9, 3, 'TPageControl', 'Vcl.ComCtrls', 'TCustomTabControl -> TWinControl -> TControl',
 'Kontrol kontainer multi-tab yang memuat lembar kerja terpisah (TTabSheet).',
 'Manfaatkan OnChanging untuk memvalidasi kelengkapan form sebelum berpindah tab, dan gunakan TabVisible untuk menyembunyikan tab.'),

(10, 1, 'TMemo', 'Vcl.StdCtrls', 'TCustomMemo -> TCustomEdit -> TWinControl',
 'Editor teks kotak masukan multibaris untuk catatan panjang, keterangan, atau jendela log.',
 'Bungkus pembaruan banyak baris dengan BeginUpdate/EndUpdate dan batasi jumlah baris log agar memori stabil.');

-- 3. Anggota Kontrol (Properties, Events, Methods)
-- TEdit
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(1, 'PROPERTY', 'Text', 'string', 'Nilai teks yang sedang diinput oleh pengguna.', 'Gunakan Edit1.Text.Trim saat validasi data kosong.'),
(1, 'PROPERTY', 'NumbersOnly', 'Boolean', 'Hanya menerima masukan digit angka.', 'User masih bisa melakukan paste teks; tetap validasi di OnKeyPress / OnChange.'),
(1, 'EVENT', 'OnChange', 'TNotifyEvent', 'Dipicu setiap kali isi teks mengalami perubahan.', 'Hati-hati! Terpicu saat form loading. Gunakan flag FIsLoading untuk mencegah eksekusi dini.'),
(1, 'EVENT', 'OnKeyPress', 'TKeyPressEvent', 'Dipicu saat karakter keyboard ditekan pada kontrol.', 'Set Key := #0 untuk membatalkan karakter yang dilarang.'),
(1, 'METHOD', 'SelectAll', 'procedure', 'Memilih seluruh blok teks di dalam kontrol.', 'Panggil di event OnEnter agar pengguna langsung dapat mengetik ulang nilai baru.');

-- TButton
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(2, 'PROPERTY', 'Action', 'TBasicAction', 'Menghubungkan tombol dengan TAction pada TActionList.', 'Sangat disarankan di aplikasi nyata agar status Enabled tersinkron otomatis via Action.OnUpdate.'),
(2, 'EVENT', 'OnClick', 'TNotifyEvent', 'Dipicu saat tombol ditekan atau dipicu tombol Enter.', 'Segera matikan tombol (Enabled := False) di baris pertama jika proses memakan waktu > 500ms.'),
(2, 'PROPERTY', 'Default', 'Boolean', 'Menjadikan tombol otomatis aktif saat pengguna menekan Enter.', 'Cocok untuk tombol OK / Simpan pada form dialog.');

-- TComboBox
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(3, 'PROPERTY', 'Style', 'TComboBoxStyle', 'Menentukan tipe dropdown (csDropDown, csDropDownList).', 'Selalu pilih csDropDownList untuk data referensi (Master Data) agar input konsisten.'),
(3, 'PROPERTY', 'ItemIndex', 'Integer', 'Indeks baris yang sedang dipilih (-1 jika kosong).', 'Cek ItemIndex >= 0 sebelum mengambil data dari Items[ItemIndex].'),
(3, 'EVENT', 'OnSelect', 'TNotifyEvent', 'Dipicu saat pengguna memilih item dari daftar dropdown.', 'Lebih aman dibanding OnChange jika tidak ingin terpicu saat navigasi kode.');

-- TDBGrid
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(4, 'EVENT', 'OnDrawColumnCell', 'TDrawColumnCellEvent', 'Event kustomisasi penggambaran sel per kolom.', 'Bagus untuk zebra striping baris. Selalu panggil DefaultDrawColumnCell di akhir.'),
(4, 'PROPERTY', 'Options', 'TDBGridOptions', 'Kumpulan pengaturan perilaku grid (dgRowSelect, dgIndicator).', 'Nyalakan dgRowSelect jika grid hanya berfungsi untuk navigasi/pilihan data.');

-- TListView
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(5, 'PROPERTY', 'ViewStyle', 'TViewStyle', 'Mode visual tampilan (vsIcon, vsList, vsReport).', 'Pilih vsReport untuk tampilan tabel transaksi bisnis.'),
(5, 'PROPERTY', 'OwnerData', 'Boolean', 'Mengaktifkan mode Virtual ListView.', 'Gunakan saat item > 1.000 untuk mencegah lonjakan konsumsi memori dan lag.'),
(5, 'EVENT', 'OnData', 'TLVDataEvent', 'Event penyuplai data per baris dalam mode OwnerData.', 'Hanya ambil data untuk baris yang diminta oleh ListView (on-demand rendering).');

-- TActionList
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(6, 'PROPERTY', 'Actions', 'TContainedAction', 'Koleksi seluruh action yang terdaftar.', 'Gunakan untuk iterasi pengecekan izin hak akses (permission loop).'),
(6, 'EVENT', 'OnUpdate', 'TNotifyEvent', 'Dipicu saat loop idle aplikasi Windows.', 'Gunakan untuk mengevaluasi syarat tombol aktif (misal: ada data terpilih, field terisi).'),
(6, 'EVENT', 'OnExecute', 'TNotifyEvent', 'Event eksekusi utama perintah saat tombol/shortcut ditekan.', 'Pusatkan kode eksekusi bisnis di sini, bukan di event OnClick tombol.');

-- TDateTimePicker
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(7, 'PROPERTY', 'Date', 'TDateTime', 'Nilai tanggal yang terpilih.', 'Gunakan DateOf(Date) dari System.DateUtils untuk memotong jam/menit/detik.'),
(7, 'PROPERTY', 'ShowCheckbox', 'Boolean', 'Menampilkan kotak centang untuk tanggal opsional.', 'Jika Checked = False, simpan sebagai nilai NULL di database.'),
(7, 'PROPERTY', 'Format', 'string', 'Format tampilan teks tanggal kustom (misal: yyyy-MM-dd).', 'Mencegah perbedaan format tampilan tanggal antar versi Windows user.'),
(7, 'EVENT', 'OnChange', 'TNotifyEvent', 'Dipicu saat tanggal diubah oleh pengguna.', 'Gunakan untuk memicu filter ulang dataset atau validasi rentang tanggal.');

-- TStringGrid
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(8, 'PROPERTY', 'Cells', 'string (Col, Row)', 'Akses dua dimensi isi teks sel matriks grid.', 'Cells[Col, Row] berurutan Kolom dulu baru Baris.'),
(8, 'PROPERTY', 'Objects', 'TObject (Col, Row)', 'Menyimpan referensi pointer objek pada sel.', 'Berguna untuk menyimpan ID relasional atau DTO baris data.'),
(8, 'PROPERTY', 'RowCount', 'Integer', 'Jumlah total baris grid.', 'Atur RowCount := 1 untuk mengosongkan grid namun mempertahankan baris header.'),
(8, 'EVENT', 'OnDrawCell', 'TDrawCellEvent', 'Penggambaran kustom grafis sel (alignment, warna, ikon).', 'Gunakan DrawText dengan DT_RIGHT untuk meratakan angka ke kanan.');

-- TPageControl
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(9, 'PROPERTY', 'ActivePage', 'TTabSheet', 'Menunjuk ke halaman tab yang sedang aktif ditampilkan.', 'Ubah via kode untuk berpindah tab langkah wizard: PageControl1.ActivePage := Tab2.'),
(9, 'EVENT', 'OnChanging', 'TTabChangingEvent', 'Dipicu SEBELUM pengguna berpindah tab.', 'Set AllowChange := False jika validasi input di tab saat ini belum lengkap.'),
(9, 'EVENT', 'OnChange', 'TNotifyEvent', 'Dipicu SETELAH pengguna berhasil berpindah tab.', 'Gunakan untuk memuat data tab secara on-demand (lazy loading).');

-- TMemo
INSERT INTO control_members (control_id, member_type, member_name, data_type, description, production_tip) VALUES
(10, 'PROPERTY', 'Lines', 'TStrings', 'Koleksi baris teks di dalam Memo.', 'Gunakan Lines.BeginUpdate dan Lines.EndUpdate saat memuat teks dalam jumlah besar.'),
(10, 'PROPERTY', 'WordWrap', 'Boolean', 'Pemotongan kata otomatis ke baris berikutnya.', 'Matikan WordWrap jika digunakan untuk menampilkan kode program atau log terformat.'),
(10, 'PROPERTY', 'ScrollBars', 'TScrollStyle', 'Batang penggulung horizontal/vertikal (ssBoth, ssVertical).', 'Pilih ssBoth untuk log teks panjang tanpa pemotongan kata.');

-- 4. Code Snippets (Pola Produksi Nyata)
-- TEdit
INSERT INTO snippets (control_id, title, scenario_type, complexity, delphi_version, snippet_code, explanation) VALUES
(1, 'Format Rupiah Otomatis Real-Time Saat Mengetik', 'Formatting', 'Production', 'All',
'procedure TForm1.EditRupiahChange(Sender: TObject);' || CHAR(10) ||
'var' || CHAR(10) ||
'  CleanStr: string;' || CHAR(10) ||
'  ValDouble: Double;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  if FIsFormatting then Exit;' || CHAR(10) ||
'  FIsFormatting := True;' || CHAR(10) ||
'  try' || CHAR(10) ||
'    CleanStr := StringReplace(EditRupiah.Text, ''.'', '''', [rfReplaceAll]);' || CHAR(10) ||
'    CleanStr := StringReplace(CleanStr, ''Rp'', '''', [rfReplaceAll]);' || CHAR(10) ||
'    CleanStr := StringReplace(CleanStr, '' '', '''', [rfReplaceAll]);' || CHAR(10) ||
'    if TryStrToFloat(CleanStr, ValDouble) then' || CHAR(10) ||
'    begin' || CHAR(10) ||
'      EditRupiah.Text := FormatCurr(''#,##0'', ValDouble);' || CHAR(10) ||
'      EditRupiah.SelStart := Length(EditRupiah.Text);' || CHAR(10) ||
'    end' || CHAR(10) ||
'    else if CleanStr = '''' then' || CHAR(10) ||
'      EditRupiah.Text := '''';' || CHAR(10) ||
'  finally' || CHAR(10) ||
'    FIsFormatting := False;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;',
'Format angka ribuan secara instan saat pengguna mengetik. Menggunakan guard flag FIsFormatting untuk mencegah rekursi tak terbatas (infinite loop).'),

(1, 'Filter Input Hanya Angka dan Tombol Hapus (Backspace)', 'Validation', 'Basic', 'All',
'procedure TForm1.EditAngkaKeyPress(Sender: TObject; var Key: Char);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  if not (Key in [''0''..''9'', #8]) then' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    Key := #0;' || CHAR(10) ||
'    Beep;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;',
'Mencegah pengguna mengetik huruf atau simbol pada kolom kode numerik, nomor telepon, atau jumlah.'),

-- TButton
(2, 'Eksekusi Proses Berat Latar Belakang (Tanpa UI Freeze)', 'Async/Threading', 'Production', 'Delphi 10+',
'uses System.Threading;' || CHAR(10) ||
'' || CHAR(10) ||
'procedure TForm1.BtnProsesAsyncClick(Sender: TObject);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  BtnProsesAsync.Enabled := False;' || CHAR(10) ||
'  ProgressBar1.Style := pbstMarquee;' || CHAR(10) ||
'  Screen.Cursor := crHourGlass;' || CHAR(10) ||
'' || CHAR(10) ||
'  TTask.Run(procedure' || CHAR(10) ||
'  var' || CHAR(10) ||
'    TotalProcessed: Integer;' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    Sleep(2500); // Simulasi pekerjaan berat' || CHAR(10) ||
'    TotalProcessed := 150;' || CHAR(10) ||
'' || CHAR(10) ||
'    TThread.Queue(nil, procedure' || CHAR(10) ||
'    begin' || CHAR(10) ||
'      ProgressBar1.Style := pbstNormal;' || CHAR(10) ||
'      Screen.Cursor := crDefault;' || CHAR(10) ||
'      BtnProsesAsync.Enabled := True;' || CHAR(10) ||
'      ShowMessage(''Proses selesai! Total data: '' + IntToStr(TotalProcessed));' || CHAR(10) ||
'    end);' || CHAR(10) ||
'  end);' || CHAR(10) ||
'end;',
'Pola standar produksi untuk operasi komputasi berat. Memanfaatkan Parallel Programming Library (TTask) dan TThread.Queue agar aplikasi tetap responsif.'),

-- TComboBox
(3, 'Menyimpan Label & ID Relasional Database Pada TComboBox', 'Database Binding', 'Production', 'All',
'procedure TForm1.LoadKategoriToComboBox;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  ComboBox1.Items.BeginUpdate;' || CHAR(10) ||
'  try' || CHAR(10) ||
'    ComboBox1.Items.Clear;' || CHAR(10) ||
'    QueryKategori.Open;' || CHAR(10) ||
'    while not QueryKategori.Eof do' || CHAR(10) ||
'    begin' || CHAR(10) ||
'      ComboBox1.Items.AddObject(' || CHAR(10) ||
'        QueryKategori.FieldByName(''nama_kategori'').AsString,' || CHAR(10) ||
'        TObject(NativeInt(QueryKategori.FieldByName(''id'').AsInteger))' || CHAR(10) ||
'      );' || CHAR(10) ||
'      QueryKategori.Next;' || CHAR(10) ||
'    end;' || CHAR(10) ||
'  finally' || CHAR(10) ||
'    ComboBox1.Items.EndUpdate;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;' || CHAR(10) ||
'' || CHAR(10) ||
'function TForm1.GetSelectedKategoriID: Integer;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  if ComboBox1.ItemIndex >= 0 then' || CHAR(10) ||
'    Result := NativeInt(ComboBox1.Items.Objects[ComboBox1.ItemIndex])' || CHAR(10) ||
'  else' || CHAR(10) ||
'    Result := -1;' || CHAR(10) ||
'end;',
'Menggunakan pointer casting TObject(NativeInt(ID)) yang aman dari memory leak karena tidak mengalokasikan objek baru di heap.'),

-- TDBGrid
(4, 'Zebra Striping (Warna Selang-Seling) dan Sorotan Baris Aktif', 'UI Styling', 'Production', 'All',
'procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;' || CHAR(10) ||
'  DataCol: Integer; Column: TColumn; State: TGridDrawState);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  if gdSelected in State then' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    DBGrid1.Canvas.Brush.Color := clHighlight;' || CHAR(10) ||
'    DBGrid1.Canvas.Font.Color := clHighlightText;' || CHAR(10) ||
'  end' || CHAR(10) ||
'  else if Odd(DBGrid1.DataSource.DataSet.RecNo) then' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    DBGrid1.Canvas.Brush.Color := $00F9F9F9;' || CHAR(10) ||
'    DBGrid1.Canvas.Font.Color := clWindowText;' || CHAR(10) ||
'  end' || CHAR(10) ||
'  else' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    DBGrid1.Canvas.Brush.Color := clWhite;' || CHAR(10) ||
'    DBGrid1.Canvas.Font.Color := clWindowText;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);' || CHAR(10) ||
'end;',
'Membuat tampilan tabel data VCL terlihat profesional dan nyaman dibaca untuk aplikasi pengolahan data volume besar.'),

-- TListView
(5, 'Tampilan Virtual List (OwnerData) Super Cepat untuk Data Besar', 'High Performance', 'Production', 'All',
'procedure TForm1.FormCreate(Sender: TObject);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  ListView1.ViewStyle := vsReport;' || CHAR(10) ||
'  ListView1.OwnerData := True; // Aktifkan mode virtual' || CHAR(10) ||
'  ListView1.Items.Count := FMyList.Count;' || CHAR(10) ||
'end;' || CHAR(10) ||
'' || CHAR(10) ||
'procedure TForm1.ListView1Data(Sender: TObject; Item: TListItem);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  if (Item.Index >= 0) and (Item.Index < FMyList.Count) then' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    Item.Caption := FMyList[Item.Index].Kode;' || CHAR(10) ||
'    Item.SubItems.Add(FMyList[Item.Index].Nama);' || CHAR(10) ||
'    Item.SubItems.Add(FormatCurr(''#,##0'', FMyList[Item.Index].Nominal));' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;',
'Merender data secara on-demand hanya saat baris tampil di layar, mampu menangani 100.000+ data secara instan.'),

-- TActionList
(6, 'Kontrol Otomatis Status Enabled Tombol via Action.OnUpdate', 'State Management', 'Production', 'All',
'procedure TForm1.actSimpanUpdate(Sender: TObject);' || CHAR(10) ||
'var' || CHAR(10) ||
'  IsInputValid: Boolean;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  // Evaluasi syarat tombol Simpan boleh aktif' || CHAR(10) ||
'  IsInputValid := (Trim(edtNama.Text) <> '''') and' || CHAR(10) ||
'                  (cboKategori.ItemIndex >= 0) and' || CHAR(10) ||
'                  FIsDataModified;' || CHAR(10) ||
'' || CHAR(10) ||
'  // Status tombol Simpan di form, toolbar, dan menu akan otomatis sinkron' || CHAR(10) ||
'  (Sender as TAction).Enabled := IsInputValid;' || CHAR(10) ||
'end;',
'Menghindari kode pengecekan berulang seperti "Button1.Enabled := ..." di setiap event kontrol. ActionList memperbarui status secara otomatis pada siklus Windows Idle.'),

-- TDateTimePicker
(7, 'Filter Rentang Tanggal Akurat dengan DateOf() Tanpa Jam Liar', 'Validation', 'Production', 'All',
'uses System.DateUtils;' || CHAR(10) ||
'' || CHAR(10) ||
'procedure TForm1.btnFilterLaporanClick(Sender: TObject);' || CHAR(10) ||
'var' || CHAR(10) ||
'  TglAwal, TglAkhir: TDateTime;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  // Potong waktu menjadi 00:00:00 dengan DateOf()' || CHAR(10) ||
'  TglAwal := DateOf(dtpDari.Date);' || CHAR(10) ||
'  TglAkhir := DateOf(dtpSampai.Date);' || CHAR(10) ||
'' || CHAR(10) ||
'  if TglAwal > TglAkhir then' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    ShowMessage(''Tanggal awal tidak boleh melebihi tanggal akhir!'');' || CHAR(10) ||
'    dtpDari.SetFocus;' || CHAR(10) ||
'    Exit;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'' || CHAR(10) ||
'  // Kirim parameter bersih ke SQL query' || CHAR(10) ||
'  QueryLaporan.Close;' || CHAR(10) ||
'  QueryLaporan.ParamByName(''tgl_awal'').AsDateTime := TglAwal;' || CHAR(10) ||
'  QueryLaporan.ParamByName(''tgl_akhir'').AsDateTime := TglAkhir + EncodeTime(23, 59, 59, 999);' || CHAR(10) ||
'  QueryLaporan.Open;' || CHAR(10) ||
'end;',
'Memastikan filter tanggal mencakup seluruh transaksi sampai akhir hari (23:59:59) dan mencegah query kosong akibat jam sistem.'),

-- TStringGrid
(8, 'Ekspor Cepat Matriks TStringGrid ke File CSV (UTF-8)', 'Export & Reporting', 'Production', 'All',
'procedure TForm1.ExportGridToCSV(AGrid: TStringGrid; const AFilePath: string);' || CHAR(10) ||
'var' || CHAR(10) ||
'  Writer: TStreamWriter;' || CHAR(10) ||
'  R, C: Integer;' || CHAR(10) ||
'  LineText, CellVal: string;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  Writer := TStreamWriter.Create(AFilePath, False, TEncoding.UTF8);' || CHAR(10) ||
'  try' || CHAR(10) ||
'    for R := 0 to AGrid.RowCount - 1 do' || CHAR(10) ||
'    begin' || CHAR(10) ||
'      LineText := '''';' || CHAR(10) ||
'      for C := 0 to AGrid.ColCount - 1 do' || CHAR(10) ||
'      begin' || CHAR(10) ||
'        CellVal := StringReplace(AGrid.Cells[C, R], ''"'', ''""'', [rfReplaceAll]);' || CHAR(10) ||
'        LineText := LineText + ''"'' + CellVal + ''"'';' || CHAR(10) ||
'        if C < AGrid.ColCount - 1 then LineText := LineText + '','';' || CHAR(10) ||
'      end;' || CHAR(10) ||
'      Writer.WriteLine(LineText);' || CHAR(10) ||
'    end;' || CHAR(10) ||
'  finally' || CHAR(10) ||
'    Writer.Free;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;',
'Pola ekspor data tabel in-memory langsung ke format CSV yang dapat dibuka di Microsoft Excel dengan encoding UTF-8 standar internasional.'),

-- TPageControl
(9, 'Validasi Kelengkapan Data Sebelum Berpindah Tab Form', 'Form Workflow', 'Production', 'All',
'procedure TForm1.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  // Cegah pindah dari Tab Informasi Dasar jika nama belum diisi' || CHAR(10) ||
'  if PageControl1.ActivePage = tabInfoDasar then' || CHAR(10) ||
'  begin' || CHAR(10) ||
'    if Trim(edtNamaLengkap.Text) = '''' then' || CHAR(10) ||
'    begin' || CHAR(10) ||
'      ShowMessage(''Silakan lengkapi nama sebelum melanjutkan ke tab berikutnya!'');' || CHAR(10) ||
'      edtNamaLengkap.SetFocus;' || CHAR(10) ||
'      AllowChange := False; // Batalkan perpindahan tab' || CHAR(10) ||
'    end;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;',
'Menggunakan event OnChanging untuk mencegah form multi-langkah (*wizard/stepper*) dilompati pengguna sebelum data prasyarat terisi.'),

-- TMemo
(10, 'Jendela Log Console Real-Time dengan Auto-Scroll ke Bawah', 'Logging & Console', 'Production', 'All',
'procedure TForm1.AppendLog(const AMsg: string);' || CHAR(10) ||
'const' || CHAR(10) ||
'  MAX_LOG_LINES = 1000;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  MemoLog.Lines.BeginUpdate;' || CHAR(10) ||
'  try' || CHAR(10) ||
'    // Hapus baris lama jika melewati batas memori' || CHAR(10) ||
'    if MemoLog.Lines.Count >= MAX_LOG_LINES then' || CHAR(10) ||
'      MemoLog.Lines.Delete(0);' || CHAR(10) ||
'' || CHAR(10) ||
'    MemoLog.Lines.Add(Format(''[%s] %s'', [FormatDateTime(''hh:nn:ss'', Now), AMsg]));' || CHAR(10) ||
'  finally' || CHAR(10) ||
'    MemoLog.Lines.EndUpdate;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'' || CHAR(10) ||
'  // Gulung otomatis ke baris paling bawah' || CHAR(10) ||
'  SendMessage(MemoLog.Handle, WM_VSCROLL, SB_BOTTOM, 0);' || CHAR(10) ||
'end;',
'Pola logging aktivitas real-time yang aman dari memory leak dengan pembatasan jumlah baris dan auto-scroll via pesan Windows SB_BOTTOM.');

-- 5. Best Practices & Gotchas
INSERT INTO best_practices (control_id, title, problem_description, solution_code) VALUES
(1, 'Cegah Event OnChange Terpicu Saat Memuat Form (Form Loading)',
 'Saat form pertama kali dibuka dan mengisi data entri dari database, pengisian properti Edit.Text akan otomatis memicu event OnChange. Hal ini menyebabkan status form langsung berubah menjadi "Modified/Dirty" atau memicu kalkulasi dini yang menyebabkan bug logika.',
'private' || CHAR(10) ||
'  FIsLoadingData: Boolean;' || CHAR(10) ||
'' || CHAR(10) ||
'procedure TForm1.LoadDataToForm;' || CHAR(10) ||
'begin' || CHAR(10) ||
'  FIsLoadingData := True;' || CHAR(10) ||
'  try' || CHAR(10) ||
'    EditNama.Text := Query.FieldByName(''nama'').AsString;' || CHAR(10) ||
'  finally' || CHAR(10) ||
'    FIsLoadingData := False;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;' || CHAR(10) ||
'' || CHAR(10) ||
'procedure TForm1.EditNamaChange(Sender: TObject);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  if FIsLoadingData then Exit;' || CHAR(10) ||
'  SetFormStatusModified(True);' || CHAR(10) ||
'end;'),

(2, 'Cegah Double Submission (Klik Beruntun) Pada Tombol Simpan',
 'Pengguna sering melakukan double-click atau menekan tombol simpan beberapa kali saat jaringan atau database sedang lambat. Jika tidak ditangani, aplikasi akan mengirimkan instruksi INSERT ganda yang menyebabkan duplikasi transaksi.',
'procedure TForm1.BtnSimpanClick(Sender: TObject);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  BtnSimpan.Enabled := False;' || CHAR(10) ||
'  Screen.Cursor := crHourGlass;' || CHAR(10) ||
'  try' || CHAR(10) ||
'    SimpanDataKeDatabase;' || CHAR(10) ||
'    ShowMessage(''Data berhasil disimpan!'');' || CHAR(10) ||
'  finally' || CHAR(10) ||
'    BtnSimpan.Enabled := True;' || CHAR(10) ||
'    Screen.Cursor := crDefault;' || CHAR(10) ||
'  end;' || CHAR(10) ||
'end;'),

(3, 'Hindari Memory Leak Saat Membersihkan TComboBox dengan Objek',
 'Jika Anda memasukkan instans objek kustom ke dalam ComboBox.Items.AddObject, pemanggilan ComboBox.Items.Clear TIDAK otomatis menghapus instans objek di heap tersebut, menyebabkan kebocoran memori (memory leak).',
'// Gunakan Casting Integer/Pointer (Zero Leak):' || CHAR(10) ||
'ComboBox1.Items.AddObject(''Nama'', TObject(NativeInt(ID))); // Tidak butuh Free!'),

(6, 'Jangan Menjalankan Query SQL Lambat di Dalam Action.OnUpdate',
 'Event Action.OnUpdate dieksekusi terus-menerus setiap kali thread aplikasi memasuki status idle (bisa puluhan kali per detik). Jika Anda meletakkan query SQL atau kalkulasi berat di dalam OnUpdate, CPU akan melonjak 100% dan UI aplikasi menjadi lag parah.',
'// JANGAN LAKUKAN INI DI OnUpdate:' || CHAR(10) ||
'// (Sender as TAction).Enabled := (QueryCheckData.RecordCount > 0);' || CHAR(10) ||
'' || CHAR(10) ||
'// LAKUKAN DENGAN MEMERIKSA STATUS CACHED / VARIABEL FLAG:' || CHAR(10) ||
'procedure TForm1.ActionCetakUpdate(Sender: TObject);' || CHAR(10) ||
'begin' || CHAR(10) ||
'  (Sender as TAction).Enabled := FHasActiveTransaction;' || CHAR(10) ||
'end;'),

(7, 'Bug Jam/Menit/Detik Liar Pada Nilai DateTimePicker',
 'Komponen TDateTimePicker sering kali menyimpan sisa waktu jam/menit/detik saat komponen dibaca atau saat runtime sistem, sehingga pembandingan SQL "WHERE tgl = :input" selalu gagal menghasilkan kecocokan.',
'uses System.DateUtils;' || CHAR(10) ||
'' || CHAR(10) ||
'// Selalu gunakan DateOf() saat membandingkan tanggal tunggal:' || CHAR(10) ||
'Query.ParamByName(''tgl'').AsDateTime := DateOf(DateTimePicker1.Date);'),

(8, 'Gunakan BeginUpdate dan EndUpdate Saat Mengisi TStringGrid',
 'Mengisi ribuan sel matriks TStringGrid satu per satu tanpa BeginUpdate menyebabkan Windows mengirim pesan WM_PAINT berulang kali untuk setiap sel, yang menyebabkan layar berkedip dan form macet beberapa detik.',
'Grid1.Perform(WM_SETREDRAW, 0, 0); // Kunci rendering' || CHAR(10) ||
'try' || CHAR(10) ||
'  for R := 1 to 5000 do' || CHAR(10) ||
'    Grid1.Cells[1, R] := ''Data '' + IntToStr(R);' || CHAR(10) ||
'finally' || CHAR(10) ||
'  Grid1.Perform(WM_SETREDRAW, 1, 0); // Buka rendering' || CHAR(10) ||
'  Grid1.Invalidate;' || CHAR(10) ||
'end;'),

(9, 'Menyembunyikan TabSheet Harus Menggunakan TabVisible, Bukan Visible',
 'Pada TPageControl, mengatur properti TabSheet.Visible := False sering kali tidak menyembunyikan header tab pada beberapa tema Windows VCL atau dapat ter-reset saat form di-resize.',
'// CARA YANG BENAR:' || CHAR(10) ||
'TabSheetRahasia.TabVisible := False; // Sembunyikan header tab' || CHAR(10) ||
'TabSheetRahasia.TabVisible := True;  // Tampilkan kembali'),

(10, 'Cegah Memori Membengkak Pada Memo Logging Berkelanjutan',
 'Jika aplikasi server/background menulis log ke TMemo tanpa batas, jumlah baris akan mencapai puluhan ribu baris, menghabiskan alokasi GDI buffer Windows dan akhirnya memicu error Out of Memory.',
'// Hapus baris teratas secara periodik:' || CHAR(10) ||
'if MemoLog.Lines.Count > 1000 then' || CHAR(10) ||
'  MemoLog.Lines.Delete(0);');
