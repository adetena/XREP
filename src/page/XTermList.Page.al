page 50103 "X Term. List"
{
    ApplicationArea = All;
    Caption = 'Term. List';
    PageType = List;
    SourceTable = "X Term. Code";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Term_Code; Rec."Term. Code") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Localization)
            {
                Image = Tools;

                trigger OnAction()
                var
                    TermLang: Record "X Term. Lang.";
                    TermLoc: Page "X Term. Loc.";
                begin
                    TermLang.Reset();
                    TermLang.SetRange("Term. Code", Rec."Term. Code");
                    TermLoc.SetTableView(TermLang);
                    TermLoc.RunModal();
                end;
            }
        }

        area(Promoted)
        {
            actionref(LanguagePromoted; Localization) { }
        }
    }
}
