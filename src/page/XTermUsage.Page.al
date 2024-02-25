page 50105 "X Term. Usage"
{
    ApplicationArea = All;
    Caption = 'Term. Usage';
    PageType = List;
    SourceTable = "X Term. Usage";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                repeater(Term)
                {
                    field(Report_Usage; Rec."Term. Usage") { }
                    field(Term_Code; Rec."Term. Code") { TableRelation = "X Term. Code"; }
                }
            }
        }
    }
}
