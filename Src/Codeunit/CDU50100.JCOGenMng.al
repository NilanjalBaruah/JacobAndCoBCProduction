codeunit 50100 "JCO Genrl Management"
{
    trigger OnRun()
    begin

    end;

    var
        FromSalesHeader: Record "Sales Header";
        ILE: Record "Item Ledger Entry";


    //This EventSubscriber is used to copy the sales field to purchase Table during the creation of Purchase Order from Sales Order page
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCreatePurchaseOrderOnAfterPurchaseHeaderSetFilters', '', false, false)]
    local procedure JCOCreatePurchaseHeaderOnBeforeInsert(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header");
    begin
        PurchaseHeader."JCO Sales Order No." := SalesHeader."No.";
        PurchaseHeader."JCO Sales Quote No." := SalesHeader."Quote No.";
        PurchaseHeader."JCO Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        PurchaseHeader.Modify(true);

        Commit();
        FromSalesHeader.Reset();
        IF FromSalesHeader.Get(FromSalesHeader."Document Type"::Order, PurchaseHeader."JCO Sales Order No.") then begin
            FromSalesHeader."JCO Purchase Order No." := PurchaseHeader."No.";
            FromSalesHeader."JCO Vendor No." := PurchaseHeader."Buy-from Vendor No.";
            FromSalesHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderLine', '', false, false)]
    local procedure OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; var RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    var
        Location: Record Location;
    begin

        PurchOrderLine."JCO SalesOrderLine.No." := RequisitionLine."Demand Order No.";
        PurchOrderLine."JCO Sales Order Line No." := RequisitionLine."Demand Line No.";
        PurchOrderLine."JCO Sell-to Customer No." := PurchOrderHeader."JCO Sell-to Customer No.";

        Location.SetRange("Consignment Location ARCJCO", true);
        Location.SetRange("Consignment Vendor No. ARJCO", PurchOrderHeader."Buy-from Vendor No.");
        if Location.FindFirst() then begin
            PurchOrderLine.Validate("Consignment Location Code ARCJ", Location.Code);
            PurchOrderLine.Validate(Quantity, PurchOrderLine.Quantity);
        end;
        PurchOrderLine.Modify();
    end;


    //This function is created to update the Address 3 when selecting the customer No. from sales order    
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnBeforeCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer; var IsHandled: Boolean)
    begin
        SalesHeader."JCO Address 3" := Customer."JCO Address 3";
    end;


    //This function is created to update the Sales Line "JCO RTV" field from Item ledger Quantity Field     
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnApplToItemEntryValidateOnBeforeMessage', '', false, false)]
    local procedure OnApplToItemEntryValidateOnBeforeMessage(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin

        ILE.Reset();
        IF ILE.Get(SalesLine."Appl.-to Item Entry") then begin
            SalesLine.Validate("JCO RTV", ILE.Quantity);
        end;
    end;
}