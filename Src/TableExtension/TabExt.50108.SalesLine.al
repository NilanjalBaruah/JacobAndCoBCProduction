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