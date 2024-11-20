tableextension 50109 "JCO Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "JCO RTV"; Decimal)
        {
            Caption = 'RTV';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50101; "JCO SFM"; Decimal)
        {
            Caption = 'SFM';
            DataClassification = CustomerContent;
            Editable = false;
        }
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
        //JCO112024 >>
        field(50204; "Currency Code JCO"; Code[20])
        {
            Caption = 'Currency Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Currency Code" where("No." = field("Document No.")));
        }
        field(50205; "Currency Factor JCO"; Decimal)
        {
            Caption = 'Currency Factor';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Currency Factor" where("No." = field("Document No.")));
        }
        field(50206; "Retail Price JCO"; Decimal)
        {
            Caption = 'Retail Price';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Unit Price" where("No." = field("No.")));
        }
        //JCO112024 <<
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