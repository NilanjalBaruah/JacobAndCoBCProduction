namespace JCO.JCO;

using Microsoft.Sales.Setup;

pageextension 50217 "SalesAndRecSetup Extn ARCJCO" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Show Loss as Neg. Prft JCOARC"; Rec."Show Loss as Neg. Prft JCOARC")
            {
                ToolTip = 'Mark, if profit column shows Negative value for Sales Credit Memo, in Detailed Sales Report';
                ApplicationArea = All;
            }
            field("Cons. Template Name"; Rec."Cons. Template Name JCOARC")
            {
                ToolTip = 'This template will be used in the backgroud, and used in Sales Consignment Process';
                ApplicationArea = All;
            }
            field("Cons. Batch Name"; Rec."Cons. Batch Name JCOARC")
            {
                ToolTip = 'This batch will be used in the backgroud, and used in Sales Consignment Process';
                ApplicationArea = All;
            }

        }
    }
}