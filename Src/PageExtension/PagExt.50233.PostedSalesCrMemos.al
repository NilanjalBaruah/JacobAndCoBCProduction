namespace JCO.JCO;

using Microsoft.Sales.History;

pageextension 50233 "PSalesCrMemos Extn JCO" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Tax/VAT Amount"; Rec."Amount Including VAT" - Rec.Amount)
            {
                Caption = 'Tax/VAT Amount';
                ToolTip = 'Show the Tax or VAT Amount';
                ApplicationArea = All;
            }

            field("Tax/VAT Amount$"; VATAmountDollar)
            {
                Caption = 'Tax/VAT Amount ($)';
                ToolTip = 'Show the Tax or VAT Amount in $';
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(VATAmountDollar);
        Rec.CalcFields(Amount, "Amount Including VAT");
        if (Rec."Amount Including VAT" - Rec.Amount) <> 0 then begin
            VATAmountDollar := (Rec."Amount Including VAT" - Rec.Amount);
            if Rec."Currency Code" <> '' then
                if VATAmountDollar <> 0 then
                    VATAmountDollar := round(VATAmountDollar / Rec."Currency factor", 0.01);
        end;
    end;

    var
        VATAmountDollar: Decimal;
}