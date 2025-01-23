namespace JCO.JCO;

using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Finance.Currency;

tableextension 50210 "TransferShptLine Extn ARCJCO" extends "Transfer Shipment Line"
{
    fields
    {
        field(50201; "Reason Code JCOARC"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(50202; "Currency Code JCOARC"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50203; "Unit Price JCOARC"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code JCOARC";
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(50204; "Line Amount JCOARC"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code JCOARC";
            AutoFormatType = 2;
            Caption = 'Line Amount';
        }
    }
}