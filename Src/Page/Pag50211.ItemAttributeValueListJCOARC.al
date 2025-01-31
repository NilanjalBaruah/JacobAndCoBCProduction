
page 50211 "Item Attr ValueList JCOARC"
{
    ApplicationArea = All;
    Caption = 'Item Attribute Value List';
    PageType = List;
    SourceTable = "Item Attribute Value Mapping";
    Editable = false;
    DeleteAllowed = false;
    SourceTableView = where("Table ID" = filter(27));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Item No.';
                }
                field("Description JCOARC"; Rec."Description JCOARC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description of the Item No.';
                }
                field("Attrubute Name JCOARC"; Rec."Attrubute Name JCOARC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Attribute';
                }
                field("Attrubute Value JCOARC"; Rec."Attrubute Value JCOARC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Value of the Attribute ';
                }
            }
        }
    }
    actions
    {
    }
}
