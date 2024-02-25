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
        var
            LangMgt: Codeunit "X Lang. Mgt.";
            TermsMgt: Codeunit "X Term Mgt.";
        begin
            Language(LangMgt.GetID(Lang));
            Terms := TermsMgt.Get(Enum::"Report Selection Usage"::"S.Invoice", Lang);
        end;
    }

    var
        Offset: Integer;
        Range: Integer;
        Terms: Text;
        Lang: Text;

    trigger OnInitReport()
    begin
        Offset := 4;
        Range := 44;
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