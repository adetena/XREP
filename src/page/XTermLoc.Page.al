page 50106 "X Term. Loc."
{
    ApplicationArea = All;
    Caption = 'Term. Loc.';
    PageType = List;
    SourceTable = "X Term. Lang.";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Term. Code"; Rec."Term. Code") { }
                field("Term. Lang"; Rec."Term. Lang.") { TableRelation = "Language Selection"; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Edit)
            {
                Image = Edit;

                trigger OnAction()
                var
                    TermLang: Record "X Term. Lang.";
                    TermCard: Page "X Term. Card";
                begin
                    SetSelectionFilter(TermLang);
                    TermCard.SetTableView(TermLang);
                    TermCard.RunModal();
                end;
            }
        }

        area(Promoted)
        {
            actionref(EditPromoted; Edit) { }
        }
    }
}