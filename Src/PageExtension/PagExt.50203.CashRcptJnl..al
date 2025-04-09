namespace JCO.JCO;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50203 "CashRcptJnl Extn ARCJCO" extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Document Type")
        {
            field("Sub Document Type ARCJCO"; Rec."Sub Document Type ARCJCO")
            {
                ApplicationArea = All;
                ToolTip = 'Specify additional document Type for this transaction, if any';
            }
        }
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