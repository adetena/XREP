page 50101 "XReport Localization List"
{
    ApplicationArea = All;
    Caption = 'XReport Localization List';
    PageType = List;
    SourceTable = "XReport Localization";
    UsageCategory = Lists;
    CardPageId = "XReport Localization Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code") { }
            }
        }
    }
}
