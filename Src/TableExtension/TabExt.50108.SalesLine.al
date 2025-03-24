tableextension 50108 "JCO Sales Line" extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "JCO RTV"; Decimal)
        {
            Caption = 'RTV';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                Text001: Label '%1 : RTV value cannot be greater than %2 : Quantity value';
            begin
                IF rec."JCO RTV" <> 0 then
                    if Rec."JCO RTV" <= Rec.Quantity then
                        Rec."JCO SFM" := Rec.Quantity - Rec."JCO RTV"
                    else
                        Message(Text001, rec."JCO RTV", Rec.Quantity);
            end;
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
        }
        field(50202; "Qty Shipped to Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Shipped to Consignee';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Consignment Detail ARCJCO".Quantity where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Consignment Status" = filter("Consignment Status ARCJCO"::"Shipped to Business" .. "Sold By Business")));
        }
        field(50203; "Quantity Sold By Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Sold By  Consignee';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Consignment Detail ARCJCO".Quantity where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Consignment Status" = const("Consignment Status ARCJCO"::"Sold By Business")));
        }
        //JCO-91<<
        //JCO112024 >>
        field(50204; "Currency Code JCO"; Code[20])
        {
            Caption = 'Currency Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Currency Code" where("Document Type" = field("Document Type"),
                                                                      "No." = field("Document No.")));
        }
        field(50205; "Currency Factor JCO"; Decimal)
        {
            Caption = 'Currency Factor';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Currency Factor" where("Document Type" = field("Document Type"),
                                                                      "No." = field("Document No.")));
        }
        field(50206; "Retail Price JCO"; Decimal)
        {
            Caption = 'Retail Price';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Unit Price" where("No." = field("No.")));
        }
        //JCO112024 <<
        //JCO112224 >>
        field(50207; "Ship-to Address JCO"; Text[100])
        {
            Caption = 'Ship-to Address';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Ship-to Address" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(50208; "Ship-to County JCO"; Text[30])
        {
            Caption = 'Ship to State';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Ship-to Country/Region Code" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(50209; "Ship-to Post Code JCO"; Text[20])
        {
            Caption = 'Ship to Zip Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Ship-to Post Code" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(50210; "Ship-to Cntry/Region Code JCO"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Ship-to Country/Region Code" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(50211; "Ship-from Cntry/Regin Code JCO"; Code[10])
        {
            Caption = 'Ship-from Country Code';
            TableRelation = "Country/Region";
            FieldClass = FlowField;
            CalcFormula = lookup(Location."Country/Region Code" where(Code = field("Location Code")));
        }
        //JCO112224 <<

        field(50214; "Location Group Code ARCJCO"; Code[20])
        {
            Caption = 'Location Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Location Group ARCJCO";
        }
        field(50215; "Qty. Invoiced to Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Invoiced to Consignee';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Consignment Detail ARCJCO".Quantity where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Consignment Status" = const("Consignment Status ARCJCO"::"Invoiced to Business")));
        }
        field(50216; "Qty. Returned By Consignee JCO"; Decimal)
        {
            Caption = 'Quantity Returned By Consignee';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Consignment Detail ARCJCO".Quantity where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Consignment Status" = const("Consignment Status ARCJCO"::"Returned By Business")));
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