namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Finance.GeneralLedger.Account;

pageextension 50250 GLAccountListJCO extends "G/L Account List"
{
    layout
    {
        addafter(Name)
        {
            field("Long Description JCOARC"; Rec."Long Description JCOARC")
            {
                ApplicationArea = All;
                Caption = 'Long Description';
                Editable = false;
            }
        }
    }
}