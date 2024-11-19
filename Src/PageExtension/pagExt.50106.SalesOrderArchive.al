pageextension 50106 "JCO Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
            }
        }
    }
}