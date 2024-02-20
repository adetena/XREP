codeunit 50100 "XReport Setup"
{
    TableNo = "XReport Localization";

    trigger OnRun()
    begin

    end;

    procedure SetDefault(Localization: Record "XReport Localization")
    var
        XReportLocalization: Record "XReport Localization";
    begin
        XReportLocalization.Reset();
        XReportLocalization.SetFilter(Name, '<>%1', Localization.Name);
        if XReportLocalization.FindSet() then begin
            XReportLocalization.Default := false;
            XReportLocalization.Modify();
        end;
    end;
}
