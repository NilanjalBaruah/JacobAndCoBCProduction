tableextension 50103 "Jco Purchase Line Ext" extends "Purchase Line"
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
            FieldClass = FlowField;
            CalcFormula = sum("Purch. Consignment Det ARCJCO".Quantity where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Consignment Status" = filter("P Consignment Status ARCJCO"::"Shipped By Vendor")));
        }
        field(50203; "Qty. Received at Location JCO"; Decimal)
        {
            Caption = 'Quantity Received at Location';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Purch. Consignment Det ARCJCO".Quantity where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Consignment Status" = filter("P Consignment Status ARCJCO"::"Received At Location")));
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