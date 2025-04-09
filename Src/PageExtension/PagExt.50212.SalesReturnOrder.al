namespace JCO.JCO;

using Microsoft.Sales.Document;

pageextension 50212 "SalesRetOrd Extn ARCJCO" extends "Sales Return Order"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Sub Document Type ARCJCO"; Rec."Sub Document Type ARCJCO")
            {
                ApplicationArea = All;
                ToolTip = 'Specify the Type of the Credit Transaction';
            }
        }
        addafter(Status)
        {
            field("SWISS VAT ARCJCO"; Rec."SWISS VAT ARCJCO")
            {
                ToolTip = 'Specifies, if the Invoice is applied with Swiss VAT';
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
            }
        }
    }
}