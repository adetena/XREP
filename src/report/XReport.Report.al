report 50100 "XReport"
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/rdl/XReport.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Page_Lines; "Page Lines") { }
            column(Offset_Lines; "Offset Lines") { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 34));

                column(Child_No; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }

                trigger OnPreDataItem()
                begin
                    if CountBlanks = 0 then CurrReport.Break else SetRange(Number, 1, CountBlanks);
                end;
            }

            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 1));

                column(Subtotal_No; Number) { }

                trigger OnPreDataItem()
                begin
                    if IsEmpty then CurrReport.Break;
                end;
            }

            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(Total_No; Number) { }

                trigger OnPreDataItem()
                begin
                    if IsEmpty then CurrReport.Break;
                end;
            }
        }

        dataitem(Aside; Integer)
        {
            column(Aside_No; Number) { }

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

    var
        "Page Lines": Integer;
        "Offset Lines": Integer;

    local procedure CountLines(): Integer
    begin
        exit(Child.Count + Subtotal.Count + Total.Count + "Offset Lines");
    end;

    local procedure CountBlanks(): Integer
    begin
        exit(("Page Lines" - (CountLines mod "Page Lines")) mod "Page Lines");
    end;
}
