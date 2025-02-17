tableextension 50218 "JCO Sales CrMemo Line" extends "Sales Cr.Memo Line"
{
    fields
    {
        //JCO112024 >>
        field(50204; "Currency Code JCO"; Code[20])
        {
            Caption = 'Currency Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Currency Code" where("No." = field("Document No.")));
        }
        field(50205; "Currency Factor JCO"; Decimal)
        {
            Caption = 'Currency Factor';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Currency Factor" where("No." = field("Document No.")));
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
            CalcFormula = lookup("Sales Cr.Memo Header"."Ship-to Address" where("No." = field("Document No.")));
        }
        field(50208; "Ship-to County JCO"; Text[30])
        {
            Caption = 'Ship to State';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Ship-to County" where("No." = field("Document No.")));
        }
        field(50209; "Ship-to Post Code JCO"; Text[20])
        {
            Caption = 'Ship to Zip Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Ship-to Post Code" where("No." = field("Document No.")));
        }
        field(50210; "Ship-to Cntry/Region Code JCO"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Ship-to Country/Region Code" where("No." = field("Document No.")));
        }
        field(50211; "Ship-from Cntry/Regin Code JCO"; Code[10])
        {
            Caption = 'Ship-from Country Code';
            TableRelation = "Country/Region";
            FieldClass = FlowField;
            CalcFormula = lookup(Location."Country/Region Code" where(Code = field("Location Code")));
        }
        //JCO112224 <<
        field(50212; "Document Date JCO"; Date)
        {
            Caption = 'Document Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Document Date" where("No." = field("Document No.")));
        }
        field(50214; "Location Group Code ARCJCO"; Code[20])
        {
            Caption = 'Location Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Location Group ARCJCO";
        }

    }
}