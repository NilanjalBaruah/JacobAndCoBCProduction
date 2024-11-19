pageextension 50107 "JCO Posted Return Rcpt Header" extends "Posted Return Receipt"
{
    layout
    {
        // Add changes to page layout here
        modify("Sell-to Address")
        {
            Importance = Promoted;
        }
        modify("Sell-to Address 2")
        {
            Importance = Promoted;
        }

        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
                Importance = Promoted;
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