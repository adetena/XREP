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
                DataItemTableView = where(Number = filter('1..34'));

                column(ChildNo; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(BlankNo; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, GetBlankLines);
                end;
            }

            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter('1..8'));

                column(TotalNo; Number) { }
            }
        }
    }

    trigger OnInitReport()
    begin
        LinesPerPage := 42;
    end;

    local procedure GetDataLines(): Integer
    begin
        exit(Child.Count + Total.Count + 4);
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
