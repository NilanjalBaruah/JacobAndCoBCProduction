tableextension 50206 "Jco Sales Shpt Header Ext" extends "Sales Shipment Header"
{
    fields
    {
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
        //JCO-91<<
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