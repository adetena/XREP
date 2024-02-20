table 50100 "XReport Localization"
{
    Caption = 'XReport Localization';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Text[80]) { }
        field(2; Default; Boolean) { }
        field(3; "Header 1"; Text[256]) { }
        field(4; "Report Footer"; Text[256]) { }
        field(5; "Header 2"; Text[256]) { }
        field(6; "Page Footer"; Text[256]) { }
        field(7; Aside; Text[256]) { }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}
