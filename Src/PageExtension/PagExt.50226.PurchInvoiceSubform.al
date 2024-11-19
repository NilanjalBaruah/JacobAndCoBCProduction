namespace JCO.JCO;

using Microsoft.Purchases.Document;

pageextension 50226 "PurchInvoice Subform ARCJCO" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Original PO No. JCO"; Rec."Original PO No. JCO")
            {
                ToolTip = 'Specifies, the original Intercompany PO No. linked to this Invoice';
                ApplicationArea = All;
            }
            field("Original PO Line No. JCO"; Rec."Original PO Line No. JCO")
            {
                ToolTip = 'Specifies, the original Intercompany PO Line No. linked to this Invoice';
                ApplicationArea = All;
            }
            field("VAT %"; Rec."VAT %")
            {
                ToolTip = 'Specifies the VAT %';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

}