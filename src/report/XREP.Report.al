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
            column(LinesPerPage_; LinesPerPage_) { }
            column(NumLines; NumLines) { }
            column(NumPages; NumPages) { }

            dataitem(Pages; Integer)
            {
                column(PageNo; Number) { }


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
                    if NumBlanks > 10 then
                        NumPages += 1;

                    if NumBlanks > 1 then
                        NumBlanks -= 1;

                    SetRange(Number, 0, NumBlanks - 1);
                end;
            }

            trigger OnPreDataItem()
            begin
                PageNo_ := 1;
                LinesPerPage_ := 42;
                NumLines := Lines.Count;
                NumPages := Round(NumLines / LinesPerPage_, 1, '>');
                NumBlanks := LinesPerPage_ - (NumLines mod LinesPerPage_);
            end;
        }
    }

    trigger OnInitReport()
    begin

    end;

    var
        PageNo_: Integer;
        LinesPerPage_: Integer;
        NumPages: Integer;
        NumLines: Integer;
        NumBlanks: Integer;
        TotalLines: Integer;
}
