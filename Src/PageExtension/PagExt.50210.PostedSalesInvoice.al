namespace JCO.JCO;

using Microsoft.Sales.History;
using JCO_BCDev_JCO.JCO_BCDev_JCO;

pageextension 50210 "PSalesInvoice Extn ARCJCO" extends "Posted Sales Invoice"
{
    layout
    {
        modify("Sell-to Address")
        {
            Importance = Promoted;
        }
        modify("Sell-to Address 2")
        {
            Importance = Promoted;
        }
        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ToolTip = 'specifies the Address 3';
                ApplicationArea = All;
            }
        }
        addafter(Closed)
        {
            field("SWISS VAT ARCJCO"; Rec."SWISS VAT ARCJCO")
            {
                ToolTip = 'Specifies, if the Invoice is applied with Swiss VAT';
                ApplicationArea = All;
                Visible = false;
            }
            //JCO-91>>
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Invoice related to a Consignment(B2B) Sales';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
    }
    actions
    {
        // Add changes to page actions here
        addbefore(Invoice)
        {
            group(Conignment)
            {
                action(ConsignmentHitoryARCJCO)
                {
                    Image = History;
                    Caption = 'Consignment History';
                    ToolTip = 'Use this button to open the list showing all serial numbers consigned to Business';
                    Visible = ConsignmentHistoryEnabled;
                    ApplicationArea = All;
                    RunObject = page "Ord Consignments Hist ARCJOC";
                    RunPageLink = "Posted Invoice No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F10";
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ConsignmentHistoryEnabled := Rec."Consignment Order ARCJCO";
    end;

    var
        ConsignmentHistoryEnabled: Boolean;
}