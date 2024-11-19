namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Transfer;

pageextension 50220 TransferReceiptSubform extends "Posted Transfer Rcpt. Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Reason Code JCOARC"; Rec."Reason Code JCOARC")
            {
                ToolTip = 'Specifies the Reason Code for transfer.';
                ApplicationArea = All;
            }
        }
    }

}
