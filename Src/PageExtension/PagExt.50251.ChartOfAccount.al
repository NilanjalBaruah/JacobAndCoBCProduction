namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Finance.GeneralLedger.Account;

pageextension 50251 ChartOfAccountJCO extends "Chart of Accounts"
{
    layout
    {
        addafter(Name)
        {
            field("Long Description JCOARC"; Rec."Long Description JCOARC")
            {
                ApplicationArea = All;
                Caption = 'Long Description';
                ToolTip = 'This hold the Account Description of Legacy/QB listing';
                Editable = false;
            }
        }
    }
}