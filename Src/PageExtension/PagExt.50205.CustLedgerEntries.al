namespace JCO.JCO;

using Microsoft.Sales.Receivables;

pageextension 50205 "CustLedgerEntries Extn ARCJCO" extends "Customer Ledger Entries"
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