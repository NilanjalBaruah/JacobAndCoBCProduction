namespace JCO.JCO;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Tracking;


codeunit 50203 "ConsignmentReturnMgmt JCOARC"
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

    //This function is used to Create, post Item Reclass Journal and update Consignment Details table fields
    procedure CreateAndPostItemReclassJournalAndUpdateConsignment(ConsignmentDetailJCOARC: Record "Consignment Detail ARCJCO")
    var
        ItemJournalLine: Record "Item Journal Line";
        ConsignmentDetailARCJCO2: Record "Consignment Detail ARCJCO";
        EntryCount: Integer;
        ConfReturnLabel: Label 'You have logged, the %1 serial numbers/Non Serials (Return Confirmed by Business). Do you want to continue?.', Comment = '%1=Count';
    begin

        GetJCOSetups();
        DeleteItemJournalLine(JournalTemplateName, JournalBatchName);
        ConsignmentDetailARCJCO2.Reset();
        ConsignmentDetailARCJCO2.SetRange("Entry Type", ConsignmentDetailARCJCO2."Entry Type"::Sales);
        ConsignmentDetailARCJCO2.SetRange("Document Type", ConsignmentDetailJCOARC."Document Type");
        ConsignmentDetailARCJCO2.SetRange("Document No.", ConsignmentDetailJCOARC."Document No.");
        //ConsignmentDetailARCJCO2.SetFilter("Serial No.", '<>%1', '');
        ConsignmentDetailARCJCO2.SetRange("Consignment Status", ConsignmentDetailARCJCO2."Consignment Status"::"Shipped to Business");
        ConsignmentDetailARCJCO2.SetRange("Confirm Returned by Custromer", true);
        ConsignmentDetailARCJCO2.SetFilter("Date of Return", '<>%1', 0D);
        ConsignmentDetailARCJCO2.SetRange("Item with Business", true);
        if ConsignmentDetailARCJCO2.FindSet() then begin
            EntryCount := ConsignmentDetailARCJCO2.Count;
            if EntryCount = 0 then
                exit;
            if not Confirm(StrSubstNo(ConfReturnLabel, EntryCount), false) then
                exit;
            repeat
                CreateItemJournalLine(ConsignmentDetailARCJCO2);
            until ConsignmentDetailARCJCO2.Next() = 0;
        end;
    end;

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

    procedure CreateItemJournalLine(ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO")
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
        ItemJournalLine.Validate("Posting Date", ConsignmentDetailARCJCO."Date of Return");
        ItemJournalLine.Validate("Item No.", ConsignmentDetailARCJCO."Item No.");
        ItemJournalLine.Validate("Location Code", ConsignmentDetailARCJCO."Consignment Location Code");
        ItemJournalLine.Validate("New Location Code", ConsignmentDetailARCJCO."Location Code");
        ItemJournalLine.Validate(Quantity, ConsignmentDetailARCJCO.Quantity);
        ItemJournalLine.Validate("Reason Code", ConsignmentDetailARCJCO."Reason Code");
        ItemJournalLine.Insert();
        FillReclassReservationEntries(ItemJournalLine, ConsignmentDetailARCJCO."Serial No.", ConsignmentDetailARCJCO."Consigned Item Entry No.");
        Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
        UpdateConsignmentDetailLineStatus(ConsignmentDetailARCJCO);
    end;
    // This function is used to generate Reservation Entries, when we are processing Item Reclass Journal. 

    procedure FillReclassReservationEntries(ItemJournalLine: Record "Item Journal Line"; SerialNo: Text[50]; "Appli-to Entry No.": Integer)
    var
        Item: Record Item;
        ReclassReservationEntry: Record "Reservation Entry";
    begin
        //11/19/2024    >>
        Item.Get(ItemJournalLine."Item No.");
        If Item."Item Tracking Code" = '' then
            exit;
        //11/19/2024    <<

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

    procedure UpdateConsignmentDetailLineStatus(ConsignmentDetailARCJCO: Record "Consignment Detail ARCJCO")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.SetRange("Item No.", ConsignmentDetailARCJCO."Item No.");
        ItemLedgerEntry.SetRange("Location Code", ConsignmentDetailARCJCO."Location Code");
        ItemLedgerEntry.SetRange("Serial No.", ConsignmentDetailARCJCO."Serial No.");
        ItemLedgerEntry.SetRange(Open, true);
        if ItemLedgerEntry.FindFirst() then
            ConsignmentDetailARCJCO."Returned Item Entry" := ItemLedgerEntry."Entry No.";
        ConsignmentDetailARCJCO."Consignment Status" := ConsignmentDetailARCJCO."Consignment Status"::"Returned By Business";
        ConsignmentDetailARCJCO.Modify(true);
    end;
}