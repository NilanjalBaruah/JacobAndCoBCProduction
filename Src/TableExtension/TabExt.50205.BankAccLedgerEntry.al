namespace JCO.JCO;

using Microsoft.Bank.Ledger;

tableextension 50205 "BankAccLedgerEntry Extn ARCJCO" extends "Bank Account Ledger Entry"
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