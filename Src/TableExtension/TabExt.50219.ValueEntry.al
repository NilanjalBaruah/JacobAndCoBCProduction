tableextension 50219 "JCO Value Entry" extends "Value Entry"
{
    fields
    {
        field(50201; "Serial No. JCO"; Code[50])
        {
            Caption = 'Serial No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Serial No." where("Entry No." = field("Item Ledger Entry No."), "Entry Type" = field("Item Ledger Entry Type")));
        }
    }
}