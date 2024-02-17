/// <summary>
/// This template enables report customization with a flexible layout that maintain all
/// sections in an specific position of the document.
/// 
/// It  has  the  capability  of  setting up a global report header, which will only be
/// displayed in the first page of the report, as well as an aside section that will be
/// repeated in each page containing records.
/// 
/// The main table has header and footer sections that repeats on each page.
/// 
/// Each  page may include as many lines as defined in the report setup. To modify this
/// value, you  can  customize  the "Lines Per Page" variable value in the OnInitReport
/// trigger. If the dataset  has not enough rows to fill the page, blanks lines will be
/// added until the page is complete, so the footer of the table stays at the bottom of
/// the document.
/// 
/// This  template  also  has  subtotals  and totals sections, located between the main
/// table  and  the  footers. You can customize the source tables for the corresponding
/// dataitems or set up an specific range for the default Integer table.
/// 
/// You  may  want to use a fixed size for those sections. To achieve this, you'll need
/// to  increase the height of the corresponding row in the layout to the desired size,
/// as well as set up the range of the Integer table for the dataitem for that section.
/// That  will  generate as many rows as the specified range, but you can just hide all
/// rows except for the first one.
/// </summary>
report 50100 XReport
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XReport.rdl';

    dataset
    {
        // Master dataitem.
        //
        // You  may  replace the Integer table with the desired one, and setup your own
        // filters, fields and triggers.
        //
        // The Offset and Range columns are required  in order to enable calculation of 
        // the required parameters for the layout from the embedded code.
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Offset; "Report Header Lines") { }
            column(Range; "Lines Per Page") { }

            // Main dataitem.
            //
            // You  may  replace the Integer table with the desired one, and setup your
            // own filters, fields and triggers.
            //
            // The Child_No column is required in  order to calculate the visibility of
            // all lines in the dataitem. You can modify it's source expression.
            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 36));

                column(Child_No; Number) { }
            }

            // Auxiliary dataitem.
            //
            // This  dataitem  is responsible of generating the blank lines to complete
            // the page.
            //
            // The Blank_No column is required in  order to calculate the visibility of
            // all lines in the dataitem.
            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }

                trigger OnPreDataItem()
                begin
                    SetBlankRange;
                end;
            }

            // Subtotal section dataitem.
            //
            // You  may  replace the Integer table with the desired one, and setup your
            // own filters, fields and triggers.
            //
            // The Subtotal_No column is required in  order to calculate the visibility
            // of all lines in the dataitem. You can modify it's source expression.
            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(Subtotal_No; Number) { }

                trigger OnPreDataItem()
                begin
                    // Evita generar filas residuales si el dataitem no contiene datos.
                    if IsEmpty then CurrReport.Break;
                end;
            }

            // Total section dataitem.
            //
            // You  may  replace the Integer table with the desired one, and setup your
            // own filters, fields and triggers.
            //
            // The Total_No column is required in  order to calculate the visibility of
            // all lines in the dataitem. You can modify it's source expression.
            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(Total_No; Number) { }

                trigger OnPreDataItem()
                begin
                    // Evita generar filas residuales si el dataitem no contiene datos.
                    if IsEmpty then CurrReport.Break;
                end;
            }
        }

        // Auxiliary dataitem.
        //
        // This  dataitem  is responsible of generating the aside sections next to each
        // page.
        //
        // The Aside_No column  is required in order to calculate the visibility of all
        // lines in the dataitem. You can modify it's source expression.
        dataitem(Aside; Integer)
        {
            column(Aside_No; Number) { }

            trigger OnPreDataItem()
            begin
                SetAsideRange;
            end;
        }
    }

    // Template setup.
    trigger OnInitReport()
    begin
        "Report Header Lines" := 4;
        "Lines Per Page" := 44;
    end;

    var
        "Report Header Lines": Integer;
        "Lines Per Page": Integer;

    /// <summary>
    /// Count the number of lines in all sections of the report.
    /// </summary>
    /// <returns>El número total de líneas del informe.</returns>
    local procedure CountLines(): Integer
    begin
        exit("Report Header Lines" + Child.Count + Subtotal.Count + Total.Count)
    end;

    /// <summary>
    /// Calculates  the  number  of blank lines to add accoring to the defined template
    /// parameters.
    /// </summary>
    /// <returns>The number of blank lines to add.</returns>
    local procedure CalcBlanks(): Integer
    begin
        exit(("Lines Per Page" - (CountLines mod "Lines Per Page")) mod "Lines Per Page");
    end;

    /// <summary>
    /// Sets the range of the blank lines dataitem.
    /// </summary>
    local procedure SetBlankRange()
    begin
        Blank.SetRange(Number, 1, CalcBlanks);

        if Blank.IsEmpty then CurrReport.Break;
    end;

    /// <summary>
    /// Sets the range of the aside sections dataitem.
    /// </summary>
    local procedure SetAsideRange()
    begin
        Aside.SetRange(Number, 1, (CountLines + CalcBlanks) div "Lines Per Page");
    end;
}