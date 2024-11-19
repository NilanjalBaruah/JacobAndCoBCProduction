namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Ledger;

pageextension 50221 ItemLedgEntriesJCO extends "Item Ledger Entries"
{
    layout
    {
        addafter(Quantity)
        {
            field("Reason Code JCOARC"; Rec."Reason Code JCOARC")
            {
                ToolTip = 'Specifies the Reason Code for teh transaction';
                ApplicationArea = All;
            }
            field("Damage/Repair Location ARCJCO"; Rec."Damage/Repair Location ARCJCO")
            {
                ToolTip = 'Tagged, if the inventory in the line in transacted to/from a Damage habdling location';
                ApplicationArea = All;
            }
        }
    }

}
