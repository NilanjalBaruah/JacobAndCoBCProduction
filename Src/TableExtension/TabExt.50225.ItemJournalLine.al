namespace JCO.JCO;

using Microsoft.Foundation.Address;
using Microsoft.Inventory.Journal;

tableextension 50225 "ItemJournalLine Extn ARCJCO" extends "Item Journal Line"
{
    fields
    {
        field(50207; "Ship-to Address JCO"; Text[100])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(50208; "Ship-to County JCO"; Text[30])
        {
            Caption = 'Ship to State';
            DataClassification = CustomerContent;
        }
        field(50209; "Ship-to Post Code JCO"; Text[20])
        {
            Caption = 'Ship to Zip Code';
            DataClassification = CustomerContent;
        }
        field(50210; "Ship-to Cntry/Region Code JCO"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50211; "Ship-from Cntry/Regin Code JCO"; Code[10])
        {
            Caption = 'Ship-from Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
    }
}