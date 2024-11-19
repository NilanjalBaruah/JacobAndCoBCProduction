namespace JCO.JCO;

using Microsoft.Finance.GeneralLedger.Ledger;

tableextension 50202 "GLEntry Extn ARCJCO" extends "G/L Entry"
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