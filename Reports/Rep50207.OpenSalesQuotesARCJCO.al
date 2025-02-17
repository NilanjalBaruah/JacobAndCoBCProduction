namespace JCO_BCDev_JCO_Refined.JCO_BCDev_JCO_Refined;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;

report 50207 "Open Sales Quotes ARCJCO"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './OpenSalesQuoteARCJCO.rdl';

    Caption = 'Open Sales Quotes Listing';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = sorting("Sell-to Customer No.") where("Document Type" = Filter("Document Type"::Quote));
            RequestFilterFields = "Order Date", "Sell-to Customer No.", "Location Code";
            column(HeaderPostingDate; Format("Order Date"))
            {
            }
            column(HeaderNo; "No.")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(Filters; Filters)
            {
            }

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Item));
                RequestFilterFields = "No.", "Item Category Code", "Location Group Code ARCJCO";
                DataItemLinkReference = SalesHeader;
                column(Line_No_; "Line No.")
                {
                }
                column(PostingDate; Format("Posting Date"))
                {
                }
                column(DocumentNo; "Document No.")
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(LocationCode; "Location Code")
                {
                }
                column(Description; FullItemDescription)
                {
                }
                column(SerialNo; SerialNumberText)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(ItemPicture; Item.Picture)
                {
                }
                column(UnitPrice; "Unit Price")
                {
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                }
                column(OnHandSaleableLLC; OnHandSaleableLLC)
                {
                }
                column(OnHandSaleableSWISS; OnHandSaleableSWISS)
                {
                }
                column(OnHandSaleableLocation; OnHandSaleableLocation)
                {
                }
                trigger OnAfterGetRecord()
                var
                    ExtendedTextLine: Record "Extended Text Line";
                    ReservationEntry: Record "Reservation Entry";
                    ItemLedgerEntry: Record "Item Ledger Entry";
                begin
                    Clear(FullItemDescription);
                    Clear(SerialNumberText);

                    FullItemDescription := Description;
                    if Type = Type::Item then begin
                        Item.Get("No.");
                        FullItemDescription := Item.Description;
                    end;
                    if ShowFullItemDesc then begin
                        ExtendedTextLine.Reset();
                        ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                        ExtendedTextLine.SetRange("No.", "No.");
                        ExtendedTextLine.SetRange("Language Code", '');
                        if ExtendedTextLine.FindSet() then
                            repeat
                                FullItemDescription += ', ' + ExtendedTextLine.Text;
                            until ExtendedTextLine.Next() = 0;
                        if (StrPos(FullItemDescription, 'HS CODE') = 0) AND (StrPos(FullItemDescription, 'HS_CODE_') = 0) then
                            if Item."Tariff No." <> '' then
                                FullItemDescription += ', HS CODE: ' + Item."Tariff No.";
                        if StrPos(FullItemDescription, 'COUNTRY OF ORIGIN') = 0 then
                            if Item."Country/Region of Origin Code" <> '' then
                                FullItemDescription += ', COUNTRY OF ORIGIN: ' + Item."Country/Region of Origin Code";
                        if StrPos(FullItemDescription, 'NET WEIGHT') = 0 then
                            if Item."Net Weight" <> 0 then
                                FullItemDescription += ', NET WEIGHT: ' + format(Item."Net Weight") + ' GR';
                    end;
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source Type", 37);
                    ReservationEntry.SetRange("Source Subtype", 0);
                    ReservationEntry.SetRange("Source ID", SalesLine."Document No.");
                    ReservationEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
                    ReservationEntry.SetRange("Item No.", SalesLine."No.");
                    if ReservationEntry.FindSet() then begin
                        repeat
                            if SerialNumberText <> '' then
                                SerialNumberText := SerialNumberText + ' ,' + ReservationEntry."Serial No."
                            else
                                SerialNumberText := ReservationEntry."Serial No.";
                        until ReservationEntry.Next() = 0;
                        case ReservationEntry.Count of
                            1:
                                SerialNumberText := 'SERIAL NO.: ' + SerialNumberText;
                            0:
                                SerialNumberText := '';
                            else
                                SerialNumberText := 'SERIAL NOS.: ' + SerialNumberText;
                        end;
                    end;
                    OnHandSaleableLocation := GetOnHandInventory("No.", '');
                    OnHandSaleableLLC := GetOnHandInventory("No.", 'LLC');
                    OnHandSaleableSWISS := GetOnHandInventory("No.", 'SWISS');
                end;

                trigger OnPreDataItem()
                begin
                    //                   SetRange(Type, Type::Item);
                end;
            }
        }

    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(ShowFullItemDesc; ShowFullItemDesc)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Full Item Description';
                        ToolTip = 'Specifies if you want the printed report to show Complete Description of the Items from Extended Text.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        ShowFullItemDesc := true;
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        Filters := SalesHeader.GetFilters;
        CompanyAddress[1] := CompanyInfo.Name + ',';
        CompanyAddress[2] := CompanyInfo.Address + ',';
        CompanyAddress[3] := CompanyInfo.City + ',';
        CompanyAddress[4] := CompanyInfo.County + ' - ' + CompanyInfo."Post Code";
        CompanyAddress[5] := CompanyInfo."Country/Region Code";
        CompanyAddress[6] := CompanyInfo."Phone No.";
    end;

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        FormatAddress: Codeunit "Format Address";
        ShowFullItemDesc: Boolean;
        FullItemDescription: Text;
        SerialNumberText: Text;
        CompanyAddress: array[8] of text[100];
        Filters: Text;
        OnHandSaleableLLC: Decimal;
        OnHandSaleableSWISS: Decimal;
        OnHandSaleableLocation: Decimal;

    Local procedure GetOnHandInventory(ItemNo: Code[20]; LocationCode: code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesReservationEntry: Record "Reservation Entry";
        SalesLineQty: Decimal;
    begin
        Clear(SalesLineQty);
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if LocationCode <> '' then
            ItemLedgerEntry.SetRange("Location Code", LocationCode);
        ItemLedgerEntry.SetRange(Open, true);
        ItemLedgerEntry.CalcSums("Remaining Quantity");

        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", ItemNo);
        if LocationCode <> '' then
            SalesLine.SetRange("Location Code", LocationCode);
        if SalesLine.FindSet() then
            repeat
                SalesReservationEntry.Reset();
                SalesReservationEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Reservation Status", "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.", "Package No.");
                SalesReservationEntry.SetRange("Source Type", 37);
                SalesReservationEntry.SetRange("Source Subtype", 1);
                SalesReservationEntry.SetRange("Source ID", SalesLine."Document No.");
                SalesReservationEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
                SalesReservationEntry.SetRange("Item No.", SalesLine."No.");
                SalesReservationEntry.CalcSums("Quantity (Base)");
                SalesLineQty += SalesReservationEntry."Quantity (Base)";
            until SalesLine.Next() = 0;
        exit(ItemLedgerEntry."Remaining Quantity" - SalesLineQty);
    end;
}