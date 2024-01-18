report 50100 XREP
{
    ApplicationArea = All;
    Caption = 'XREP';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/xrep.rdl';

    dataset
    {
        dataitem(Lines; Integer)
        {
            RequestFilterFields = Number;
            RequestFilterHeading = 'Lines';

            column(LineNo; Number) { }
            column(NumLines; NumLines) { }
            column(NumPages; NumPages) { }

            dataitem(Pages; Integer)
            {
                column(PageNo; Number) { }
                column(LinesPerPage_; LinesPerPage_) { }

                trigger OnPreDataItem()
                begin
                    PageNo_ += Lines.Number div (PageNo_ * LinesPerPage_);

                    SetRange(Number, PageNo_);
                end;
            }

            dataitem(BlankLines; Integer)
            {
                column(BlankLineNo; Number) { }
                column(NumBlanks; NumBlanks) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 0, NumBlanks);
                end;
            }

            trigger OnPreDataItem()
            begin
                PageNo_ := 1;
                LinesPerPage_ := 5;
                NumLines := Lines.Count;
                NumPages := Round(NumLines / LinesPerPage_, 1, '>');
                TotalLines := 1;
                NumBlanks := LinesPerPage_ - (NumLines mod LinesPerPage_) - 1 - TotalLines;
            end;
        }
    }

    var
        PageNo_: Integer;
        LinesPerPage_: Integer;
        NumPages: Integer;
        NumLines: Integer;
        NumBlanks: Integer;
        TotalLines: Integer;
}
