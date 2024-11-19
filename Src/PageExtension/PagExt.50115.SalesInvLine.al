pageextension 50115 "JCO Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("JCO RTV"; Rec."JCO RTV")
            {
                ToolTip = 'specifies the JCO RTV Value';
                ApplicationArea = All;
            }
            field("JCO SFM"; Rec."JCO SFM")
            {
                ToolTip = 'Fetch values from Quantity - RTV';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}