namespace JCO.JCO;

using Microsoft.Inventory.Ledger;
using System.Security.AccessControl;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Foundation.Address;

tableextension 50212 "ItemLedgEntry Extn ARCJCO" extends "Item Ledger Entry"
{
    fields
    {
        field(50201; "Reason Code JCOARC"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(50202; "Damage/Repair Location ARCJCO"; Boolean)
        {
            Caption = 'Damage/Repair Location';
        }
        field(50106; "Location Group Code ARCJCO"; Code[20])
        {
            Caption = 'Location Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Location Group ARCJCO";
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
        field(50212; "User Name ARCJCO"; Code[50])
        {
            Caption = 'User Name';
            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where("User Security ID" = field(SystemCreatedBy)));
            Editable = false;
        }
    }
}