table 50100 "XReport Setup"
{
    Caption = 'XReport Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Language Code"; Code[2]) { }
        field(2; "Header 1"; Text[256]) { }
        field(3; "Header 2"; Text[256]) { }
        field(4; "Footer 1"; Text[256]) { }
        field(5; "Footer 2"; Text[256]) { }
        field(6; "Aside_1"; Text[256]) { }
    }
    keys
    {
        key(PK; "Language Code")
        {
            Clustered = true;
        }
    }
}
