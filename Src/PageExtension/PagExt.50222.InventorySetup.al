namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Setup;

pageextension 50222 InventorySetupJCO extends "Inventory Setup"
{
    layout
    {
        addafter(Location)
        {
            field("Reason Code required Trnfr ARC"; Rec."Reason Code required Trnfr ARC")
            {
                ToolTip = 'Specifies if it is mandatory to specify a reason code while making any transfer order';
                ApplicationArea = All;
            }
        }
    }
}