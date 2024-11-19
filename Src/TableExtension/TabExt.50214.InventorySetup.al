namespace JCO.JCO;

using Microsoft.Inventory.Setup;

tableextension 50214 "InvtSetup Extn ARCJCO" extends "Inventory Setup"
{
    fields
    {
        field(50201; "Reason Code required Trnfr ARC"; Boolean)
        {
            Caption = 'Reason Code required in Transfer Order';
            DataClassification = CustomerContent;
        }
    }
}