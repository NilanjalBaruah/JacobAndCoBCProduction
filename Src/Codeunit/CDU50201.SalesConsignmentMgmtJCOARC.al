namespace JCO.JCO;
using Microsoft.Sales.Document;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using Microsoft.Sales.History;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Tracking;


codeunit 50201 "SalesConsignmentMgmt JCOARC"
{
    var
        SourceCodeSetup: Record "Source Code Setup";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemJournalBatch: Record "Item Journal Batch";
        JournalTemplateName: code[10];
        JournalBatchName: Code[10];
        GotJCOSetup: Boolean;
        gText001Err: Label 'Cannot delete the Line as one or more Items has been shipped to Consignee';
        gText002Err: Label 'Cannot change the %1 as one or more Items has been shipped to Consignee', Comment = '%1 = Caption(Item No./LocationCode)';

    //This function is used to populate Consignment Details table data on validate of "Qty. to Ship" of Sales Line
    local procedure LoadSalesLineDataIntoConsignmentDetails(var SalesLine: Record "Sales Line")
    var
        ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO";
        ConsignmentDetailARCJCO2: Record "Consignment Detail ARCJCO";
        ConsignmentDetailsCount: Integer;
        i: Integer;
        NewLineNo: Integer;
    begin
        IF SalesLine."Document Type" <> SalesLine."Document Type"::Order then
            exit;
        If SalesLine."Consignment Location Code ARCJ" = '' then
            exit;
        if SalesLine.Type <> SalesLine.Type::Item then
            exit;
        SalesLine.TestStatusOpen();
        SalesLine.TestField("Location Code");

        NewLineNo := 10000;
        //Take Total No of lines>>
        ConsignmentDetailARCJCO.SetRange("Entry Type", ConsignmentDetailARCJCO."Entry Type"::Sales);
        ConsignmentDetailARCJCO.SetRange("Document Type", SalesLine."Document Type");
        ConsignmentDetailARCJCO.SetRange("Document No.", SalesLine."Document No.");
        ConsignmentDetailARCJCO.SetRange("Document Line No.", SalesLine."Line No.");
        ConsignmentDetailsCount := ConsignmentDetailARCJCO.Count;
        if SalesLine."Quantity" = ConsignmentDetailsCount then
            exit;
        //Take Total No of lines <<

        //get last consignment line no. >>
        if ConsignmentDetailARCJCO.FindLast() then
            NewLineNo := ConsignmentDetailARCJCO."Line No." + 10000;
        //get last consignment line no. <<

        //Add remaining Lines
        if SalesLine."Quantity" > ConsignmentDetailsCount then
            for i := 1 to (SalesLine."Quantity" - ConsignmentDetailsCount) do begin
                ConsignmentDetailARCJCO2.Init();
                ConsignmentDetailARCJCO2."Entry Type" := ConsignmentDetailARCJCO."Entry Type"::Sales;
                ConsignmentDetailARCJCO2."Document Type" := SalesLine."Document Type";
                ConsignmentDetailARCJCO2."Document No." := SalesLine."Document No.";
                ConsignmentDetailARCJCO2."Document Line No." := SalesLine."Line No.";
                ConsignmentDetailARCJCO2."Line No." := NewLineNo;
                ConsignmentDetailARCJCO2."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
                ConsignmentDetailARCJCO2."Item No." := SalesLine."No.";
                ConsignmentDetailARCJCO2.Description := SalesLine.Description;
                ConsignmentDetailARCJCO2."Location Code" := SalesLine."Location Code";
                ConsignmentDetailARCJCO2."Consignment Location Code" := SalesLine."Consignment Location Code ARCJ";
                ConsignmentDetailARCJCO2.Validate(Quantity, 1);
                ConsignmentDetailARCJCO2.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
                ConsignmentDetailARCJCO2.Validate("Qty. per Unit of Measure", SalesLine."Qty. per Unit of Measure");
                ConsignmentDetailARCJCO2.Validate("Quantity (Base)", SalesLine."Qty. per Unit of Measure" * 1);
                ConsignmentDetailARCJCO2.Insert();

                NewLineNo += 10000;
            end;
    end;
    // This function is used to generate Reservation Entries, when Customer confirms the Item Sold and user logs the information. 
    procedure FillSalesReservationEntries(ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO")
    var
        SalesReservationEntry: Record "Reservation Entry";
        Item: Record Item;
    begin
        //11/03/2024    >>
        Item.Get(ConsignmentDetailARCJCO."Item No.");
        If Item."Item Tracking Code" = '' then
            exit;
        //11/03/2024    <<

        SalesReservationEntry.Init();
        SalesReservationEntry."Entry No." := SalesReservationEntry.GetLastEntryNo() + 1;
        SalesReservationEntry."Positive" := false;
        SalesReservationEntry."Item No." := ConsignmentDetailARCJCO."Item No.";
        SalesReservationEntry."Location Code" := ConsignmentDetailARCJCO."Location Code";
        SalesReservationEntry."Quantity (Base)" := -ConsignmentDetailARCJCO."Quantity (Base)";
        SalesReservationEntry."Reservation Status" := SalesReservationEntry."Reservation Status"::Surplus;
        SalesReservationEntry."Description" := ConsignmentDetailARCJCO."Description";
        SalesReservationEntry."Creation Date" := Today;
        SalesReservationEntry."Source Type" := 37;
        SalesReservationEntry."Source Subtype" := 1;
        SalesReservationEntry."Source ID" := ConsignmentDetailARCJCO."Document No.";
        SalesReservationEntry."Source Ref. No." := ConsignmentDetailARCJCO."Document Line No.";
        SalesReservationEntry."Shipment Date" := ConsignmentDetailARCJCO."Shipment Date";
        SalesReservationEntry."Serial No." := ConsignmentDetailARCJCO."Serial No.";
        SalesReservationEntry."Created By" := UserId;
        SalesReservationEntry."Qty. per Unit of Measure" := ConsignmentDetailARCJCO."Qty. per Unit of Measure";
        SalesReservationEntry."Quantity" := -ConsignmentDetailARCJCO.Quantity;
        SalesReservationEntry."Planning Flexibility" := SalesReservationEntry."Planning Flexibility"::Unlimited;
        SalesReservationEntry."Appl.-to Item Entry" := ConsignmentDetailARCJCO."Returned Item Entry";
        SalesReservationEntry."Qty. to Handle (Base)" := -ConsignmentDetailARCJCO."Quantity (Base)";
        SalesReservationEntry."Qty. to Invoice (Base)" := -ConsignmentDetailARCJCO."Quantity (Base)";
        SalesReservationEntry."Correction" := false;
        SalesReservationEntry."Item Tracking" := SalesReservationEntry."Item Tracking"::"Serial No.";
        SalesReservationEntry."Untracked Surplus" := false;
        SalesReservationEntry.Insert(True);
    end;

    //This function is used to Create, post Item Reclass Journal and update Consignment Details table fields
    procedure CreateAndPostItemReclassJournalAndUpdateConsignment(ConsignmentDetailJCOARC: Record "Consignment Detail ARCJCO"; ShipmentEntry: Boolean)
    var
        ItemJournalLine: Record "Item Journal Line";
        ConsignmentDetailARCJCO2: Record "Consignment Detail ARCJCO";
        Item: Record Item;
        EntryCount: Integer;
        ConfShipemntLabel: Label 'You have logged %1 Items (Serial Numbers) for Shipment. When shipped, these serial numbers will shown as available with Business (Consignment) Location. Do you want to continue?', Comment = '%1=Count';
        ConfSalesLabel: Label 'You have logged, the  %1 serial numbers (Sales Business Confirmed by Business). Do you want to continue?.', Comment = '%1=Count';
    begin

        GetJCOSetups();
        DeleteItemJournalLine(JournalTemplateName, JournalBatchName);
        ConsignmentDetailARCJCO2.Reset();
        ConsignmentDetailARCJCO2.SetRange("Entry Type", ConsignmentDetailARCJCO2."Entry Type"::Sales);
        ConsignmentDetailARCJCO2.SetRange("Document Type", ConsignmentDetailJCOARC."Document Type");
        ConsignmentDetailARCJCO2.SetRange("Document No.", ConsignmentDetailJCOARC."Document No.");
        //11/03/2024    >>
        //ConsignmentDetailARCJCO2.SetFilter("Serial No.", '<>%1', '');
        //11/03/2024    <<
        if ShipmentEntry then begin
            ConsignmentDetailARCJCO2.SetRange("Consignment Status", ConsignmentDetailARCJCO2."Consignment Status"::" ");
            if ConsignmentDetailJCOARC."Serial No." <> '' then
                ConsignmentDetailARCJCO2.SetRange("Item with Business", false);
            ConsignmentDetailARCJCO2.SetFilter("Shipment Confirmed By", '<>%1', '');
            ConsignmentDetailARCJCO2.SetFilter("Shipment Date", '<>%1', 0D);
        end else begin
            ConsignmentDetailARCJCO2.SetRange("Consignment Status", ConsignmentDetailARCJCO2."Consignment Status"::"Shipped to Business");
            ConsignmentDetailARCJCO2.SetRange("Confirm Sold by Custromer", true);
            ConsignmentDetailARCJCO2.SetFilter("B2B Sales Date", '<>%1', 0D);
            if ConsignmentDetailJCOARC."Serial No." <> '' then
                ConsignmentDetailARCJCO2.SetRange("Item with Business", true);
        end;
        if ConsignmentDetailARCJCO2.FindSet() then begin
            EntryCount := ConsignmentDetailARCJCO2.Count;
            if EntryCount = 0 then
                exit;
            if ShipmentEntry then
                if not Confirm(StrSubstNo(ConfShipemntLabel, EntryCount), false) then
                    exit;
            if not ShipmentEntry then
                if not Confirm(StrSubstNo(ConfSalesLabel, EntryCount), false) then
                    exit;
            repeat
                case ConsignmentDetailARCJCO2."Consignment Status" of
                    ConsignmentDetailARCJCO2."Consignment Status"::" ":
                        CreateItemJournalLine(ConsignmentDetailARCJCO2, true);
                    ConsignmentDetailARCJCO2."Consignment Status"::"Shipped to Business":
                        CreateItemJournalLine(ConsignmentDetailARCJCO2, false);
                end;
            until ConsignmentDetailARCJCO2.Next() = 0;
            if ShipmentEntry then
                ArchiveConsigmentOrder(ConsignmentDetailJCOARC);
        end;
    end;

    //This function is used to create Item Journal (Reclass) journal Line
    procedure GetJCOSetups()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if GotJCOSetup then
            exit;

        SourceCodeSetup.Get();
        SalesSetup.Get();
        SalesSetup.TestField("Cons. Template Name JCOARC");
        SalesSetup.TestField("Cons. Batch Name JCOARC");
        JournalTemplateName := SalesSetup."Cons. Template Name JCOARC";
        JournalBatchName := SalesSetup."Cons. Batch Name JCOARC";
        GotJCOSetup := true;
    end;

    procedure DeleteItemJournalLine(JnlTemplateName: Code[10]; JnlBatchName: Code[10])
    var
        OldItemJnlLine: Record "Item Journal Line";
    begin
        OldItemJnlLine.SetRange("Journal Template Name", JnlTemplateName);
        OldItemJnlLine.SetRange("Journal Batch Name", JnlBatchName);
        OldItemJnlLine.DeleteAll();
    end;

    procedure CreateItemJournalLine(ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO"; ShipmentEntry: Boolean)
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        LastLineNo: Integer;
    begin
        GetJCOSetups();

        ItemJournalLine2.SetRange("Journal Template Name", JournalTemplateName);
        ItemJournalLine2.SetRange("Journal Batch Name", JournalBatchName);
        If ItemJournalLine2.FindLast() then
            LastLineNo := ItemJournalLine2."Line No.";

        ItemJournalLine.Init;
        ItemJournalLine."Journal Template Name" := JournalTemplateName;
        ItemJournalLine."Journal Batch Name" := JournalBatchName;
        ItemJournalLine."Line No." := LastLineNo + 10000;
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Transfer);
        ItemJournalLine."Document No." := ConsignmentDetailARCJCO."Document No.";
        ItemJournalLine.Validate("Posting Date", ConsignmentDetailARCJCO."Shipment Date");
        ItemJournalLine.Validate("Item No.", ConsignmentDetailARCJCO."Item No.");
        if ShipmentEntry then begin
            ItemJournalLine.Validate("Location Code", ConsignmentDetailARCJCO."Location Code");
            ItemJournalLine.Validate("New Location Code", ConsignmentDetailARCJCO."Consignment Location Code");
        end else begin
            ItemJournalLine.Validate("Location Code", ConsignmentDetailARCJCO."Consignment Location Code");
            ItemJournalLine.Validate("New Location Code", ConsignmentDetailARCJCO."Location Code");
        end;
        ItemJournalLine.Validate(Quantity, ConsignmentDetailARCJCO.Quantity);
        ItemJournalLine.Insert();
        if ShipmentEntry then
            FillReclassReservationEntries(ItemJournalLine, ConsignmentDetailARCJCO."Serial No.", ConsignmentDetailARCJCO."Appl.-to Item Entry", ShipmentEntry)
        else
            FillReclassReservationEntries(ItemJournalLine, ConsignmentDetailARCJCO."Serial No.", ConsignmentDetailARCJCO."Consigned Item Entry No.", ShipmentEntry);
        Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
        UpdateConsignmentDetailLineStatus(ConsignmentDetailARCJCO, ShipmentEntry);
        if not ShipmentEntry then
            FillSalesReservationEntries(ConsignmentDetailARCJCO);
    end;

    // This function is used to generate Reservation Entries, when we are processing Item Reclass Journal. 

    procedure FillReclassReservationEntries(ItemJournalLine: Record "Item Journal Line"; SerialNo: Text[50]; "Appli-to Entry No.": Integer; ShipmentEntry: Boolean)
    var
        ReclassReservationEntry: Record "Reservation Entry";
        Item: Record Item;
    begin
        //11/03/2024    >>
        Item.Get(ItemJournalLine."Item No.");
        If Item."Item Tracking Code" = '' then
            exit;
        //11/03/2024    <<

        ReclassReservationEntry.Init();
        ReclassReservationEntry."Entry No." := ReclassReservationEntry.GetLastEntryNo() + 1;
        ReclassReservationEntry."Positive" := false;
        ReclassReservationEntry."Item No." := ItemJournalLine."Item No.";
        ReclassReservationEntry."Location Code" := ReclassReservationEntry."Location Code";
        ReclassReservationEntry."Quantity (Base)" := -ItemJournalLine."Quantity (Base)";
        ReclassReservationEntry."Reservation Status" := ReclassReservationEntry."Reservation Status"::Prospect;
        ReclassReservationEntry."Description" := ItemJournalLine."Description";
        ReclassReservationEntry."Creation Date" := Today;
        ReclassReservationEntry."Source Type" := 83;
        ReclassReservationEntry."Source Subtype" := 4;
        ReclassReservationEntry."Source ID" := ItemJournalLine."Journal Template Name";
        ReclassReservationEntry."Source Batch Name" := ItemJournalLine."Journal Batch Name";
        ReclassReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
        ReclassReservationEntry."Shipment Date" := ItemJournalLine."Posting Date";
        ReclassReservationEntry."Serial No." := SerialNo;
        ReclassReservationEntry."New Serial No." := SerialNo;
        ReclassReservationEntry."Created By" := UserId;
        ReclassReservationEntry."Qty. per Unit of Measure" := ItemJournalLine."Qty. per Unit of Measure";
        ReclassReservationEntry."Quantity" := -ItemJournalLine.Quantity;
        ReclassReservationEntry."Planning Flexibility" := ReclassReservationEntry."Planning Flexibility"::Unlimited;
        ReclassReservationEntry.Validate("Appl.-to Item Entry", "Appli-to Entry No.");
        ReclassReservationEntry."Qty. to Handle (Base)" := -ItemJournalLine."Quantity (Base)";
        ReclassReservationEntry."Qty. to Invoice (Base)" := -ItemJournalLine."Quantity (Base)";
        ReclassReservationEntry."Correction" := false;
        ReclassReservationEntry."Item Tracking" := ReclassReservationEntry."Item Tracking"::"Serial No.";
        ReclassReservationEntry."Untracked Surplus" := false;
        ReclassReservationEntry.Insert(True);
    end;

    procedure UpdateConsignmentDetailLineStatus(ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO"; ShipmentEntry: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesHeader: Record "Sales Header";
    begin
        if ShipmentEntry then begin
            ItemLedgerEntry.SetRange("Item No.", ConsignmentDetailARCJCO."Item No.");
            ItemLedgerEntry.SetRange("Location Code", ConsignmentDetailARCJCO."Consignment Location Code");
            //11/03/2024    >>
            if ConsignmentDetailARCJCO."Serial No." <> '' then
                //11/03/2024    <<
                ItemLedgerEntry.SetRange("Serial No.", ConsignmentDetailARCJCO."Serial No.");
            ItemLedgerEntry.SetRange(Open, true);
            if ItemLedgerEntry.FindFirst() then begin
                ConsignmentDetailARCJCO."Consigned Item Entry No." := ItemLedgerEntry."Entry No.";
                ConsignmentDetailARCJCO."Consignment Status" := ConsignmentDetailARCJCO."Consignment Status"::"Shipped to Business";
            end;
        end else begin
            ItemLedgerEntry.SetRange("Item No.", ConsignmentDetailARCJCO."Item No.");
            ItemLedgerEntry.SetRange("Location Code", ConsignmentDetailARCJCO."Location Code");
            //11/03/2024    >>
            if ConsignmentDetailARCJCO."Serial No." <> '' then
                ItemLedgerEntry.SetRange("Serial No.", ConsignmentDetailARCJCO."Serial No.");
            //11/03/2024    <<
            ItemLedgerEntry.SetRange(Open, true);
            if ItemLedgerEntry.FindFirst() then begin
                ConsignmentDetailARCJCO."Returned Item Entry" := ItemLedgerEntry."Entry No.";
                ConsignmentDetailARCJCO."Consignment Status" := ConsignmentDetailARCJCO."Consignment Status"::"Sold By Business";
            end;
        end;
        ConsignmentDetailARCJCO.Modify(true);

        SalesHeader.Get(ConsignmentDetailARCJCO."Document Type", ConsignmentDetailARCJCO."Document No.");
        if not SalesHeader."Consignment Order ARCJCO" then begin
            SalesHeader."Consignment Order ARCJCO" := true;
            SalesHeader.Modify();
        end;
    end;

    //Runs when quantity is updated >>
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure QuantityOnAfterValidateJCO(var Rec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec."Line No." <> 0 then
            LoadSalesLineDataIntoConsignmentDetails(Rec);
    end;

    //Runs when quantity is and record inserted
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertJCO(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec.IsTemporary then
            exit;
        if Rec.Quantity <> 0 then
            LoadSalesLineDataIntoConsignmentDetails(Rec);
    end;

    //Runs before sales line is tried to delete
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDelete(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec.IsTemporary then
            exit;
        if RunTrigger then begin
            Rec.CalcFields("Qty Shipped to Consignee JCO");
            if Rec."Qty Shipped to Consignee JCO" <> 0 then
                Error(gText001Err);
        end;
    end;

    //Runs after sales line is deleted
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesLineJCO(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec.IsTemporary then
            exit;
        if RunTrigger then begin
            Rec.CalcFields("Qty Shipped to Consignee JCO");
            if Rec."Qty Shipped to Consignee JCO" = 0 then
                DeleteBlankLines(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure SalesLineNoOnAfterValidateJCO(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
        Location: Record Location;
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec."Consignment Location Code ARCJ" = '' then
            if Rec.Type = Rec.Type::Item then begin
                SalesHeader.Get(Rec."Document Type", Rec."Document No.");
                Location.SetRange("Consignment Location ARCJCO", true);
                Location.SetRange("Consignment Customer No. ARJCO", SalesHeader."Sell-to Customer No.");
                if Location.FindFirst() then
                    Rec."Consignment Location Code ARCJ" := Location.Code;
            end;
        if (xRec."No." <> '') and (Rec."No." <> xRec."No.") then begin
            Rec.CalcFields("Qty Shipped to Consignee JCO");
            if Rec."Qty Shipped to Consignee JCO" <> 0 then
                Error(StrSubstNo(gText002Err, Rec.FieldCaption("No.")))
            else
                DeleteBlankLines(Rec);
        end;
    end;
    //Runs when Consignment Location Code is changed
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Consignment Location Code ARCJ', false, false)]
    local procedure SalesLineConsLocCodeOnAfterValidateJCO(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
        Location: Record Location;
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if (xRec."Consignment Location Code ARCJ" <> '') and (Rec."Consignment Location Code ARCJ" <> xRec."Consignment Location Code ARCJ") then begin
            Rec.CalcFields("Qty Shipped to Consignee JCO");
            if Rec."Qty Shipped to Consignee JCO" <> 0 then
                Error(StrSubstNo(gText002Err, Rec.FieldCaption("Consignment Location Code ARCJ")))
            else
                DeleteBlankLines(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterInitFromSalesLine', '', false, false)]
    Local procedure OnAfterInitShptLineFromSalesLineJCO(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesLine.CalcFields("Qty Shipped to Consignee JCO", "Quantity Sold By Consignee JCO");
        SalesShptLine."Qty Shipped to Consignee JCO" := SalesLine."Qty Shipped to Consignee JCO";
        SalesShptLine."Quantity Sold By Consignee JCO" := SalesLine."Quantity Sold By Consignee JCO";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', false, false)]
    Local procedure OnAfterInitInvLneFromSalesLineJCO(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    begin
        SalesLine.CalcFields("Qty Shipped to Consignee JCO", "Quantity Sold By Consignee JCO");
        SalesInvLine."Qty Shipped to Consignee JCO" := SalesLine."Qty Shipped to Consignee JCO";
        SalesInvLine."Quantity Sold By Consignee JCO" := SalesLine."Quantity Sold By Consignee JCO";
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLineJCOARC(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        Location: Record Location;
    begin
        Location.SetRange("Consignment Location ARCJCO", true);
        Location.SetRange("Consignment Customer No. ARJCO", SalesQuoteLine."Sell-to Customer No.");
        if Location.FindFirst() then begin
            SalesOrderLine.validate("Consignment Location Code ARCJ", Location.Code);
            SalesOrderLine.Validate(Quantity);
        end;
    end;

    procedure DeleteBlankLines(SalesLine: Record "Sales Line")
    var
        BlankConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO";
    begin
        BlankConsignmentDetailARCJCO.SetRange("Entry Type", BlankConsignmentDetailARCJCO."Entry Type"::Sales);
        BlankConsignmentDetailARCJCO.SetRange("Document Type", SalesLine."Document Type");
        BlankConsignmentDetailARCJCO.SetRange("Document No.", SalesLine."Document No.");
        BlankConsignmentDetailARCJCO.SetRange("Document Line No.", SalesLine."Line No.");
        BlankConsignmentDetailARCJCO.DeleteAll();
    end;

    procedure ArchiveConsigmentOrder(ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO")
    var
        SalesHeader: Record "Sales Header";
        ArchiveMgmt: Codeunit ArchiveManagement;
    begin
        if SalesHeader.Get(ConsignmentDetailARCJCO."Document Type", ConsignmentDetailARCJCO."Document No.") then
            if SalesHeader."Archive Ordr on Shpmt ARCJCO" then
                ArchiveMgmt.ArchiveSalesDocument(SalesHeader);
    end;

    procedure PrintMemoJCO(var SalesHeader: Record "Sales Header")
    var
        MemoReport: Report "Sales - Memo JCOARC";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("Consignment Location Code ARCJ", '<>%1', '');
        SalesLine.SetFilter(Quantity, '<>%1', 0);
        if SalesLine.FindFirst() then begin
            MemoReport.SetTableView(SalesHeader);
            MemoReport.Run();
        end else
            Error('Nothing to Print!');
    end;
}