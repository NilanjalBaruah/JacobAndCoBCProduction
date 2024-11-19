table 50200 "Consignment Detail ARCJCO"
{
    Caption = 'Consignment Detail';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry Type"; Enum "Consignment Entry Type ARCJCO")
        {
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
        }

        field(2; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

        }
        field(4; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(6; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(7; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item where(Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(9; "Consignment Location Code"; Code[10])
        {
            Caption = 'Consignment Location Code';
            TableRelation = Location where("Consignment Location ARCJCO" = const(true), "Consignment Customer No. ARJCO" = field("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(13; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(14; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;

        }
        field(15; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                ItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code");
                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Positive, true);
                ItemLedgEntry.SetRange("Location Code", "Location Code");
                ItemLedgEntry.SetFilter("Serial No.", '<>%1', '');
                ItemLedgEntry.SetRange(Open, true);
                if PAGE.RunModal(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK then begin
                    "Serial No." := ItemLedgEntry."Serial No.";
                    Validate("Appl.-to Item Entry", ItemLedgEntry."Entry No.");
                end;
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                if "Appl.-to Item Entry" = 0 then
                    exit;
                ItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code");
                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Positive, true);
                ItemLedgEntry.SetRange("Location Code", "Location Code");
                ItemLedgEntry.SetRange("Serial No.", "Serial No.");
                ItemLedgEntry.SetRange(Open, true);
                if ItemLedgEntry.FindFirst() then begin
                    //If Not IsUsedInOtherReservation("Serial No.") then begin
                    "Appl.-to Item Entry" := ItemLedgEntry."Entry No.";
                    //"Serial No." := ItemLedgEntry."Serial No.";
                end;
            end;
        }
        field(16; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
            DataClassification = CustomerContent;
            TableRelation = "Item Ledger Entry" where("Location Code" = field("Location Code"), "Serial No." = field("Serial No."));
        }
        field(17; "Consignment Status"; Enum "Consignment Status ARCJCO")
        {
            Caption = 'Consignment Status';
            DataClassification = CustomerContent;
        }

        field(18; "Shipment Confirmed By"; Code[50])
        {
            Caption = 'Shipment Confirmed By';
            TableRelation = "User Setup";
        }
        field(19; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(20; "Item with Business"; Boolean)
        {
            Caption = 'Item with Business';
            Editable = true;
            FieldClass = FlowField;
            CalcFormula = exist("Item Ledger Entry" where("Item No." = field("Item No."), "Location Code" = field("Consignment Location Code"), Open = const(true), "Serial No." = field("Serial No.")));
        }
        field(21; "Consigned Item Entry No."; Integer)
        {
            Caption = 'Consigned Item Entry No.';
            Editable = true;
            TableRelation = "Item Ledger Entry" where("Location Code" = field("Consignment Location Code"), "Serial No." = field("Serial No."));
        }
        //When recieving sales information from business
        field(22; "Confirm Sold by Custromer"; Boolean)
        {
            Caption = 'Confirm Sold by Customer';
            DataClassification = CustomerContent;
        }
        field(23; "B2B Sales Date"; Date)
        {
            Caption = 'B2B Sales Date';
            DataClassification = CustomerContent;
        }
        field(24; Comment; Text[100])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
        field(25; "Returned Item Entry"; Integer)
        {
            Caption = 'Returned Item Entry';
            DataClassification = CustomerContent;
            TableRelation = "Item Ledger Entry" where("Location Code" = field("Location Code"), "Serial No." = field("Serial No."));
        }
        field(27; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = CustomerContent;
        }
        field(28; "Shipment Received By"; code[50])
        {
            Caption = 'Shipment Received By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }
        field(29; "Buy from Vendor No"; Code[20])
        {
            Caption = 'Buy from Vendor No';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(30; "Shipment Received at Loc"; Boolean)
        {
            Caption = 'Shipment Received at Location';
            DataClassification = CustomerContent;
        }
        //For return>>
        field(31; "Confirm Returned by Custromer"; Boolean)
        {
            Caption = 'Confirm Returned by Customer';
            DataClassification = CustomerContent;
        }
        field(32; "Date of Return"; Date)
        {
            Caption = 'Date of Return';
            DataClassification = CustomerContent;
        }
        field(33; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        //For return<<

    }
    keys
    {
        key(PK; "Entry Type", "Document Type", "Document No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Consignment Status")
        {

        }
    }

    procedure CalcBaseQty(Qty: Decimal; FromFieldName: Text; ToFieldName: Text): Decimal
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        exit(UOMMgt.CalcBaseQty(
            "Item No.", '', "Unit of Measure Code", Qty, "Qty. per Unit of Measure", 5, '', FromFieldName, ToFieldName));
    end;

    procedure IsUsedInOtherReservation(SerialNo: Text[50]): Boolean
    begin
        exit(false);
    end;
}