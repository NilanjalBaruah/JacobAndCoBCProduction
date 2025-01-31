page 50212 "Location Groups ARCJCO"
{
    ApplicationArea = All;
    Caption = 'Location Groups';
    PageType = List;
    SourceTable = "Location Group ARCJCO";
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
                    ToolTip = 'Specifies the Code for the Location Group as Unique Identifier.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description of the Location Group.', Comment = '%';
                }
            }
        }
    }
}