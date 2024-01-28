report 50101 "XReport"
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/XReport.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            column(XLinesPerPage; XLinesPerPage) { }
            column(XTotalsLines; XTotalsLines) { }
            column(XLines; XLines) { }

            dataitem(Child; Integer)
            {
                // DataItemTableView = where(Number = filter('1..1'));
                // DataItemTableView = where(Number = filter('1..2'));
                // DataItemTableView = where(Number = filter('1..3'));
                // DataItemTableView = where(Number = filter('1..5'));
                // DataItemTableView = where(Number = filter('1..8'));
                // DataItemTableView = where(Number = filter('1..13'));
                // DataItemTableView = where(Number = filter('1..21'));
                // DataItemTableView = where(Number = filter('1..34'));

                // DataItemTableView = where(Number = filter('1..37'));
                DataItemTableView = where(Number = filter('1..38'));
                // DataItemTableView = where(Number = filter('1..39'));
                // DataItemTableView = where(Number = filter('1..40'));

                // DataItemTableView = where(Number = filter('1..55'));
                // DataItemTableView = where(Number = filter('1..89'));

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

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1);
            end;
        }

        dataitem(XSideBars; Integer)
        {
            column(XSideBar; Number) { }

            trigger OnPreDataItem()
            var
                Bars: Integer;
            begin
                SetRange(Number, 1, GetSideBars);
            end;
        }
    }

    trigger OnInitReport()
    begin
        XLinesPerPage := 40;
        XTotalsLines := 0;
    end;

    local procedure TestRange(Range: Integer)
    begin
        if (Range = XLinesPerPage) and (XTotalsLines = 0) then
            CurrReport.Break();
    end;

    local procedure GetBlanks(): Integer
    var
        Range: Integer;
    begin
        Range := XLinesPerPage - (XLines Mod XLinesPerPage);

        TestRange(Range);

        if Range < XTotalsLines then begin
            Range += XLinesPerPage;
        end;

        XBlanks := Range;

        exit(XBlanks);
    end;

    local procedure GetSideBars(): Integer
    begin
        TestRange(XLines);

        exit(XLines div XLinesPerPage);
    end;

    var
        XLinesPerPage: Integer;
        XTotalsLines: Integer;
        XBlanks: Integer;
        XLines: Integer;
}
