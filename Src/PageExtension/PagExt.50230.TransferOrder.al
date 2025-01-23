namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Transfer;

pageextension 50230 TransferOrderJCO extends "Transfer Order"
{
    layout
    {
        addafter("In-Transit Code")
        {
            field("Customer No. JCOARC"; Rec."Customer No. JCOARC")
            {
                ToolTip = 'Specifies the linked Customer Code for Transfer-To Code';
                ApplicationArea = All;
            }
            field("Currency Code JCOARC"; Rec."Currency Code JCOARC")
            {
                ToolTip = 'Specifies the Currency Code linked to the Customer';
                ApplicationArea = All;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ToolTip = 'Specifies the Customer Reference No.';
                ApplicationArea = All;
            }
            field("Your Reference JCOARC"; Rec."Your Reference JCOARC")
            {
                ToolTip = 'Specifies the Reference No.';
                ApplicationArea = All;
            }
        }
    }
}
