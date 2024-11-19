namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Sales.History;

pageextension 50216 PostedSalesShipmentSubformJCO extends "Posted Sales Shpt. Subform"
{
    layout
    {
        //JCO-91>>
        addafter("Location Code")
        {
            field("Consignment Location Code ARCJ"; Rec."Consignment Location Code ARCJ")
            {
                ToolTip = 'This is the location of the Customer (B2B), for Consignment Sales Shipment';
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Qty Shipped to Consignee JCO"; Rec."Qty Shipped to Consignee JCO")
            {
                ToolTip = 'This is the Quantity shipped to Business (B2B), at the time of this Consignment Sales shipment';
                ApplicationArea = All;
                Editable = false;
            }

            field("Quantity Sold By Consignee JCO"; Rec."Quantity Sold By Consignee JCO")
            {
                ToolTip = 'This is the Quantity sold by Business (B2B), for Consignment Sales shipment';
                ApplicationArea = All;
                Editable = false;
            }
        }
        //JCO091<<
    }
}
