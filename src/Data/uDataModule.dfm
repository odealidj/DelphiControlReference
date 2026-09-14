object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 350
  Width = 550
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 176
    Top = 32
  end
  object FDQueryCategories: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM categories ORDER BY sort_order, name')
    Left = 56
    Top = 112
  end
  object FDQueryControls: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT c.*, cat.name AS category_name'
      'FROM controls c'
      'JOIN categories cat ON c.category_id = cat.id'
      'ORDER BY c.control_name')
    Left = 176
    Top = 112
  end
  object FDQueryMembers: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM control_members'
      'WHERE control_id = :control_id'
      'ORDER BY member_type, member_name')
    Left = 296
    Top = 112
    ParamData = <
      item
        Name = 'CONTROL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDQuerySnippets: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM snippets'
      'WHERE control_id = :control_id'
      'ORDER BY id')
    Left = 56
    Top = 192
    ParamData = <
      item
        Name = 'CONTROL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDQueryBestPractices: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM best_practices'
      'WHERE control_id = :control_id'
      'ORDER BY id')
    Left = 176
    Top = 192
    ParamData = <
      item
        Name = 'CONTROL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
