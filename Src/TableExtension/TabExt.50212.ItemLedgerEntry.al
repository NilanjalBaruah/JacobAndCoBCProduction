namespace JCO.JCO;

using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.AuditCodes;

tableextension 50212 "ItemLedgEntry Extn ARCJCO" extends "Item Ledger Entry"
{
    fields
    {
        field(50201; "Reason Code JCOARC"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(50202; "Damage/Repair Location ARCJCO"; Boolean)
        {
            Caption = 'Damage/Repair Location';
        }
    }
}