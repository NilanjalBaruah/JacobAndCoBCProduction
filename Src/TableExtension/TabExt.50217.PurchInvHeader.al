tableextension 50217 "PurchaseInvHeader JCOExt" extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50201; "Consignment Order ARCJCO"; Boolean)
        {
            Caption = 'Consignment Order';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}