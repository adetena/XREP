report 50100 XReport
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XReport.rdl';

    dataset
    {
        dataitem(Parent; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            column(Offset; Offset) { }
            column(Range; Range) { }

            dataitem(Child; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Child_No; "No.") { IncludeCaption = true; }
                column(Child_Description; Description) { IncludeCaption = true; }
                column(Child_Unit_Price; "Unit Price") { IncludeCaption = true; }
                column(Child_Quantity; Quantity) { IncludeCaption = true; }
                column(Child_Line_Discount_Pct; "Line Discount %") { IncludeCaption = true; }
                column(Child_VAT_Pct; "VAT %") { IncludeCaption = true; }
                column(Child_Amount; Amount) { IncludeCaption = true; }
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
        Offset := 4;
        Range := 43;
    end;

    var
        Offset: Integer;
        Range: Integer;

    local procedure CountLines(): Integer
    begin
        exit(Offset + Child.Count + Subtotal.Count + Total.Count)
    end;

    local procedure CalcBlanks(): Integer
    begin
        exit((Range - (CountLines mod Range)) mod Range);
    end;

    local procedure SetBlankRange()
    begin
        Blank.SetRange(Number, 1, CalcBlanks);

        if Blank.IsEmpty then CurrReport.Break;
    end;

    local procedure SetAsideRange()
    begin
        Aside.SetRange(Number, 1, (CountLines + CalcBlanks) div Range);
    end;
}