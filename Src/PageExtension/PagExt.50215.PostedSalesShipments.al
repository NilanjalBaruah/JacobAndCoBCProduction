namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Sales.History;

pageextension 50215 PostedSalesShipments extends "Posted Sales Shipments"
{
    layout
    {


        addafter("Sell-to Customer Name")
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
