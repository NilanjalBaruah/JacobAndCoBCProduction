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
        addafter("Sell-to Customer No.")
        {
            field("Ship-to Address JCO"; Rec."Ship-to Address JCO")
            {
                ToolTip = 'Specifies the Shipping Address of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to State JCO"; Rec."Ship-to County JCO")
            {
                ToolTip = 'Specifies the Shipping State of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to Post Code JCO"; Rec."Ship-to Post Code JCO")
            {
                ToolTip = 'Specifies the Shipping Zip Code of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to Cntry/Region Code JCO"; Rec."Ship-to Cntry/Region Code JCO")
            {
                ToolTip = 'Specifies the Shipping Country of the Customer';
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-from Cntry/Regin Code JCO"; Rec."Ship-from Cntry/Regin Code JCO")
            {
                ToolTip = 'Specifies the Ship from Country';
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