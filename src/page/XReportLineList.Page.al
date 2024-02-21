page 50102 "XReport Line List"
{
    ApplicationArea = All;
    Caption = 'XReport Line List';
    PageType = CardPart;
    SourceTable = "XReport Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                // field(Name; Rec."Loc. Name") { Editable = false; }
                // field("Line No"; Rec."Line No") { Editable = false; }
                field(Type; Rec.Type) { }
                field(Description; Rec.Description) { }
            }
        }
    }

    var
        Name: Text[80];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Loc. Name" := Name;
    end;

    procedure SetLocName(LocName: Text[80])
    begin
        Name := LocName;
    end;
}
