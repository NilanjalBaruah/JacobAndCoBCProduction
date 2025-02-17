namespace JCO.JCO;

using Microsoft.Sales.History;

pageextension 50233 "PSalesCrMemos Extn JCO" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter(Amount)
        {
            field(amountDollar; AmountDollar)
            {
                ToolTip = 'Shows the Sales Amount in $';
                Caption = 'Amount $';
                ApplicationArea = All;
                Editable = false;
                AssistEdit = true;
                trigger OnAssistEdit()
                var
                    SalesCrMemoLine: Record "Sales Cr.Memo Line";
                begin
                    SalesCrMemoLine.SetRange("Document No.", Rec."No.");
                    SalesCrMemoLine.SetFilter(Type, '<>%1', SalesCrMemoLine.Type::" ");
                    Page.RunModal(page::"Posted Sales Credit Memo Lines", SalesCrMemoLine);
                end;

            }
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
        Clear(AmountDollar);
        Clear(VATAmountDollar);

        Rec.CalcFields(Amount, "Amount Including VAT");
        AmountDollar := Rec.Amount;
        if Rec."Currency Factor" <> 0 then
            if Rec.Amount <> 0 then
                AmountDollar := round(Rec.Amount / Rec."Currency Factor", 0.01);

        if (Rec."Amount Including VAT" - Rec.Amount) <> 0 then begin
            VATAmountDollar := (Rec."Amount Including VAT" - Rec.Amount);
            if Rec."Currency Factor" <> 0 then
                if VATAmountDollar <> 0 then
                    VATAmountDollar := round(VATAmountDollar / Rec."Currency factor", 0.01);
        end;
    end;

    var
        AmountDollar: Decimal;
        VATAmountDollar: Decimal;
}