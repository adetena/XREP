table 50104 "X Term. Lang."
{
    Caption = 'Term. Lang';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Term. Code"; Code[20]) { }
        field(2; "Term. Lang."; Text[100]) { }
    }
    keys
    {
        key(PK; "Term. Code", "Term. Lang.")
        {
            Clustered = true;
        }
    }
}
