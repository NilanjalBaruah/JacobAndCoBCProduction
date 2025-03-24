pageextension 50109 "JCO Sales Order Line" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("JCO RTV"; Rec."JCO RTV")
            {
                ToolTip = 'Fetched the values from Quantity of Item Ledger Entry (Appl.-to Item Entry) ';
                ApplicationArea = All;
                Visible = false;
            }
            field("JCO SFM"; Rec."JCO SFM")
            {
                ToolTip = 'Fetch values from Quantity - RTV';
                ApplicationArea = All;
                Visible = false;
            }
        }
        //JCO-91>>
        addafter("Location Code")
        {
            field("Consignment Location Code ARCJ"; Rec."Consignment Location Code ARCJ")
            {
                ToolTip = 'This is the location of the Customer. Select a location for a Consignment Sales';
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Qty Shipped to Consignee JCO"; Rec."Qty Shipped to Consignee JCO")
            {
                ToolTip = 'This is the Quantity Shipped to Business (B2B). Information will automatically updated from "Consignment Shipment Details" button';
                ApplicationArea = All;
                Editable = false;
            }

            field("Quantity Sold By Consignee JCO"; Rec."Quantity Sold By Consignee JCO")
            {
                ToolTip = 'This is the Quantity sold by Business (B2B). Information will automatically updated from "Confirm Consignment Sales" button';
                ApplicationArea = All;
                Editable = false;
            }
            field("Qty. Invoiced to Consignee JCO"; Rec."Qty. Invoiced to Consignee JCO")
            {
                ToolTip = 'This is the Quantity Invoiced to Business (B2B). Information will automatically updated when Invoice is posted from Consignments to Invoice page';
                ApplicationArea = All;
                Editable = false;
            }
            field("Qty. Returned By Consignee JCO"; Rec."Qty. Returned By Consignee JCO")
            {
                ToolTip = 'This is the Quantity Invoiced to Business (B2B). Information will automatically updated when Invoice is posted from Consignments to Invoice page';
                ApplicationArea = All;
                Editable = false;
            }
        }
        //JCO091<<
        //JCO11122024>>
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        //JCO11122024<<
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}