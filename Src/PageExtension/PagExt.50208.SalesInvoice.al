namespace JCO.JCO;

using Microsoft.Sales.Document;

pageextension 50208 "SalesInvoice Extn ARCJCO" extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Sub Document Type ARCJCO"; Rec."Sub Document Type ARCJCO")
            {
                ApplicationArea = All;
                ToolTip = 'Specify the Additional Type of the Transaction';
            }
        }
        addafter(Status)
        {
            field("SWISS VAT ARCJCO"; Rec."SWISS VAT ARCJCO")
            {
                ToolTip = 'Specifies, if the Invoice is applied with Swiss VAT';
                ApplicationArea = All;
                Visible = false;
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