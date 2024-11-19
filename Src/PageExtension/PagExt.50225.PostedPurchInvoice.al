namespace JCO.JCO;

using Microsoft.Purchases.History;
using JCO_BCDev_JCO.JCO_BCDev_JCO;

pageextension 50225 "PPurchInvoice Extn ARCJCO" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Invoice related to a Consignment Purchase';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
    }
    actions
    {
        // Add changes to page actions here
        addbefore("&Invoice")
        {
            group(Conignment)
            {
                action(ConsignmentHitoryARCJCO)
                {
                    Image = History;
                    Caption = 'Consignment History';
                    ToolTip = 'Use this button to open the list showing all serial numbers consigned by Vendor';
                    ApplicationArea = All;
                    RunObject = page "P Ord Consignments Hist ARCJOC";
                    RunPageLink = "Document No." = field("Order No.");
                    ShortcutKey = "Ctrl+Alt+F10";
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }

    }

}