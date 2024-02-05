report 50102 "XReport2"
{
    ApplicationArea = All;
    Caption = 'XReport2';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/rdl/XReport2.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 64));

                column(ChildNo; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(BlankNo; Number) { }

                trigger OnPreDataItem()
                begin

                    if GetBlankLines = 0 then CurrReport.Break;
                    if GetBlankLines > 0 then SetRange(Number, 1, GetBlankLines);
                end;
            }

            dataitem(SubTotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(SubTotalNo; Number) { }

                trigger OnPreDataItem()
                begin
                    if Count = 0 then CurrReport.Break;
                end;
            }

            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(TotalNo; Number) { }

                trigger OnPreDataItem()
                begin
                    if Count = 0 then CurrReport.Break;
                end;
            }
        }

        dataitem(Aside; Integer)
        {
            column(AsideNo; Number) { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, Round(GetDataLines / LinesPerPage, 1, '>'));
            end;
        }
    }

    trigger OnInitReport()
    begin
        LinesPerPage := 44;
        OffsetLines := 4;
    end;

    local procedure GetDataLines(): Integer
    begin
        exit(Child.Count + SubTotal.Count + Total.Count + OffsetLines);
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
        OffsetLines: Integer;
}
