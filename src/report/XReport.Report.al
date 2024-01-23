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
            column(XLinesPerPage; XLinesPerPage) { }
            column(XTotalsLines; XTotalsLines) { }
            column(XLines; XLines) { }

            dataitem(Item; Item)
            {
                // DataItemTableView = where("No." = filter('1000..2199'));

                column(No_; "No.") { IncludeCaption = true; }

                trigger OnPreDataItem()
                begin
                    XLines := Count;
                end;
            }

            dataitem(XAuxLines; Integer)
            {
                column(XBlanks; XBlanks) { }
                column(XBlank; Number) { }

                trigger OnPreDataItem()
                begin
                    XBlanks := XLinesPerPage - (XLines Mod XLinesPerPage);

                    if XBlanks < XTotalsLines then begin
                        XBlanks += XLinesPerPage;
                        XLines += XLinesPerPage;
                    end;

                    SetRange(Number, 1, XBlanks);
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1);
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
        XLinesPerPage := 40;
        XTotalsLines := 3;
    end;

    var
        XLinesPerPage: Integer;
        XTotalsLines: Integer;
        XBlanks: Integer;
        XLines: Integer;
}
