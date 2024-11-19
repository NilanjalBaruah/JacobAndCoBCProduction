tableextension 50105 "Jco Sales Cr.memo Head Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        // Add changes to table fields here
        field(50102; "JCO Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(50103; "SWISS VAT ARCJCO"; Boolean)
        {
            Caption = 'SWISS VAT';
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