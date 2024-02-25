report 50100 "X Report"
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XReport.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Offset; Offset) { }
            column(Range; Range) { }
            column(Terms; Terms) { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 36));

                column(Child_No; Number) { }
            }

            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }

                trigger OnPreDataItem()
                begin
                    SetBlankRange;
                end;
            }

            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(Subtotal_No; Number) { }

                trigger OnPreDataItem()
                begin
                    if IsEmpty then CurrReport.Break;
                end;
            }

            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(Total_No; Number) { }

                trigger OnPreDataItem()
                begin
                    if IsEmpty then CurrReport.Break;
                end;
            }
        }

        dataitem(Aside; Integer)
        {
            column(Aside_No; Number) { }

            trigger OnPreDataItem()
            begin
                SetAsideRange;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(TermLang; Lang) { TableRelation = "Language Selection"; }
            }
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            SetLang(Lang);
        end;

        var
            Lang: Text;
    }

    var
        Offset: Integer;
        Range: Integer;
        Terms: Text;

    trigger OnInitReport()
    begin
        Offset := 4;
        Range := 44;
    end;

    procedure SetLang(Lang: Text)
    var
        LanguageSelection: Record "Language Selection";
        TermUsage: Record "X Term. Usage";
        TermLine: Record "X Term. Line";
    begin
        LanguageSelection.Reset();
        LanguageSelection.SetRange(Name, Lang);
        if LanguageSelection.FindFirst() then
            Language(LanguageSelection."Language ID");

        TermUsage.Reset();
        TermUsage.SetRange("Term. Usage", Enum::"Report Selection Usage"::"S.Invoice");
        if TermUsage.FindFirst() then begin
            TermLine.Reset();
            TermLine.SetRange("Term. Code", TermUsage."Term. Code");
            TermLine.SetRange("Term. Lang.", Lang);
            if TermLine.FindSet() then
                repeat
                    case TermLine."Line Type" of
                        "X Term. Line Type"::title:
                            begin
                                Terms += '<h1 style="text-align: center;">';
                                Terms += TermLine."Line Text";
                                Terms += '</h1>';
                            end;
                        "X Term. Line Type"::header:
                            begin
                                Terms += '<h4>';
                                Terms += TermLine."Line Text";
                                Terms += '</h4>';
                            end;
                        "X Term. Line Type"::paragraph:
                            begin
                                Terms += '<p>';
                                Terms += TermLine."Line Text";
                                Terms += '</p>';
                            end;
                    end;
                until TermLine.Next() = 0;
        end;
    end;

    local procedure CountLines(): Integer
    begin
        exit(Offset + Child.Count + Subtotal.Count + Total.Count)
    end;

    local procedure CalcBlanks(): Integer
    begin
        exit((Range - (CountLines mod Range)) mod Range);
    end;

    local procedure SetBlankRange()
    begin
        Blank.SetRange(Number, 1, CalcBlanks);

        if Blank.IsEmpty then CurrReport.Break;
    end;

    local procedure SetAsideRange()
    begin
        Aside.SetRange(Number, 1, (CountLines + CalcBlanks) div Range);
    end;
}