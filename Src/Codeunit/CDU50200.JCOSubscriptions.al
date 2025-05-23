namespace JCO.JCO;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Receivables;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Customer;
using Microsoft.Finance.VAT.Setup;
using JCO_BC_Dev_.JCO_BC_Dev_;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
using Microsoft.Bank.BankAccount;
using Microsoft.Foundation.Enums;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;
using Microsoft.Bank.Ledger;
using Microsoft.Finance.ReceivablesPayables;


codeunit 50200 "JCO Subscriptions"
{
    Permissions = TableData "Cust. Ledger Entry" = rimd,
                  TableData "Sales Invoice Header" = rimd,
                  tabledata "Sales Cr.Memo Header" = rimd;

    //This event is used to flow custom field data from General Journal Line to GL Entries
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitGLEntry', '', false, false)]
    procedure OnAfterInitGLEntryJCO(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    begin
        if GenJournalLine."Description 2 ARCJCO" <> '' then
            GLEntry."Description 2 ARCJCO" := GenJournalLine."Description 2 ARCJCO";
    end;

    //This event is used to flow custom field data from General Journal Line to Vendor Ledger Entry
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeVendLedgEntryInsert', '', false, false)]
    local procedure OnBeforeVendLedgEntryInsert(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        if GenJournalLine."Description 2 ARCJCO" <> '' then
            VendorLedgerEntry."Description 2 ARCJCO" := GenJournalLine."Description 2 ARCJCO";
    end;

    //This event is used to flow custom field data from General Journal Line to Customer Ledger Entry
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeCustLedgEntryInsert', '', false, false)]

    local procedure OnBeforeCustLedgEntryInsertJCO(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    begin
        if GenJournalLine."Description 2 ARCJCO" <> '' then
            CustLedgerEntry."Description 2 ARCJCO" := GenJournalLine."Description 2 ARCJCO";
    end;

    //This event is used to flow custom field data from General Journal Line to Bank Account Ledger Entry
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', false, false)]

    local procedure OnPostBankAccOnBeforeBankAccLedgEntryInsertJCO(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: record "Bank Account"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextTransactionNo: Integer; GLRegister: Record "G/L Register")
    begin
        if GenJournalLine."Description 2 ARCJCO" <> '' then
            BankAccountLedgerEntry."Description 2 ARCJCO" := GenJournalLine."Description 2 ARCJCO";
    end;

    //JCO-91
    [EventSubscriber(ObjectType::Table, Database::Location, 'OnAfterValidateEvent', 'Consignment Location ARCJCO', false, false)]
    local procedure ConsLocationAfterValidate(var Rec: Record "Location"; var xRec: Record Location; CurrFieldNo: Integer)
    begin
        if Rec."Consignment location ARCJCO" = false then
            if xRec."Consignment Location ARCJCO" = true then begin
                if (Rec."Consignment Customer No. ARJCO" = '') and (Rec."Consignment Vendor No. ARJCO" = '') then
                    exit;
                CheckOpenItemLedgerForCustomerVendor(Rec, xRec, 1);
                CheckOpenItemLedgerForCustomerVendor(Rec, xRec, 2);
                //if open entries found>>
                if OpenConsCustItemEntryFound and OpenConsVendItemEntryFound then
                    Error(StrSubstNo(Text001ARCJCOErr, Rec.FieldCaption("Consignment Location ARCJCO"), Rec."Consignment Customer No. ARJCO", Rec."Consignment Vendor No. ARJCO"));
                if Rec."Consignment Customer No. ARJCO" = '' then
                    if OpenConsVendItemEntryFound then
                        Error(StrSubstNo(Text003ARCJCOErr, Rec.FieldCaption("Consignment Location ARCJCO"), Rec."Consignment Vendor No. ARJCO"));
                if Rec."Consignment Vendor No. ARJCO" = '' then
                    if OpenConsCustItemEntryFound then
                        Error(StrSubstNo(Text002ARCJCOErr, Rec.FieldCaption("Consignment Location ARCJCO"), Rec."Consignment Customer No. ARJCO"));

                //if no open entries found>>
                if (not OpenConsCustItemEntryFound) and (not OpenConsVendItemEntryFound) then begin
                    if (Rec."Consignment Customer No. ARJCO" <> '') and (Rec."Consignment Vendor No. ARJCO" = '') then
                        if confirm(StrSubstNo(Text001ARCJCOConf, Rec.FieldCaption("Consignment Location ARCJCO"), Rec.FieldCaption("Consignment Customer No. ARJCO"), Rec."Consignment Customer No. ARJCO"), false) then
                            Rec."Consignment Customer No. ARJCO" := ''
                        else
                            Rec."Consignment Location ARCJCO" := true;
                    if (Rec."Consignment Vendor No. ARJCO" <> '') and (Rec."Consignment Customer No. ARJCO" = '') then
                        if confirm(StrSubstNo(Text001ARCJCOConf, Rec.FieldCaption("Consignment Location ARCJCO"), Rec.FieldCaption("Consignment Vendor No. ARJCO"), Rec."Consignment Vendor No. ARJCO"), false) then
                            Rec."Consignment Vendor No. ARJCO" := ''
                        else
                            Rec."Consignment Location ARCJCO" := true;
                    if (Rec."Consignment Customer No. ARJCO" <> '') and (Rec."Consignment Vendor No. ARJCO" <> '') then
                        if confirm(StrSubstNo(Text002ARCJCOConf, Rec.FieldCaption("Consignment Location ARCJCO"), Rec.FieldCaption("Consignment Customer No. ARJCO"), Rec.FieldCaption("Consignment Vendor No. ARJCO")), false) then begin
                            Rec."Consignment Customer No. ARJCO" := '';
                            Rec."Consignment Vendor No. ARJCO" := '';
                        end else
                            Rec."Consignment Location ARCJCO" := true;
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Location, 'OnAfterValidateEvent', 'Consignment Customer No. ARJCO', false, false)]
    local procedure ConsCustOnAfterValidate(var Rec: Record "Location"; var xRec: Record Location; CurrFieldNo: Integer)
    begin
        if xRec."Consignment Customer No. ARJCO" = '' then
            Rec.TestField("Consignment Location ARCJCO")
        else
            CheckForOpenEntries(Rec, xRec, 1);
    end;

    [EventSubscriber(ObjectType::Table, Database::Location, 'OnAfterValidateEvent', 'Consignment Vendor No. ARJCO', false, false)]
    local procedure VendOnAfterValidate(var Rec: Record "Location"; var xRec: Record Location; CurrFieldNo: Integer)
    begin
        if xRec."Consignment Vendor No. ARJCO" = '' then
            Rec.TestField("Consignment Location ARCJCO")
        else
            CheckForOpenEntries(Rec, xRec, 2);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnRecreatePurchLinesOnBeforeInsertPurchLine', '', false, false)]

    local procedure OnRecreatePurchLinesOnBeforeInsertPurchLineJCO(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary; ChangedFieldName: Text[100])
    begin
        PurchaseLine.Validate("Direct Unit Cost", TempPurchaseLine."Direct Unit Cost");
    end;

    //Additional Document Type to CLE
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeaderJCO(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Sub Document Type ARCJCO" := SalesHeader."Sub Document Type ARCJCO";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeaderPrepmtPost', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeaderPrepmtPost(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line"; UsePmtDisc: Boolean)
    var
        SubDocTypeJCO: Record "Sub Doc. Type ARCJCO";
    begin
        SubDocTypeJCO.SetRange("Default to Document Type", SubDocTypeJCO."Default to Document Type"::Prepayment);
        if SubDocTypeJCO.FindFirst() then
            GenJournalLine."Sub Document Type ARCJCO" := SubDocTypeJCO.Code;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnAfterInitCustLedgEntryJCO(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var GLRegister: Record "G/L Register")
    begin
        CustLedgerEntry."Sub Document Type ARCJCO" := GenJournalLine."Sub Document Type ARCJCO";
    end;

    [EventSubscriber(ObjectType::Codeunit, 442, 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; GenJnlDocNo: Code[20])
    var
        SubDocTypeJCO: Record "Sub Doc. Type ARCJCO";
    begin
        SubDocTypeJCO.SetRange("Default to Document Type", SubDocTypeJCO."Default to Document Type"::Prepayment);
        if SubDocTypeJCO.FindFirst() then
            SalesInvHeader."Sub Document Type ARCJCO" := SubDocTypeJCO.Code;
    end;

    procedure OneOffMaintenanceCLEAddDocType()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SubDocType: Record "Sub Doc. Type ARCJCO";
    begin
        CustLedgEntry.SetCurrentKey("Document Type", "Posting Date");
        if CustLedgEntry.FindSet() then
            repeat
                if CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::"Credit Memo" then begin
                    SalesCrMemoHeader.Reset();
                    SalesCrMemoHeader.SetRange("No.", CustLedgEntry."Document No.");
                    if SalesCrMemoHeader.FindFirst() then begin
                        SalesCrMemoLine.Reset();
                        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::"G/L Account");
                        SalesCrMemoLine.SetFilter(Amount, '<>%1', 0);
                        if SalesCrMemoLine.FindFirst() then begin
                            if SalesCrMemoLine."No." = '66000' then begin
                                SalesCrMemoHeader."Sub Document Type ARCJCO" := 'CO-OP MARKETING';
                                SalesCrMemoHeader.Modify();
                                CustLedgEntry."Sub Document Type ARCJCO" := 'CO-OP MARKETING';
                                CustLedgEntry.Modify();
                            end else begin
                                SalesCrMemoHeader."Sub Document Type ARCJCO" := '';
                                SalesCrMemoHeader.Modify();
                                CustLedgEntry."Sub Document Type ARCJCO" := '';
                                CustLedgEntry.Modify();
                            end;
                        end else begin
                            SalesCrMemoLine.Reset();
                            SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                            SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
                            SalesCrMemoLine.SetFilter(Amount, '<>%1', 0);
                            if SalesCrMemoLine.FindFirst() then begin
                                SalesCrMemoHeader."Sub Document Type ARCJCO" := 'RETURN';
                                SalesCrMemoHeader.Modify();
                                CustLedgEntry."Sub Document Type ARCJCO" := 'RETURN';
                                CustLedgEntry.Modify();
                            end;
                        end;
                    end;
                end else if CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Invoice then begin
                    if CustLedgEntry.Prepayment then begin
                        SubDocType.Reset();
                        SubDocType.SetRange("Default to Document Type", SubDocType."Default to Document Type"::Prepayment);
                        if SubDocType.FindFirst() then begin
                            SalesInvoiceHeader.Reset();
                            SalesInvoiceHeader.SetRange("No.", CustLedgEntry."Document No.");
                            if SalesInvoiceHeader.FindFirst() then begin
                                SalesInvoiceHeader."Sub Document Type ARCJCO" := SubDocType.Code;
                                SalesInvoiceHeader.Modify();

                                CustLedgEntry."Sub Document Type ARCJCO" := SubDocType.Code;
                                CustLedgEntry.Modify();
                            end;
                        end;
                    end;
                end;
            until CustLedgEntry.Next() = 0;
    end;
    //Additional Document Type to CLE<<

    //CheckFor: 1: Consignment Custoner, 2: Consignment Vendor
    local procedure CheckForOpenEntries(Loc: Record Location; xLoc: Record Location; CheckFor: Integer)
    begin
        case checkfor of
            0:
                begin
                end;
            1:
                begin
                    CheckOpenItemLedgerForCustomerVendor(Loc, xLoc, 1);
                    if OpenConsCustItemEntryFound then
                        Error(StrSubstNo(Text002ARCJCOErr, Loc.FieldCaption("Consignment Location ARCJCO"), xLoc."Consignment Customer No. ARJCO"));
                end;
            2:
                begin
                    CheckOpenItemLedgerForCustomerVendor(Loc, xLoc, 2);
                    if OpenConsVendItemEntryFound then
                        Error(StrSubstNo(Text003ARCJCOErr, Loc.FieldCaption("Consignment Location ARCJCO"), xLoc."Consignment Vendor No. ARJCO"));
                end;
        end;
    end;

    local procedure CheckOpenItemLedgerForCustomerVendor(Loc: Record Location; xLoc: Record Location; CheckFor: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        Clear(OpenConsCustItemEntryFound);
        Clear(OpenConsVendItemEntryFound);
        ItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgEntry.SetRange(Open, true);
        ItemLedgEntry.SetRange("Location Code", Loc.Code);
        case CheckFor of
            1:
                begin
                    ItemLedgEntry.SetRange("Source Type", ItemLedgEntry."Source Type"::Customer);
                    ItemLedgEntry.SetRange("Source No.", xLoc."Consignment Customer No. ARJCO");
                    if ItemLedgEntry.FindFirst() then
                        OpenConsCustItemEntryFound := true;
                end;
            2:
                begin
                    ItemLedgEntry.SetRange("Source Type", ItemLedgEntry."Source Type"::Vendor);
                    ItemLedgEntry.SetRange("Source No.", xLoc."Consignment Vendor No. ARJCO");
                    if ItemLedgEntry.FindFirst() then
                        OpenConsVendItemEntryFound := true;
                end;
        end;
    end;

    procedure PrintJCOStatement(var Customer: Record Customer)
    var
        Cust: Record Customer;
        CustomerStatementRpt: Report "Customer Statement ARCJCO";
    begin
        Cust.SetRange("No.", Customer."No.");
        CustomerStatementRpt.SetTableView(Cust);
        CustomerStatementRpt.RunModal();
    end;

    procedure PrintJCOStatementAll()
    var
        CustomerStatementRpt: Report "Customer Statement ARCJCO";
    begin
        CustomerStatementRpt.RunModal();
    end;

    var
        OpenConsCustItemEntryFound: Boolean;
        OpenConsVendItemEntryFound: Boolean;
        Text001ARCJCOErr: label 'You cannot unmark %1 because there are one or more open ledger entries for this location, for Consignment Customer %2 and Consignment Vendor %3.', Comment = '%1=caption(Consignment Location), %2= Consignment Customer No., %3=Consignment Vemdor No.';
        Text002ARCJCOErr: label 'You cannot unmark %1 because there are one or more open ledger entries for this location, for Consignment Customer %2.', Comment = '%1=caption(Consignment Location), %2= Consignment Customer No.';
        Text003ARCJCOErr: label 'You cannot unmark %1 because there are one or more open ledger entries for this location, for Consignment Vendor %2.', Comment = '%1=caption(Consignment Location), %2= Consignment Vendor No.';
        Text001ARCJCOConf: Label 'Unmarking %1 will delink the location from %2 = %3. Do you want to continue?', Comment = '%1=Fieldcaption(Consignment Location), %2= Fieldcaption(Consignment Customer No.), %3=Consignment Customer No.';
        Text002ARCJCOConf: Label 'Unmarking %1 will delink the location from %2 and %3 linked to it. Do you want to continue?', Comment = '%1=Fieldcaption(Consignment Location), %2= Fieldcaption(Consignment Customer No.), %3=Fieldcaption(Consignment Vendor No.)';
}