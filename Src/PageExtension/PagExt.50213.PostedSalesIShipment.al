namespace JCO.JCO;

using Microsoft.Sales.History;

pageextension 50213 "PSalesShipment Extn ARCJCO" extends "Posted Sales Shipment"
{
    layout
    {
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
                ApplicationArea = All;
                ToolTip = 'specifies the Address 3';
                Importance = Promoted;
            }
        }
        addafter("Order No.")
        {
            //JCO-91>>
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a shipment related to a Consignment(B2B) Sales';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
    }
}