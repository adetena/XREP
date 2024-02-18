table 50100 "XReport Localization"
{
    Caption = 'XReport Localization';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Text[80]) { }
        field(3; "Header 1"; Text[256]) { }
        field(4; "Footer 1"; Text[256]) { }
        field(5; "Header 2"; Text[256]) { }
        field(6; "Footer 2"; Text[256]) { }
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
