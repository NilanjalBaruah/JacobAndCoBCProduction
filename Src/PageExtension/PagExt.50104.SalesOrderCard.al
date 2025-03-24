pageextension 50104 "JCO Sales Order Card" extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("JCO Purchase Order No."; Rec."JCO Purchase Order No.")
            {
                ApplicationArea = All;
            }
            field("JCO Vendor No."; Rec."JCO Vendor No.")
            {
                ApplicationArea = All;
            }
            field("SWISS VAT ARCJCO"; Rec."SWISS VAT ARCJCO")
            {
                ToolTip = 'Specifies, if the Order applied with Swiss VAT';
                ApplicationArea = All;
            }
            //JCO-91>>
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Sales order to a Consignment Customer (B2B). This field is updated automatically upon sending Consignment Items';
                ApplicationArea = All;
            }
            field("Archive Ordr on Shpmt ARCJCO"; Rec."Archive Ordr on Shpmt ARCJCO")
            {
                ToolTip = 'If Marked, Version of the Consignment Order will be archived, automatically, when a Consignment is Shipped to Business (from Consignment Shipment Details screen)';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
        addafter("Sell-to Address 2")
        {
            field("JCO Address 3"; Rec."JCO Address 3")
            {
                ApplicationArea = All;
            }
        }
        //>>Prepay
        addafter("Prepayment %")
        {
            field("Prepayment Amount ARCJCO"; Rec."Prepayment Amount ARCJCO")
            {
                ToolTip = 'Prepayment Amount';
                Caption = 'Prepayment Amount';
                ApplicationArea = All;
            }
        }
        //Prepay <<
    }

    actions
    {
        modify("Pick Instruction")
        {
            Caption = 'Packing List';
            ToolTip = 'Packing List comprising of Items in the Sales Order Line';
        }
        // Add changes to page actions here
        //JCO-91>>
        addbefore("Request Approval")
        {
            group(Conignment)
            {
                action(ConsignmentShipmentDetailsARCJCO)
                {
                    Image = SalesShipment;
                    Caption = 'Consignment Shipment Details';
                    ToolTip = 'Use this button to open the page to log details of serials of Items to Ship or Shipped to Business (B2B)';
                    ApplicationArea = All;
                    RunObject = page "Consignments Shipment ARCJOC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F2";
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(ConfirmConsignmentSaleARCJCO)
                {
                    Image = Sales;
                    Caption = 'Confirm Consignment Sales';
                    ToolTip = 'Use this button to open the page to log details of serials of Items Sold By Business (B2B)';
                    ApplicationArea = All;
                    RunObject = page "Consignments Sales ARCJOC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F10";
                    Promoted = true;
                    PromotedCategory = Process;

                }
                action(ConfirmConsignmentReturnARCJCO)
                {
                    Image = Return;
                    Caption = 'Confirm Consignment Return';
                    ToolTip = 'Use this button to open the page to log details of serials of Items Returned By Business (B2B)';
                    ApplicationArea = All;
                    RunObject = page "Consignments Return ARCJOC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F11";
                    Promoted = true;
                    PromotedCategory = Process;

                }
                action(ConsignmentToInvoiceARCJCO)
                {
                    Image = SalesInvoice;
                    Caption = 'Consignments to Invoice';
                    ToolTip = 'Use this button to open the page to log details of serials of Items ready for Invoicing to Business (B2B)';
                    ApplicationArea = All;
                    RunObject = page "Consignments To Invoice ARCJOC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F3";
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(ConsignmentHitoryARCJCO)
                {
                    Image = History;
                    Caption = 'Consignment History';
                    ToolTip = 'Use this button to open the list showing all serial numbers consigned to Business';
                    ApplicationArea = All;
                    RunObject = page "Ord Consignments Hist ARCJOC";
                    RunPageLink = "Document Type" = field("Document Type"),
                                    "Document No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F10";
                    Promoted = true;
                    PromotedCategory = Process;
                }

            }
        }
        //JCO-91<<
        addafter(ProformaInvoice)
        {
            action(MemoJCO)
            {
                Image = Report;
                Caption = 'Memo PDF';
                ToolTip = 'Prints the Memo PDF';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesConsignmentMgmt: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesHeader.SetRange("Document Type", Rec."Document Type");
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.FindFirst();
                    SalesConsignmentMgmt.PrintMemoJCO(SalesHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}