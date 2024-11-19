namespace JCO_BCDev_JCO.JCO_BCDev_JCO;
using JCO.JCO;

page 50208 "P Ord Consignments Hist ARCJOC"
{
    ApplicationArea = All;
    Caption = 'Order Consignments History';
    PageType = List;
    SourceTable = "Purch. Consignment Det ARCJCO";
    SourceTableView = sorting("Consignment Status") where("Consignment Status" = filter("Shipped By Vendor" | "Received At Location"));
    UsageCategory = None;
    DataCaptionFields = "Document No.", "Document Line No.", "Item No.";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Consignment Status"; Rec."Consignment Status")
                {
                    ToolTip = ' Status of Consignment for this Serial No.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. of the document Line (e.g. Sales Line)';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description of the document Line (e.g. Sales Line) ';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code the document Line (e.g. Sales Line)';
                    ApplicationArea = All;
                }
                field("Consignment Location Code"; Rec."Consignment Location Code")
                {
                    ToolTip = 'Specifies the value of the Consignment Location Code the customer in document Line(e.g. Sales Line)';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the Quantity of Serial number';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the Unit of Measurement of the Serial';
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. of the Item';
                    ApplicationArea = All;
                }
                field("Date Shipped by Vendor"; Rec."Date Shipped by Vendor")
                {
                    ToolTip = 'Specifies the date Shipped by Vendor';
                    ApplicationArea = All;
                }
                field("Item In Transit"; Rec."Item In Transit")
                {
                    ToolTip = 'Specifies, if the Item is in Transit or not not physically received at location';
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ToolTip = 'Specifies the Date phycically Received at Location';
                    ApplicationArea = All;
                }

                field("Receipt Confirmed By"; Rec."Receipt Confirmed By")
                {
                    ToolTip = 'Specifies the Name of the User who confirm the Receipt.';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    Caption = 'Shipment Comment';
                    ToolTip = 'Specifies theComment, if user wants to add to the line';
                    ApplicationArea = All;
                }
            }
        }
    }
}