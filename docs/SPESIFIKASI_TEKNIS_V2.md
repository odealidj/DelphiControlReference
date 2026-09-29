# Spesifikasi Teknis & Panduan Arsitektur: Delphi Control Reference (Production-Grade)

## 1. Latar Belakang & Tujuan Baru
Aplikasi ini dirancang sebagai pustaka referensi dan panduan praktis desktop VCL (*Visual Component Library*) berbasis **standar produksi nyata (production-grade)**.

Fokus aplikasi:
- Bukan hanya mendokumentasikan properti dasar secara teoritis, melainkan menyajikan **pola implementasi bisnis nyata** (validasi input, format mata uang/angka, thread-safe background tasks, navigasi multi-form).
- Menyediakan dokumentasi **Gotchas & Pitfalls** (isu-isu kritis seperti event triggering yang tak diinginkan saat load, memory leaks, dan High-DPI scaling).
- Memberikan potongan kode (*code snippets*) yang langsung siap di-*copy* dan diterapkan pada proyek enterprise Delphi.

---

## 2. Struktur Direktori Proyek
```text
DelphiControlReference/
├── bin/                       # Direktori output biner executable (.exe)
├── database/                  # Skrip DDL SQLite, seeder, dan database lokal
│   ├── schema.sql             # Definisi skema tabel relasional
│   ├── seed_data.sql          # Data awal 10 kontrol VCL produksi & real-world snippet
│   └── control_ref.db         # Database SQLite lokal (terisi 10 kontrol)
├── docs/                      # Dokumentasi dan referensi arsitektur
│   └── SPESIFIKASI_TEKNIS_V2.md
├── src/                       # Kode sumber Delphi
│   ├── Data/                  # DataModule (koneksi FireDAC SQLite, query)
│   ├── Forms/                 # Form VCL (TMainForm, TFormEditControl, TFramePreview)
│   ├── Models/                # Tipe data, records, dan DTO
│   └── Utils/                 # Unit helper (Format, Clipboard, String, Threading)
└── DelphiControlRef.dpr       # Project file Delphi
```

---

## 3. Skema Basis Data Relasional (SQLite)
Basis data SQLite terdiri dari tabel-tabel utama:
1. **`categories`**: Kategori komponen VCL (Standard, Additional, Win32, System, Data-Aware, Dialogs, Custom).
2. **`controls`**: Daftar komponen VCL (`TEdit`, `TButton`, `TComboBox`, `TDBGrid`, `TTreeView`, dll).
3. **`control_members`**: Properti, Event, dan Method penting dengan catatan perilaku real-world.
4. **`snippets`**: Pola implementasi kode nyata dengan tingkat kompleksitas (*Basic*, *Intermediate*, *Production-Grade*) dan tipe skenario (*Validation*, *Async*, *Formatting*, *Database Binding*).
5. **`best_practices`**: Katalog *Gotchas & Pitfalls* berisi deskripsi masalah dan solusi konkret.

---

## 4. Fitur CRUD Lengkap (Create, Read, Update, Delete)
Aplikasi mendukung siklus manajemen data menyeluruh:
- **Create**: Menambah referensi kontrol baru (`InitAdd`) via tombol `+ Tambah Catatan Baru`.
- **Read**: Membaca dan menampilkan hirarki kategori di `TTreeView` serta navigasi detail di `TPageControl`.
- **Update**: Mengubah data kontrol yang sedang dipilih (`InitEdit`) via tombol `Ubah Kontrol` pada header card.
- **Delete (Cascade)**: Menghapus kontrol terpilih via tombol `Hapus` dengan konfirmasi peringatan, di mana SQLite secara otomatis menghapus rincian anggota, snippet, dan catatan best practices terkait (`ON DELETE CASCADE`).
- **Sub-Item Delete**: Mendukung penghapusan potongan kode individual (`btnDeleteSnippet`) dan catatan masalah individual (`btnDeleteBP`).
