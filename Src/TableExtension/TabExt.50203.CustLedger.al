namespace JCO.JCO;

using Microsoft.Sales.Receivables;
using Microsoft.Foundation.Address;

tableextension 50203 "CustLedgerEntry Extn ARCJCO" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50100; "Description 2 ARCJCO"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
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