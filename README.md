# Delphi Control Reference & Cheat Sheet
### *Production-Grade VCL Component Engineering Guide*

![Delphi](https://img.shields.io/badge/Language-Object%20Pascal%20%2F%20Delphi-blue)
![Platform](https://img.shields.io/badge/Platform-Windows%20VCL-brightgreen)
![Database](https://img.shields.io/badge/Database-SQLite%203%20(FireDAC)-lightgrey)
![Compiler](https://img.shields.io/badge/Compiler-Embarcadero%20Delphi%20v37.0-red)
![Build](https://img.shields.io/badge/Build-Passing%20(0%20Errors)-success)

Aplikasi desktop referensi pribadi (*knowledge base*) yang cepat, terstruktur, dan luring (*offline*) untuk mendokumentasikan komponen VCL Delphi. Berbeda dengan dokumentasi teoritis biasa, aplikasi ini dirancang khusus untuk mewakili **kebutuhan nyata di aplikasi produksi industri (*enterprise / real-world apps*)**.

---

## Fitur Utama

- ⚡ **Master-Detail Layout Responsif**: Navigasi pohon hirarkis (`TTreeView`) yang memisahkan kategori dan kontrol, dipadukan dengan `TSplitter` yang fleksibel.
- 🔍 **Instant Search dengan Debounce**: Pencarian instan nama komponen atau fungsi dengan proteksi *debounce timer* (250ms) agar performa tetap ringan saat mengetik cepat.
- 📋 **Katalog Anggota Komprehensif**: Menampilkan Properties, Events, dan Methods lengkap dengan tipe data dan **Tips Penggunaan Nyata (*Production Tips*)**.
- 💡 **Production Code Snippets**: Potongan kode Pascal berkualitas tinggi siap pakai, terlabel skenario (*Formatting*, *Validation*, *Async*, *Database Binding*), dan tombol **Salin Kode ke Clipboard** dalam 1 klik.
- 🛡️ **Katalog Best Practices & Gotchas**: Panduan praktis untuk menghindari jebakan umum VCL seperti *event triggering* prematur saat form load, *memory leak*, dan masalah *scaling*.
- 🧪 **Live Interactive Sandbox**: Area demo interaktif langsung di dalam aplikasi untuk menguji coba kontrol (Format Rupiah real-time, Pemrosesan Asinkron latar belakang, dan Relational ID ComboBox).
- ✏️ **Manajemen Data Mandiri (Full CRUD)**:
  - **Tambah Kontrol Baru**: Formulir modal mandiri untuk mendokumentasikan pola baru yang Anda temukan di IDE.
  - **Ubah Kontrol**: Tombol edit langsung untuk memperbarui deskripsi dan rekomendasi.
  - **Hapus Kontrol & Snippet**: Penghapusan aman dengan peringatan konfirmasi dan pembersihan otomatis bertingkat (*Cascading Delete*).

---

## Struktur Direktori Proyek

```text
DelphiControlReference/
├── DelphiControlRef.dpr           # Program utama Delphi
├── DelphiControlRef.dproj         # File project RAD Studio (siap buka di IDE)
├── README.md                      # Dokumentasi pengantar proyek ini
├── bin/
│   └── DelphiControlRef.exe       # Direktori output hasil kompilasi biner Win32
├── database/
│   ├── control_ref.db             # Basis data lokal SQLite 3 (terisi 10 kontrol)
│   ├── schema.sql                 # Skrip DDL skema relasional
│   ├── seed_data.sql              # Skrip seeder data awal produksi
│   └── InitDatabase.dpr           # Tool utilitas untuk reset ulang database
├── docs/
│   ├── DOKUMENTASI_TEKNIS.md      # Panduan teknis arsitektur lengkap dan detail
│   └── SPESIFIKASI_TEKNIS_V2.md   # Spesifikasi teknis rancangan antarmuka
└── src/
    ├── Data/
    │   ├── uDataModule.pas & .dfm # Modul data koneksi FireDAC SQLite
    ├── Forms/
    │   ├── uMainForm.pas & .dfm   # Form utama Master-Detail
    │   └── uEditControlForm.pas   # Form modal input & edit kontrol (CRUD)
    ├── Models/
    │   └── uModels.pas            # Definisi entitas data records
    └── Utils/
        └── uCommonUtils.pas       # Utilitas helper (Clipboard, Format Currency, Path)
```

---

## 10 Kontrol VCL Bawaan yang Telah Terdokumentasi

1. **`TEdit`** (Standard): Format Rupiah real-time saat ketik, validasi angka, dan guard flag `FIsLoadingData`.
2. **`TButton`** (Standard): Background worker asinkron via `TTask.Run` + `TThread.Queue`, dan anti double-click.
3. **`TComboBox`** (Standard): Penyimpanan pasangan Label & ID relasional database di dalam `Items.Objects[]` (*zero memory leak*).
4. **`TDBGrid`** (Data-Aware): Pola pewarnaan baris selang-seling (*zebra striping*) dan auto-fit lebar kolom.
5. **`TListView`** (Win32): Mode virtual list `OwnerData` untuk menangani 100.000+ data secara instan tanpa lag.
6. **`TActionList`** (Standard): Pengendalian terpusat status `Enabled` tombol pada loop Windows Idle via `Action.OnUpdate`.
7. **`TDateTimePicker`** (Win32): Pembersihan jam liar dengan `DateOf()`, validasi rentang tanggal, dan dukungan tanggal *null*.
8. **`TStringGrid`** (Additional): Ekspor cepat matriks tabel ke format CSV (UTF-8) dan eliminasi kedipan via `WM_SETREDRAW`.
9. **`TPageControl`** (Win32): Validasi kelengkapan form sebelum ganti tab di `OnChanging`, dan trik `TabVisible`.
10. **`TMemo`** (Standard): Jendela log console real-time dengan auto-scroll `SB_BOTTOM` dan pembatasan memori baris.

---

## Panduan Memulai Cepat (Quick Start)

### 1. Membuka & Mengompilasi di RAD Studio
1. Buka file proyek `DelphiControlRef.dproj` di Embarcadero RAD Studio / Delphi.
2. Tekan **Shift+F9** (*Build*) atau **F9** (*Run*).
3. File executable mandiri akan dihasilkan secara otomatis di `bin\DelphiControlRef.exe` dan langsung terhubung ke `database\control_ref.db`.

## Dokumentasi Teknis Lanjutan
Untuk rincian kamus data, diagram relasi ERD, spesifikasi tabel DDL, dan prinsip rekayasa yang mendalam, silakan baca:
* 📖 **[docs/DOKUMENTASI_TEKNIS.md](docs/DOKUMENTASI_TEKNIS.md)**
* 📐 **[docs/SPESIFIKASI_TEKNIS_V2.md](docs/SPESIFIKASI_TEKNIS_V2.md)**
