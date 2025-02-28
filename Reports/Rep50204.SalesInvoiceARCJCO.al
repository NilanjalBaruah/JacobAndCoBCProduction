report 50204 "Sales - Invoice JCOARC"
{
    Caption = 'Invoice';
    DefaultRenderingLayout = "StandardSalesInvoice.rdlc";
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Invoice';
            column(DocumentDate; Format("Document Date", 0, 4))
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
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyLegalOffice; LegalOfficeTxt)
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
            column(CustomerVATRegNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(CustomerVATRegistrationNoLbl; GetCustomerVATRegistrationNumberLbl())
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
            column(CustomerNo; "Sell-to Customer No.")
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
            column(CompanyLegalOfficeLbl; LegalOfficeLbl)
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
            column(TariffLbl; Item.FieldCaption("Tariff No."))
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(CountryOfManufactuctureLbl; CountryOfManufactuctureLbl)
            {
            }
            column(AmountLbl; Line.FieldCaption(Amount))
            {
            }
            column(VATPctLbl; Line.FieldCaption("VAT %"))
            {
            }
            column(TotalWeightLbl; TotalWeightLbl)
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
            column(NetWeightLbl; Line.FieldCaption("Net Weight"))
            {
            }
            column(DeclartionLbl; DeclartionLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(SignatureNameLbl; SignatureNameLbl)
            {
            }
            column(SignaturePositionLbl; SignaturePositionLbl)
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(ShowDisc; ShowDiscount)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription) { }
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(ItemPicture; Item.Picture)
                {
                }
                column(No; "No.")
                {
                }
                column(ItemDescription; FullItemDescription)
                {
                }
                column(CountryOfManufacturing; Item."Country/Region of Origin Code")
                {
                }
                column(Tariff; Item."Tariff No.")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 2;
                }
                column(Line_Discount__; FormattedLineDiscPercent)
                {
                }
                column(NetWeight; "Net Weight")
                {
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmountDec; LineAmount)
                {
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmount; FormattedVATAmount)
                {
                }
                column(VATAmountDec; VATAmount)
                {
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
                    ValueEntry: Record "Value Entry";
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    Location: Record Location;
                    SalesLineComment: Record "Sales Invoice Line";
                    AutoFormatType: Enum "Auto Format";
                    SrNoCnt: Integer;
                    BlankSpace: Text;
                    i: Integer;
                begin
                    Clear(SrNoCnt);
                    Clear(FullItemDescription);
                    Clear(SerialNumberText);
                    Clear(FormattedLineDiscPercent);

                    if Type = Type::Item then begin
                        GetItemForRec("No.");
                        if (Item."Replenishment System" = Item."Replenishment System"::Assembly) and (Item."Assembly Policy" = Item."Assembly Policy"::"Assemble-to-Order") then
                            CurrReport.Skip();
                    end else
                        Item.Init();
                    if Type = Type::" " then begin
                        SalesLineComment.SetRange("Document No.", "Document No.");
                        SalesLineComment.SetFilter("Line No.", '<=%1', "Line No.");
                        SalesLineComment.SetFilter(Type, '<>%1', SalesLineComment.Type::" ");
                        if SalesLineComment.FindLast() then
                            if SalesLineComment.Type = SalesLineComment.Type::Item then
                                CurrReport.Skip();
                    end;

                    if Quantity = 0 then begin
                        LinePrice := "Unit Price";
                        LineAmount := 0;
                        VATAmount := 0;
                    end else begin
                        if ShowDiscount then
                            LinePrice := "Unit Price"
                        else
                            LinePrice := Round(Amount / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount := Round(Amount, Currency."Amount Rounding Precision");
                        if Currency.Code = '' then
                            VATAmount := "Amount Including VAT" - Amount
                        else
                            VATAmount := Round(
                                Amount * "VAT %" / 100 * Quantity, Currency."Amount Rounding Precision");

                        TotalAmount += LineAmount;
                        TotalWeight += Round(Quantity * "Net Weight");
                        TotalVATAmount += VATAmount;
                        TotalAmountInclVAT += Round("Amount Including VAT", Currency."Amount Rounding Precision");
                    end;
                    if Type <> Type::" " then begin
                        FormattedLinePrice := CurrencySymbol + Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                        FormattedLineAmount := CurrencySymbol + Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                        FormattedVATAmount := CurrencySymbol + Format(VATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                        if Line."Line Discount %" <> 0 then
                            FormattedLineDiscPercent := format(Line."Line Discount %") + '%';
                    end else begin
                        FormattedLinePrice := '';
                        FormattedLineAmount := '';
                        FormattedVATAmount := '';
                        FormattedLineDiscPercent := '';
                    end;
                    ;
                    if Type = Type::Item then begin
                        SrNoJCO += 1;
                        SrNoJCOText := Format(SrNoJCO);
                    end else
                        SrNoJCOText := '';
                    if Type = Type::Item then begin
                        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                        ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                        ValueEntry.SetRange("Document No.", Line."Document No.");
                        ValueEntry.SetRange("Document Line No.", Line."Line No.");
                        if ValueEntry.FindSet() then
                            repeat
                                ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.");
                                If ItemLedgerEntry."Serial No." <> '' then begin
                                    if SerialNumberText <> '' then
                                        SerialNumberText := SerialNumberText + ' ,' + ItemLedgerEntry."Serial No."
                                    else
                                        SerialNumberText := ItemLedgerEntry."Serial No.";
                                    SrNoCnt += 1;
                                end;
                            until ValueEntry.Next() = 0;
                        case SrNoCnt of
                            1:
                                SerialNumberText := 'SERIAL NO.: ' + SerialNumberText;
                            0:
                                SerialNumberText := '';
                            else
                                SerialNumberText := 'SERIAL NOS.: ' + SerialNumberText;
                        end;
                    end;
                    if (Type = Type::Item) and (SerialNumberText <> '') then
                        ShowSerialNoLine := true
                    else
                        ShowSerialNoLine := false;
                    GetFullDescription(Line);
                end;

                trigger OnPreDataItem()
                begin
                    TotalWeight := 0;
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    SrNoJCO := 0;

                    SetFilter(Quantity, '>%1', 0);
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 99999));
                column(WorkDescriptionLineNumber; Number) { }
                column(WorkDescriptionLine; WorkDescriptionLine) { }

                trigger OnAfterGetRecord()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInStream.EOS() then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInStream, TypeHelper.LFSeparator());
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInStream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    Header."Work Description".CreateInStream(WorkDescriptionInStream, TextEncoding::UTF8);
                end;
            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;
                column(TotalWeight; TotalWeight)
                {
                }
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
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue();
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
                    field(ShowDiscount; ShowDiscount)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Discount';
                        ToolTip = 'Specifies whether or not to show Discount column, in the report';
                    }
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
        layout("StandardSalesInvoice.rdlc")
        {
            Type = RDLC;
            LayoutFile = './StandardSalesInvoiceARCJCO.rdl';
            Caption = 'Standard Sales Invoice (RDL)';
            Summary = 'The Standard Sales Invoice (RDL) provides a detailed layout.';
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
        DummyShipmentMethod: Record "Shipment Method";
        DummyCurrency: Record Currency;
        AutoFormat: Codeunit "Auto Format";
        LanguageMgt: Codeunit Language;
        CountryOfManufactuctureLbl: Label 'Country';
        TotalWeightLbl: Label 'Total Weight';
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        CurrencySymbol: Text[10];
        FullItemDescription: Text;
        FormattedLineDiscPercent: Text;
        ShowDiscount: Boolean;
        ShowPaymentTerms: Boolean;
        PaymentTermsDescription: Text;
        DocumentTitleLbl: Label 'INVOICE NO.';
        PageLbl: Label 'PAGE NO.';
        ItemLbl: Label 'STYLE';
        YourReferenceLbl: Label 'OUR PO#';
        ExternalDocNoLbl: Label 'YOUR PO#';
        ShipmentMethodLbl: Label 'Ship Via';
        CustomerNoLbl: Label 'CUST. CODE';
        PaymentTermsLbl: Label 'TERMS';
        SrNoJCO: Integer;
        ShowSerialNoLine: Boolean;
        SrNoJCOText: Text[3];
        SerialNumberText: Text;
        DeclartionLbl: Label 'For customs purposes only.';
        SignatureLbl: Label 'For and on behalf of the above named company:';
        SignatureNameLbl: Label 'Name (in print) Signature';
        SignaturePositionLbl: Label 'Position in company';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        LegalOfficeTxt, LegalOfficeLbl : Text;

    protected var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        Currency: Record Currency;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];
        ShipFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        WorkDescriptionInStream: InStream;
        SalesPersonLblText: Text[50];
        TotalAmountLbl: Text[50];
        TotalAmountInclVATLbl: Text[50];
        FormattedLinePrice: Text;
        FormattedLineAmount: Text;
        FormattedVATAmount: Text;
        FormattedTotalAmount: Text;
        FormattedTotalVATAmount: Text;
        FormattedTotalAmountInclVAT: Text;
        WorkDescriptionLine: Text;
        CurrencyCode: Code[10];
        TotalWeight: Decimal;
        TotalAmount: Decimal;
        TotalVATAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LinePrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;
        ShowWorkDescription: Boolean;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        Customer: Record Customer;
        FormatDocument: Codeunit "Format Document";
        FormatAddress: Codeunit "Format Address";
        TotalAmounExclVATLbl: Text[50];
        LocationForAddrJCO: Record Location;
        PaymentTermsJCO: Record "Payment Terms";
    begin
        FormatAddress.SetLanguageCode(SalesInvoiceHeader."Language Code");
        Customer.Get(SalesInvoiceHeader."Sell-to Customer No.");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesInvoiceHeader."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName := SalespersonPurchaser.Name;

        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");
        ShipmentMethodDescription := ShipmentMethod.Description;

        FormatAddress.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
        FormatAddress.SalesInvBillTo(CustomerAddress, SalesInvoiceHeader);

        if ShowPaymentTerms then begin
            FormatDocument.SetPaymentTerms(PaymentTermsJCO, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
            PaymentTermsDescription := PaymentTermsJCO.Description;
        end;
        FormatAddress.SalesInvShipTo(ShipToAddress, CustomerAddress, SalesInvoiceHeader);
        LocationForAddrJCO.Get(SalesInvoiceHeader."Location Code");
        FormatAddress.Location(ShipFromAddress, LocationForAddrJCO);
        if SalesInvoiceHeader."Currency Code" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode := GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
            CurrencySymbol := GeneralLedgerSetup."Local Currency Symbol";
        end else begin
            CurrencyCode := SalesInvoiceHeader."Currency Code";
            Currency.Get(SalesInvoiceHeader."Currency Code");
            CurrencySymbol := Currency.Symbol;
        end;

        FormatDocument.SetTotalLabels(SalesInvoiceHeader."Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    end;

    local procedure GetFullDescription(SalesInvLine: Record "Sales Invoice Line")
    var
        SalesInvLineComment: Record "Sales Invoice Line";
        NextSalesInvLine: Record "Sales Invoice Line";
        NextSalesInvLineNo: Integer;
        BlankSpace: Text;
        i: Integer;
    begin
        Clear(BlankSpace);
        FullItemDescription := SalesInvLine.Description;
        if SalesInvLine.Type = SalesInvLine.Type::Item then begin
            NextSalesInvLine.SetRange("Document No.", SalesInvLine."Document No.");
            NextSalesInvLine.SetFilter(Type, '<>%1', SalesInvLine.Type::" ");
            NextSalesInvLine.SetFilter("Line No.", '>%1', SalesInvLine."Line No.");
            If NextSalesInvLine.FindFirst() then
                NextSalesInvLineNo := NextSalesInvLine."Line No.";
            if SalesInvLine.Type = SalesInvLine.Type::Item then begin
                SalesInvLineComment.SetRange("Document No.", SalesInvLine."Document No.");
                SalesInvLineComment.SetRange(Type, SalesInvLineComment.Type::" ");
                if NextSalesInvLineNo <> 0 then
                    SalesInvLineComment.SetFilter("Line No.", '%1..%2', SalesInvLine."Line No.", NextSalesInvLineNo)
                else
                    SalesInvLineComment.SetFilter("Line No.", '%1..', SalesInvLine."Line No.");
                if SalesInvLineComment.FindSet() then
                    repeat
                        FullItemDescription += ', ' + SalesInvLineComment.Description;
                    until SalesInvLineComment.Next() = 0;
                GetItemForRec(SalesInvLine."No.");
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