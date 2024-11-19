// namespace Microsoft.Inventory.Transfer;

// using Microsoft.Foundation.Address;
// using Microsoft.Inventory.Item;
// using Microsoft.Foundation.ExtendedText;
// using Microsoft.Inventory.Tracking;
// using Microsoft.Foundation.Company;
// using Microsoft.Foundation.Shipping;
// using System.Utilities;

report 50203 "Transfer Order JCO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransferOrderJCO.rdl';
    Caption = 'Transfer Order';
    WordMergeDataItem = "Transfer Header";

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Order';
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(No_TransferHdr; "No.")
            {
            }
            column(TransferOrderNoCaption; TransferOrderNoCaptionLbl)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CopyCaption; StrSubstNo(Text001, CopyText))
                    {
                    }
                    column(TransferToAddr1; TransferToAddr[1])
                    {
                    }
                    column(TransferFromAddr1; TransferFromAddr[1])
                    {
                    }
                    column(TransferToAddr2; TransferToAddr[2])
                    {
                    }
                    column(TransferFromAddr2; TransferFromAddr[2])
                    {
                    }
                    column(TransferToAddr3; TransferToAddr[3])
                    {
                    }
                    column(TransferFromAddr3; TransferFromAddr[3])
                    {
                    }
                    column(TransferToAddr4; TransferToAddr[4])
                    {
                    }
                    column(TransferFromAddr4; TransferFromAddr[4])
                    {
                    }
                    column(TransferToAddr5; TransferToAddr[5])
                    {
                    }
                    column(TransferToAddr6; TransferToAddr[6])
                    {
                    }
                    column(InTransitCode_TransHdr; "Transfer Header"."In-Transit Code")
                    {
                        IncludeCaption = true;
                    }
                    column(DirectTransfer; "Transfer Header"."Direct Transfer")
                    {
                    }
                    column(PostingDate_TransHdr; Format("Transfer Header"."Posting Date", 0, 4))
                    {
                    }
                    column(TransferToAddr7; TransferToAddr[7])
                    {
                    }
                    column(TransferToAddr8; TransferToAddr[8])
                    {
                    }
                    column(TransferFromAddr5; TransferFromAddr[5])
                    {
                    }
                    column(TransferFromAddr6; TransferFromAddr[6])
                    {
                    }
                    column(PageCaption; StrSubstNo(Text002, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShptMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    dataitem("Transfer Line"; "Transfer Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = sorting("Document No.", "Line No.") where("Derived From Line No." = const(0));
                        column(ItemNo_TransLine; "Item No.")
                        {
                        }
                        column(Desc_TransLine; FullItemDescription)
                        {
                        }
                        column(SerialNumberText; SerialNumberText)
                        {
                        }
                        column(Qty_TransLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(UOM_TransLine; "Unit of Measure")
                        {
                            IncludeCaption = true;
                        }
                        column(Qty_TransLineShipped; "Quantity Shipped")
                        {
                            IncludeCaption = true;
                        }
                        column(QtyReceived_TransLine; "Quantity Received")
                        {
                            IncludeCaption = true;
                        }
                        column(TransFromBinCode_TransLine; "Transfer-from Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(TransToBinCode_TransLine; "Transfer-To Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(LineNo_TransLine; "Line No.")
                        {
                        }
                        column(ItemPicture; Item.Picture)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            ReservationEntry: Record "Reservation Entry";
                            ExtendedTextLine: Record "Extended Text Line";
                        begin
                            Clear(FullItemDescription);
                            Clear(SerialNumberText);
                            Item.Get("Item No.");

                            FullItemDescription := Description;

                            ReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                            ReservationEntry.SetRange("Source Type", 5741);
                            ReservationEntry.SetRange("Source Subtype", 0);
                            ReservationEntry.SetRange("Source ID", "Document No.");
                            ReservationEntry.SetRange("Source Ref. No.", "Line No.");
                            ReservationEntry.SetRange("Item No.", "Item No.");
                            if ReservationEntry.FindSet() then begin
                                repeat
                                    if SerialNumberText <> '' then
                                        SerialNumberText := SerialNumberText + ' ,' + ReservationEntry."Serial No."
                                    else
                                        SerialNumberText := ReservationEntry."Serial No.";
                                until ReservationEntry.Next() = 0;
                                case ReservationEntry.Count of
                                    1:
                                        SerialNumberText := 'SERIAL NO.: ' + SerialNumberText;
                                    0:
                                        SerialNumberText := '';
                                    else
                                        SerialNumberText := 'SERIAL NOS.: ' + SerialNumberText;
                                end;
                            end;

                            if ShowFullItemDesc then begin
                                ExtendedTextLine.Reset();
                                ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                                ExtendedTextLine.SetRange("No.", "Item No.");
                                ExtendedTextLine.SetRange("Language Code", '');
                                if ExtendedTextLine.FindSet() then
                                    repeat
                                        FullItemDescription += ', ' + ExtendedTextLine.Text;
                                    until ExtendedTextLine.Next() = 0;
                            end;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text000;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FormatAddr.TransferHeaderTransferFrom(TransferFromAddr, "Transfer Header");
                FormatAddr.TransferHeaderTransferTo(TransferToAddr, "Transfer Header");

                if not ShipmentMethod.Get("Shipment Method Code") then
                    ShipmentMethod.Init();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Location;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowFullItemDesc; ShowFullItemDesc)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Full Item Description';
                        ToolTip = 'Specifies if you want the printed report to show Complete Description of the Items from Extended Text.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        ShptMethodDescCaption = 'Shipment Method';
    }
    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        ShowFullItemDesc: Boolean;
        FullItemDescription: Text;
        SerialNumberText: Text;
        CopyText: Text[30];

        Text000: Label 'COPY';
        Text001: Label 'Transfer Order %1';
        Text002: Label 'Page %1';
        TransferOrderNoCaptionLbl: Label 'Transfer Order No.';

    protected var
        ShipmentMethod: Record "Shipment Method";
        FormatAddr: Codeunit "Format Address";
        TransferFromAddr: array[8] of Text[100];
        TransferToAddr: array[8] of Text[100];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
}