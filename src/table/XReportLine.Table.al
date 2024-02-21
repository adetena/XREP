table 50101 "XReport Line"
{
    Caption = 'XReport Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loc. Name"; Text[80])
        {
            Caption = 'Name';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Title,Header,Description;
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Loc. Name", "Line No")
        {
            Clustered = true;
        }
    }
}
