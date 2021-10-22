object dmDrivers: TdmDrivers
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 549
  Width = 863
  object conDrivers: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Drivers.mdb;Persist' +
      ' Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 320
    Top = 136
  end
  object tblDrivers: TADOTable
    Connection = conDrivers
    CursorType = ctStatic
    TableName = 'tblDrivers'
    Left = 168
    Top = 248
  end
  object tblFDADrivers: TADOTable
    Left = 248
    Top = 248
  end
  object tblApplicants: TADOTable
    Connection = conDrivers
    CursorType = ctStatic
    TableName = 'tblApplicants'
    Left = 320
    Top = 248
  end
  object tblID: TADOTable
    Left = 392
    Top = 248
  end
  object ADOTable5: TADOTable
    Left = 464
    Top = 248
  end
  object qryDrivers: TADOQuery
    Parameters = <>
    Left = 544
    Top = 248
  end
  object dsDrivers: TDataSource
    DataSet = qryDrivers
    Left = 440
    Top = 352
  end
end
