namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using Microsoft.Projects.Project.Job;
using JCO.JCO;
using Microsoft.Inventory.Item;

page 50200 "Consignments Shipment ARCJOC"
{
    ApplicationArea = All;
    Caption = 'Consignments Shipment';
    PageType = List;
    SourceTable = "Consignment Detail ARCJCO";
    SourceTableView = sorting("Consignment Status") where("Consignment Status" = filter(" "));
    UsageCategory = None;
    DataCaptionFields = "Document No.", "Document Line No.", "Item No.";
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
                    Visible = false;
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
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the Unit of Measurement of the Serial';
                    ApplicationArea = All;
                    Visible = false;
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
                }
                field("Shipment Confirmed By"; Rec."Shipment Confirmed By")
                {
                    ToolTip = 'Specifies the Name of the User who confirmed the Shipment.';
                    ApplicationArea = All;

                    //11/03/2024    >>
                    trigger OnValidate()
                    var
                        Item: Record Item;
                    begin
                        if Rec."Serial No." = '' then begin
                            Item.Get(Rec."Item No.");
                            if Item."Item Tracking Code" <> '' then
                                Error('Serial Number must have a value!!!');
                        end;
                    end;
                    //11/03/2024    <<
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies theComment, if user wants to add to the line';
                    ApplicationArea = All;
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
                    ToolTip = 'Show TRUE or CHECKED, if the Item is shipped to Consignee';
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
            action(ConfirmShipment)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Shipment;
                Caption = 'Confirm Shipment information';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgmtJCOARC.CreateAndPostItemReclassJournalAndUpdateConsignment(Rec, true);
                end;
            }
        }
    }
}
