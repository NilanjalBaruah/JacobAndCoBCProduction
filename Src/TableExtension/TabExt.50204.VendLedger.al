namespace JCO.JCO;

using Microsoft.Purchases.Payables;

tableextension 50204 "VendLedgerEntry Extn ARCJCO" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50100; "Description 2 ARCJCO"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
    }

}