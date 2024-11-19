pageextension 50108 "JCO Posted Sales Inv Line" extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("JCO RTV"; Rec."JCO RTV")
            {
                ToolTip = 'specifies the JCO RTV Value';
                ApplicationArea = All;
            }
            field("JCO SFM"; Rec."JCO SFM")
            {
                ToolTip = 'Fetch values from Quantity - RTV';
                ApplicationArea = All;
            }
        }
        //JCO-91>>
        addafter("Location Code")
        {
            field("Consignment Location Code ARCJ"; Rec."Consignment Location Code ARCJ")
            {
                ToolTip = 'This is the location of the Customer (B2B), for Consignment Sales Invoice';
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Qty Shipped to Consignee JCO"; Rec."Qty Shipped to Consignee JCO")
            {
                ToolTip = 'This is the Quantity shipped to Business (B2B), for Consignment Sales Invoice';
                ApplicationArea = All;
                Editable = false;
            }
            field("Quantity Sold By Consignee JCO"; Rec."Quantity Sold By Consignee JCO")
            {
                ToolTip = 'This is the Quantity sold by Business (B2B), for Consignment Sales Invoice';
                ApplicationArea = All;
                Editable = false;
            }
        }
        //JCO091<<
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}