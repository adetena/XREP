page 50100 "XReport Localization Card"
{
    ApplicationArea = All;
    Caption = 'XReport Localization';
    PageType = Card;
    SourceTable = "XReport Localization";

    layout
    {
        area(content)
        {
            field(Name; Rec.Name) { TableRelation = "Language Selection".Name; }
            field(Header_1; Rec."Header 1") { MultiLine = true; }
            field(Footer_1; Rec."Footer 1") { MultiLine = true; }
            field(Header_2; Rec."Header 2") { MultiLine = true; }
            field(Footer_2; Rec."Footer 2") { MultiLine = true; }
            field(Aside; Rec.Aside) { MultiLine = true; }
        }
    }
}