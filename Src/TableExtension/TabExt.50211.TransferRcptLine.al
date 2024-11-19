namespace JCO.JCO;

using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.AuditCodes;

tableextension 50211 "TransferRcptLine Extn ARCJCO" extends "Transfer Receipt Line"
{
    fields
    {
        field(50201; "Reason Code JCOARC"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
    }
}