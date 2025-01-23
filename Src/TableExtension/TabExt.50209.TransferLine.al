namespace JCO.JCO;

using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;

tableextension 50209 "TransferLine Extn ARCJCO" extends "Transfer Line"
{
    fields
    {
        field(50201; "Reason Code JCOARC"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        //010325>>
        field(50202; "Currency Code JCOARC"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50203; "Unit Price JCOARC"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code JCOARC";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
                Currency: Record Currency;
            begin
                "Line Amount JCOARC" := Quantity * "Unit Price JCOARC";
                if "Currency Code JCOARC" <> '' then begin
                    Currency.Get("Currency Code JCOARC");
                    "Line Amount JCOARC" := Round("Line Amount JCOARC", Currency."Amount Rounding Precision");
                end else
                    "Line Amount JCOARC" := Round("Line Amount JCOARC", GLSetup."Amount Rounding Precision");
            end;
        }
        field(50204; "Line Amount JCOARC"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code JCOARC";
            AutoFormatType = 2;
            Caption = 'Line Amount';
        }
        //010325<<
    }
}