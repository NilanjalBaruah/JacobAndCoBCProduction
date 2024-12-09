namespace JCO_BCDev_JCO.JCO_BCDev_JCO;

using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Item;

pageextension 50223 ItemCardJCO extends "Item Card"
{
    layout
    {
        addafter(Inventory)
        {
            group(SaleableInventory)
            {
                Caption = 'JCO Saleable Inventory';
                field("Reserved Qty. on Sales Orders"; Rec."Reserved Qty. on Sales Orders")
                {
                    ApplicationArea = All;
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
                    Editable = false;
                    Caption = 'Available for Sale';
                    DecimalPlaces = 0 : 0;
                }
            }
        }
        //JCO11122024>>
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        //JCO11122024<<

        addafter(Description)
        {
            field(ProductEnvironment; Rec."Product Environment JCOARC")
            {
                ToolTip = 'This is used for assigning the Assembly Item linked to the Packaging materials for this Item';
                ApplicationArea = All;
                Visible = True;
            }
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