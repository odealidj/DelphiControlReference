object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Delphi Control Reference & Cheat Sheet (Production-Grade)'
  ClientHeight = 720
  ClientWidth = 1140
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnClose = FormClose
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1140
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 2955540
    ParentBackground = False
    TabOrder = 0
    object lblAppTitle: TLabel
      Left = 20
      Top = 12
      Width = 328
      Height = 21
      Caption = 'Delphi Control Reference & Cheat Sheet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAppSubtitle: TLabel
      Left = 20
      Top = 36
      Width = 349
      Height = 15
      Caption = 'Panduan & Katalog Komponen VCL Berbasis Standar Produksi Nyata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14474460
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblSearch: TLabel
      Left = 600
      Top = 22
      Width = 63
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Cari Kontrol:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtSearch: TEdit
      Left = 672
      Top = 18
      Width = 280
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      TextHint = 'Ketik nama kontrol / fungsi...'
      OnChange = edtSearchChange
    end
    object btnNewRecord: TButton
      Left = 964
      Top = 17
      Width = 155
      Height = 27
      Anchors = [akTop, akRight]
      Caption = '+ Tambah Catatan Baru'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnNewRecordClick
    end
  end
  object pnlLeftNav: TPanel
    Left = 0
    Top = 65
    Width = 270
    Height = 636
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object lblNavHeader: TLabel
      Left = 5
      Top = 5
      Width = 260
      Height = 24
      Align = alTop
      Caption = ' DAFTAR KOMPONEN VCL'
      Color = 15790320
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4539717
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object tvControls: TTreeView
      Left = 5
      Top = 29
      Width = 260
      Height = 602
      Align = alClient
      HideSelection = False
      Indent = 19
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      OnChange = tvControlsChange
    end
  end
  object splMain: TSplitter
    Left = 270
    Top = 65
    Width = 5
    Height = 636
    Color = 14474460
    ParentColor = False
  end
  object pnlClientArea: TPanel
    Left = 275
    Top = 65
    Width = 865
    Height = 636
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 2
    object pnlControlCard: TPanel
      Left = 8
      Top = 8
      Width = 849
      Height = 90
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lblCardTitle: TLabel
        Left = 16
        Top = 10
        Width = 85
        Height = 28
        Caption = 'TControl'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2955540
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCardUnit: TLabel
        Left = 16
        Top = 40
        Width = 99
        Height = 15
        Caption = 'Unit: Vcl.StdCtrls'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      object lblCardDesc: TLabel
        Left = 16
        Top = 60
        Width = 276
        Height = 15
        Caption = 'Pilih salah satu komponen di panel kiri untuk melihat.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object pnlCardActions: TPanel
        Left = 600
        Top = 15
        Width = 235
        Height = 60
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object btnEditControl: TButton
          Left = 10
          Top = 12
          Width = 105
          Height = 32
          Caption = 'Ubah Kontrol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnEditControlClick
        end
        object btnDeleteControl: TButton
          Left = 125
          Top = 12
          Width = 100
          Height = 32
          Caption = 'Hapus'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1974005
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnDeleteControlClick
        end
      end
    end
    object pcDetails: TPageControl
      Left = 8
      Top = 104
      Width = 849
      Height = 524
      ActivePage = tsMembers
      Align = alClient
      TabOrder = 1
      object tsMembers: TTabSheet
        Caption = 'Properties, Events & Methods'
        object lvMembers: TListView
          Left = 0
          Top = 0
          Width = 841
          Height = 494
          Align = alClient
          Columns = <
            item
              Caption = 'Tipe'
              Width = 90
            end
            item
              Caption = 'Nama Anggota'
              Width = 140
            end
            item
              Caption = 'Tipe Data / Parameter'
              Width = 150
            end
            item
              Caption = 'Deskripsi'
              Width = 220
            end
            item
              Caption = 'Tips Penggunaan Nyata (Production Tip)'
              Width = 220
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object tsSnippets: TTabSheet
        Caption = 'Production Code Snippets'
        ImageIndex = 1
        object pnlSnippetToolbar: TPanel
          Left = 0
          Top = 0
          Width = 841
          Height = 44
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblPilihSnippet: TLabel
            Left = 12
            Top = 13
            Width = 66
            Height = 15
            Caption = 'Pilih Snippet:'
          end
          object cboSnippets: TComboBox
            Left = 90
            Top = 9
            Width = 350
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnChange = cboSnippetsChange
          end
          object btnCopySnippet: TButton
            Left = 455
            Top = 8
            Width = 150
            Height = 26
            Caption = ' Salin Kode'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = btnCopySnippetClick
          end
          object btnDeleteSnippet: TButton
            Left = 615
            Top = 8
            Width = 110
            Height = 26
            Caption = ' Hapus Snippet'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 1974005
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = btnDeleteSnippetClick
          end
          object lblSnippetMeta: TLabel
            Left = 735
            Top = 13
            Width = 98
            Height = 15
            Caption = '[Skenario: General]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2955540
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object mmoSnippetCode: TMemo
          Left = 0
          Top = 44
          Width = 841
          Height = 350
          Align = alClient
          Color = 1973790
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 1
        end
        object pnlSnippetFooter: TPanel
          Left = 0
          Top = 394
          Width = 841
          Height = 100
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object lblExplanation: TLabel
            Left = 8
            Top = 6
            Width = 143
            Height = 15
            Caption = 'Penjelasan & Cara Terapkan:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object mmoExplanation: TMemo
            Left = 0
            Top = 25
            Width = 841
            Height = 75
            Align = alBottom
            Color = 15921906
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object tsBestPractices: TTabSheet
        Caption = 'Best Practices & Gotchas'
        ImageIndex = 2
        object pnlBPToolbar: TPanel
          Left = 0
          Top = 0
          Width = 841
          Height = 44
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblPilihBP: TLabel
            Left = 12
            Top = 13
            Width = 82
            Height = 15
            Caption = 'Pilih Masalah:'
          end
          object cboBestPractices: TComboBox
            Left = 105
            Top = 9
            Width = 400
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnChange = cboBestPracticesChange
          end
          object btnCopyBP: TButton
            Left = 520
            Top = 8
            Width = 140
            Height = 26
            Caption = ' Salin Solusi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = btnCopyBPClick
          end
          object btnDeleteBP: TButton
            Left = 670
            Top = 8
            Width = 110
            Height = 26
            Caption = ' Hapus Masalah'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 1974005
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = btnDeleteBPClick
          end
        end
        object pnlBPContent: TPanel
          Left = 0
          Top = 44
          Width = 841
          Height = 450
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object lblBPProblemTitle: TLabel
            Left = 10
            Top = 8
            Width = 235
            Height = 15
            Caption = 'Deskripsi Masalah / Gejala di Lapangan:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 1974005
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object mmoBPProblem: TMemo
            Left = 0
            Top = 28
            Width = 841
            Height = 90
            Align = alCustom
            Anchors = [akLeft, akTop, akRight]
            Color = 15921906
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object lblBPSolutionTitle: TLabel
            Left = 10
            Top = 126
            Width = 191
            Height = 15
            Caption = 'Solusi Rekayasa & Potongan Kode:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2955540
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object mmoBPSolution: TMemo
            Left = 0
            Top = 146
            Width = 841
            Height = 300
            Align = alCustom
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = 1973790
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Consolas'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 1
          end
        end
      end
      object tsSandbox: TTabSheet
        Caption = 'Live Interactive Sandbox'
        ImageIndex = 3
        object pnlSandboxDesc: TPanel
          Left = 0
          Top = 0
          Width = 841
          Height = 40
          Align = alTop
          BevelOuter = bvNone
          Color = 15921906
          ParentBackground = False
          TabOrder = 0
          object lblSandboxNote: TLabel
            Left = 12
            Top = 11
            Width = 582
            Height = 15
            Caption = 'Uji coba langsung pola kontrol di bawah ini untuk merasakan perilakunya secara nyata pada runtime VCL.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2955540
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsItalic]
            ParentFont = False
          end
        end
        object gbDemoEdit: TGroupBox
          Left = 16
          Top = 52
          Width = 380
          Height = 160
          Caption = ' Demo 1: TEdit Real-Time Rupiah '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lblDemoEditPrompt: TLabel
            Left = 16
            Top = 28
            Width = 149
            Height = 15
            Caption = 'Ketik nominal angka di sini:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblDemoEditResult: TLabel
            Left = 16
            Top = 92
            Width = 118
            Height = 15
            Caption = 'Hasil Nilai: 0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2955540
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtDemoRupiah: TEdit
            Left = 16
            Top = 50
            Width = 340
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = edtDemoRupiahChange
          end
        end
        object gbDemoAsyncButton: TGroupBox
          Left = 420
          Top = 52
          Width = 380
          Height = 160
          Caption = ' Demo 2: TButton Async Threading '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object lblDemoAsyncStatus: TLabel
            Left = 16
            Top = 115
            Width = 99
            Height = 15
            Caption = 'Status: Standby'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7105644
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object btnDemoAsync: TButton
            Left = 16
            Top = 32
            Width = 340
            Height = 32
            Caption = 'Mulai Proses Berat (2.5 Detik)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnDemoAsyncClick
          end
          object pbDemoAsync: TProgressBar
            Left = 16
            Top = 78
            Width = 340
            Height = 20
            TabOrder = 1
          end
        end
        object gbDemoComboBox: TGroupBox
          Left = 16
          Top = 230
          Width = 380
          Height = 160
          Caption = ' Demo 3: TComboBox Relational ID '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object lblDemoComboPrompt: TLabel
            Left = 16
            Top = 28
            Width = 145
            Height = 15
            Caption = 'Pilih opsi dari daftar master:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblDemoComboResult: TLabel
            Left = 16
            Top = 95
            Width = 138
            Height = 15
            Caption = 'Selected ID Database: -'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2955540
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cboDemoKeyValue: TComboBox
            Left = 16
            Top = 52
            Width = 340
            Height = 23
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cboDemoKeyValueChange
          end
        end
      end
    end
  end
  object tmrSearchDebounce: TTimer
    Enabled = False
    Interval = 250
    OnTimer = tmrSearchDebounceTimer
    Left = 200
    Top = 16
  end
  object tmrAsyncSim: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrAsyncSimTimer
    Left = 700
    Top = 320
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 701
    Width = 1140
    Height = 19
    Panels = <
      item
        Text = 'Ready'
        Width = 250
      end
      item
        Text = 'Database: Connected (SQLite)'
        Width = 300
      end
      item
        Text = 'Delphi VCL Production Guide v2.0'
        Width = 200
      end>
  end
end
