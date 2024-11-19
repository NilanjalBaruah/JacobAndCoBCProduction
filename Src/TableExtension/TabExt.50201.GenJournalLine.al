namespace JCO.JCO;

using Microsoft.Finance.GeneralLedger.Journal;

tableextension 50201 "GenJournalLine Extn ARCJCO" extends "Gen. Journal Line"
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