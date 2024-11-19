tableextension 50207 "JCO SalesShipmentLine Ext" extends "Sales Shipment Line"
{
    fields
    {
        //JCO-91>>
        field(50201; "Consignment Location Code ARCJ"; Code[20])
        {
            Caption = 'Consignment Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location where("Consignment Location ARCJCO" = const(true), "Consignment Customer No. ARJCO" = field("Sell-to Customer No."));
            Editable = false;
        }
        field(50202; "Qty Shipped to Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Shipped to Consignee';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }

        field(50203; "Quantity Sold By Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Sold By Customer';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
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