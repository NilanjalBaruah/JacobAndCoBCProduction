namespace JCO.JCO;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using JCO_BCDev_JCO.JCO_BCDev_JCO;

pageextension 50214 "PSalesInvoices Extn JCO" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            //JCO-91>>
            field("Consignment Order ARCJCO"; Rec."Consignment Order ARCJCO")
            {
                ToolTip = 'Specifies, if this is a Invoice related to a Consignment(B2B) Sales';
                ApplicationArea = All;
            }
            //JCO-91<<          
        }
        addafter(Amount)
        {
            field(amountDollar; AmountDollar)
            {
                ToolTip = 'Shows the Sales Amount in $';
                Caption = 'Amount $';
                ApplicationArea = All;
                Editable = false;
                AssistEdit = true;
                trigger OnAssistEdit()
                var
                    SalesInvoiceLine: Record "Sales Invoice Line";
                begin
                    SalesInvoiceLine.SetRange("Document No.", Rec."No.");
                    SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
                    Page.RunModal(page::"Posted Sales Invoice Lines", SalesInvoiceLine);
                end;
            }
        }
        addafter("Amount Including VAT")
        {
            field("Tax/VAT Amount"; Rec."Amount Including VAT" - Rec.Amount)
            {
                Caption = 'Tax/VAT Amount';
                ToolTip = 'Show the Tax or VAT Amount';
                ApplicationArea = All;
            }

            field("Tax/VAT Amount$"; VATAmountDollar)
            {
                Caption = 'Tax/VAT Amount ($)';
                ToolTip = 'Show the Tax or VAT Amount in $';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore(Invoice)
        {
            group(Conignment)
            {
                action(ConsignmentHitoryARCJCO)
                {
                    Image = History;
                    Caption = 'Consignment History';
                    ToolTip = 'Use this button to open the list showing all serial numbers consigned to Business';
                    Visible = ConsignmentHistoryEnabled;
                    ApplicationArea = All;
                    RunObject = page "Ord Consignments Hist ARCJOC";
                    RunPageLink = "Posted Invoice No." = field("No.");
                    ShortcutKey = "Ctrl+Alt+F10";
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        Clear(AmountDollar);
        Clear(VATAmountDollar);
        Rec.CalcFields(Amount, "Amount Including VAT");
        AmountDollar := Rec.Amount;
        if Rec."Currency Factor" <> 0 then
            if Rec.Amount <> 0 then
                AmountDollar := round(Rec.Amount / Rec."Currency Factor", 0.01);
        if (Rec."Amount Including VAT" - Rec.Amount) <> 0 then begin
            VATAmountDollar := (Rec."Amount Including VAT" - Rec.Amount);
            if Rec."Currency Factor" <> 0 then begin
                if VATAmountDollar <> 0 then
                    VATAmountDollar := round(VATAmountDollar / Rec."Currency factor", 0.01);
            end;
        end;
        ConsignmentHistoryEnabled := Rec."Consignment Order ARCJCO";
    end;

    var
        AmountDollar: Decimal;
        VATAmountDollar: Decimal;
        ConsignmentHistoryEnabled: Boolean;
}