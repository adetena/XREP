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

            column(LinesPerPage; LinesPerPage) { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter('1..38'));

                column(ChildNo; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(BlankNo; Number) { }

                trigger OnPreDataItem()
                begin
                    if GetBlankLines = 0 then CurrReport.Break();
                    if GetBlankLines > 0 then SetRange(Number, 1, GetBlankLines);
                end;
            }

            dataitem(SubTotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. -1));

                column(SubTotalNo; Number) { }

                trigger OnPreDataItem()
                begin
                    if Count = 0 then CurrReport.Break();
                end;
            }

            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. -1));

                column(TotalNo; Number) { }

                trigger OnPreDataItem()
                begin
                    if Count = 0 then CurrReport.Break();
                end;
            }
        }
    }

    trigger OnInitReport()
    begin
        LinesPerPage := 42;
    end;

    local procedure GetDataLines(): Integer
    begin
        exit(Child.Count + SubTotal.Count + Total.Count + 4);
    end;

    local procedure GetLastPageLines(): Integer
    begin
        exit(GetDataLines mod LinesPerPage);
    end;

    local procedure GetBlankLines(): Integer
    begin
        exit((LinesPerPage - GetLastPageLines) mod LinesPerPage);
    end;

    var
        LinesPerPage: Integer;
}
