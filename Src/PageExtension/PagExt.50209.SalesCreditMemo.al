namespace JCO.JCO;

using Microsoft.Sales.Document;

pageextension 50209 "SalesCrMemo Extn ARCJCO" extends "Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Address")
        {
            Importance = Promoted;
        }
        modify("Sell-to Address 2")
        {
            Importance = Promoted;
        }
        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("SWISS VAT ARCJCO"; Rec."SWISS VAT ARCJCO")
            {
                ToolTip = 'Specifies, if the Credit Memo is applied with Swiss VAT';
                ApplicationArea = All;
            }
        }
    }
}