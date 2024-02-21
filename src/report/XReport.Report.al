report 50100 XReport
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XReport.rdl';

    dataset
    {
        dataitem(Parent; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            column(Offset; Offset) { }
            column(Range; Range) { }

            column(Page_Footer; Localization."Page Footer") { }
            column(Report_Footer; Localization."Report Footer") { }

            column(T; T) { }

            dataitem(Child; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Child_No; "No.") { IncludeCaption = true; }
                column(Child_Description; Description) { IncludeCaption = true; }
                column(Child_Unit_Price; "Unit Price") { IncludeCaption = true; }
                column(Child_Quantity; Quantity) { IncludeCaption = true; }
                column(Child_Line_Discount_Pct; "Line Discount %") { IncludeCaption = true; }
                column(Child_VAT_Pct; "VAT %") { IncludeCaption = true; }
                column(Child_Amount; Amount) { IncludeCaption = true; }
            }

            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }

                trigger OnPreDataItem()
                begin
                    Subtotal.SetRange("Prepayment Order No.", Parent."Order No.");
                    SetBlankRange;
                end;
            }

            dataitem(Subtotal; "Sales Invoice Header")
            {
                DataItemLink = "Prepayment Order No." = field("Order No.");

                column(Subtotal_No; "No.") { }

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

            trigger OnAfterGetRecord()
            var
                XRL: Record "XReport Line";
            begin
                XRL.SetRange("Loc. Name", Localization.Name);
                if XRL.FindSet() then
                    repeat
                        if XRL.Type = XRL.Type::Title then begin
                            T += '<h1 style="text-align: center;">';
                            T += XRL.Description;
                            T += '</h1>';
                        end;

                        if XRL.Type = XRL.Type::Header then begin
                            T += '<h2>';
                            T += XRL.Description;
                            T += '</h2>';
                        end;

                        if XRL.Type = XRL.Type::Description then begin
                            T += '<p>';
                            T += XRL.Description;
                            T += '</p>';
                        end;
                    until XRL.Next() = 0;
            end;
        }

        dataitem(Aside; Integer)
        {
            column(Aside_No; Number) { }
            column(Aside_Text; Localization.Aside) { }

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
                field(Language; Localization.Name)
                {
                    TableRelation = "XReport Localization";
                }
            }
        }

        trigger OnInit()
        begin
            Localization.SetRange(Default, true);
            Localization.FindFirst();
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            LanguageSelection: Record "Language Selection";
        begin
            Localization.Get(Localization.Name);
            LanguageSelection.SetRange(Name, Localization.Name);
            if LanguageSelection.FindSet() then
                Language(LanguageSelection."Language ID");
        end;
    }

    trigger OnInitReport()
    begin
        Offset := 4;
        Range := 43;
    end;

    var
        Localization: Record "XReport Localization";
        Offset: Integer;
        Range: Integer;
        T: Text;

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