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
                trigger OnValidate()
                begin
                    XReportLocalization.SetDefault(Rec);
                end;
            }
            field(Report_Footer; Rec."Report Footer") { }
            field(Page_Footer; Rec."Page Footer") { }
            field(Aside; Rec.Aside) { }

            part(Lines; "XReport Line List")
            {
                SubPageLink = "Loc. Name" = field(Name);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.Lines.Page.SetLocName(Rec.Name);
    end;

    var
        XReportLocalization: Codeunit "XReport Setup";
        XReportLineList: Page "XReport Line List";
}