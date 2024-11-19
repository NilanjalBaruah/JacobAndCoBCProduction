pageextension 50110 "JCO Sales Quote" extends "Sales Quote"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}