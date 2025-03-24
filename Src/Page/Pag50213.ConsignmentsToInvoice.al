namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Reporting;
using Microsoft.Sales.Document;
using JCO.JCO;

page 50213 "Consignments To Invoice ARCJOC"
{
    ApplicationArea = All;
    Caption = 'Consignments To Invoice';
    PageType = List;
    SourceTable = "Consignment Detail ARCJCO";
    SourceTableView = sorting("Consignment Status") where("Consignment Status" = filter("Sold By Business"));
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("B2B Sales Date"; Rec."B2B Sales Date")
                {
                    ToolTip = 'Date on which Business Sold the Item';
                    ApplicationArea = All;
                }
                field("Confirm Invoice To Customer"; Rec."Confirm Invoice To Customer")
                {
                    ToolTip = 'Confirm Invoice To Customer';
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Date on Invoice is posted';
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
            action(UpdateInvoicedStatus)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;
                Caption = 'Validate Invoiced Consignments';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgmtJCOARC.UpdateInvoicedConsignments(Rec);
                end;
            }

            // action(PreviewPostInvoice)
            // {
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = PreviewChecks;
            //     Caption = 'Preview Post';
            //     trigger OnAction()
            //     var
            //         SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
            //     begin
            //         SalesConsignmentMgmtJCOARC.PreviewPostConsignmentSalesInvoice(Rec);
            //     end;
            // }

            action(PostInvoice)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostDocument;
                Caption = 'Post';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgmtJCOARC.PostConsignmentSalesInvoice(Rec);
                end;
            }
            action(UpdateConfirmInvoiceSelected)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;
                Caption = 'Set Selected Lines';
                ToolTip = 'Updates Confirm Invoice to Customer and Date of Invoice with Current Date, for the Lines, you selected (only for NON Serialized Lines)';
                trigger OnAction()
                var
                    Item: Record Item;
                    MarkedCount: Integer;
                begin
                    if confirm(StrSubstNo(ConfirmSetLbl, Rec.FieldCaption("Confirm Invoice To Customer")), false) then begin
                        SetSelectionFilter(Rec);
                        Rec.MarkedOnly(true);
                        if Rec.FindSet() then
                            repeat
                                Item.Get(Rec."Item No.");
                                if Item."Item Tracking Code" = '' then
                                    if Rec."Confirm Invoice To Customer" = false then begin
                                        Rec."Confirm Invoice To Customer" := true;
                                        Rec."Invoice Date" := TODAY;
                                        Rec.Modify();
                                        MarkedCount += 1;
                                    end;
                            until Rec.Next() = 0;
                        if MarkedCount = 0 then
                            Message('Nothing to Process!');
                        Rec.MarkedOnly(false);
                    end;
                end;
            }
            action(UpdateConfirmIncoiceAll)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AllLines;
                Caption = 'Set All Lines';
                ToolTip = 'Updates Confirm Invoice to Customer and Date of Invoice, for all Lines (only for NON Serialized Lines)';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgmtJCOARC.SetConfirmInvoiceAll(Rec, false);
                end;
            }
            action(ClearSelected)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;
                Caption = 'Clear Selected';
                ToolTip = 'Clears Confirm Invoice to Customer and Date of Invoice, for the Lines, you selected (only for NON Serialized Lines)';
                trigger OnAction()
                var
                    Item: Record Item;
                    MarkedCount: Integer;
                begin
                    if confirm(StrSubstNo(ConfirmClearLbl, Rec.FieldCaption("Confirm Invoice To Customer")), false) then begin
                        SetSelectionFilter(Rec);
                        Rec.MarkedOnly(true);
                        if Rec.FindSet() then
                            repeat
                                Item.Get(Rec."Item No.");
                                if Item."Item Tracking Code" = '' then
                                    if Rec."Confirm Invoice To Customer" = true then begin
                                        Rec."Confirm Invoice To Customer" := false;
                                        Rec."Invoice Date" := 0D;
                                        Rec.Modify();
                                        MarkedCount += 1;
                                    end;
                            until Rec.Next() = 0;
                        if MarkedCount = 0 then
                            Message('Nothing to Process!');
                        Rec.MarkedOnly(false);
                    end;
                end;
            }
            action(ClearAll)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AllLines;
                Caption = 'Clear All';
                ToolTip = 'Clears Confirm Invoice to Customer and Date of Invoice, for all Lines (only for NON Serialized Lines)';
                trigger OnAction()
                var
                    SalesConsignmentMgmtJCOARC: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgmtJCOARC.SetConfirmInvoiceAll(Rec, true);
                end;
            }
        }
        area(Reporting)
        {
            action(ProformaInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pro Forma Invoice';
                Ellipsis = true;
                Image = ViewPostedOrder;
                ToolTip = 'View or print the pro forma sales invoice.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    DocPrint: Codeunit "Document-Print";
                    SalesConsignmentMgnt: Codeunit "SalesConsignmentMgmt JCOARC";
                begin
                    SalesConsignmentMgnt.UpdateSalesLineQtyToShipBeforePosting(Rec, true);
                    Commit();
                    SalesHeader.SetRange("Document Type", Rec."Document Type");
                    SalesHeader.SetRange("No.", Rec."Document No.");
                    if SalesHeader.FindFirst() then
                        DocPrint.PrintProformaSalesInvoice(SalesHeader);
                end;
            }
        }
    }
    var
        ConfirmSetLbl: Label 'Do you want to mark %1 to the Selected Non Serialized lines?';
        ConfirmClearLbl: Label 'Do you want to clear %1 to the Selected Non Serialized lines?';
}