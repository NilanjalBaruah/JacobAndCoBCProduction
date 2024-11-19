namespace JCO.JCO;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50203 "CashRcptJnl Extn ARCJCO" extends "Cash Receipt Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2 ARCJCO")
            {
                ToolTip = 'Specify additional Description to the Journal Line';
                ApplicationArea = All;
            }
        }
    }
}