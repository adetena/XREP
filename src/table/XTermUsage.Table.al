table 50103 "X Term. Usage"
{
    Caption = 'Term. Usage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Term. Code"; Code[20]) { }
        field(2; "Term. Usage"; Enum "Report Selection Usage") { }
    }
    keys
    {
        key(PK; "Term. Code", "Term. Usage")
        {
            Clustered = true;
        }
    }
}
