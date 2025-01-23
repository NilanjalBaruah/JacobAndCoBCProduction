pageextension 50228 "JCO PostedSalesInvLinesExtn" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ToolTip = 'Specifies the Posting Date of the Invoice';
                ApplicationArea = All;
                Editable = false;
            }
            field("Document Date JCO"; Rec."Document Date JCO")
            {
                ToolTip = 'Specifies the Document Date of the Invoice';
                ApplicationArea = All;
                Editable = false;
            }
            field("Currency Code JCO"; Rec."Currency Code JCO")
            {
                ToolTip = 'Specifies the Currency Code of the Invoice';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Sell-to Customer No.")
        {
            field("Ship-to Address JCO"; Rec."Ship-to Address JCO")
            {
                ToolTip = 'Specifies the Shipping Address of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to State JCO"; Rec."Ship-to County JCO")
            {
                ToolTip = 'Specifies the Shipping State of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to Post Code JCO"; Rec."Ship-to Post Code JCO")
            {
                ToolTip = 'Specifies the Shipping Zip Code of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to Cntry/Region Code JCO"; Rec."Ship-to Cntry/Region Code JCO")
            {
                ToolTip = 'Specifies the Shipping Country of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-from Cntry/Regin Code JCO"; Rec."Ship-from Cntry/Regin Code JCO")
            {
                ToolTip = 'Specifies the Ship from Country';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addbefore("Unit Price")
        {
            field("Retail Price JCO"; Rec."Retail Price JCO")
            {
                ToolTip = 'Shows the Retail Price';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Amount)
        {
            field(amountDollar; AmountDollar)
            {
                ToolTip = 'Shows the Sales Amount in $';
                Caption = 'Amount $';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Amount Including VAT")
        {
            field("VAT %"; Rec."VAT %")
            {
                ToolTip = 'Shows the Tax/VAT %';
                Caption = 'Tax/VAT %';
                ApplicationArea = All;
                Editable = false;
            }
            field(VATAmount; VATAmount)
            {
                ToolTip = 'Shows the Tax/VAT Amount';
                Caption = 'Tax/VAT Amount';
                ApplicationArea = All;
                Editable = false;
            }
            field(VATAmountDollar; VATAmountDollar)
            {
                ToolTip = 'Shows the Tax/VAT Amount in $';
                Caption = 'Tax/VAT Amount ($)';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(AmountDollar);
        Clear(VATAmount);
        Clear(VATAmountDollar);
        VATAmount := Rec."Amount Including VAT" - Rec.Amount;
        Rec.CalcFields("Currency Factor JCO");
        if Rec."Currency Factor JCO" = 0 then begin
            AmountDollar := Rec.Amount;
            VATAmountDollar := VATAmount;
        end else begin
            if Rec.Amount <> 0 then
                AmountDollar := round(Rec.Amount / Rec."Currency Factor JCO", 0.01);
            if VATAmount <> 0 then
                VATAmountDollar := round(VATAmount / Rec."Currency Factor JCO", 0.01);
        end;
    end;

    var
        AmountDollar: Decimal;
        VATAmount: Decimal;
        VATAmountDollar: Decimal;
}