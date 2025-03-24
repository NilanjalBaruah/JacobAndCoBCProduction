namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using JCO.JCO;
using Microsoft.Sales.History;

page 50215 "Invoiced Consignments ARCJOC"
{
    ApplicationArea = All;
    Caption = 'Invoiced Consignments';
    PageType = List;
    SourceTable = "Consignment Detail ARCJCO";
    SourceTableView = sorting("Consignment Status", "Posted Invoice No.") where("Consignment Status" = filter("Invoiced to Business"));
    UsageCategory = History;
    DataCaptionFields = "Document No.", "Document Line No.", "Item No.";
    //Editable = false;
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
                    Visible = false;
                }
                field("Posted Invoice No."; Rec."Posted Invoice No.")
                {
                    Editable = false;
                    ToolTip = 'This is the Posted Invoice Number of the Invoice sent to Business';
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    Editable = false;
                    ToolTip = 'This is the Posting Date of the Invoice Number of the Invoice sent to Business';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Sales Order No';
                    ToolTip = 'Specifies the value of the Document No. of the Consignment';
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    Caption = 'Sales Order Line No';
                    ToolTip = 'Specifies the value of the Document Line No. of the Consignment (e.g. Sales Order Line No.)';
                    ApplicationArea = All;
                    Visible = false;
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date';
                    ApplicationArea = All;
                }
                field("B2B Sales Date"; Rec."B2B Sales Date")
                {
                    ToolTip = 'Date on which Business Sold the Item';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(SalesInvoicePrint)
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = PrintDocument;
                PromotedOnly = true;
                Enabled = PrintEnabled;
                Caption = 'Sales Invoice';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgmtJCOARC.PrintSalesInvoice(Rec);
                end;
            }
        }
        area(Navigation)
        {
            action("Show Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Invoice';
                Image = View;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'Open the Posted Sales Invoice that the selected line exists on.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader.Get(Rec."Posted Invoice No.");
                    Page.Run(Page::"Posted Sales Invoice", SalesInvHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PrintEnabled := (Rec."Posted Invoice No." <> '');
    end;

    var
        PrintEnabled: Boolean;
}