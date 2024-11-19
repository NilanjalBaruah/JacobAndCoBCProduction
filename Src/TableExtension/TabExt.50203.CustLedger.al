namespace JCO.JCO;

using Microsoft.Sales.Receivables;

tableextension 50203 "CustLedgerEntry Extn ARCJCO" extends "Cust. Ledger Entry"
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