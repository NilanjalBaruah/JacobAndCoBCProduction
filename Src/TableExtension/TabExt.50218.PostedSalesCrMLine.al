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
    }
}