table 50204 "Sub Doc. Type ARCJCO"
{
    Caption = 'Sub Document Type';
    DataClassification = CustomerContent;
    LookupPageId = "Sub Document Type ARCJCO";
    DrillDownPageId = "Sub Document Type ARCJCO";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Default to Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Default to Document Type transactions';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}