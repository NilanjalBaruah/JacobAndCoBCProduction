namespace JCO.JCO;

using Microsoft.Inventory.Journal;
using Microsoft.Sales.Setup;

tableextension 50208 "SalesRecSetup Extn ARCJCO" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50201; "Cons. Template Name JCOARC"; Code[10])
        {
            Caption = 'Consignment Journal Template Name';
            NotBlank = true;
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Template" where(Type = filter(Transfer));
            trigger OnValidate()
            begin
                if Rec."Cons. Template Name JCOARC" = '' then
                    Rec."Cons. Batch Name JCOARC" := '';
            end;
        }
        field(50202; "Cons. Batch Name JCOARC"; Code[10])
        {
            Caption = 'Consignment Journal Batch Name';
            NotBlank = true;
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Cons. Template Name JCOARC"));

            trigger OnValidate()
            begin
                Rec.TestField("Cons. Template Name JCOARC");
            end;
        }
        field(50203; "Show Loss as Neg. Prft JCOARC"; Boolean)
        {
            Caption = 'Show Loss as Negative Profit';
            DataClassification = CustomerContent;
        }
    }
}