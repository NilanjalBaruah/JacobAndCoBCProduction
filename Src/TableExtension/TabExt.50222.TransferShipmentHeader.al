namespace JCO.JCO;

using Microsoft.Inventory.Transfer;
using Microsoft.Finance.Currency;
using Microsoft.Sales.Customer;

tableextension 50222 "TransferShptHeader Extn ARCJCO" extends "Transfer Shipment Header"
{
    fields
    {
        field(50201; "Customer No. JCOARC"; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(50202; "Currency Code JCOARC"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

        }
        field(50203; "Currency Factor JCOARC"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50204; "Your Reference JCOARC"; Text[50])
        {
            Caption = 'Your Reference';
        }
    }
}