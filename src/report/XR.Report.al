report 50102 XR
{
    ApplicationArea = All;
    Caption = 'XR';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XR.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Parent_Row_No; "Parent Row No.") { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 5));

                column(Child_Row_No; "Child Row No.") { }

                trigger OnAfterGetRecord()
                begin
                    "Child Row No." += 1;
                end;
            }

            dataitem(Blank; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 29));

                column(Blank_Row_No; "Blank Row No.") { }

                trigger OnAfterGetRecord()
                begin
                    "Blank Row No." += 1;
                end;
            }

            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(Subtotal_Row_No; "Subtotal Row No.") { }

                trigger OnAfterGetRecord()
                begin
                    "Subtotal Row No." += 1;
                end;
            }

            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(Total_Row_No; "Total Row No.") { }

                trigger OnAfterGetRecord()
                begin
                    "Total Row No." += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Parent Row No." += 1;
            end;
        }
    }

    var
        "Parent Row No.": Integer;
        "Child Row No.": Integer;
        "Blank Row No.": Integer;
        "Subtotal Row No.": Integer;
        "Total Row No.": Integer;
}
