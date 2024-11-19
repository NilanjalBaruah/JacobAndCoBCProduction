namespace JCO.JCO;

using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 50204 "GenLedgerEntries Extn ARCJCO" extends "General Ledger Entries"
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