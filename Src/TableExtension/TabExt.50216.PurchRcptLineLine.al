tableextension 50216 "JCO PurchReceiptLine Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
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
        field(50204; "Original PO No. JCO"; Code[20])
        {
            Caption = 'Original PO No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Buy-from Vendor No."));
        }
        field(50205; "Original PO Line No. JCO"; Integer)
        {
            Caption = 'Original PO Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Line"."Line No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Buy-from Vendor No."), "No." = field("No."), "Consignment Location Code ARCJ" = field("Location Code"));
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