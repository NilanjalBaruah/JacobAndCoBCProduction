namespace JCO.JCO;

using Microsoft.Inventory.Location;

pageextension 50201 "LocationList Extn ARCJCO" extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Consignment Location"; Rec."Consignment Location ARCJCO")
            {
                ToolTip = 'Mark True, if the Location belongs to one of your customers and/or Vendor. Sales or Purchase cannot be happened to/from this location';
                ApplicationArea = All;
            }
            field("Consignment Customer No."; Rec."Consignment Customer No. ARJCO")
            {
                ToolTip = 'This location will be dedicated to this customer. One Customer can only have one location linked';
                ApplicationArea = All;
            }
            field("Consignment Vendor No."; Rec."Consignment Vendor No. ARJCO")
            {
                ToolTip = 'This location will be dedicated to this Vendor. One Vendor can only have one location linked';
                ApplicationArea = All;
            }
            field("Sales/Purchase Location ARCJCO"; Rec."Sales/Purchase Location ARCJCO")
            {
                ToolTip = 'Checked, if this location will be allowed to do any Sales or Purchase Transactions';
                ApplicationArea = All;
            }
            field("Damage/Repair Location ARCJCO"; Rec."Damage/Repair Location ARCJCO")
            {
                ToolTip = 'Check, if this location will be Used to keep Damaged/Returned Items. This will be used for reporting and analysis purpose';
                ApplicationArea = All;
            }
            field("Allow Trnsfer Ord ToFro ARCJCO"; Rec."Allow Trnsfer Ord ToFro ARCJCO")
            {
                ToolTip = 'Specify, if To and From Location Transfer (Transfer Order) is allowed for this location. This will bypass the restriction of using consignment locations in Transfer Orders';
                ApplicationArea = All;
            }
            field("Location Group Code ARCJCO"; Rec."Location Group Code ARCJCO")
            {
                ToolTip = 'Specify the Location Group, this location belongs to';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(AssignTaxArea)
        {
            action(UpdateLocGrp)
            {
                Caption = 'Update Location Group in Ledger Entry';
                ApplicationArea = All;
                trigger OnAction()
                var
                    InventoryMgmtJCOARC: Codeunit "InventoryMgmt JCOARC";
                begin
                    InventoryMgmtJCOARC.UpdateLedgerLocatiionGroup();
                end;
            }
        }
    }
}