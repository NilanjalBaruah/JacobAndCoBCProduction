namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.ExtendedText;

report 50210 "Items In Memo JCO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemsInMemoJCO.rdl';
    ApplicationArea = All;
    Caption = 'Items In Memo';
    UsageCategory = History;
    dataset
    {
        dataitem(ConsignmentDetailARCJCO; "Consignment Detail ARCJCO")
        {
            RequestFilterFields = "Consignment Status", "Consignment Location Code", "Shipment Date", "B2B Sales Date";
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
            column(CompanyAddress7; CompanyAddress[7])
            {
            }
            column(CompanyAddress8; CompanyAddress[8])
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(B2BSalesDate; Format("B2B Sales Date"))
            {
            }
            column(AppltoItemEntry; "Appl.-to Item Entry")
            {
            }
            column(Comment; Comment)
            {
            }
            column(ConfirmSoldbyCustromer; "Confirm Sold by Custromer")
            {
            }
            column(ConsignmentLocationCode; "Consignment Location Code")
            {
            }
            column(Description; FullItemDescription)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(ConsignedItemEntryNo; "Consigned Item Entry No.")
            {
            }
            column(ConsignmentStatus; "Consignment Status")
            {
            }
            column(DocumentLineNo; "Document Line No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(ItemwithBusiness; "Item with Business")
            {
            }
            column(LineNo; "Line No.")
            {
            }
            column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(ShipmentConfirmedBy; "Shipment Confirmed By")
            {
            }
            column(ShipmentDate; format("Shipment Date"))
            {
            }
            column(SerialNo; "Serial No.")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(UnitofMeasureCode; "Unit of Measure Code")
            {
            }
            column(ItemPicture; Item.Picture)
            {
            }
            column(Filters; Filters)
            {
            }
            trigger OnPreDataItem()
            begin
                SetFilter("Shipment Date", '<>%1', 0D);
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(FullItemDescription);
                if not Item.Get("Item No.") then
                    Item.Init();

                FullItemDescription := Description;
                ExtendedTextLine.Reset();
                ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                ExtendedTextLine.SetRange("No.", "Item No.");
                ExtendedTextLine.SetRange("Language Code", '');
                if ExtendedTextLine.FindSet() then
                    repeat
                        FullItemDescription += ', ' + ExtendedTextLine.Text;
                    until ExtendedTextLine.Next() = 0;
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        Filters := ConsignmentDetailARCJCO.GetFilters;
        CompanyAddress[1] := CompanyInfo.Name + ',';
        CompanyAddress[2] := CompanyInfo.Address + ',';
        CompanyAddress[3] := CompanyInfo.City + ',';
        CompanyAddress[4] := CompanyInfo.County + ' - ' + CompanyInfo."Post Code";
        CompanyAddress[5] := CompanyInfo."Country/Region Code";
        CompanyAddress[6] := CompanyInfo."Phone No.";
    end;

    var
        Item: Record Item;
        CompanyInfo: Record "Company Information";
        ExtendedTextLine: Record "Extended Text Line";
        FormatAddress: Codeunit "Format Address";
        CompanyAddress: array[8] of text[100];
        FullItemDescription: Text;
        Filters: Text;
}
