codeunit 50102 "X Report Mgt."
{
    procedure GetUsage(ID: Integer) Usage: Enum "Report Selection Usage"
    begin
        ReportSelections.Reset();
        ReportSelections.SetRange("Report ID", ID);
        if ReportSelections.FindFirst() then
            Usage := ReportSelections.Usage;
    end;

    procedure GetID(Usage: Enum "Report Selection Usage") ID: Integer
    begin
        ReportSelections.Reset();
        ReportSelections.SetRange(Usage, Usage);
        if ReportSelections.FindFirst() then
            ID := ReportSelections."Report ID";
    end;

    var
        ReportSelections: Record "Report Selections";
}
