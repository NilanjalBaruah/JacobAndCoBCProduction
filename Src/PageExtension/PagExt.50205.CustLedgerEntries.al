namespace JCO.JCO;

using Microsoft.Sales.Receivables;

pageextension 50205 "CustLedgerEntries Extn ARCJCO" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("Sub Document Type ARCJCO"; Rec."Sub Document Type ARCJCO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Additional Type of the Transaction';
            }
        }

        addafter(Description)
        {
            field("Description 2"; Rec."Description 2 ARCJCO")
            {
                ToolTip = 'Additional Description entered in Journal Line';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Sales (LCY)")
        {
            field(VATAmount; VATAmount)
            {
                Caption = 'Tax/VAT Amount';
                ToolTip = 'Show the Tax or VAT Amount';
                ApplicationArea = All;
                Editable = false;
            }
            field(VATAmountDollar; VATAmountDollar)
            {
                Caption = 'Tax/VAT Amount ($)';
                ToolTip = 'Show the Tax or VAT Amount in $';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Detailed &Ledger Entries")
        {
            action(UpdateEntryType)
            {
                Caption = 'One off Update Entry Type (Addidional)';
                ApplicationArea = All;
                trigger OnAction()
                var
                    JCOSubscriptions: Codeunit "JCO Subscriptions";
                begin
                    JCOSubscriptions.OneOffMaintenanceCLEAddDocType();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(VATAmount);
        Clear(VATAmountDollar);
        if Rec."Sales (LCY)" = 0 then
            exit;
        Rec.CalcFields("Amount (LCY)");
        VATAmountDollar := (Rec."Amount (LCY)" - Rec."Sales (LCY)");
        VATAmount := VATAmountDollar;
        if Rec."Currency Code" <> '' then
            VATAmount := round(VATAmountDollar * Rec."Original Currency Factor", 0.01);
    end;

    var
        VATAmount: Decimal;
        VATAmountDollar: Decimal;
}