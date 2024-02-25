codeunit 50101 "X Lang. Mgt."
{
    procedure GetName(ID: Integer) Name: Text
    begin
        LanguageSelection.Reset();
        LanguageSelection.SetRange("Language ID", ID);
        if LanguageSelection.FindFirst() then
            Name := LanguageSelection.Name;
    end;

    procedure GetID(Name: Text[100]) ID: Integer
    begin
        LanguageSelection.Reset();
        LanguageSelection.SetRange(Name, Name);
        if LanguageSelection.FindFirst() then
            ID := LanguageSelection."Language ID";
    end;

    var
        LanguageSelection: Record "Language Selection";
}
