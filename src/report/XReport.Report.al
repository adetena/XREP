/// <summary>
/// XReport is an advanced ready-to-use report prototype capable of generating customized
/// layouts with headers, footers, fill lines, totals and side bars automatically, based on
/// the specified XLinesPerPage and XTotalsLines specified values.
/// 
/// For the layout to work properly, data lines must have a standard height (E.G.: 0.25in),
/// and every other element, like footer or totals, must have a height equal to n times the
/// default line height, where n is an integer number.
/// 
/// Side bar height may also be adjusted in the layout to fill the height of a single group.
/// </summary>
report 50101 "XReport"
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/XReport.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(XPage; XPage) { }

            dataitem(Item; Item)
            {
                column(XLinesPerPage; XLinesPerPage) { } // [XReport] Lines per page
                column(XTotalsLines; XTotalsLines) { } // [XReport] totals lines number
                column(XLines; XLines) { } // [XReport] number of data lines
                column(XLine; XLine) { } // [DEV] counter, remove for production

                column(No_; "No.") { IncludeCaption = true; }

                trigger OnPreDataItem()
                begin
                    XLines := 5; // [DEV] replace with XLines = Count for production
                end;

                /* [XReport] update page number */
                trigger OnAfterGetRecord()
                begin
                    // [DEV] control how many rows are generated, remove for production
                    if XLine = XLines then
                        CurrReport.Break();

                    XLine += 1;

                    if XLine mod XLinesPerPage = 0 then
                        XPage += 1;
                end;
            }

            dataitem(XAuxLines; Integer)
            {
                column(XBlanks; XBlanks) { } // [XReport] number of blank lines
                column(XBlank; Number) { } // [XReport] blank line number

                trigger OnPreDataItem()
                begin
                    // [XReport] calcs the number of blank lines to generate
                    XBlanks := XLinesPerPage - (XLines Mod XLinesPerPage);

                    /* [XReport] adds XLinesPerPage lines to both blanks and lines counters 
                    if the number of blank lines is lower than the required by the totals */
                    if XBlanks < XTotalsLines then begin
                        XBlanks += XLinesPerPage;
                        XLines += XLinesPerPage;
                    end;

                    // [XReport] filters the dataitem to the required length
                    SetRange(Number, 1, XBlanks);
                end;

                trigger OnAfterGetRecord()
                begin
                    XLine += 1; // [XReport] update line counter
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1); // [DEV] main dataitem range
            end;
        }

        dataitem(XSideBars; Integer)
        {
            column(XSideBar; Number) { }

            trigger OnPreDataItem()
            begin
                // [XReport] calcs the number of sidebars to generate
                SetRange(Number, 1, XLines div XLinesPerPage);
            end;
        }
    }

    trigger OnInitReport()
    begin
        XLinesPerPage := 5;
        XTotalsLines := 3;
        XPage := 1; // [XReport] initial page number
    end;

    var
        XLinesPerPage: Integer; // [XReport] lines per page
        XTotalsLines: Integer; // [XReport] totals lines
        XBlanks: Integer; // [XReport] counter
        XLines: Integer; // [XReport] lines per page
        XLine: Integer; // [XReport] counter
        XPage: Integer; // [XReport] counter
}
