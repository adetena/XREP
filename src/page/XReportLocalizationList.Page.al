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
                field(Name; Rec.Name) { }
                field(Default; Rec.Default)
                {
                    trigger OnValidate()
                    begin
                        XReportLocalization.SetDefault(Rec);
                    end;
                }
            }
        }
    }

    var
        XReportLocalization: Codeunit "XReport Setup";
}
