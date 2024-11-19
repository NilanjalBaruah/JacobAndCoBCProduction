// SGN_15MAR24  Created this Customer Extension to add the new field in Customer Card>>
pageextension 50100 "JCO CustomerCardExtn" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
            }
        }
    }
}