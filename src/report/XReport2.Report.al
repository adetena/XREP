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

            column(PageLines; "Page Lines") { }
            column(OffsetLines; "Offset Lines") { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 36));

                column(ChildNo; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(BlankNo; Number) { }

                trigger OnPreDataItem()
                begin
                    if CountBlanks = 0 then CurrReport.Break else SetRange(Number, 1, CountBlanks);
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
                SetRange(Number, 1, (CountLines + CountBlanks) div "Page Lines");
            end;
        }
    }

    trigger OnInitReport()
    begin
        "Page Lines" := 44;
        "Offset Lines" := 4;
    end;

    local procedure CountLines(): Integer
    begin
        exit(Child.Count + SubTotal.Count + Total.Count + "Offset Lines");
    end;

    local procedure CountBlanks(): Integer
    begin
        exit(("Page Lines" - (CountLines mod "Page Lines")) mod "Page Lines");
    end;

    var
        "Page Lines": Integer;
        "Offset Lines": Integer;
}
