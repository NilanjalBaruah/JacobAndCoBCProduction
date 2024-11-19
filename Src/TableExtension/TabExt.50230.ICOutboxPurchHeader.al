tableextension 50230 "Outbox Purch Header Ext JCO" extends "IC Outbox Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "JCO Sales Order No."; Code[20])
        {
            Caption = 'JCO Sales Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header";
            Editable = false;
        }
        field(50101; "JCO Sales Quote No."; Code[20])
        {
            Caption = 'JCO Sales Quote No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50102; "JCO Sell-to Customer No."; Code[20])
        {
            Caption = 'JCO Sell-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Editable = false;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}