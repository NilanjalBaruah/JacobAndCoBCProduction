namespace JCO_BCDev_.JCO_BCDev_;

using Microsoft.Inventory.Ledger;
using JCO_BCDev_JCO_Refined.JCO_BCDev_JCO_Refined;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item.Attribute;

page 50210 "Detailed Sales Report JCOARC"
{
    ApplicationArea = All;
    Caption = 'Detailed Sales Report';
    PageType = List;
    SourceTable = "Value Entry";
    Editable = false;
    SourceTableView = sorting("Item Ledger Entry Type", "Posting Date", "Item No.", "Inventory Posting Group", "Dimension Set ID") where("Document Type" = filter("Sales Invoice" | "Sales Credit Memo"), "Item Ledger Entry Type" = filter("Sale"), "Source Type" = filter("Customer"));
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date of this entry.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what type of document was posted to create the value entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number of the entry.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer reference No. of the entry.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the Customer number';
                }
                field(CustomerName; CustName)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Customer Name';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item that this value entry is linked to.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Serial No. JCO"; Rec."Serial No. JCO")
                {
                    Caption = 'Serial No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Serial Number';
                }
                field("Item Ledger Entry Quantity"; Abs(Rec."Invoiced Quantity"))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the Quantity.';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of the item for a sales entry.';
                }
                field("Cost Amount (Actual)"; Abs(Rec."Cost Amount (Actual)"))
                {
                    Caption = 'Cost Ampunt';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost of invoiced items.';
                }
                field(ProfitAmt; ProfitAmt)
                {
                    ApplicationArea = All;
                    Caption = 'Profit Amount';
                    ToolTip = 'Specifies the Profit Amount';
                }
                field(AttType; AttType)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    ToolTip = 'Specifies the Type Attribute';
                }
                field(AttCollection; AttCollection)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    ToolTip = 'Specifies the Collection Attribute';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Location Code';
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(PrintReport)
            {
                Image = Print;
                Caption = 'Print Report';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Report.RunModal(report::"Detailed Sales Report ARCJCO");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        Clear(ProfitAmt);
        Clear(AttType);
        Clear(AttCollection);
        Clear(CustName);

        if Customer.Get(Rec."Source No.") then
            CustName := Customer.Name;
        ProfitAmt := Rec."Sales Amount (Actual)" + Rec."Cost Amount (Actual)";
        if ProfitAmt < 0 then
            ProfitAmt := 0;

        //Type>>
        ItemAttributeValueMapping.SetRange("Table ID", 27);
        ItemAttributeValueMapping.SetRange("No.", Rec."Item No.");
        ItemAttributeValueMapping.SetRange("Item Attribute ID", 2);
        ItemAttributeValueMapping.SetFilter("Item Attribute Value ID", '<>%1', 0);
        if ItemAttributeValueMapping.FindFirst() then begin
            ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
            AttType := ItemAttributeValue.Value;
        end;

        //Collection>>
        ItemAttributeValueMapping.SetRange("Table ID", 27);
        ItemAttributeValueMapping.SetRange("No.", Rec."Item No.");
        ItemAttributeValueMapping.SetRange("Item Attribute ID", 4);
        ItemAttributeValueMapping.SetFilter("Item Attribute Value ID", '<>%1', 0);
        if ItemAttributeValueMapping.FindFirst() then begin
            ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
            AttCollection := ItemAttributeValue.Value;
        end;
    end;

    var
        Customer: Record Customer;
        AttType: Text;
        AttCollection: Text;
        CustName: Text[100];
        ProfitAmt: Decimal;
}
