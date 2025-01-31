namespace JCO.JCO;

using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Item;

tableextension 50224 "ItemAttValMapp Extn ARCJCO" extends "Item Attribute Value Mapping"
{
    fields
    {
        field(50201; "Description JCOARC"; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("No.")));
            Editable = false;
        }
        field(50202; "Attrubute Name JCOARC"; Text[250])
        {
            Caption = 'Attrubute Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Attribute".Name where(ID = field("Item Attribute ID")));
            Editable = false;
        }
        field(50203; "Attrubute Value JCOARC"; Text[250])
        {
            Caption = 'Attrubute Value';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Attribute Value"."Value" where(ID = field("Item Attribute Value ID")));
            Editable = false;
        }
    }
}