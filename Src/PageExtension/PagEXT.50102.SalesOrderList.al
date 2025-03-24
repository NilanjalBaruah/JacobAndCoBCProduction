pageextension 50102 "JCO Sales order List" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("JCO Purchase Order No."; Rec."JCO Purchase Order No.")
            {
                ApplicationArea = All;
            }
            field("JCO Vendor No."; Rec."JCO Vendor No.")
            {
                ApplicationArea = All;
            }
            //JCO-91>>
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Consignment(B2B) Sales Order.';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
    }

    actions
    {
        modify("Pick Instruction")
        {
            Caption = 'Packing List';
            ToolTip = 'Packing List comprising of Items in the Sales Order Line';
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}