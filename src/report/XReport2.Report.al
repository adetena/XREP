report 50101 "XReport2"
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

            column(Page_Lines; "Page Lines") { }
            column(Offset_Lines; "Offset Lines") { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 36));

                column(Child_No; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }

                trigger OnPreDataItem()
                begin
                    SetBlankRange;
                end;
            }

            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

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
                SetAsideRange;
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
        exit(Child.Count + Subtotal.Count + Total.Count + "Offset Lines")
    end;

    local procedure CountBlanks(): Integer
    begin
        exit(("Page Lines" - (CountLines mod "Page Lines")) mod "Page Lines");
    end;

    local procedure SetBlankRange()
    begin
        Blank.SetRange(Number, 1, CountBlanks());

        if Blank.IsEmpty then CurrReport.Break;
    end;

    local procedure SetAsideRange()
    begin
        Aside.SetRange(Number, 1, (CountLines + CountBlanks) div "Page Lines");
    end;
}
