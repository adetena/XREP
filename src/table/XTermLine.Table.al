table 50102 "X Term. Line"
{
    Caption = 'Term. Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Term. Code"; Code[20]) { }
        field(2; "Term. Lang."; Text[100]) { }
        field(3; "Line No."; Integer) { }
        field(4; "Line Type"; Enum "X Term. Line Type") { }
        field(5; "Line Text"; Text[250]) { }
    }

    keys
    {
        key(PK; "Term. Code", "Term. Lang.", "Line No.")
        {
            Clustered = true;
        }
    }
}
