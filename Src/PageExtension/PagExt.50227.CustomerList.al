// SGN_15MAR24  Created this Customer Extension to add the new field in Customer Card>>
pageextension 50227 "JCO CustomerListExtn" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ToolTip = 'Specifies Tax Area Code';
                ApplicationArea = All;
            }
        }
    }
}