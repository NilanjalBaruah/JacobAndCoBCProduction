namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using Microsoft.Projects.Project.Job;
using JCO.JCO;

page 50204 "Consignments Return ARCJOC"
{
    ApplicationArea = All;
    Caption = 'Consignments Retun';
    PageType = List;
    SourceTable = "Consignment Detail ARCJCO";
    SourceTableView = sorting("Consignment Status") where("Consignment Status" = filter("Shipped to Business"));
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
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type of source Entry (Sale/Purchase)';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type of the Consignment. (e.g. Sales Order)';
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
                    ToolTip = 'Specifies the value of the Document Line No. of the Consignment (e.g. Sales Order Line No.)';
                    ApplicationArea = All;
                    Editable = false;
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
                    ToolTip = 'Specifies the value of the Item No. of the document Line (e.g. Sales Line)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description of the document Line (e.g. Sales Line) ';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code the document Line (e.g. Sales Line)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consignment Location Code"; Rec."Consignment Location Code")
                {
                    ToolTip = 'Specifies the value of the Consignment Location Code the customer in document Line(e.g. Sales Line)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the Quantity of Serial number';
                    ApplicationArea = All;
                    Visible = false;
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
                    ToolTip = 'Specifies the value of the Quantity (Base). This is Quantity converted to Sales Unit of Measure, if any';
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
                field("Shipment Confirmed By"; Rec."Shipment Confirmed By")
                {
                    ToolTip = 'Specifies the Name of the User who confirm the Shipment.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies theComment, if user wants to add to the line';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'The Incoming entry applied to this Shiped Serial Number';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Item with Business"; Rec."Item with Business")
                {
                    Editable = false;
                    ToolTip = 'Show TRUE or CHECKED, if the Item is shipped to Consignee';
                    ApplicationArea = All;
                }
                field("Confirm Returned by Custromer"; Rec."Confirm Returned by Custromer")
                {
                    ToolTip = 'Confirm Returned By Customer';
                    ApplicationArea = All;
                }
                field("Date of Return"; Rec."Date of Return")
                {
                    ToolTip = 'Date on which Business Returned the Item';
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specify a Reason for Return';
                    ApplicationArea = All;
                }
                field("Consigned Item Entry No."; Rec."Consigned Item Entry No.")
                {
                    ToolTip = 'The Item Ledger Entry No. that sent the Consignment Item';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ConfirmReturnByCustomer)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Return;
                Caption = 'Confirm Return by Customer';
                trigger OnAction()
                var
                    ConsignmentMgmtReturnJCOARC: Codeunit "ConsignmentReturnMgmt JCOARC";
                begin
                    ConsignmentMgmtReturnJCOARC.CreateAndPostItemReclassJournalAndUpdateConsignment(Rec);
                end;
            }
        }
    }
}