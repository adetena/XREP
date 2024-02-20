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
            field(Name; Rec.Name) { TableRelation = "Language Selection"; }
            field(Default; Rec.Default)
            {


            }
            field(Report_Footer; Rec."Report Footer") { }
            field(Page_Footer; Rec."Page Footer") { }
            field(Aside; Rec.Aside) { }
        }
    }

    var
        XReportLocalization: Codeunit "XReport Setup";
}