report 50102 "XReport2"
{
    ApplicationArea = All;
    Caption = 'XReport2';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/XReport2.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            // column(XLinesPerPage; XLinesPerPage) { }
            // column(XTotalsLines; XTotalsLines) { }
            // column(XLines; XLines) { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter('1..34'));

                column(ChildNo; Number) { }
            }

            dataitem(XBlankLines; Integer)
            {
                column(BlankNo; Number) { }

                trigger OnPreDataItem()
                var
                    Blanks: Integer;
                begin
                    Blanks := GetBlankLines(Child.Count + XTotalLines.Count);

                    if Blanks = XLinesPerPage then
                        Blanks := 0;

                    SetRange(Number, 1, Blanks);
                end;
            }

            dataitem(XTotalLines; Integer)
            {
                DataItemTableView = where(Number = filter('1..7'));

                column(TotalNo; Number) { }
            }
        }
    }

    trigger OnInitReport()
    begin
        XLinesPerPage := 42;
    end;

    local procedure GetBlankLines(Lines: Integer): Integer
    begin
        exit(XLinesPerPage - (Lines mod XLinesPerPage));
    end;

    var
        XLinesPerPage: Integer;
}
