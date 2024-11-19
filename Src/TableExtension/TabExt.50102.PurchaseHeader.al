tableextension 50102 "Jco Purchase Header Ext" extends "Purchase Header"
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
        field(50201; "Consignment Order ARCJCO"; Boolean)
        {
            Caption = 'Consignment Order';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50202; "Archive Ordr on Rcpt. ARCJCO"; Boolean)
        {
            Caption = 'Archive Consignment Order on Receipt';
            DataClassification = CustomerContent;
            Editable = true;
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

    var
        myInt: Integer;
}