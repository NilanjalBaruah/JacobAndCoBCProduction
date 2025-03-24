namespace JCO.JCO;
using Microsoft.Sales.Document;
using Microsoft.Finance.Currency;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.History;
using Microsoft.Sales.History;
using Microsoft.Sales.Receivables;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Setup;
using Microsoft.Warehouse.History;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Journal;

codeunit 50202 "InventoryMgmt JCOARC"
{
    Permissions = TableData "Item Ledger Entry" = rimd,
                  TableData "Value Entry" = rimd,
                  tabledata "Sales Invoice Line" = rimd,
                  tabledata "Sales Cr.Memo Line" = rimd,
                  tabledata "Sales Shipment Line" = rimd,
                  tabledata "Return Receipt Line" = rimd,
                  tabledata "Purch. Inv. Line" = rimd,
                  tabledata "Purch. Cr. Memo Line" = rimd,
                  tabledata "Purch. Rcpt. Line" = rimd,
                  tabledata "Return Shipment Line" = rimd,
                  tabledata "Transfer Shipment Line" = rimd,
                  tabledata "Transfer Receipt Line" = rimd;

    //TransferEvents >>
    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterValidateEvent', 'Transfer-from Code', false, false)]
    local procedure TransferHeaderFromCodeOnAfterValidateJCO(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer)
    var
        Location: Record Location;
    begin
        //exit; //Fix as per UAT requirement. To allow taking inventory back from Consignee to LLC
        Location.Get(Rec."Transfer-from Code");
        if Location."Allow Trnsfer Ord ToFro ARCJCO" then
            exit;
        Location.TestField("Consignment Location ARCJCO", false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterValidateEvent', 'Transfer-to Code', false, false)]
    local procedure TransferHeaderToCodeOnAfterValidateJCO(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer)
    var
        Location: Record Location;
    begin
        Location.Get(Rec."Transfer-to Code");
        if Location."Allow Trnsfer Ord ToFro ARCJCO" then begin
            Rec.Validate("Customer No. JCOARC", Location."Consignment Customer No. ARJCO");
            exit;
        end;
        Location.TestField("Consignment Location ARCJCO", false);
        Rec.Validate("Customer No. JCOARC", Location."Consignment Customer No. ARJCO");
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure OnBeforeTransferOrderPostShipmentJCO(var TransferHeader: Record "Transfer Header"; var CommitIsSuppressed: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
        TransferLine: Record "Transfer Line";
    begin
        InvtSetup.Get();
        TransferLine.SetRange("Document No.", TransferHeader."No.");
        TransferLine.SetFilter("Qty. to Ship", '<>%1', 0);
        if TransferLine.FindSet() then
            repeat
                if InvtSetup."Reason Code required Trnfr ARC" then
                    TransferLine.TestField("Reason Code JCOARC");
            until TransferLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforeTransferOrderPostReceipt', '', false, false)]
    local procedure OnBeforeTransferOrderPostReceiptJCO(var TransferHeader: Record "Transfer Header"; var CommitIsSuppressed: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var
        InvtSetup: Record "Inventory Setup";
        TransferLine: Record "Transfer Line";
    begin
        InvtSetup.Get();
        TransferLine.SetRange("Document No.", TransferHeader."No.");
        TransferLine.SetFilter("Qty. to Receive", '<>%1', 0);
        if TransferLine.FindSet() then
            repeat
                if InvtSetup."Reason Code required Trnfr ARC" then
                    TransferLine.TestField("Reason Code JCOARC");
            until TransferLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, 5857, 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure JCOOnAfterCopyFromTransferLine(var DirectTransLine: Record "Direct Trans. Line"; TransferLine: Record "Transfer Line")
    begin
        DirectTransLine."Reason Code JCOARC" := TransferLine."Reason Code JCOARC";
        DirectTransLine."Currency Code JCOARC" := TransferLine."Currency Code JCOARC";
        DirectTransLine."Unit Price JCOARC" := TransferLine."Unit Price JCOARC";
        DirectTransLine."Line Amount JCOARC" := TransferLine."Line Amount JCOARC";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5856, 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure JCODirectTranOnAfterCreateItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; TransLine: Record "Transfer Line"; DirectTransHeader: Record "Direct Trans. Header"; DirectTransLine: Record "Direct Trans. Line")
    begin
        if DirectTransLine."Reason Code JCOARC" <> '' then
            ItemJnlLine."Reason Code" := DirectTransLine."Reason Code JCOARC"
        else
            ItemJnlLine."Reason Code" := TransLine."Reason Code JCOARC"
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure JCOTransShptOnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine."Reason Code" := TransferLine."Reason Code JCOARC";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure JCOOnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    begin
        ItemJournalLine."Reason Code" := TransferLine."Reason Code JCOARC";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeInsertTransShptHeader', '', false, false)]
    local procedure OnBeforeInsertTransShptHeaderJCO(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    begin
        TransShptHeader."Customer No. JCOARC" := TransHeader."Customer No. JCOARC";
        TransShptHeader."Currency Code JCOARC" := TransHeader."Currency Code JCOARC";
        TransShptHeader."Currency Factor JCOARC" := TransHeader."Currency Factor JCOARC";
        TransShptHeader."Your Reference JCOARC" := TransHeader."Your Reference JCOARC";
    end;

    [EventSubscriber(ObjectType::Table, database::"Transfer Shipment Line", 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure JCOOnAfterCopyFromTransferLinetoShptLine(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    begin
        TransferShipmentLine."Reason Code JCOARC" := TransferLine."Reason Code JCOARC";
        TransferShipmentLine."Currency Code JCOARC" := TransferLine."Currency Code JCOARC";
        TransferShipmentLine."Unit Price JCOARC" := TransferLine."Unit Price JCOARC";
        TransferShipmentLine."Line Amount JCOARC" := TransferLine."Line Amount JCOARC";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforeTransRcptHeaderInsert', '', false, false)]
    local procedure OnBeforeTransRcptHeaderInsertJCO(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Customer No. JCOARC" := TransferHeader."Customer No. JCOARC";
        TransferReceiptHeader."Currency Code JCOARC" := TransferHeader."Currency Code JCOARC";
        TransferReceiptHeader."Currency Factor JCOARC" := TransferHeader."Currency Factor JCOARC";
        TransferReceiptHeader."Your Reference JCOARC" := TransferHeader."Your Reference JCOARC";
    end;

    [EventSubscriber(ObjectType::Table, 5747, 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure JCOOnAfterCopyFromTransferLinetoRcptLine(var TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line")
    begin
        TransferReceiptLine."Reason Code JCOARC" := TransferLine."Reason Code JCOARC";
        TransferReceiptLine."Currency Code JCOARC" := TransferLine."Currency Code JCOARC";
        TransferReceiptLine."Unit Price JCOARC" := TransferLine."Unit Price JCOARC";
        TransferReceiptLine."Line Amount JCOARC" := TransferLine."Line Amount JCOARC";
    end;
    //TransferEvents <<

    [EventSubscriber(ObjectType::Table, Database::"Location", 'OnAfterValidateEvent', 'Location Group Code ARCJCO', false, false)]

    local procedure OnAfterValidateLocationLocationGroupCodeJCO(var Rec: Record Location; var xRec: Record Location; CurrFieldNo: Integer)
    var
        ItemLedgerEntryJCO: Record "Item Ledger Entry";
        ValueEntryJCO: Record "Value Entry";
        SalesLineJCO: Record "Sales Line";
        SalesInvLineJCO: Record "Sales Invoice Line";
        SalesCrMemoLineJCO: Record "Sales Cr.Memo Line";
        PurchLineJCO: Record "Purchase Line";
        PurchInvLineJCO: Record "Purch. Inv. Line";
        PurchCrMemoLineJCO: Record "Purch. Cr. Memo Line";
        LocationGroupChangeConf: Label 'Changing the Location Group Code for this Location will update the Location Group references in Ledger Entries and Open documents. Do you want to continue?';
    begin
        if Rec."Location Group Code ARCJCO" = xRec."Location Group Code ARCJCO" then
            exit;
        if not Confirm(LocationGroupChangeConf) then begin
            Rec."Location Group Code ARCJCO" := xRec."Location Group Code ARCJCO";
            exit;
        end;
        ItemLedgerEntryJCO.SetRange("Location Code", Rec.Code);
        ItemLedgerEntryJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if ItemLedgerEntryJCO.FindSet() then
            repeat
                ItemLedgerEntryJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                ItemLedgerEntryJCO.Modify();
            until ItemLedgerEntryJCO.Next() = 0;

        ValueEntryJCO.SetRange("Location Code", Rec.Code);
        ValueEntryJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if ValueEntryJCO.FindSet() then
            repeat
                ValueEntryJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                ValueEntryJCO.Modify();
            until ValueEntryJCO.Next() = 0;

        SalesLineJCO.SetRange("Location Code", Rec.Code);
        SalesLineJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if SalesLineJCO.FindSet() then
            repeat
                SalesLineJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                SalesLineJCO.Modify();
            until SalesLineJCO.Next() = 0;

        SalesInvLineJCO.SetRange("Location Code", Rec.Code);
        SalesInvLineJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if SalesInvLineJCO.FindSet() then
            repeat
                SalesInvLineJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                SalesInvLineJCO.Modify();
            until SalesInvLineJCO.Next() = 0;

        SalesCrMemoLineJCO.SetRange("Location Code", Rec.Code);
        SalesCrMemoLineJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if SalesCrMemoLineJCO.FindSet() then
            repeat
                SalesCrMemoLineJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                SalesCrMemoLineJCO.Modify();
            until SalesCrMemoLineJCO.Next() = 0;

        PurchLineJCO.SetRange("Location Code", Rec.Code);
        PurchLineJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if PurchLineJCO.FindSet() then
            repeat
                PurchLineJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                PurchLineJCO.Modify();
            until PurchLineJCO.Next() = 0;

        PurchInvLineJCO.SetRange("Location Code", Rec.Code);
        PurchInvLineJCO.SetFilter("Location Group Code ARCJCO", '%1', xRec."Location Group Code ARCJCO");
        if PurchInvLineJCO.FindSet() then
            repeat
                PurchInvLineJCO."Location Group Code ARCJCO" := Rec."Location Group Code ARCJCO";
                PurchInvLineJCO.Modify();
            until PurchInvLineJCO.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterValidateLocationCode', '', false, false)]
    local procedure OnAfterValidateLocationCodeJCO(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        Location: Record Location;
    begin
        if SalesLine."Location Code" <> '' then begin
            Location.Get(SalesLine."Location Code");
            SalesLine."Location Group Code ARCJCO" := Location."Location Group Code ARCJCO";
        end else
            SalesLine."Location Group Code ARCJCO" := '';
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnAfterValidateLocationCode', '', false, false)]
    local procedure OnAfterValidateLocationCode(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    var
        Location: Record Location;
    begin
        if PurchaseLine."Location Code" <> '' then begin
            Location.Get(PurchaseLine."Location Code");
            PurchaseLine."Location Group Code ARCJCO" := Location."Location Group Code ARCJCO";
        end else
            PurchaseLine."Location Group Code ARCJCO" := '';
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeaderJCO(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    var
        Location: Record Location;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) or (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) then begin
            ItemJnlLine."Ship-to Address JCO" := SalesHeader."Ship-to Address";
            ItemJnlLine."Ship-to Post Code JCO" := SalesHeader."Ship-to Post Code";
            ItemJnlLine."Ship-to County JCO" := SalesHeader."Ship-to County";
            ItemJnlLine."Ship-to Cntry/Region Code JCO" := SalesHeader."Ship-to Country/Region Code";
            if Location.Get(SalesHeader."Location Code") then
                ItemJnlLine."Ship-from Cntry/Regin Code JCO" := Location."Country/Region Code";
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeaderJCO(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
        Location: Record Location;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) or (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) then begin
            GenJournalLine."Ship-to Address JCO" := SalesHeader."Ship-to Address";
            GenJournalLine."Ship-to Post Code JCO" := SalesHeader."Ship-to Post Code";
            GenJournalLine."Ship-to County JCO" := SalesHeader."Ship-to County";
            GenJournalLine."Ship-to Cntry/Region Code JCO" := SalesHeader."Ship-to Country/Region Code";
            if Location.Get(SalesHeader."Location Code") then
                GenJournalLine."Ship-from Cntry/Regin Code JCO" := Location."Country/Region Code";
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLineJCO(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Ship-to Address JCO" := GenJournalLine."Ship-to Address JCO";
        CustLedgerEntry."Ship-to Cntry/Region Code JCO" := GenJournalLine."Ship-to Cntry/Region Code JCO";
        CustLedgerEntry."Ship-to County JCO" := GenJournalLine."Ship-to County JCO";
        CustLedgerEntry."Ship-to Post Code JCO" := GenJournalLine."Ship-to Post Code JCO";
        CustLedgerEntry."Ship-from Cntry/Regin Code JCO" := GenJournalLine."Ship-from Cntry/Regin Code JCO";
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure JCOOnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        Location: Record Location;
    begin
        NewItemLedgEntry."Reason Code JCOARC" := ItemJournalLine."Reason Code";
        if ItemJournalLine."New Location Code" <> '' then begin
            Location.Get(ItemJournalLine."New Location Code");
            if Location."Damage/Repair Location ARCJCO" then
                NewItemLedgEntry."Damage/Repair Location ARCJCO" := Location."Damage/Repair Location ARCJCO";
            NewItemLedgEntry."Location Group Code ARCJCO" := Location."Location Group Code ARCJCO";
        end else if ItemJournalLine."Location Code" <> '' then begin
            Location.Get(ItemJournalLine."Location Code");
            if Location."Damage/Repair Location ARCJCO" then
                NewItemLedgEntry."Damage/Repair Location ARCJCO" := Location."Damage/Repair Location ARCJCO";
            NewItemLedgEntry."Location Group Code ARCJCO" := Location."Location Group Code ARCJCO";
        end;
        if (ItemJournalLine."Location Code" = '') and (ItemJournalLine."New Location Code" = '') then
            NewItemLedgEntry."Location Group Code ARCJCO" := '';
        NewItemLedgEntry."Ship-to Address JCO" := ItemJournalLine."Ship-to Address JCO";
        NewItemLedgEntry."Ship-to Cntry/Region Code JCO" := ItemJournalLine."Ship-to Cntry/Region Code JCO";
        NewItemLedgEntry."Ship-to County JCO" := ItemJournalLine."Ship-to County JCO";
        NewItemLedgEntry."Ship-to Post Code JCO" := ItemJournalLine."Ship-to Post Code JCO";
        NewItemLedgEntry."Ship-from Cntry/Regin Code JCO" := ItemJournalLine."Ship-from Cntry/Regin Code JCO";
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitValueEntry', '', false, false)]
    local procedure JCOOnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer; var ItemLedgEntry: Record "Item Ledger Entry")
    var
        Location: Record Location;
    begin
        if Location.Get(ItemLedgEntry."Location Code") then
            ValueEntry."Location Group Code ARCJCO" := ItemLedgEntry."Location Group Code ARCJCO";
        if ItemLedgEntry."Location Code" = '' then
            ValueEntry."Location Group Code ARCJCO" := '';
        ValueEntry."Ship-to Address JCO" := ItemLedgEntry."Ship-to Address JCO";
        ValueEntry."Ship-to Cntry/Region Code JCO" := ItemLedgEntry."Ship-to Cntry/Region Code JCO";
        ValueEntry."Ship-to County JCO" := ItemLedgEntry."Ship-to County JCO";
        ValueEntry."Ship-to Post Code JCO" := ItemLedgEntry."Ship-to Post Code JCO";
        ValueEntry."Ship-from Cntry/Regin Code JCO" := ItemLedgEntry."Ship-from Cntry/Regin Code JCO";
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure JCOOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        SalesLine: Record "Sales Line";
        Location: Record Location;
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
        if SalesHeader.Ship then
            SalesLine.SetFilter("Qty. to Ship", '<>%1', 0);
        if SalesHeader.Receive then
            SalesLine.SetFilter("Return Qty. to Receive", '<>%1', 0);
        if SalesHeader.Invoice then
            SalesLine.SetFilter("Qty. to Invoice", '<>%1', 0);
        if SalesLine.FindSet() then
            repeat
                Location.Get(SalesLine."Location Code");
                Location.TestField("Sales/Purchase Location ARCJCO");
            until SalesLine.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]

    local procedure JCOOnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        Location: Record Location;
    begin
        //For Intercompany incoming Purchase Incoices (JC0-153)>>
        /*
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
            if PurchaseHeader."IC Direction" = PurchaseHeader."IC Direction"::Incoming then begin
                PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                PurchaseLine.SetFilter(Type, '%1', PurchaseLine.Type::Item);
                PurchaseLine.SetFilter("Qty. to Invoice", '<>%1', 0);
                if PurchaseLine.FindSet() then
                    Repeat
                        PurchaseLine.TestField("Original PO No. JCO");
                        PurchaseLine.Testfield("Original PO Line No. JCO");
                    until PurchaseLine.Next() = 0;
                exit;
            end;
        */
        //For Intercompany incoming Purchase Incoices<<

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter(Type, '%1', PurchaseLine.Type::Item);
        if PurchaseHeader.Receive then
            PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        if PurchaseHeader.Ship then
            PurchaseLine.SetFilter("Return Qty. to Ship", '<>%1', 0);
        if PurchaseHeader.Invoice then
            PurchaseLine.SetFilter("Qty. to Invoice", '<>%1', 0);
        if PurchaseLine.FindSet() then
            repeat
                Location.Get(PurchaseHeader."Location Code");
                Location.TestField("Sales/Purchase Location ARCJCO");
            until PurchaseLine.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, database::"Transfer Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValuesJCO(var TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header")
    var
        Item: Record Item;
    begin
        Item.Get(TransferLine."Item No.");
        TransferLine.Validate("Unit Price JCOARC", Item."Unit Price");
        if TransferLine.Quantity <> 0 then
            TransferLine.Validate(Quantity);
    end;

    [EventSubscriber(ObjectType::Table, database::"Transfer Line", 'OnValidateQuantityOnBeforeTransLineVerifyChange', '', false, false)]
    local procedure OnValidateQuantityOnBeforeTransLineVerifyChangeJCO(var TransferLine: Record "Transfer Line"; xTransferLine: Record "Transfer Line"; var IsHandled: Boolean)
    begin
        TransferLine."Line Amount JCOARC" := TransferLine.Quantity * TransferLine."Unit Price JCOARC";
    end;


    [EventSubscriber(ObjectType::Table, database::"Transfer Line", 'OnAfterGetTransHeader', '', false, false)]

    local procedure OnAfterGetTransHeaderJCOARC(var TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header")
    begin
        TransferLine.Validate("Currency Code JCOARC", TransferHeader."Currency Code JCOARC");
    end;

    procedure UpdateTransferCurrencyFactorJCO(var TransHeader: Record "Transfer Header"; var xTransHeader: Record "Transfer Header"; Updated: Boolean)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        CurrencyDate: Date;
    begin
        if Updated then
            exit;

        if TransHeader."Currency Code JCOARC" <> '' then begin
            if TransHeader."Posting Date" <> 0D then
                CurrencyDate := TransHeader."Posting Date"
            else
                CurrencyDate := WorkDate();

            if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, TransHeader."Currency Code JCOARC") then begin
                TransHeader."Currency Factor JCOARC" := CurrExchRate.ExchangeRate(CurrencyDate, TransHeader."Currency Code JCOARC");
                if TransHeader."Currency Code JCOARC" <> xTransHeader."Currency Code JCOARC" then
                    UpdateTransLinesJCO(TransHeader);
            end else
                UpdateCurrencyExchangeRates.ShowMissingExchangeRatesNotification(TransHeader."Currency Code JCOARC");
        end else begin
            TransHeader."Currency Factor JCOARC" := 0;
            if TransHeader."Currency Factor JCOARC" <> xTransHeader."Currency Factor JCOARC" then
                UpdateTransLinesJCO(TransHeader)
        end;
    end;

    procedure UpdateTransLinesJCO(TransHeader: Record "Transfer Header")
    var
        TransLine: Record "Transfer Line";
    begin
        TransLine.SetRange("Document No.", TransHeader."No.");
        if TransLine.FindSet() then
            repeat
                TransLine.Validate("Currency Code JCOARC", TransHeader."Currency Code JCOARC");
                TransLine.Modify();
            until TransLine.Next() = 0;
    end;
    //one off maintenance function>>
    procedure UpdateLedgerLocatiionGroup()
    var
        LocationJCO: Record Location;
        ItemLedgerEntryJCO: Record "Item Ledger Entry";
        ValueEntryJCO: Record "Value Entry";
        SalesLineJCO: Record "Sales Line";
        SalesInvLineJCO: Record "Sales Invoice Line";
        SalesCrMemoLineJCO: Record "Sales Cr.Memo Line";
        PurchLineJCO: Record "Purchase Line";
        PurchInvLineJCO: Record "Purch. Inv. Line";
        PurchCrMemoLineJCO: Record "Purch. Cr. Memo Line";
    begin
        LocationJCO.SetFilter("Location Group Code ARCJCO", '<>%1', '');
        if LocationJCO.FindSet() then
            repeat
                ItemLedgerEntryJCO.Reset();
                ItemLedgerEntryJCO.SetRange("Location Code", LocationJCO.Code);
                ItemLedgerEntryJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if ItemLedgerEntryJCO.FindSet() then
                    ItemLedgerEntryJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");
                ValueEntryJCO.Reset();
                ValueEntryJCO.SetRange("Location Code", LocationJCO.Code);
                ValueEntryJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if ValueEntryJCO.FindSet() then
                    ValueEntryJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");

                SalesLineJCO.Reset();
                SalesLineJCO.SetRange("Location Code", LocationJCO.Code);
                SalesLineJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if SalesLineJCO.FindSet() then
                    SalesLineJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");

                SalesInvLineJCO.Reset();
                SalesInvLineJCO.SetRange("Location Code", LocationJCO.Code);
                SalesInvLineJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if SalesInvLineJCO.FindSet() then
                    SalesInvLineJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");

                SalesCrMemoLineJCO.Reset();
                SalesCrMemoLineJCO.SetRange("Location Code", LocationJCO.Code);
                SalesCrMemoLineJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if SalesCrMemoLineJCO.FindSet() then
                    SalesCrMemoLineJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");

                PurchLineJCO.Reset();
                PurchLineJCO.SetRange("Location Code", LocationJCO.Code);
                PurchLineJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if PurchLineJCO.FindSet() then
                    PurchLineJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");

                PurchInvLineJCO.Reset();
                PurchInvLineJCO.SetRange("Location Code", LocationJCO.Code);
                PurchInvLineJCO.SetFilter("Location Group Code ARCJCO", '%1', '');
                if PurchInvLineJCO.FindSet() then
                    PurchInvLineJCO.ModifyAll("Location Group Code ARCJCO", LocationJCO."Location Group Code ARCJCO");
            until LocationJCO.Next() = 0;
        ItemLedgerEntryJCO.Reset();
        ItemLedgerEntryJCO.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Posting Date");
        ItemLedgerEntryJCO.SetFilter("Location Code", '%1', '');
        ItemLedgerEntryJCO.SetFilter("Location Group Code ARCJCO", '<>%1', '');
        if ItemLedgerEntryJCO.FindSet() then
            ItemLedgerEntryJCO.ModifyAll("Location Group Code ARCJCO", '');
    end;
    [EventSubscriber(ObjectType::Table, Database::"Item", 'OnAfterValidateEvent', 'Item Category Code', false, false)]
    local procedure ItemCategoryCodeOnAfterValidateJCO(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        SalesLine: Record "Sales Line";
        SalesShptLine: Record "Sales Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        RetRcptLine: Record "Return Receipt Line";
        PurchLine: Record "Purchase Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        RetShptLine: Record "Return Shipment Line";
        TransferLine: Record "Transfer Line";
        TransferShptLine: Record "Transfer Shipment Line";
        TransferRcptLine: Record "Transfer Receipt Line";
        ItemJnlLine: Record "Item Journal Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ConfMessageLbl: Label 'You are changing the %1 of Item %2 from %3 to %4. Do you want to update all open and historical transactions to reflect the new Item Category of this Item?', Comment = '%1=FieldCaption("Item Category Code"), %2="No.", %3= xRec."Item Category Code", %4= Rec."Item Category Code"';
    begin
        if Rec."Item Category Code" = xRec."Item Category Code" then
            exit;
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        ItemLedgerEntry.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if ItemLedgerEntry.FindFirst() then
            if not Confirm(StrSubstNo(ConfMessageLbl, Rec.FieldCaption("Item Category Code"), Rec."No.", xRec."Item Category Code", Rec."Item Category Code"), false) then
                exit;

        //Update Open and Posted Sales
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", Rec."No.");
        SalesLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if SalesLine.Findfirst() then
            SalesLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        SalesShptLine.SetRange(Type, SalesShptLine.Type::Item);
        SalesShptLine.SetRange("No.", Rec."No.");
        SalesShptLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if SalesShptLine.Findfirst() then
            SalesShptLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
        SalesInvLine.SetRange("No.", Rec."No.");
        SalesInvLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if SalesInvLine.Findfirst() then
            SalesInvLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
        SalesCrMemoLine.SetRange("No.", Rec."No.");
        SalesCrMemoLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if SalesCrMemoLine.Findfirst() then
            SalesCrMemoLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        RetRcptLine.SetRange(Type, RetRcptLine.Type::Item);
        RetRcptLine.SetRange("No.", Rec."No.");
        RetRcptLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if RetRcptLine.Findfirst() then
            RetRcptLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        //Update Open and Posted Purchase
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        PurchLine.SetRange("No.", Rec."No.");
        PurchLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if PurchLine.Findfirst() then
            PurchLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        PurchRcptLine.SetRange(Type, PurchRcptLine.Type::Item);
        PurchRcptLine.SetRange("No.", Rec."No.");
        PurchRcptLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if PurchRcptLine.Findfirst() then
            PurchRcptLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        PurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
        PurchInvLine.SetRange("No.", Rec."No.");
        PurchInvLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if PurchInvLine.Findfirst() then
            PurchInvLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        RetShptLine.SetRange(Type, SalesLine.Type::Item);
        RetShptLine.SetRange("No.", Rec."No.");
        RetShptLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if RetShptLine.Findfirst() then
            RetShptLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        PurchCrMemoLine.SetRange(Type, PurchCrMemoLine.Type::Item);
        PurchCrMemoLine.SetRange("No.", Rec."No.");
        PurchCrMemoLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if PurchCrMemoLine.Findfirst() then
            PurchCrMemoLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        //Update Open and Posted Transfers
        TransferLine.SetRange("Item No.", Rec."No.");
        TransferLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if TransferLine.Findfirst() then
            TransferLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        TransferShptLine.SetRange("Item No.", Rec."No.");
        TransferShptLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if TransferShptLine.Findfirst() then
            TransferShptLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        TransferRcptLine.SetRange("Item No.", Rec."No.");
        TransferRcptLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if TransferRcptLine.Findfirst() then
            TransferRcptLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        //Update Open Journals
        ItemJnlLine.SetRange("Item No.", Rec."No.");
        ItemJnlLine.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if ItemJnlLine.Findfirst() then
            ItemJnlLine.ModifyAll("Item Category Code", Rec."Item Category Code");

        //Update Item ledgers
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        ItemLedgerEntry.SetFilter("Item Category Code", '<>%1', Rec."Item Category Code");
        if ItemLedgerEntry.Findfirst() then
            ItemLedgerEntry.ModifyAll("Item Category Code", Rec."Item Category Code");
    end;
}