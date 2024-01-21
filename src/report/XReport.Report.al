report 50101 "XReport"
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/XReport.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(XLinesPerPage; XLinesPerPage) { }
            column(XLine; XLine) { }
            column(No_; "No.") { IncludeCaption = true; }

            trigger OnPreDataItem()
            begin
                XLines := 10; // Replace with XLines = Count for production;
            end;

            // Development trigger
            // Controls how many rows are generated
            trigger OnAfterGetRecord()
            begin
                if XLine = XLines then
                    CurrReport.Break();

                XLine += 1;
            end;
        }

        dataitem(XAuxLines; Integer)
        {
            column(XBlanks; XBlanks) { }
            column(XBlank; Number) { }

            trigger OnPreDataItem()
            begin
                XBlanks := XLinesPerPage - (XLines Mod XLinesPerPage);

                SetRange(Number, 1, XBlanks);
            end;
        }

        dataitem(XSideBars; Integer)
        {
            column(XSideBar; Number) { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, XLines div XLinesPerPage);
            end;
        }
    }

    trigger OnInitReport()
    begin
        // VREP
        XLinesPerPage := 5;
    end;

    var
        // VREP
        XLinesPerPage: Integer;
        XBlanks: Integer;
        XLine: Integer;
        XLines: Integer;
}
