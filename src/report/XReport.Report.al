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
            column(LinesPerPage; LinesPerPage) { }
            column(Line; Line) { }
            column(No_; "No.") { IncludeCaption = true; }

            trigger OnPreDataItem()
            begin
                Lines := 5; // Lines = Count;
            end;

            // Remove
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
            column(Blank; Number) { }

            trigger OnPreDataItem()
            begin
                Blanks := LinesPerPage - (Lines Mod LinesPerPage);

                SetRange(Number, 1, Blanks);
            end;
        }
    }

    trigger OnInitReport()
    begin
        // VREP
        LinesPerPage := 5;
    end;

    var
        // VREP
        LinesPerPage: Integer;
        Blanks: Integer;
        Line: Integer;
        Lines: Integer;
}
