tableextension 50104 "Jco Sales Inv Header Ext" extends "Sales Invoice Header"
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
        //JCO-91>>
        field(50201; "Consignment Order ARCJCO"; Boolean)
        {
            Caption = 'Consignment Order';
            DataClassification = CustomerContent;
        }
        //JCO-91<<
        field(50204; "Sub Document Type ARCJCO"; Code[20])
        {
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
            TableRelation = "Sub Doc. Type ARCJCO";
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