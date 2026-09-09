unit uModels;

interface

type
  TControlRecord = record
    ID: Integer;
    CategoryID: Integer;
    CategoryName: string;
    ControlName: string;
    UnitName: string;
    Inheritance: string;
    Description: string;
    RecommendedUse: string;
  end;

  TMemberRecord = record
    ID: Integer;
    ControlID: Integer;
    MemberType: string;
    MemberName: string;
    DataType: string;
    Description: string;
    ProductionTip: string;
  end;

  TSnippetRecord = record
    ID: Integer;
    ControlID: Integer;
    Title: string;
    ScenarioType: string;
    Complexity: string;
    DelphiVersion: string;
    SnippetCode: string;
    Explanation: string;
  end;

  TBestPracticeRecord = record
    ID: Integer;
    ControlID: Integer;
    Title: string;
    ProblemDescription: string;
    SolutionCode: string;
  end;

implementation

end.
