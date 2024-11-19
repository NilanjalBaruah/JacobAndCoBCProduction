pageextension 50101 "JCO Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter(status)
        {
            field("JCO Sales Quote No."; Rec."JCO Sales Quote No.")
            {
                ApplicationArea = All;
            }
            field("JCO Sales Order No."; Rec."JCO Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("JCO Sell-to Customer No."; Rec."JCO Sell-to Customer No.")
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