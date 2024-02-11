report 50102 "XReport3"
{
    ApplicationArea = All;
    Caption = 'XReport3';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/XReport3.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(XLinesPerPage; XLinesPerPage) { }
            column(XTotalsLines; XTotalsLines) { }
            column(XLines; XLines) { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter('1..34'));

                column(No_; Number) { }

                trigger OnPreDataItem()
                begin
                    XLines := Count;
                end;
            }

            dataitem(XBlankLines; Integer)
            {
                column(XBlanks; XBlanks) { }
                column(XBlank; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, GetBlanks);
                end;
            }
        }

        dataitem(XSideBars; Integer)
        {
            column(XSideBar; Number) { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, GetSideBars);
            end;
        }
    }

    trigger OnInitReport()
    begin
        XLinesPerPage := 40;
        XTotalsLines := 3;
    end;

    local procedure GetLines(): Integer
    begin
        exit(XLines mod XLinesPerPage);
    end;

    local procedure GetPages(): Integer
    begin
        exit(XLines div XLinesPerPage);
    end;

    local procedure TestRange(Range: Integer)
    begin
        if (Range = XLinesPerPage) and (XTotalsLines = 0) then
            CurrReport.Break;
    end;

    local procedure TestBlanks()
    begin
        if XBlanks < XTotalsLines then begin
            XBlanks += XLinesPerPage;
            XLines += XLinesPerPage;
        end;
    end;

    local procedure GetBlanks(): Integer
    begin
        XBlanks := XLinesPerPage - GetLines;

        TestRange(XBlanks);
        TestBlanks;

        exit(XBlanks);
    end;

    local procedure GetSideBars(): Integer
    begin
        TestRange(XLines);

        exit(GetPages);
    end;

    var
        XLinesPerPage: Integer;
        XTotalsLines: Integer;
        XBlanks: Integer;
        XLines: Integer;
}
