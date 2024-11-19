namespace JCO.JCO;

using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.AuditCodes;

tableextension 50209 "TransferLine Extn ARCJCO" extends "Transfer Line"
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