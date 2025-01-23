namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Transfer;

pageextension 50218 TransferOrderSubform extends "Transfer Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Reason Code JCOARC"; Rec."Reason Code JCOARC")
            {
                ToolTip = 'Specifies the Reason Code for transfer';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Unit Price JCOARC"; Rec."Unit Price JCOARC")
            {
                ToolTip = 'Specifies the Unit price of the Transfer. This is onlt for reporting purpose';
                ApplicationArea = All;
            }
            field("Line Amount JCOARC"; Rec."Line Amount JCOARC")
            {
                Editable = false;
                ToolTip = 'Specifies the Line Amount of the Transfer. This is onlt for reporting purpose';
                ApplicationArea = All;
            }
        }
    }
}
