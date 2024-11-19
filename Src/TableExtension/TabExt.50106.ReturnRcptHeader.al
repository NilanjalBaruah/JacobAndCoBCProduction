tableextension 50106 "Jco Return Rcpt Header Ext" extends "Return Receipt Header"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "JCO Address 3"; Text[100])
        {
            Caption = 'Address 3';
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