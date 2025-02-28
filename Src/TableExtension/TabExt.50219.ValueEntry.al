tableextension 50219 "JCO Value Entry" extends "Value Entry"
{
    fields
    {
        field(50201; "Serial No. JCO"; Code[50])
        {
            Caption = 'Serial No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Serial No." where("Entry No." = field("Item Ledger Entry No."), "Entry Type" = field("Item Ledger Entry Type")));
        }
        field(50106; "Location Group Code ARCJCO"; Code[20])
        {
            Caption = 'Location Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Location Group ARCJCO";
        }
        field(50207; "Ship-to Address JCO"; Text[100])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(50208; "Ship-to County JCO"; Text[30])
        {
            Caption = 'Ship to State';
            DataClassification = CustomerContent;
        }
        field(50209; "Ship-to Post Code JCO"; Text[20])
        {
            Caption = 'Ship to Zip Code';
            DataClassification = CustomerContent;
        }
        field(50210; "Ship-to Cntry/Region Code JCO"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50211; "Ship-from Cntry/Regin Code JCO"; Code[10])
        {
            Caption = 'Ship-from Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
    }
}