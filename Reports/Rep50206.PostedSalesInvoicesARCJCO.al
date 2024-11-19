namespace JCO_BCDev_JCO_Refined.JCO_BCDev_JCO_Refined;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Foundation.Company;
using Microsoft.Sales.History;
using Microsoft.Foundation.Address;

report 50206 "Posted Sales Invoices ARCJCO"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './PostedSalesInvoicesARCJCO.rdl';

    Caption = 'Posted Sales Invoices Listing';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date", "Sell-to Customer No.", "Location Code";
            DataItemTableView = sorting("Sell-to Customer No.");
            column(HeaderPostingDate; Format("Posting Date"))
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

            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = SalesInvoiceHeader;
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
                column(Line_Discount__; "Line Discount %")
                {
                }
                trigger OnAfterGetRecord()
                var
                    ExtendedTextLine: Record "Extended Text Line";
                    ValueEntry: Record "Value Entry";
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
                    end;
                    ValueEntry.Reset();
                    ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                    ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                    ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                    ValueEntry.SetRange("Document No.", "Document No.");
                    ValueEntry.SetRange("Document Line No.", "Line No.");
                    if ValueEntry.FindSet() then
                        repeat
                            ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.");
                            If ItemLedgerEntry."Serial No." <> '' then begin
                                if SerialNumberText <> '' then
                                    SerialNumberText := SerialNumberText + ' ,' + ItemLedgerEntry."Serial No."
                                else
                                    SerialNumberText := ItemLedgerEntry."Serial No.";
                            end;
                        until ValueEntry.Next() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter(Type, '%1|%2', Type::"G/L Account", Type::Item);
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
        Filters := SalesInvoiceHeader.GetFilters;
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
}