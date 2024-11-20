pageextension 50228 "JCO PostedSalesInvLinesExtn" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ToolTip = 'Specifies the Posting Date of the Invoice';
                ApplicationArea = All;
                Editable = false;
            }
            field("Currency Code JCO"; Rec."Currency Code JCO")
            {
                ToolTip = 'Specifies the Currency Code of the Invoice';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addbefore("Unit Price")
        {
            field("Retail Price JCO"; Rec."Retail Price JCO")
            {
                ToolTip = 'Shows the Retail Price';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}