namespace JCO.JCO;

using Microsoft.Sales.History;

pageextension 50214 "PSalesInvoices Extn JCO" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            //JCO-91>>
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Invoice related to a Consignment(B2B) Sales';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
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