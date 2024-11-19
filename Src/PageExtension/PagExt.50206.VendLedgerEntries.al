namespace JCO.JCO;

using Microsoft.Purchases.Payables;

pageextension 50206 "VendLedgerEntries Extn ARCJCO" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2 ARCJCO")
            {
                ToolTip = 'Additional Description entered in Journal Line';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}