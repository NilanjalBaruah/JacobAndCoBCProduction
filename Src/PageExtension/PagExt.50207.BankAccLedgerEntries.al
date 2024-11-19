namespace JCO.JCO;

using Microsoft.Bank.Ledger;

pageextension 50207 "BankAccLdgEntries Extn ARCJCO" extends "Bank Account Ledger Entries"
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