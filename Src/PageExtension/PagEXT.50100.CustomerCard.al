// SGN_15MAR24  Created this Customer Extension to add the new field in Customer Card>>
pageextension 50100 "JCO CustomerCardExtn" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Report Statement")
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
                    JCOSubsciption.PrintJCOStatement(Rec);
                end;
            }
        }
    }
}