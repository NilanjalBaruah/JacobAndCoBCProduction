page 50216 "Sub Document Type ARCJCO"
{
    ApplicationArea = All;
    Caption = 'Sub Document Types';
    PageType = List;
    SourceTable = "Sub Doc. Type ARCJCO";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Code for the Sub Document Type (To be used in Transactions as Unique Identifier.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description of the Sub Document Type.', Comment = '%';
                }
                field("Default to Document Type"; Rec."Default to Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies, if this Sub Document Type is defaulted to this Document Type.', Comment = '%';
                }
            }
        }
    }
}