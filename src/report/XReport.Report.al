report 50101 "XReport"
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/XReport.rdl';

    dataset
    {
        dataitem(Parent; Integer) // Table may be replaced with the required one
        {
            DataItemTableView = where(Number = const(1)); // Range of the parent dataitem must be 1.

            column(XLinesPerPage; XLinesPerPage) { }
            column(XTotalsLines; XTotalsLines) { }
            column(XLines; XLines) { }

            dataitem(Child; Integer) // Table may be replaced with the required one
            {
                DataItemTableView = where(Number = filter('1..34')); // Replace or remove for production.

                column(No_; Number) { }

                trigger OnPreDataItem()
                begin
                    XLines := Count; // Sets the number of data lines to the dataitem count
                end;
            }

            // Shows blank lines to fill the remaining space
            dataitem(XBlankLines; Integer)
            {
                column(XBlanks; XBlanks) { }
                column(XBlank; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, GetBlanks); // Sets the blank lines range
                end;
            }
        }

        // Shows sidebars next to each page
        dataitem(XSideBars; Integer)
        {
            column(XSideBar; Number) { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, GetSideBars); // Sets the side bars range
            end;
        }
    }

    // Initializes XReport parameters
    trigger OnInitReport()
    begin
        XLinesPerPage := 40;
        XTotalsLines := 3;
    end;

    /// <summary>
    /// Tests the given range to check if blank lines are required
    /// </summary>
    /// <param name="Range">The range to test</param>
    local procedure TestRange(Range: Integer)
    begin
        if (Range = XLinesPerPage) and (XTotalsLines = 0) then
            CurrReport.Break();
    end;

    /// <summary>
    /// Gets the required number of blank lines to fill the remaining space
    /// </summary>
    /// <returns>The number of blank lines</returns>
    local procedure GetBlanks(): Integer
    begin
        XBlanks := XLinesPerPage - (XLines Mod XLinesPerPage);

        TestRange(XBlanks);

        if XBlanks < XTotalsLines then begin
            XBlanks += XLinesPerPage;
            XLines += XLinesPerPage;
        end;

        exit(XBlanks);
    end;

    /// <summary>
    /// Gets the required number of sidebars to show next to each page
    /// </summary>
    /// <returns>The number of sidebars</returns>
    local procedure GetSideBars(): Integer
    begin
        TestRange(XLines);

        exit(XLines div XLinesPerPage);
    end;

    var
        /// <summary>
        /// Number of lines per page
        /// </summary>
        XLinesPerPage: Integer;
        /// <summary>
        /// Number of lines for totals
        /// </summary>
        XTotalsLines: Integer;
        /// <summary>
        /// Number of blank lines
        /// </summary>
        XBlanks: Integer;
        /// <summary>
        /// Number of data lines
        /// </summary>
        XLines: Integer;
}
