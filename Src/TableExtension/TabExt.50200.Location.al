namespace JCO.JCO;

using Microsoft.Inventory.Location;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;

tableextension 50200 "Location Extn ARCJCO" extends Location
{
    fields
    {
        field(50100; "Consignment Location ARCJCO"; Boolean)
        {
            Caption = 'Consignment Location';
            DataClassification = CustomerContent;
        }
        field(50101; "Consignment Customer No. ARJCO"; Code[20])
        {
            Caption = 'Consignment Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50102; "Consignment Vendor No. ARJCO"; Code[20])
        {
            Caption = 'Consignment Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50103; "Sales/Purchase Location ARCJCO"; Boolean)
        {
            Caption = 'Sales/Purchase Location';
            DataClassification = CustomerContent;
        }
        field(50104; "Damage/Repair Location ARCJCO"; Boolean)
        {
            Caption = 'Damage/Repair Location';
            DataClassification = CustomerContent;
        }
        field(50105; "Allow Trnsfer Ord ToFro ARCJCO"; Boolean)
        {
            Caption = 'Allow Transfer (Order) From and To this location';
            DataClassification = CustomerContent;
        }
        field(50106; "Location Group Code ARCJCO"; Code[20])
        {
            Caption = 'Location Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Location Group ARCJCO";
        }
    }
}