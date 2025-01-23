namespace JCO.JCO;
using Microsoft.Sales.Document;
using Microsoft.Finance.Currency;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Setup;
using Microsoft.Warehouse.History;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Posting;
using Microsoft.Intercompany.Setup;
using Microsoft.Inventory.Journal;


codeunit 50202 "InventoryMgmt JCOARC"
{
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
        end else if ItemJournalLine."Location Code" <> '' then begin
            Location.Get(ItemJournalLine."Location Code");
            if Location."Damage/Repair Location ARCJCO" then
                NewItemLedgEntry."Damage/Repair Location ARCJCO" := Location."Damage/Repair Location ARCJCO";
        end;

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
}