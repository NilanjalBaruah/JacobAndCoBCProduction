namespace JCO.JCO;

using Microsoft.Inventory.Journal;
using Microsoft.Purchases.Setup;

tableextension 50111 "PurchaseSetup Extn ARCJCO" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50201; "Cons. Template Name JCOARC"; Code[10])
        {
            Caption = 'Consignment Journal Template Name';
            NotBlank = true;
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Template" where(Type = filter(Item));

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

    }
}