page 50100 "XReport Setup"
{
    ApplicationArea = All;
    Caption = 'XReport Setup';
    PageType = Card;
    SourceTable = "XReport Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            field("Language Code"; Rec."Language Code") { }

            field(Header_1; Rec."Header 1")
            {
                MultiLine = true;
            }
            field(Footer_1; Rec."Footer 1")
            {
                MultiLine = true;
            }
            field("Header"; Rec."Header 2")
            {
                MultiLine = true;
            }
            field(Footer; Rec."Footer 2")
            {
                MultiLine = true;
            }
            field(Aside; Rec."Aside_1")
            {
                MultiLine = true;
            }
        }
    }
}