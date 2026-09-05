-- =====================================================================
-- Delphi Control Reference & Knowledge Base: Production-Grade Schema
-- Database: SQLite 3
-- =====================================================================

PRAGMA foreign_keys = ON;

-- 1. Kategori Komponen
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    sort_order INTEGER DEFAULT 0
);

-- 2. Daftar Kontrol / Komponen VCL
CREATE TABLE IF NOT EXISTS controls (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL,
    control_name TEXT NOT NULL UNIQUE,      -- misal: TEdit, TButton, TComboBox
    unit_name TEXT NOT NULL,                -- misal: Vcl.StdCtrls, Vcl.ComCtrls
    inheritance TEXT,                       -- misal: TCustomEdit -> TWinControl -> TControl
    description TEXT NOT NULL,
    recommended_use TEXT,                   -- Rekomendasi penggunaan terbaik di aplikasi nyata
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

-- 3. Anggota Kontrol (Properties, Events, Methods)
CREATE TABLE IF NOT EXISTS control_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    control_id INTEGER NOT NULL,
    member_type TEXT NOT NULL,             -- 'PROPERTY', 'EVENT', 'METHOD'
    member_name TEXT NOT NULL,             -- misal: OnChange, Text, SelectAll
    data_type TEXT,                        -- misal: TNotifyEvent, String, Procedure
    description TEXT NOT NULL,
    production_tip TEXT,                   -- Catatan khusus saat dipakai di produksi
    FOREIGN KEY (control_id) REFERENCES controls (id) ON DELETE CASCADE
);

-- 4. Code Snippets & Pola Implementasi Nyata
CREATE TABLE IF NOT EXISTS snippets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    control_id INTEGER NOT NULL,
    title TEXT NOT NULL,                   -- misal: 'Input Angka / Format Rupiah Otomatis'
    scenario_type TEXT NOT NULL,           -- 'Validation', 'Formatting', 'Async/Threading', 'State Management', 'CRUD'
    complexity TEXT DEFAULT 'Production',  -- 'Basic', 'Intermediate', 'Production'
    delphi_version TEXT DEFAULT 'All',     -- 'All', 'Delphi 10+', 'Delphi 11/12'
    snippet_code TEXT NOT NULL,            -- Kode Pascal/Delphi siap salin
    explanation TEXT,                      -- Penjelasan cara kerja dan dependensi unit
    FOREIGN KEY (control_id) REFERENCES controls (id) ON DELETE CASCADE
);

-- 5. Best Practices & Gotchas (Jebakan & Solusi Nyata)
CREATE TABLE IF NOT EXISTS best_practices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    control_id INTEGER NOT NULL,
    title TEXT NOT NULL,                   -- misal: 'Cegah OnChange Terpicu Saat Loading Form'
    problem_description TEXT NOT NULL,     -- Gejala masalah umum di lapangan
    solution_code TEXT NOT NULL,           -- Kode solusi konkret
    FOREIGN KEY (control_id) REFERENCES controls (id) ON DELETE CASCADE
);

-- Indeks performa pencarian
CREATE INDEX IF NOT EXISTS idx_controls_name ON controls(control_name);
CREATE INDEX IF NOT EXISTS idx_controls_category ON controls(category_id);
CREATE INDEX IF NOT EXISTS idx_members_control ON control_members(control_id);
CREATE INDEX IF NOT EXISTS idx_snippets_control ON snippets(control_id);
CREATE INDEX IF NOT EXISTS idx_bestpractices_control ON best_practices(control_id);
