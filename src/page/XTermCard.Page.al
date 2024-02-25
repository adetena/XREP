page 50104 "X Term. Card"
{
    ApplicationArea = All;
    Caption = 'Term. Card';
    PageType = Card;
    SourceTable = "X Term. Lang.";

    layout
    {
        area(content)
        {
            field(Term_Code; Rec."Term. Code") { Editable = false; }
            field(Term_Lang; Rec."Term. Lang.") { Editable = false; }

            part(Lines; "X Term. Line List")
            {
                SubPageLink = "Term. Code" = field("Term. Code"), "Term. Lang." = field("Term. Lang.");
            }
        }
    }
}
