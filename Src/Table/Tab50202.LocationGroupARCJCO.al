table 50202 "Location Group ARCJCO"
{
    Caption = 'Location Group';
    DataClassification = CustomerContent;
    LookupPageId = "Location Groups ARCJCO";
    DrillDownPageId = "Location Groups ARCJCO";

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
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}