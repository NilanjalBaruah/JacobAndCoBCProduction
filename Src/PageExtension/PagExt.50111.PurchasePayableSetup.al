namespace JCO.JCO;

using Microsoft.Purchases.Setup;

pageextension 50111 "PurchaseRecSetup Extn ARCJCO" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Cons. Template Name"; Rec."Cons. Template Name JCOARC")
            {
                ToolTip = 'This template will be used in the backgroud, and used in Purchase Consignment Process';
                ApplicationArea = All;
            }
            field("Cons. Batch Name"; Rec."Cons. Batch Name JCOARC")
            {
                ToolTip = 'This batch will be used in the backgroud, and used in Purchase Consignment Process';
                ApplicationArea = All;
            }
        }
    }
}