namespace JCO.JCO;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Utilities;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Posting;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Tracking;


codeunit 50204 "PurchaseConsignmentMgmt JCOARC"
{
    var
        SourceCodeSetup: Record "Source Code Setup";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemJournalBatch: Record "Item Journal Batch";
        JournalTemplateName: code[10];
        JournalBatchName: Code[10];
        GotJCOSetup: Boolean;
        gText001Err: Label 'Cannot delete the Line as one or more Items has been shipped by Consignee';
        gText002Err: Label 'Cannot change the %1 as one or more Items has been shipped by Consignee', Comment = '%1 = Caption(Item No./LocationCode)';


    //This function is used to populate Consignment Details table data on validate of "Quantity" of Sales Line
    local procedure LoadPurchLineDataIntoConsignmentDetails(var PurchLine: Record "Purchase Line")
    var
        ConsignmentDetailARCJCO: Record "Purch. Consignment Det ARCJCO";
        ConsignmentDetailARCJCO2: Record "Purch. Consignment Det ARCJCO";
        ConsignmentDetailsCount: Integer;
        i: Integer;
        NewLineNo: Integer;
    begin
        if PurchLine."Document Type" <> PurchLine."Document Type"::Order then
            exit;
        If PurchLine."Consignment Location Code ARCJ" = '' then
            exit;
        if PurchLine.Type <> PurchLine.Type::Item then
            exit;
        PurchLine.TestStatusOpen();
        PurchLine.TestField("Location Code");

        NewLineNo := 10000;
        //Take Total No of lines>>
        ConsignmentDetailARCJCO.SetRange("Document Type", PurchLine."Document Type");
        ConsignmentDetailARCJCO.SetRange("Document No.", PurchLine."Document No.");
        ConsignmentDetailARCJCO.SetRange("Document Line No.", PurchLine."Line No.");
        ConsignmentDetailsCount := ConsignmentDetailARCJCO.Count;
        if PurchLine."Quantity" = ConsignmentDetailsCount then
            exit;
        //Take Total No of lines <<

        //get last consignment line no. >>
        if ConsignmentDetailARCJCO.FindLast() then
            NewLineNo := ConsignmentDetailARCJCO."Line No." + 10000;
        //get last consignment line no. <<

        //Add remaining Lines
        if PurchLine."Quantity" > ConsignmentDetailsCount then
            for i := 1 to (PurchLine."Quantity" - ConsignmentDetailsCount) do begin
                ConsignmentDetailARCJCO2.Init();
                ConsignmentDetailARCJCO2."Document Type" := PurchLine."Document Type";
                ConsignmentDetailARCJCO2."Document No." := PurchLine."Document No.";
                ConsignmentDetailARCJCO2."Document Line No." := PurchLine."Line No.";
                ConsignmentDetailARCJCO2."Line No." := NewLineNo;
                ConsignmentDetailARCJCO2."Buy-from Vendor No." := PurchLine."Buy-from Vendor No.";
                ConsignmentDetailARCJCO2."Item No." := PurchLine."No.";
                ConsignmentDetailARCJCO2.Description := PurchLine.Description;
                ConsignmentDetailARCJCO2."Location Code" := PurchLine."Location Code";
                ConsignmentDetailARCJCO2."Consignment Location Code" := PurchLine."Consignment Location Code ARCJ";
                ConsignmentDetailARCJCO2.Validate(Quantity, 1);
                ConsignmentDetailARCJCO2.Validate("Unit of Measure Code", PurchLine."Unit of Measure Code");
                ConsignmentDetailARCJCO2.Validate("Qty. per Unit of Measure", PurchLine."Qty. per Unit of Measure");
                ConsignmentDetailARCJCO2.Validate("Quantity (Base)", PurchLine."Qty. per Unit of Measure" * 1);
                ConsignmentDetailARCJCO2.Insert();

                NewLineNo += 10000;
            end;
    end;


    // This function is used to generate Reservation Entries, when Item is physically received at location. 
    procedure FillPurchReservationEntries(PurchConsignmentDetailARCJCO: Record "Purch. Consignment Det ARCJCO")
    var
        PurchReservationEntry: Record "Reservation Entry";
    begin

        PurchReservationEntry.Init();
        PurchReservationEntry."Entry No." := PurchReservationEntry.GetLastEntryNo() + 1;
        PurchReservationEntry."Positive" := true;
        PurchReservationEntry."Item No." := PurchConsignmentDetailARCJCO."Item No.";
        PurchReservationEntry."Location Code" := PurchConsignmentDetailARCJCO."Location Code";
        PurchReservationEntry."Quantity (Base)" := PurchConsignmentDetailARCJCO."Quantity (Base)";
        PurchReservationEntry."Reservation Status" := PurchReservationEntry."Reservation Status"::Surplus;
        PurchReservationEntry."Description" := PurchConsignmentDetailARCJCO."Description";
        PurchReservationEntry."Creation Date" := Today;
        PurchReservationEntry."Source Type" := 39;
        PurchReservationEntry."Source Subtype" := 1;
        PurchReservationEntry."Source ID" := PurchConsignmentDetailARCJCO."Document No.";
        PurchReservationEntry."Source Ref. No." := PurchConsignmentDetailARCJCO."Document Line No.";
        PurchReservationEntry."Expected Receipt Date" := PurchConsignmentDetailARCJCO."Receipt Date";
        PurchReservationEntry."Serial No." := PurchConsignmentDetailARCJCO."Serial No.";
        PurchReservationEntry."Created By" := UserId;
        PurchReservationEntry."Qty. per Unit of Measure" := PurchConsignmentDetailARCJCO."Qty. per Unit of Measure";
        PurchReservationEntry."Quantity" := PurchConsignmentDetailARCJCO.Quantity;
        PurchReservationEntry."Planning Flexibility" := PurchReservationEntry."Planning Flexibility"::Unlimited;
        //PurchReservationEntry."Appl.-to Item Entry" := PurchConsignmentDetailARCJCO."Consigned Item Entry No.";
        PurchReservationEntry."Qty. to Handle (Base)" := PurchConsignmentDetailARCJCO."Quantity (Base)";
        PurchReservationEntry."Qty. to Invoice (Base)" := PurchConsignmentDetailARCJCO."Quantity (Base)";
        PurchReservationEntry."Correction" := false;
        PurchReservationEntry."Item Tracking" := PurchReservationEntry."Item Tracking"::"Serial No.";
        PurchReservationEntry."Untracked Surplus" := false;
        PurchReservationEntry.Insert(True);
    end;

    //This function is used to Create, post negative Item Journal and update Consignment Details table fields
    procedure CreateAndPostItemJournalAndUpdateConsignment(PurchConsignmentDetailJCOARC: Record "Purch. Consignment Det ARCJCO"; ReceivedAtLocation: Boolean)
    var
        ItemJournalLine: Record "Item Journal Line";
        PurchConsignmentDetailJCOARC2: Record "Purch. Consignment Det ARCJCO";
        EntryCount: Integer;
        ConfShippedByVendorLabel: Label 'You have logged %1 Items (Serial Numbers) as Shipped by Vendor. Upon completion of this action, these serial numbers will shown as available with Vendor Location. Do you want to continue?', Comment = '%1=Count';
        ConfReceivedAtLocationLabel: Label 'You have logged, the  %1 serial numbers (Confirmed received at Location). Do you want to continue?.', Comment = '%1=Count';
    begin

        GetJCOSetups();
        DeleteItemJournalLine(JournalTemplateName, JournalBatchName);
        PurchConsignmentDetailJCOARC2.Reset();
        PurchConsignmentDetailJCOARC2.SetRange("Document Type", PurchConsignmentDetailJCOARC."Document Type");
        PurchConsignmentDetailJCOARC2.SetRange("Document No.", PurchConsignmentDetailJCOARC."Document No.");
        PurchConsignmentDetailJCOARC2.SetFilter("Serial No.", '<>%1', '');
        if ReceivedAtLocation then begin
            PurchConsignmentDetailJCOARC2.SetRange("Consignment Status", PurchConsignmentDetailJCOARC2."Consignment Status"::"Shipped By Vendor");
            PurchConsignmentDetailJCOARC2.SetRange("Item In Transit", true);
            PurchConsignmentDetailJCOARC2.SetRange("Shipment Received", true);
            PurchConsignmentDetailJCOARC2.SetFilter("Receipt Confirmed By", '<>%1', '');
            PurchConsignmentDetailJCOARC2.SetFilter("Receipt Date", '<>%1', 0D);
        end else begin
            PurchConsignmentDetailJCOARC2.SetRange("Consignment Status", PurchConsignmentDetailJCOARC2."Consignment Status"::" ");
            PurchConsignmentDetailJCOARC2.SetFilter("Date Shipped by Vendor", '<>%1', 0D);
            PurchConsignmentDetailJCOARC2.SetRange("Item In Transit", false);
        end;
        if PurchConsignmentDetailJCOARC2.FindSet() then begin
            EntryCount := PurchConsignmentDetailJCOARC2.Count;
            if EntryCount = 0 then
                exit;
            if ReceivedAtLocation then
                if not Confirm(StrSubstNo(ConfReceivedAtLocationLabel, EntryCount), false) then
                    exit;
            if not ReceivedAtLocation then
                if not Confirm(StrSubstNo(ConfShippedByVendorLabel, EntryCount), false) then
                    exit;
            repeat
                case PurchConsignmentDetailJCOARC2."Consignment Status" of
                    PurchConsignmentDetailJCOARC2."Consignment Status"::" ":
                        CreateItemJournalLine(PurchConsignmentDetailJCOARC2, false);
                    PurchConsignmentDetailJCOARC2."Consignment Status"::"Shipped By Vendor":
                        CreateItemJournalLine(PurchConsignmentDetailJCOARC2, true);
                end;
            until PurchConsignmentDetailJCOARC2.Next() = 0;
            if ReceivedAtLocation then
                ArchiveConsigmentOrder(PurchConsignmentDetailJCOARC);
        end;
    end;

    //This function is used to create Item Journal Line
    procedure GetJCOSetups()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        if GotJCOSetup then
            exit;

        SourceCodeSetup.Get();
        PurchSetup.Get();
        PurchSetup.TestField("Cons. Template Name JCOARC");
        PurchSetup.TestField("Cons. Batch Name JCOARC");
        JournalTemplateName := PurchSetup."Cons. Template Name JCOARC";
        JournalBatchName := PurchSetup."Cons. Batch Name JCOARC";
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

    procedure CreateItemJournalLine(PurchConsignmentDetailARCJCO: Record "Purch. Consignment Det ARCJCO"; ReceivedAtLocation: Boolean)
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
        if ReceivedAtLocation then
            ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.")
        else
            ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
        ItemJournalLine."Document No." := PurchConsignmentDetailARCJCO."Document No.";
        if ReceivedAtLocation then
            ItemJournalLine.Validate("Posting Date", PurchConsignmentDetailARCJCO."Receipt Date")
        else
            ItemJournalLine.Validate("Posting Date", PurchConsignmentDetailARCJCO."Date Shipped by Vendor");
        ItemJournalLine.Validate("Item No.", PurchConsignmentDetailARCJCO."Item No.");
        ItemJournalLine.Validate("Location Code", PurchConsignmentDetailARCJCO."Consignment Location Code");
        ItemJournalLine.Validate(Quantity, PurchConsignmentDetailARCJCO.Quantity);
        ItemJournalLine.Validate("Serial No.", PurchConsignmentDetailARCJCO."Serial No.");
        ItemJournalLine.Insert();
        if ReceivedAtLocation then
            FillItemJnlReservationEntries(ItemJournalLine, PurchConsignmentDetailARCJCO."Serial No.", PurchConsignmentDetailARCJCO."Consigned Item Entry No.", ReceivedAtLocation)
        else
            FillItemJnlReservationEntries(ItemJournalLine, PurchConsignmentDetailARCJCO."Serial No.", 0, ReceivedAtLocation);
        Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
        UpdateConsignmentDetailLineStatus(PurchConsignmentDetailARCJCO, ReceivedAtLocation);
        if ReceivedAtLocation then
            FillPurchReservationEntries(PurchConsignmentDetailARCJCO);
    end;

    // This function is used to generate Reservation Entries, when we are processing Item Journal. 

    procedure FillItemJnlReservationEntries(ItemJournalLine: Record "Item Journal Line"; SerialNo: Text[50]; "Appli-to Entry No.": Integer; ReceivedAtLocation: Boolean)
    var
        ItemJnlReservationEntry: Record "Reservation Entry";
        Sign: Integer;
    begin
        if ReceivedAtLocation then
            Sign := -1
        else
            Sign := 1;
        ItemJnlReservationEntry.Init();
        ItemJnlReservationEntry."Entry No." := ItemJnlReservationEntry.GetLastEntryNo() + 1;
        ItemJnlReservationEntry."Positive" := (not ReceivedAtLocation);
        ItemJnlReservationEntry."Item No." := ItemJournalLine."Item No.";
        ItemJnlReservationEntry."Location Code" := ItemJournalLine."Location Code";
        ItemJnlReservationEntry."Quantity (Base)" := Sign * ItemJournalLine."Quantity (Base)";
        ItemJnlReservationEntry."Reservation Status" := ItemJnlReservationEntry."Reservation Status"::Prospect;
        ItemJnlReservationEntry."Description" := ItemJournalLine."Description";
        ItemJnlReservationEntry."Creation Date" := Today;
        ItemJnlReservationEntry."Source Type" := 83;
        if ReceivedAtLocation then
            ItemJnlReservationEntry."Source Subtype" := 3
        else
            ItemJnlReservationEntry."Source Subtype" := 0;
        ItemJnlReservationEntry."Source ID" := ItemJournalLine."Journal Template Name";
        ItemJnlReservationEntry."Source Batch Name" := ItemJournalLine."Journal Batch Name";
        ItemJnlReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
        if ReceivedAtLocation then
            ItemJnlReservationEntry."Shipment Date" := ItemJournalLine."Posting Date"
        else
            ItemJnlReservationEntry."Expected Receipt Date" := ItemJournalLine."Posting Date";
        ItemJnlReservationEntry."Serial No." := SerialNo;
        ItemJnlReservationEntry."Created By" := UserId;
        ItemJnlReservationEntry."Qty. per Unit of Measure" := ItemJournalLine."Qty. per Unit of Measure";
        ItemJnlReservationEntry."Quantity" := Sign * ItemJournalLine.Quantity;
        ItemJnlReservationEntry."Planning Flexibility" := ItemJnlReservationEntry."Planning Flexibility"::Unlimited;
        if "Appli-to Entry No." <> 0 then
            ItemJnlReservationEntry.Validate("Appl.-to Item Entry", "Appli-to Entry No.");
        ItemJnlReservationEntry."Qty. to Handle (Base)" := Sign * ItemJournalLine."Quantity (Base)";
        ItemJnlReservationEntry."Qty. to Invoice (Base)" := Sign * ItemJournalLine."Quantity (Base)";
        ItemJnlReservationEntry."Correction" := false;
        ItemJnlReservationEntry."Item Tracking" := ItemJnlReservationEntry."Item Tracking"::"Serial No.";
        ItemJnlReservationEntry."Untracked Surplus" := false;
        ItemJnlReservationEntry.Insert(True);
    end;

    procedure UpdateConsignmentDetailLineStatus(PurchConsignmentDetailARCJCO: Record "Purch. Consignment Det ARCJCO"; ReceivedAtLocation: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PurchaseHeader: Record "Purchase Header";
    begin
        if ReceivedAtLocation then begin
            // ItemLedgerEntry.SetRange("Item No.", PurchConsignmentDetailARCJCO."Item No.");
            // ItemLedgerEntry.SetRange("Location Code", PurchConsignmentDetailARCJCO."Consignment Location Code");
            // ItemLedgerEntry.SetRange("Serial No.", PurchConsignmentDetailARCJCO."Serial No.");
            // //ItemLedgerEntry.SetRange(Open, true);
            // ItemLedgerEntry.SetRange(Open, false);
            // if ItemLedgerEntry.FindFirst() then begin
            //PurchConsignmentDetailARCJCO."Consigned Item Entry No." := ItemLedgerEntry."Entry No.";
            PurchConsignmentDetailARCJCO."Consignment Status" := PurchConsignmentDetailARCJCO."Consignment Status"::"Received At Location";
            //end;
        end else begin
            ItemLedgerEntry.SetRange("Item No.", PurchConsignmentDetailARCJCO."Item No.");
            ItemLedgerEntry.SetRange("Location Code", PurchConsignmentDetailARCJCO."Consignment Location Code");
            ItemLedgerEntry.SetRange("Serial No.", PurchConsignmentDetailARCJCO."Serial No.");
            ItemLedgerEntry.SetRange(Open, true);
            if ItemLedgerEntry.FindFirst() then begin
                PurchConsignmentDetailARCJCO."Consigned Item Entry No." := ItemLedgerEntry."Entry No.";
                PurchConsignmentDetailARCJCO."Consignment Status" := PurchConsignmentDetailARCJCO."Consignment Status"::"Shipped By Vendor";
            end;
        end;
        PurchConsignmentDetailARCJCO.Modify(true);

        PurchaseHeader.Get(PurchConsignmentDetailARCJCO."Document Type", PurchConsignmentDetailARCJCO."Document No.");
        if not PurchaseHeader."Consignment Order ARCJCO" then begin
            PurchaseHeader."Consignment Order ARCJCO" := true;
            PurchaseHeader.Modify();
        end;
    end;

    //Runs when quantity is updated >>
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure QuantityOnAfterValidateJCO(var Rec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        if Rec.IsTemporary then
            exit;
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec."Line No." <> 0 then
            LoadPurchLineDataIntoConsignmentDetails(Rec);
    end;

    //Runs when quantity is and record inserted
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertJCO(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if Rec.Quantity <> 0 then
            LoadPurchLineDataIntoConsignmentDetails(Rec);
    end;

    //Runs before Purchase line is tried to delete
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDelete(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if RunTrigger then begin
            Rec.CalcFields("Qty. Shipped by Consignee JCO");
            if Rec."Qty. Shipped by Consignee JCO" <> 0 then
                Error(gText001Err);
        end;
    end;

    //Runs after Purchase line is deleted
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesLineJCO(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if RunTrigger then begin
            Rec.CalcFields("Qty. Shipped by Consignee JCO");
            if Rec."Qty. Shipped by Consignee JCO" = 0 then
                DeleteBlankLines(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure PurchaseLineNoOnAfterValidateJCO(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        Location: Record Location;
    begin
        if Rec."Consignment Location Code ARCJ" = '' then
            if Rec.Type = Rec.Type::Item then begin
                PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
                Location.SetRange("Consignment Location ARCJCO", true);
                Location.SetRange("Consignment Vendor No. ARJCO", PurchaseHeader."Buy-from Vendor No.");
                if Location.FindFirst() then
                    Rec."Consignment Location Code ARCJ" := Location.Code;
            end;
        if (xRec."No." <> '') and (Rec."No." <> xRec."No.") then begin
            Rec.CalcFields("Qty. Shipped by Consignee JCO");
            if Rec."Qty. Shipped by Consignee JCO" <> 0 then
                Error(StrSubstNo(gText002Err, Rec.FieldCaption("No.")))
            else
                DeleteBlankLines(Rec);
        end;
    end;
    //Runs when Consignment Location Code is changed
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Consignment Location Code ARCJ', false, false)]
    local procedure PurchLineConsLocCodeOnAfterValidateJCO(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        Location: Record Location;
    begin
        if (xRec."Consignment Location Code ARCJ" <> '') and (Rec."Consignment Location Code ARCJ" <> xRec."Consignment Location Code ARCJ") then begin
            Rec.CalcFields("Qty. Shipped by Consignee JCO");
            if Rec."Qty. Shipped by Consignee JCO" <> 0 then
                Error(StrSubstNo(gText002Err, Rec.FieldCaption("Consignment Location Code ARCJ")))
            else
                DeleteBlankLines(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure OnAfterInitFromPurchLineJCOARC(PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        PurchLine.CalcFields("Qty. Shipped by Consignee JCO", "Qty. Received at Location JCO");
        PurchRcptLine."Qty. Shipped by Consignee JCO" := PurchLine."Qty. Shipped by Consignee JCO";
        PurchRcptLine."Qty. Received at Location JCO" := PurchLine."Qty. Received at Location JCO";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Line", 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure OnAfterInitFromPurchLine(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")

    begin
        PurchLine.CalcFields("Qty. Shipped by Consignee JCO", "Qty. Received at Location JCO");
        PurchInvLine."Qty. Shipped by Consignee JCO" := PurchLine."Qty. Shipped by Consignee JCO";
        PurchInvLine."Qty. Received at Location JCO" := PurchLine."Qty. Received at Location JCO";
    end;

    [EventSubscriber(ObjectType::Codeunit, 1314, 'OnCopySalesLinesToPurchaseLinesOnBeforeInsert', '', false, false)]
    local procedure OnCopySalesLinesToPurchaseLinesOnBeforeInsertJCOARC(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line")
    var
        Location: Record Location;
    begin
        Location.SetRange("Consignment Location ARCJCO", true);
        Location.SetRange("Consignment Vendor No. ARJCO", PurchaseLine."Buy-from Vendor No.");
        if Location.FindFirst() then
            PurchaseLine.validate("Consignment Location Code ARCJ", Location.Code);
        PurchaseLine.Validate(Quantity, PurchaseLine.Quantity);
    end;

    procedure DeleteBlankLines(PurchLine: Record "Purchase Line")
    var
        BlankConsignmentDetailARCJCO: Record "Purch. Consignment Det ARCJCO";
    begin
        BlankConsignmentDetailARCJCO.SetRange("Document Type", PurchLine."Document Type");
        BlankConsignmentDetailARCJCO.SetRange("Document No.", PurchLine."Document No.");
        BlankConsignmentDetailARCJCO.SetRange("Document Line No.", PurchLine."Line No.");
        BlankConsignmentDetailARCJCO.DeleteAll();
    end;

    procedure ArchiveConsigmentOrder(PurchConsignmentDetailJCOARC: Record "Purch. Consignment Det ARCJCO")
    var
        PurcahseHeader: Record "Purchase Header";
        ArchiveMgmt: Codeunit ArchiveManagement;
    begin
        if PurcahseHeader.Get(PurchConsignmentDetailJCOARC."Document Type", PurchConsignmentDetailJCOARC."Document No.") then
            if PurcahseHeader."Archive Ordr on Rcpt. ARCJCO" then
                ArchiveMgmt.ArchivePurchDocument(PurcahseHeader);
    end;
}