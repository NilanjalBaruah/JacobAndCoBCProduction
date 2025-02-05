// SGN_15MAR24  Created this Customer Extension to add the new field in Customer Card>>
pageextension 50227 "JCO CustomerListExtn" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ToolTip = 'Specifies Tax Area Code';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Email)
        {
            action(StatementJCO)
            {
                Image = BankAccountStatement;
                Caption = 'JCO Customer Statement';
                ToolTip = 'This action runs the Customer Statement specific to Jacob & Co LLC';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    JCOSubsciption: Codeunit "JCO Subscriptions";
                begin
                    JCOSubsciption.PrintJCOStatementAll();
                end;
            }
        }
    }
}