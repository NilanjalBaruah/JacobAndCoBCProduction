namespace JCO_BCDev_.JCO_BCDev_;

using Microsoft.Inventory.Ledger;
using JCO_BCDev_JCO_Refined.JCO_BCDev_JCO_Refined;
using Microsoft.Sales.Customer;
using JCO.JCO;
using Microsoft.Sales.Setup;
using Microsoft.Sales.History;
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Document Date of this entry.';
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
                field("Ship-to Address JCO"; Rec."Ship-to Address JCO")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address';
                    ToolTip = 'Shows the Ship-to Address of the Sales Document';
                }
                field("Ship-to State JCO"; Rec."Ship-to Address JCO")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to State';
                    ToolTip = 'Shows the Ship-to State of the Sales Document';
                }
                field("Ship-to Post Code JCO"; Rec."Ship-to Post Code JCO")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Zip Code';
                    ToolTip = 'Shows the Ship-to Zip Code of the Sales Document';
                }
                field("Ship-to Cntry/Region Code JCO"; Rec."Ship-to Cntry/Region Code JCO")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Country';
                    ToolTip = 'Shows the Ship-to Country of the Sales Document';
                }
                field("Ship-from Cntry/Regin Code JCO"; Rec."Ship-from Cntry/Regin Code JCO")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-from Country';
                    ToolTip = 'Shows the Ship-from Country of the Sales Document';
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
                field(UnitPrice; UnitPrice)
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit Price of the item for the sales entry.';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount $';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Amount of the item for a sales entry in $.';
                }
                field(SalesDollar; SalesCurr)
                {
                    Caption = 'Sales Amount';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Amount of the item for a sales entry in Customer Currency';

                }
                field("Cost per Unit"; Rec."Cost per Unit")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Cost';
                }
                field("Cost Amount (Actual)"; Abs(Rec."Cost Amount (Actual)"))
                {
                    Caption = 'Cost Amount';
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
        area(Navigation)
        {
            action("Show Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Document';
                Image = View;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'Open the document that the selected line exists on.';

                trigger OnAction()
                begin
                    case Rec."Document Type" = Rec."Document Type" of
                        Rec."Document Type" = Rec."Document Type"::"Sales Invoice":
                            begin
                                SalesInvHeader.Get(Rec."Document No.");
                                Page.Run(Page::"Posted Sales Invoice", SalesInvHeader);
                            end;
                        Rec."Document Type" = Rec."Document Type"::"Sales Credit Memo":
                            begin
                                SalesCrMemoHeader.Get(Rec."Document No.");
                                Page.Run(Page::"Posted Sales Credit Memo", SalesCrMemoHeader);
                            end;
                    end;
                end;
            }
        }

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
        SalesSetup: Record "Sales & Receivables Setup";
        CurrCode: Code[10];
        CurrFact: Decimal;
    begin
        Clear(ProfitAmt);
        Clear(AttType);
        Clear(AttCollection);
        Clear(CustName);
        Clear(CurrCode);
        Clear(CurrFact);
        Clear(UnitPrice);
        SalesSetup.Get();
        if Customer.Get(Rec."Source No.") then
            CustName := Customer.Name;
        ProfitAmt := Rec."Sales Amount (Actual)" + Rec."Cost Amount (Actual)";
        if ProfitAmt < 0 then
            if not SalesSetup."Show Loss as Neg. Prft JCOARC" then
                ProfitAmt := 0;
        case Rec."Document Type" = Rec."Document Type" of
            Rec."Document Type" = Rec."Document Type"::"Sales Invoice":
                begin
                    if SalesInvHeader.Get(Rec."Document No.") then begin
                        CurrCode := SalesInvHeader."Currency Code";
                        CurrFact := SalesInvHeader."Currency Factor";
                    end;
                end;
            Rec."Document Type" = Rec."Document Type"::"Sales Credit Memo":
                begin
                    if SalesCrMemoHeader.Get(Rec."Document No.") then begin
                        CurrCode := SalesCrMemoHeader."Currency Code";
                        CurrFact := SalesCrMemoHeader."Currency Factor";
                    end;
                end;
        end;
        if CurrFact = 0 then
            CurrFact := 1;
        if Rec."Sales Amount (Actual)" <> 0 then
            SalesCurr := round(Rec."Sales Amount (Actual)" * CurrFact, 0.01)
        else
            SalesCurr := Rec."Sales Amount (Actual)";
        if Rec."Sales Amount (Actual)" <> 0 then
            UnitPrice := Abs(Rec."Sales Amount (Actual)" / Rec."Invoiced Quantity");
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
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        AttType: Text;
        AttCollection: Text;
        CustName: Text[100];
        ProfitAmt: Decimal;
        SalesCurr: Decimal;
        UnitPrice: Decimal;
}
