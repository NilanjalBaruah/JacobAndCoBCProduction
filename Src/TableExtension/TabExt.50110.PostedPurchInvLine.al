tableextension 50110 "JCO Posted Purchase Inv Line" extends "Purch. Inv. Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "JCO SalesOrderLine.No."; Code[20])
        {
            Caption = 'JCO SalesOrderLine.No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50101; "JCO Sales Order Line No."; Integer)
        {
            Caption = 'JCO Sales Order Line No';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50102; "JCO Sell-to Customer No."; Code[20])
        {
            Caption = 'JCO Sell-to Customer No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50103; "JCO Shipping Request Status"; Enum "JCO Shipping Request Status")
        {
            Caption = 'Shipping Request Status';
            DataClassification = CustomerContent;
        }
        field(50104; "JCO Shipping Req. Status Date"; Date)
        {
            Caption = 'Shipping Req. Status Date';
        }
        field(50201; "Consignment Location Code ARCJ"; Code[20])
        {
            Caption = 'Consignment Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location where("Consignment Location ARCJCO" = const(True), "Consignment Vendor No. ARJCO" = field("Buy-from Vendor No."));
        }
        field(50202; "Qty. Shipped by Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Shipped by Consignee';
            DecimalPlaces = 0 : 5;
        }
        field(50203; "Qty. Received at Location JCO"; Decimal)
        {
            Caption = 'Quantity Received at Location';
            DecimalPlaces = 0 : 5;
        }
        field(50214; "Location Group Code ARCJCO"; Code[20])
        {
            Caption = 'Location Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Location Group ARCJCO";
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