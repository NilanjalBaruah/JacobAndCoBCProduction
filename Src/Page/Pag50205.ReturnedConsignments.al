namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using JCO.JCO;

page 50205 "Returned Consignments ARCJOC"
{
    ApplicationArea = All;
    Caption = 'Returned Consignment Details';
    PageType = List;
    SourceTable = "Consignment Detail ARCJCO";
    SourceTableView = sorting("Consignment Status") where("Consignment Status" = filter("Returned By Business"));
    UsageCategory = History;
    DataCaptionFields = "Document No.", "Document Line No.", "Item No.";
    Editable = false;
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
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. of the Consignment';
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Line No. of the Consignment (e.g. Sales Order Line No.)';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. of the document Line (e.g. Sales Line)';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description of the document Line (e.g. Sales Line) ';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code the document Line (e.g. Sales Line)';
                    ApplicationArea = All;
                }
                field("Consignment Location Code"; Rec."Consignment Location Code")
                {
                    ToolTip = 'Specifies the value of the Consignment Location Code the customer in document Line(e.g. Sales Line)';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the Quantity of Serial number';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the Unit of Measurement of the Serial';
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. of the Item';
                    ApplicationArea = All;
                }
                field("Shipment Confirmed By"; Rec."Shipment Confirmed By")
                {
                    ToolTip = 'Specifies the Name of the User who confirm the Shipment.';
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    Caption = 'Shipment Comment';
                    ToolTip = 'Specifies theComment, if user wants to add to the line';
                    ApplicationArea = All;
                }
                field("Confirm Sold by Custromer"; Rec."Confirm Sold by Custromer")
                {
                    ToolTip = 'Sales Confirmed By Customer';
                    ApplicationArea = All;
                }
                field("B2B Sales Date"; Rec."B2B Sales Date")
                {
                    ToolTip = 'Date on which Business Sold the Item';
                    ApplicationArea = All;
                }
                field("Item with Business"; Rec."Item with Business")
                {
                    Editable = false;
                    ToolTip = 'Show TRUE or CHECKED, if the Item is shipped to Consignee';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(ReturnedMemo)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                Caption = 'Credit Memo';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    // SalesConsignmentMgmtJCOARC.CreateAndPostItemReclassJournalAndUpdateConsignment(Rec, false);
                end;
            }
        }
    }
}