pageextension 50103 "JCO Purchase Order Card" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("JCO Sales Quote No."; Rec."JCO Sales Quote No.")
            {
                ApplicationArea = All;
            }
            field("JCO Sales Order No."; Rec."JCO Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("JCO Sell-to Customer No."; Rec."JCO Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Sales order to a Consignment Customer (B2B). This field is updated automatically upon sending Consignment Items';
                ApplicationArea = All;
            }
            field("Archive Ordr on Rcpt ARCJCO"; Rec."Archive Ordr on Rcpt. ARCJCO")
            {
                ToolTip = 'If Marked, Version of the Consignment Order will be archived, automatically, when a Consignment is Received)';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addbefore("Request Approval")
        {
            group(Conignment)
            {
                action(ConsignmentShipmentDetailsARCJCO)
                {
                    Image = ShipmentLines;
                    Caption = 'Update Shipment Sent By Vendor';
                    ToolTip = 'Use this button to open the page to log details of serials of Items Shipped by Vendor';
                    ApplicationArea = All;
                    RunObject = page "Cons. Shipped By Vendor JCOARC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(ConsignmentRcptDetailsARCJCO)
                {
                    Image = Receipt;
                    Caption = 'Update Receipt of Shipped Items';
                    ToolTip = 'Use this button to open the page to log details of serials of Items physically received at location';
                    ApplicationArea = All;
                    RunObject = page "Consignments Receive JCOARC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(ConsignmentHitoryARCJCO)
                {
                    Image = History;
                    Caption = 'Consignment History';
                    ToolTip = 'Use this button to open the list showing all serial numbers consigned by Vendor';
                    ApplicationArea = All;
                    RunObject = page "P Ord Consignments Hist ARCJOC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F10";
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
    }

    var
        myInt: Integer;
}