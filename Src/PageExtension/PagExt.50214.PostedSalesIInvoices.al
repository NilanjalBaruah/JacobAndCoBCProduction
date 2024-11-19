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
    }
}