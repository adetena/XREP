/// <summary>
/// XReport template.
/// </summary>
report 50100 XReport
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XReport.rdl';

    dataset
    {
        // Parent dataitem.
        // You may need to replace the source table.
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Offset; "Report Header Lines") { }   // Include var in dataset.
            column(Range; "Lines Per Page") { }         // Include var in dataset.

            // Child dataitem.
            // You may need to replace the source table.
            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 36));

                column(Child_No; Number) { }    // Master Child column. You may need to replace the source field.
            }

            // Blank dataitem.
            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }    // Master dataitem column.

                trigger OnPreDataItem()
                begin
                    SetBlankRange;
                end;
            }

            // Subtotal dataitem.
            // You may need to replace the source table.
            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(Subtotal_No; Number) { }         // Master dataitem column.

                trigger OnPreDataItem()
                begin
                    if IsEmpty then CurrReport.Break;   // Skip dataitem if empty.
                end;
            }

            // Total dataitem.
            // You may need to replace the source table.
            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(Total_No; Number) { }            // Master dataitem column.

                trigger OnPreDataItem()
                begin
                    if IsEmpty then CurrReport.Break;   // Skip dataitem if empty.
                end;
            }
        }

        // Aside dataitem.
        dataitem(Aside; Integer)
        {
            column(Aside_No; Number) { }    // Master dataitem column.

            trigger OnPreDataItem()
            begin
                SetAsideRange;
            end;
        }
    }

    // XReport setup.
    trigger OnInitReport()
    begin
        "Report Header Lines" := 4;
        "Lines Per Page" := 44;
    end;

    var
        "Report Header Lines": Integer;
        "Lines Per Page": Integer;

    /// <summary>
    /// Counts the number of lines in the DataSet.
    /// </summary>
    /// <returns>The number of lines in the DataSet.</returns>
    local procedure CountLines(): Integer
    begin
        exit("Report Header Lines" + Child.Count + Subtotal.Count + Total.Count)
    end;

    /// <summary>
    /// Calculates the number of blank lines to add.
    /// </summary>
    /// <returns>The number of blank lines to add.</returns>
    local procedure CalcBlanks(): Integer
    begin
        exit(("Lines Per Page" - (CountLines mod "Lines Per Page")) mod "Lines Per Page");
    end;

    /// <summary>
    /// Sets the range of the Blank dataitem.
    /// </summary>
    local procedure SetBlankRange()
    begin
        Blank.SetRange(Number, 1, CalcBlanks);

        if Blank.IsEmpty then CurrReport.Break;
    end;

    /// <summary>
    /// Sets the range of the Aside dataitem.
    /// </summary>
    local procedure SetAsideRange()
    begin
        Aside.SetRange(Number, 1, (CountLines + CalcBlanks) div "Lines Per Page");
    end;
}