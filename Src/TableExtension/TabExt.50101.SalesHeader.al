tableextension 50101 "Jco Sales Header Ext" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "JCO Purchase Order No."; Code[20])
        {
            Caption = 'JCO Purchase Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header";
            Editable = false;

        }
        field(50101; "JCO Vendor No."; code[20])
        {
            Caption = 'JCO Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Editable = false;
        }
        field(50102; "JCO Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(50103; "SWISS VAT ARCJCO"; Boolean)
        {
            Caption = 'SWISS VAT';
            DataClassification = CustomerContent;
        }
        //JCO-91>>
        field(50201; "Consignment Order ARCJCO"; Boolean)
        {
            Caption = 'Consignment Order';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50202; "Archive Ordr on Shpmt ARCJCO"; Boolean)
        {
            Caption = 'Archive Consignment Order on Shipment to Business';
            DataClassification = CustomerContent;
            Editable = true;
        }
        //JCO-91<<
        field(50203; "Prepayment Amount ARCJCO"; Decimal)
        {
            Caption = 'Premayment Amount';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                CalcFields("Amount Including VAT");
                if "Prepayment Amount ARCJCO" > "Amount Including VAT" then
                    Error('Prepayment Amount cannot exceed Total Amount of Invoice');
                SalesLine.SetRange("Document Type", "Document Type");
                SalesLine.SetRange("Document No.", "No.");
                if SalesLine.FindSet() then
                    repeat
                        if SalesLine.Type <> SalesLine.Type::" " then
                            SalesLine.Validate("Prepmt. Line Amount", "Prepayment Amount ARCJCO");
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
            end;
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