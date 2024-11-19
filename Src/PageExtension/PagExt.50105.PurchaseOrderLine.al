pageextension 50105 "JCO PurchaseOrder SubForm" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Consignment Location Code ARCJ"; Rec."Consignment Location Code ARCJ")
            {
                ToolTip = 'This is the location of the Vendor. Select a location for a Consignment Purchase';
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Qty. Shipped by Consignee JCO"; Rec."Qty. Shipped by Consignee JCO")
            {
                ToolTip = 'This is the Quantity Shipped by Vendor. Information will automatically updated from "Consignment Shipment Details" button';
                ApplicationArea = All;
                Editable = false;
            }

            field("Qty. Received at Location JCO"; Rec."Qty. Received at Location JCO")
            {
                ToolTip = 'This is the Quantity Physically Received At Location. Information will automatically updated from "Consignment Receipt Details" button';
                ApplicationArea = All;
                Editable = false;
            }

        }
        addafter("Quantity Invoiced")
        {
            field("JCO SalesOrderLine.No."; Rec."JCO SalesOrderLine.No.")
            {
                ApplicationArea = All;
            }
            field("JCO Sales Order Line No."; Rec."JCO Sales Order Line No.")
            {
                ApplicationArea = All;
            }
            field("JCO Shipping Request Status"; Rec."JCO Shipping Request Status")
            {
                ApplicationArea = All;
            }
            field("JCO Shipping Req. Status Date"; Rec."JCO Shipping Req. Status Date")
            {
                ApplicationArea = All;
            }
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}