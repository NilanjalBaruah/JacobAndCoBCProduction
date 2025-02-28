
report 50203 "Trans - Pro Forma Inv JCOARC"
{
    Caption = 'Transfer ProForma Invoice';
    DefaultRenderingLayout = "TranferProFormaInv.rdlc";
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Transfer Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Pro Forma Invoice';
            column(DocumentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyVATRegNo; CompanyInformation.GetVATRegistrationNumber())
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(CompanyAddress7; CompanyAddress[7])
            {
            }
            column(CompanyAddress8; CompanyAddress[8])
            {
            }
            column(CustomerAddress1; CustomerAddress[1])
            {
            }
            column(CustomerAddress2; CustomerAddress[2])
            {
            }
            column(CustomerAddress3; CustomerAddress[3])
            {
            }
            column(CustomerAddress4; CustomerAddress[4])
            {
            }
            column(CustomerAddress5; CustomerAddress[5])
            {
            }
            column(CustomerAddress6; CustomerAddress[6])
            {
            }
            column(CustomerAddress7; CustomerAddress[7])
            {
            }
            column(CustomerAddress8; CustomerAddress[8])
            {
            }
            column(YourReference; "Your Reference JCOARC")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(PaymentTermsDescription; PaymentTermsDescription)
            {
            }
            column(Currency; CurrencyCode)
            {
            }
            column(CurrencySymbol; CurrencySymbol)
            {

            }
            column(CustomerVATRegNo; Customer."VAT Registration No.")
            {
            }
            column(CustomerVATRegistrationNoLbl; CustomerVATRegistrationNumberLbl)
            {
            }
            column(ShipFromAddress1; ShipFromAddress[1])
            {
            }
            column(ShipFromAddress2; ShipFromAddress[2])
            {
            }
            column(ShipFromAddress3; ShipFromAddress[3])
            {
            }
            column(ShipFromAddress4; ShipFromAddress[4])
            {
            }
            column(ShipFromAddress5; ShipFromAddress[5])
            {
            }
            column(ShipFromAddress6; ShipFromAddress[6])
            {
            }
            column(ShipFromAddress7; ShipFromAddress[7])
            {
            }
            column(ShipFromAddress8; ShipFromAddress[8])
            {
            }
            column(ShipToAddress1; ShipToAddress[1])
            {
            }
            column(ShipToAddress2; ShipToAddress[2])
            {
            }
            column(ShipToAddress3; ShipToAddress[3])
            {
            }
            column(ShipToAddress4; ShipToAddress[4])
            {
            }
            column(ShipToAddress5; ShipToAddress[5])
            {
            }
            column(ShipToAddress6; ShipToAddress[6])
            {
            }
            column(ShipToAddress7; ShipToAddress[7])
            {
            }
            column(ShipToAddress8; ShipToAddress[8])
            {
            }
            column(CustomerNo; "Customer No. JCOARC")
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(DocumentTitleLbl; DocumentCaption())
            {
            }
            column(YourReferenceLbl; YourReferenceLbl)
            {
            }
            column(ExternalDocumentNoLbl; ExternalDocNoLbl)
            {
            }
            column(CustomerNoLbl; CustomerNoLbl)
            {
            }
            column(PaymentTermsLbl; PaymentTermsLbl)
            {
            }
            column(SalesPersonLbl; SalesPersonLblText)
            {
            }
            column(EMailLbl; CompanyInformation.FieldCaption("E-Mail"))
            {
            }
            column(HomePageLbl; '')
            {
            }
            column(CompanyPhoneNoLbl; CompanyInformation.FieldCaption("Phone No."))
            {
            }
            column(ShipmentMethodDescriptionLbl; ShipmentMethodLbl)
            {
            }
            column(CurrencyLbl; DummyCurrency.TableCaption())
            {
            }
            column(ItemLbl; ItemLbl)
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(TotalAmountInclVATLbl; TotalAmountInclVATLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(ShowDiscount; ShowDiscount)
            {
            }
            dataitem(Line; "Transfer Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(ItemPicture; Item.Picture)
                {

                }
                column(No; "Item No.")
                {
                }
                column(ItemDescription; FullItemDescription)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = "Currency Code JCOARC";
                    AutoFormatType = 2;
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code JCOARC";
                    AutoFormatType = 1;
                }
                column(LineAmountDec; LineAmount)
                {
                    AutoFormatExpression = "Currency Code JCOARC";
                    AutoFormatType = 1;
                }
                column(VATAmount; FormattedVATAmount)
                {
                }
                column(VATAmountDec; VATAmount)
                {
                    AutoFormatExpression = "Currency Code JCOARC";
                    AutoFormatType = 1;
                }
                column(SrNoJCO; SrNoJCOText)
                {
                }
                column(SerialNumberText; SerialNumberText)
                {
                }
                column(ShowSerialNoLine; ShowSerialNoLine)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                    ReservationEntry: Record "Reservation Entry";
                    SalesShipmentLine: Record "Sales Shipment Line";
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    SalesLineComment: Record "Sales Line";
                    AutoFormatType: Enum "Auto Format";
                    BlankSpace: Text;
                    I: Integer;
                begin
                    Clear(FullItemDescription);
                    Clear(SerialNumberText);
                    if Quantity = 0 then begin
                        LinePrice := "Unit Price JCOARC";
                        LineAmount := 0;
                        VATAmount := 0;
                    end else begin
                        if ShowDiscount then
                            LinePrice := "Unit Price JCOARC"
                        else
                            LinePrice := Round("Line Amount JCOARC" / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount := Round("Line Amount JCOARC", Currency."Amount Rounding Precision");
                        VATAmount := 0;

                        TotalAmount += LineAmount;
                        TotalVATAmount += VATAmount;
                        TotalAmountInclVAT += LineAmount + VATAmount;
                    end;
                    FormattedLinePrice := CurrencySymbol + Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                    FormattedLineAmount := CurrencySymbol + Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedVATAmount := CurrencySymbol + Format(VATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));

                    SrNoJCO += 1;
                    SrNoJCOText := Format(SrNoJCO);

                    ReservationEntry.SetRange("Source Type", 5741);
                    ReservationEntry.SetRange("Source Subtype", 0);
                    ReservationEntry.SetRange("Source ID", "Document No.");
                    ReservationEntry.SetRange("Source Ref. No.", "Line No.");
                    ReservationEntry.SetRange("Item No.", Line."Item No.");
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
                    end
                    else if Line."Quantity Shipped" <> 0 then begin
                        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                        ItemLedgerEntry.SetRange("Order No.", Line."Document No.");
                        ItemLedgerEntry.SetRange("Order Line No.", Line."Line No.");
                        ItemLedgerEntry.SetRange(Open, true);
                        ItemLedgerEntry.SetFilter("Serial No.", '<>%1', '');
                        if ItemLedgerEntry.FindSet() then
                            repeat
                                if SerialNumberText <> '' then
                                    SerialNumberText := SerialNumberText + ' ,' + ItemLedgerEntry."Serial No."
                                else
                                    SerialNumberText := ItemLedgerEntry."Serial No.";
                            until ItemLedgerEntry.Next() = 0;
                        case ItemLedgerEntry.Count of
                            1:
                                SerialNumberText := 'SERIAL NO.: ' + SerialNumberText;
                            0:
                                SerialNumberText := '';
                            else
                                SerialNumberText := 'SERIAL NOS.: ' + SerialNumberText;
                        end;
                    end;
                    if (SerialNumberText <> '') then
                        ShowSerialNoLine := true
                    else
                        ShowSerialNoLine := false;

                    GetFullDescription(Line);
                end;

                trigger OnPreDataItem()
                begin
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    SrNoJCO := 0;

                    SetFilter("In-Transit Code", '<>%1', '');
                end;
            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;
                column(TotalValue; FormattedTotalAmount)
                {
                }
                column(TotalVATAmount; FormattedTotalVATAmount)
                {
                }
                column(TotalAmountInclVAT; FormattedTotalAmountInclVAT)
                {
                }

                trigger OnPreDataItem()
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    FormattedTotalAmount := CurrencySymbol + Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalVATAmount := CurrencySymbol + Format(TotalVATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalAmountInclVAT := CurrencySymbol + Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Customer.Get("Customer No. JCOARC");
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault(Customer."Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault(Customer."Format Region");
                FormatDocumentFields(Header);
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
                    field(ShowPaymentTerms; ShowPaymentTerms)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Payment Terms';
                        ToolTip = 'Specifies whether or not to show Payment Terms, in the report';
                    }
                }
            }
        }

        actions
        {
        }
    }

    rendering
    {
        layout("TranferProFormaInv.rdlc")
        {
            Type = RDLC;
            LayoutFile = './TranferProFormaInvJCO.rdl';
            Caption = 'Transfer Proforma Invoice (RDL)';
            Summary = 'The Transfer Proforma Invoice (RDL) provides a detailed layout.';
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        IsHandled: Boolean;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        IsHandled := false;
    end;

    var
        Customer: Record Customer;
        DummyCurrency: Record Currency;
        AutoFormat: Codeunit "Auto Format";
        LanguageMgt: Codeunit Language;
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        CurrencySymbol: Text[10];
        FullItemDescription: Text;
        PaymentTermsDescription: Text;
        DocumentTitleLbl: Label 'PROFORMA INVOICE NO.';
        PageLbl: Label 'PAGE NO.';
        ItemLbl: Label 'STYLE';
        YourReferenceLbl: Label 'OUR PO#';
        ExternalDocNoLbl: Label 'YOUR PO#';
        ShipmentMethodLbl: Label 'Ship Via';
        CustomerNoLbl: Label 'CUST. CODE';
        PaymentTermsLbl: Label 'TERMS';
        SrNoJCO: Integer;
        SrNoJCOText: Text[3];
        CustomerVATRegistrationNumberLbl: label 'Tax Registration No.';

    protected var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        Currency: Record Currency;
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];
        ShipFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        ShowDiscount: Boolean;
        ShowPaymentTerms: Boolean;
        SalesPersonLblText: Text[50];
        TotalAmountLbl: Text[50];
        TotalAmountInclVATLbl: Text[50];
        FormattedLinePrice: Text;
        FormattedLineAmount: Text;
        FormattedVATAmount: Text;
        FormattedTotalAmount: Text;
        FormattedTotalVATAmount: Text;
        FormattedTotalAmountInclVAT: Text;
        SerialNumberText: Text;
        ShowSerialNoLine: Boolean;
        CurrencyCode: Code[10];
        TotalAmount: Decimal;
        TotalVATAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LinePrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;

    local procedure FormatDocumentFields(TransHeader: Record "Transfer Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        Customer: Record Customer;
        FormatDocument: Codeunit "Format Document";
        FormatAddress: Codeunit "Format Address";
        TotalAmounExclVATLbl: Text[50];
        PaymentTermsJCO: Record "Payment Terms";
    begin
        Customer.Get(TransHeader."Customer No. JCOARC");
        FormatAddress.SetLanguageCode(Customer."Language Code");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, Customer."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName := SalespersonPurchaser.Name;

        FormatDocument.SetShipmentMethod(ShipmentMethod, Customer."Shipment Method Code", Customer."Language Code");
        ShipmentMethodDescription := ShipmentMethod.Description;

        FormatAddress.GetCompanyAddr(Customer."Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
        FormatAddress.Customer(CustomerAddress, Customer);
        if ShowPaymentTerms then begin
            FormatDocument.SetPaymentTerms(PaymentTermsJCO, Customer."Payment Terms Code", Customer."Language Code");
            PaymentTermsDescription := PaymentTermsJCO.Description;
        end;
        FormatAddress.TransferHeaderTransferTo(ShipToAddress, TransHeader);
        FormatAddress.TransferHeaderTransferFrom(ShipFromAddress, TransHeader);

        if TransHeader."Currency Code JCOARC" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode := GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
            CurrencySymbol := GeneralLedgerSetup."Local Currency Symbol";
        end else begin
            CurrencyCode := TransHeader."Currency Code JCOARC";
            Currency.Get(TransHeader."Currency Code JCOARC");
            CurrencySymbol := Currency.Symbol;
        end;

        FormatDocument.SetTotalLabels(TransHeader."Currency Code JCOARC", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    end;

    local procedure GetFullDescription(TransferLine: Record "Transfer Line")
    var
        ExtendedTextLine: Record "Extended Text Line";
        BlankSpace: Text;
        i: Integer;
    begin
        Clear(BlankSpace);
        FullItemDescription := TransferLine.Description;
        ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
        ExtendedTextLine.SetRange("No.", TransferLine."Item No.");
        ExtendedTextLine.SetRange("Language Code", '');
        if ExtendedTextLine.FindSet() then
            repeat
                FullItemDescription += ', ' + ExtendedTextLine.Text;
            until ExtendedTextLine.Next() = 0;
        GetItemForRec(TransferLine."Item No.");
        if (StrPos(FullItemDescription, 'HS CODE') = 0) AND (StrPos(FullItemDescription, 'HS_CODE_') = 0) then
            if Item."Tariff No." <> '' then
                FullItemDescription += ', HS CODE: ' + Item."Tariff No.";
        if StrPos(FullItemDescription, 'COUNTRY OF ORIGIN') = 0 then
            if Item."Country/Region of Origin Code" <> '' then
                FullItemDescription += ', COUNTRY OF ORIGIN: ' + Item."Country/Region of Origin Code";
        if StrPos(FullItemDescription, 'NET WEIGHT') = 0 then
            if Item."Net Weight" <> 0 then
                FullItemDescription += ', NET WEIGHT: ' + format(Item."Net Weight") + ' GR';
        if StrLen(FullItemDescription) < 340 then begin
            for i := 1 to (340 - StrLen(FullItemDescription)) do
                BlankSpace += ' ';
            FullItemDescription += BlankSpace;
        end;
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    local procedure GetItemForRec(ItemNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;
        Item.Get(ItemNo);
    end;
}