namespace JCO_BCDev_JCO_Refined.JCO_BCDev_JCO_Refined;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;

report 50205 "Items By Location ARCJCO"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ItemsByLocationARCJCO.rdl';

    Caption = 'Items By Location';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.", Positive, "Location Code", "Variant Code") where(Open = filter(true));
            RequestFilterFields = "Posting Date", "Item No.", "Location Code";
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
            column(ItemNo; "Item No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(Description; FullItemDescription)
            {
            }
            column(SerialNo; "Serial No.")
            {
            }
            column(ReasonCodeJCOARC; "Reason Code JCOARC")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(ItemPicture; Item.Picture)
            {
            }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            {
            }
            column(Sales_Amount__Actual_; "Sales Amount (Actual)")
            {
            }
            trigger OnAfterGetRecord()
            var
                ExtendedTextLine: Record "Extended Text Line";
            begin
                Clear(FullItemDescription);
                Item.Get("Item No.");

                FullItemDescription := Item.Description;
                if ShowFullItemDesc then begin
                    ExtendedTextLine.Reset();
                    ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                    ExtendedTextLine.SetRange("No.", "Item No.");
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
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
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
        Filters := ItemLedgerEntry.GetFilters;
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
        CompanyAddress: array[8] of text[100];
        Filters: Text;
}