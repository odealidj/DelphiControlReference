object FormEditControl: TFormEditControl
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tambah / Edit Referensi Kontrol VCL'
  ClientHeight = 520
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 580
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    Color = 2955540
    ParentBackground = False
    TabOrder = 0
    object lblTitle: TLabel
      Left = 20
      Top = 10
      Width = 271
      Height = 20
      Caption = 'Input Referensi Kontrol Baru / Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSub: TLabel
      Left = 20
      Top = 33
      Width = 352
      Height = 15
      Caption = 'Dokumentasikan pola baru atau trik komponen yang Anda temukan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14474460
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlContent: TPanel
    Left = 0
    Top = 60
    Width = 580
    Height = 405
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 15
    TabOrder = 1
    object lblCat: TLabel
      Left = 20
      Top = 15
      Width = 109
      Height = 15
      Caption = 'Kategori Komponen:'
    end
    object lblName: TLabel
      Left = 20
      Top = 70
      Width = 139
      Height = 15
      Caption = 'Nama Kontrol (misal: TEdit):'
    end
    object lblUnit: TLabel
      Left = 300
      Top = 70
      Width = 161
      Height = 15
      Caption = 'Unit Name (misal: Vcl.StdCtrls):'
    end
    object lblInherit: TLabel
      Left = 20
      Top = 125
      Width = 186
      Height = 15
      Caption = 'Hirarki Pewarisan (Inheritance Class):'
    end
    object lblDesc: TLabel
      Left = 20
      Top = 180
      Width = 134
      Height = 15
      Caption = 'Deskripsi Umum Kontrol:'
    end
    object lblBestUse: TLabel
      Left = 20
      Top = 290
      Width = 279
      Height = 15
      Caption = 'Rekomendasi Pola Penggunaan Nyata di Produksi:'
    end
    object cboCategory: TComboBox
      Left = 20
      Top = 35
      Width = 540
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
    object edtControlName: TEdit
      Left = 20
      Top = 90
      Width = 260
      Height = 23
      TabOrder = 1
    end
    object edtUnitName: TEdit
      Left = 300
      Top = 90
      Width = 260
      Height = 23
      TabOrder = 2
    end
    object edtInheritance: TEdit
      Left = 20
      Top = 145
      Width = 540
      Height = 23
      TabOrder = 3
    end
    object mmoDescription: TMemo
      Left = 20
      Top = 200
      Width = 540
      Height = 80
      ScrollBars = ssVertical
      TabOrder = 4
    end
    object mmoRecommendedUse: TMemo
      Left = 20
      Top = 310
      Width = 540
      Height = 80
      ScrollBars = ssVertical
      TabOrder = 5
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 465
    Width = 580
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnSimpan: TButton
      Left = 345
      Top = 12
      Width = 110
      Height = 32
      Caption = 'Simpan'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnSimpanClick
    end
    object btnBatal: TButton
      Left = 465
      Top = 12
      Width = 95
      Height = 32
      Cancel = True
      Caption = 'Batal'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
