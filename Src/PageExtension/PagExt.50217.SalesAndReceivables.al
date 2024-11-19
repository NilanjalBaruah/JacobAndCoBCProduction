namespace JCO.JCO;

using Microsoft.Sales.Setup;

pageextension 50217 "SalesAndRecSetup Extn ARCJCO" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Disable Search by Name")
        {
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