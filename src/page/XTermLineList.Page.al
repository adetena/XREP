page 50102 "X Term. Line List"
{
    ApplicationArea = All;
    Caption = 'Term. Line List';
    PageType = ListPart;
    SourceTable = "X Term. Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Term. Code"; Rec."Term. Code") { Editable = false; }
                field("Lang. Name"; Rec."Term. Lang.") { Editable = false; }
                field(Line_No; Rec."Line No.") { Editable = false; }
                field(Line_Type; Rec."Line Type") { }
                field(Line_Text; Rec."Line Text") { }
            }
        }
    }
}
