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

            column(Header_1; Setup."Header 1") { }
            column(Header_2; Setup."Header 2") { }
            column(Footer_2; Setup."Footer 2") { }
            column(Footer_1; Setup."Footer 1") { }

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
            column(Aside_1; Setup."Aside_1") { }

            trigger OnPreDataItem()
            begin
                SetAsideRange;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field("Language Code"; Setup."Language Code")
                {
                    TableRelation = "XReport Setup";
                }
            }
        }

        trigger OnInit()
        begin
            Setup.FindFirst();
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            Setup.Get(Setup."Language Code");
        end;
    }

    trigger OnInitReport()
    begin
        Offset := 4;
        Range := 43;
    end;

    var
        Setup: Record "XReport Setup";
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