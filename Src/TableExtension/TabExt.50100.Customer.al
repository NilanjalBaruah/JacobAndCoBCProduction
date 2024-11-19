//Documentation format <<Developer code_DDMONthYY Description of the task>>
// <<SGN_15MAR24  Created this Extension to add the additional fields for the customer master for JCO>>
tableextension 50100 "JCO Customer Extn" extends Customer
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
    var
        myInt: Integer;
}