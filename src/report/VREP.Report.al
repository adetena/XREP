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
            column(LinesPerPage; LinesPerPage) { }
            column(Lines; Lines) { }
            column(Line; Line) { }
            column(No; "No.") { IncludeCaption = true; }

            trigger OnPreDataItem()
            begin
                LastPageLines := Lines mod LinesPerPage;
                Blanks := LinesPerPage - LastPageLines - SummaryLines - FooterLines;

                if LastPageLines > (LinesPerPage - SummaryLines - FooterLines) then
                    Blanks := 2 * LinesPerPage - LastPageLines - SummaryLines - FooterLines;
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
        // Report
        SummaryLines := 1;
        FooterLines := 1;

        // Item
        LinesPerPage := 10;
        Lines := 72;
    end;

    var
        // Report
        LinesPerPage: Integer;
        LastPageLines: Integer;
        SummaryLines: Integer;
        FooterLines: Integer;

        // Item
        Lines: Integer;
        Line: Integer;

        // Blanks
        Blanks: Integer;
        Blank: Integer;
}
