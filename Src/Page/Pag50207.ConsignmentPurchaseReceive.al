namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using JCO.JCO;

page 50207 "Consignments Receive JCOARC"
{
    ApplicationArea = All;
    Caption = 'Update Receipt of Shipped Items';
    PageType = List;
    SourceTable = "Purch. Consignment Det ARCJCO";
    SourceTableView = sorting("Consignment Status") where("Consignment Status" = filter("Shipped By Vendor"));
    UsageCategory = None;
    DataCaptionFields = "Document No.", "Document Line No.", "Item No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Consignment Status"; Rec."Consignment Status")
                {
                    ToolTip = ' Status of Consignment for this Serial No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type of the Consignment. (e.g. Purchase Order)';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. of the Consignment';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Line No. of the Consignment (e.g. Purchase  Order Line No.)';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. of the document Line (e.g. Purchase Line)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description of the document Line (e.g. Purchase Line) ';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code the document Line (e.g. Purchase Line)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consignment Location Code"; Rec."Consignment Location Code")
                {
                    ToolTip = 'Specifies the value of the Consignment Location Code the customer in document Line(e.g. Purchase Line)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the Quantity of Serial number';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the Unit of Measurement of the Serial';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base). This is Quantity converted to Purchase Unit of Measure, if any';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. of the Item';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Shipped by Vendor"; Rec."Date Shipped by Vendor")
                {
                    ToolTip = 'This is the date the Item was shipped by Vendor';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipment Received at Location"; Rec."Shipment Received")
                {
                    ToolTip = 'Confirm whether the shipment Received at location';
                    ApplicationArea = All;
                }
                field("Date Received"; Rec."Receipt Date")
                {
                    ToolTip = 'Specifies the Date when the item received at Location';
                    ApplicationArea = All;
                }
                field("Receipt Confirmed By"; Rec."Receipt Confirmed By")
                {
                    ToolTip = 'Specifies the Name of the User who confirm the physical Receipt of the Item';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the Comment, if user wants to add to the line';
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                // {
                //     ToolTip = 'The Incoming entry applied to this Receipt Serial Number';
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                // }
                field("Item In Transit"; Rec."Item In Transit")
                {
                    Editable = false;
                    ToolTip = 'Show TRUE or CHECKED, if the Item is Item In Transit';
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Consigned Item Entry No."; Rec."Consigned Item Entry No.")
                // {
                //     ToolTip = 'The Item Ledger Entry No. that sent the Consignment Item';
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                // }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ConfirmReceivedAtLocation)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Receipt;
                Caption = 'Confirm Receipt of Shipped Items';
                trigger OnAction()
                var
                    PurchConsignmentMgmt: Codeunit "PurchaseConsignmentMgmt JCOARC";
                begin
                    PurchConsignmentMgmt.CreateAndPostItemJournalAndUpdateConsignment(Rec, true);
                end;
            }
        }
    }
}