namespace JCO.JCO;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;

tableextension 50215 "Item Extn ARCJCO" extends Item
{
    fields
    {
        field(50201; "Qty. on Damage Location JCOARC"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."Quantity" where("Item No." = field("No."),
                                                                            "Damage/Repair Location ARCJCO" = filter(true),
                                                                            "Open" = filter(true),
                                                                            "Location Code" = field("Location Filter"),
                                                                            "Posting Date" = field("Date Filter")));
            Caption = 'Quantity on Damage Location';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }
}