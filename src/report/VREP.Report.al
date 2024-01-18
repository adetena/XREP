report 50117 VREP
{
    ApplicationArea = All;
    Caption = 'VREP';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/rdl/vrep.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(Lines; Lines) { }
            column(Line; Line) { }
            column(No; "No.") { IncludeCaption = true; }

            trigger OnPreDataItem()
            begin
                Lines := 5;
                Blanks := (Lines mod LinesPerPage) - SummaryLines;
            end;


            trigger OnAfterGetRecord()
            begin
                if Line = Lines then
                    CurrReport.Break();

                Line += 1;
            end;
        }

        dataitem(Fill; Integer)
        {
            column(Blanks; Blanks) { }
            column(Blank; Blank) { }
            column(Number; Number) { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, Blanks);
            end;

            trigger OnAfterGetRecord()
            begin
                Blank += 1;
            end;
        }
    }

    trigger OnInitReport()
    begin
        LinesPerPage := 10;
        SummaryLines := 1;
    end;

    var
        // Report
        LinesPerPage: Integer;
        SummaryLines: Integer;

        // Item
        Lines: Integer;
        Line: Integer;

        // Blanks
        Blanks: Integer;
        Blank: Integer;
}
