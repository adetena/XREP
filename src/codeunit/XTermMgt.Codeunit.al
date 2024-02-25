codeunit 50103 "X Term Mgt."
{
    procedure Get(Usage: Enum "Report Selection Usage"; Lang: Text) Terms: Text
    var
        TermUsage: Record "X Term. Usage";
        TermLine: Record "X Term. Line";
    begin
        TermUsage.Reset();
        TermUsage.SetRange("Term. Usage", Usage);
        if TermUsage.FindFirst() then begin
            TermLine.Reset();
            TermLine.SetRange("Term. Code", TermUsage."Term. Code");
            TermLine.SetRange("Term. Lang.", Lang);
            if TermLine.FindSet() then
                repeat
                    Terms += ToHTML(TermLine);
                until TermLine.Next() = 0;
        end;
    end;

    local procedure ToHTML(TermLine: Record "X Term. Line") HTML: Text
    var
        Tag: Text;
        Style: Text;
    begin
        case TermLine."Line Type" of
            "X Term. Line Type"::title:
                begin
                    Tag := 'h1';
                    Style := 'text-align: center; color: red;';
                end;
            "X Term. Line Type"::header:
                begin
                    Tag := 'h4';
                    Style := 'color: purple;';
                end;
            "X Term. Line Type"::paragraph:
                begin
                    Tag := 'p';
                    Style := 'text-indent: 8pt;';
                end;
        end;

        HTML := '<' + Tag + ' style="' + Style + '">' + TermLine."Line Text" + '</' + Tag + '>';
    end;
}
