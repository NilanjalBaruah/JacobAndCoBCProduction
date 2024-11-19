namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Item;

pageextension 50224 ItemListJCO extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ToolTip = 'Specifies the Tax Group assigned to the Item. This is used for SALES TAX calculation';
                ApplicationArea = All;
            }
        }
        addbefore("Substitutes Exist")
        {
            field("Reserved Qty. on Sales Orders"; Rec."Reserved Qty. on Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Inventory Reserved in Sales';
                Editable = false;
            }
            field("Qty. on Damage Location"; Rec."Qty. on Damage Location JCOARC")
            {
                ApplicationArea = All;
                Editable = false;
            }
            //field(SelleableQty; Rec.Inventory - rec."Reserved Qty. on Sales Orders" - Rec."Qty. on Damage Location JCOARC")
            field(AvailableForSale; AvailableForSale)
            {
                ApplicationArea = All;
                Caption = 'Available for Sales';
                DecimalPlaces = 0 : 0;
            }
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
    }
    trigger OnAfterGetRecord()
    begin
        AvailableForSale := Rec.Inventory - Rec."Reserved Qty. on Sales Orders" - Rec."Qty. on Damage Location JCOARC";
        if AvailableForSale < 0 then
            AvailableForSale := 0;
    end;

    var
        AvailableForSale: Decimal;
}