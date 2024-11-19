namespace JCO.JCO;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;
using Microsoft.Intercompany.Inbox;
using Microsoft.Purchases.History;


codeunit 50205 "Intercompany Mgmt JCOARC"
{
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchaseDoc', '', false, false)]

    local procedure OnAfterPostPurchaseDocJCOARC(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ConsignmentDetailARCJCO: Record "Purch. Consignment Det ARCJCO";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
        ItemLedgerEntry.SetRange("Document No.", PurchRcpHdrNo);
        ItemLedgerEntry.SetRange(Open, true);
        if ItemLedgerEntry.FindSet() then
            repeat
                PurchRcptLine.Reset();
                PurchRcptLine.SetRange("Document No.", PurchRcpHdrNo);
                PurchRcptLine.SetRange("Line No.", ItemLedgerEntry."Document Line No.");
                if PurchRcptLine.FindFirst() then begin
                    ConsignmentDetailARCJCO.Reset();
                    ConsignmentDetailARCJCO.SetRange("Document Type", ConsignmentDetailARCJCO."Document Type"::Order);
                    ConsignmentDetailARCJCO.SetRange("Document No.", PurchRcptLine."Original PO No. JCO");
                    ConsignmentDetailARCJCO.SetRange("Document Line No.", PurchRcptLine."Original PO Line No. JCO");
                    ConsignmentDetailARCJCO.SetFilter("Serial No.", '%1', '');
                    if ConsignmentDetailARCJCO.FindFirst() then begin
                        ConsignmentDetailARCJCO.Validate("Serial No.", ItemLedgerEntry."Serial No.");
                        ConsignmentDetailARCJCO."Consigned Item Entry No." := ItemLedgerEntry."Entry No.";
                        ConsignmentDetailARCJCO."Consignment Status" := ConsignmentDetailARCJCO."Consignment Status"::"Shipped By Vendor";
                        ConsignmentDetailARCJCO.Modify();
                    end;
                end;
            until ItemLedgerEntry.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 427, 'OnCreatePurchDocumentOnBeforePurchHeaderModify', '', false, false)]
    local procedure OnCreatePurchDocumentOnBeforePurchHeaderModifyJCOARC(var PurchHeader: Record "Purchase Header"; ICInboxPurchHeader: Record "IC Inbox Purchase Header")
    var
        Location: Record Location;
    begin
        Location.SetRange("Consignment Location ARCJCO", true);
        Location.SetRange("Consignment Vendor No. ARJCO", ICInboxPurchHeader."Buy-from Vendor No.");
        if Location.FindFirst() then
            PurchHeader.Validate("Location Code", Location.Code);
    end;

    [EventSubscriber(ObjectType::Codeunit, 427, 'OnCreatePurchLinesOnBeforeCalcPriceAndAmounts', '', false, false)]
    local procedure OnCreatePurchLinesOnBeforeCalcPriceAndAmountsJCOARC(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchaseLine.Validate("Location Code", PurchaseHeader."Location Code");
    end;
}