namespace JCO.JCO;

using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Finance.Currency;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Setup;

tableextension 50221 "TransferHeader Extn ARCJCO" extends "Transfer Header"
{
    fields
    {
        field(50201; "Customer No. JCOARC"; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Get("Customer No. JCOARC");
                if Customer."Currency Code" <> '' then
                    Validate("Currency Code JCOARC", Customer."Currency Code");
            end;
        }
        field(50202; "Currency Code JCOARC"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            var
                InventoryMgmtJCO: Codeunit "InventoryMgmt JCOARC";
            begin
                if "Currency Code JCOARC" <> xRec."Currency Code JCOARC" then
                    InventoryMgmtJCO.UpdateTransferCurrencyFactorJCO(Rec, xRec, false)
                else
                    if "Currency Code JCOARC" <> '' then
                        InventoryMgmtJCO.UpdateTransferCurrencyFactorJCO(Rec, xRec, false)
            end;
        }
        field(50203; "Currency Factor JCOARC"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50204; "Your Reference JCOARC"; Text[50])
        {
            Caption = 'Your Reference';
        }
    }
}