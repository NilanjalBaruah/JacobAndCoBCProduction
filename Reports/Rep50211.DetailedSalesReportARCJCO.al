namespace JCO_BCDev_JCO_Refined.JCO_BCDev_JCO_Refined;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;

report 50211 "Detailed Sales Report ARCJCO"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './DetailedSalesReportARCJCO.rdl';

    Caption = 'Detailed Sales Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            RequestFilterFields = "Posting Date", "Source No.", "Location Code";
            DataItemTableView = sorting("Item Ledger Entry Type", "Posting Date", "Item No.", "Inventory Posting Group", "Dimension Set ID") where("Document Type" = filter("Sales Invoice" | "Sales Credit Memo"), "Item Ledger Entry Type" = filter("Sale"), "Source Type" = filter("Customer"));
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(CustNo; "Source No.")
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(Document_Type; DocType)
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Serial_No; "Serial No. JCO")
            {
            }
            column(Invoiced_Quantity; Abs("Invoiced Quantity"))
            {
            }
            column(Sales_Amount__Actual_; "Sales Amount (Actual)")
            {
            }
            column(Cost_Amount__Actual_; Abs("Cost Amount (Actual)"))
            {
            }
            column(Profit; ProfitAmt)
            {
            }
            column(AttColl; AttCollection)
            {
            }
            column(AttType; AttType)
            {
            }

            column(Description; FullItemDescription)
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

            trigger OnAfterGetRecord()
            var
                ExtendedTextLine: Record "Extended Text Line";
                ItemLedgerEntry: Record "Item Ledger Entry";
                ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                ItemAttributeValue: Record "Item Attribute Value";
            begin
                Clear(FullItemDescription);
                Clear(ProfitAmt);
                Clear(AttType);
                Clear(AttCollection);
                Clear(DocType);

                if not Customer.Get("Source No.") then
                    Customer.init;
                ProfitAmt := "Sales Amount (Actual)" + "Cost Amount (Actual)";
                if ProfitAmt < 0 then
                    ProfitAmt := 0;

                CalcFields("Serial No. JCO");
                //Full Description>>
                FullItemDescription := Description;
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

                //Type>>
                ItemAttributeValueMapping.SetRange("Table ID", 27);
                ItemAttributeValueMapping.SetRange("No.", "Item No.");
                ItemAttributeValueMapping.SetRange("Item Attribute ID", 2);
                ItemAttributeValueMapping.SetFilter("Item Attribute Value ID", '<>%1', 0);
                if ItemAttributeValueMapping.FindFirst() then begin
                    ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
                    AttType := ItemAttributeValue.Value;
                end;

                //Collection>>
                ItemAttributeValueMapping.SetRange("Table ID", 27);
                ItemAttributeValueMapping.SetRange("No.", "Item No.");
                ItemAttributeValueMapping.SetRange("Item Attribute ID", 4);
                ItemAttributeValueMapping.SetFilter("Item Attribute Value ID", '<>%1', 0);
                if ItemAttributeValueMapping.FindFirst() then begin
                    ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
                    AttCollection := ItemAttributeValue.Value;
                end;
                //DocType
                if "Document Type" = "Document Type"::"Sales Invoice" then
                    DocType := 'INV'
                else
                    DocType := 'CR';


            end;

            trigger OnPreDataItem()
            begin

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
                group(Options)
                {
                    field(ShowFullItemDesc; ShowFullItemDesc)
                    {
                        Visible = false;
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
        Filters := "Value Entry".GetFilters;
        CompanyAddress[1] := CompanyInfo.Name + ',';
        CompanyAddress[2] := CompanyInfo.Address + ',';
        CompanyAddress[3] := CompanyInfo.City + ',';
        CompanyAddress[4] := CompanyInfo.County + ' - ' + CompanyInfo."Post Code";
        CompanyAddress[5] := CompanyInfo."Country/Region Code";
        CompanyAddress[6] := CompanyInfo."Phone No.";
    end;

    var
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        FormatAddress: Codeunit "Format Address";
        ShowFullItemDesc: Boolean;
        FullItemDescription: Text;
        AttType: Text[50];
        AttCollection: Text[50];
        DocType: Text[5];
        CompanyAddress: array[8] of text[100];
        ProfitAmt: Decimal;
        Filters: Text;
}