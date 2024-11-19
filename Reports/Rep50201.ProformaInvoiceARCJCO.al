
report 50201 "Sales - Pro Forma Inv JCOARC"
{
    Caption = 'ProForma Invoice';
    DefaultRenderingLayout = "StandardSalesProFormaInv.rdlc";
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Pro Forma Invoice';
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
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
            column(CustomerVATRegNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(CustomerVATRegistrationNoLbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
            //JCO>>
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
            //JOC<<
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
            //JCO>>
            column(CustomerNoLbl; CustomerNoLbl)
            {
            }
            column(PaymentTermsLbl; PaymentTermsLbl)
            {
            }
            //JCO<<
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
            column(VATAmountLbl; DummyVATAmountLine.VATAmountText())
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
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
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
                column(Quantity; "Qty. to Invoice")
                {
                }
                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(NetWeight; "Net Weight")
                {
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmount; FormattedVATAmount)
                {
                }
                //JCO>>
                column(SrNoJCO; SrNoJCO)
                {
                }
                column(SerialNumberText; SerialNumberText)
                {
                }
                column(FormattedLineDiscountAmount; FormattedLineDiscountAmount)
                {
                }
                column(Line_Discount__; FormattedLineDiscPercent)
                {
                }
                //JCO<<

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
                    //JCO>>
                    Clear(FullItemDescription);
                    Clear(SerialNumberText);
                    Clear(LineDiscountAmount);
                    Clear(FormattedLineDiscPercent);
                    //JCO<<

                    GetItemForRec("No.");
                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    if IsShipment() then
                        if Location.RequireShipment("Location Code") and ("Quantity Shipped" = 0) then
                            "Qty. to Invoice" := Quantity;

                    if Quantity = 0 then begin
                        LinePrice := "Unit Price";
                        LineAmount := 0;
                        VATAmount := 0;
                        //JCO>>
                        LineDiscountAmount := 0;
                        //JCO<<

                    end else begin
                        if ShowDiscount then
                            LinePrice := "Unit Price"
                        else
                            LinePrice := Round(Amount / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount := Round(Amount * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        if Currency.Code = '' then
                            VATAmount := "Amount Including VAT" - Amount
                        else
                            VATAmount := Round(
                                Amount * "VAT %" / 100 * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");

                        TotalAmount += LineAmount;
                        TotalWeight += Round("Qty. to Invoice" * "Net Weight");
                        TotalVATAmount += VATAmount;
                        TotalAmountInclVAT += Round("Amount Including VAT" * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        //JCO>>
                        if "Line Discount Amount" <> 0 then
                            LineDiscountAmount := "Line Discount Amount";
                        BalanceAmount := TotalAmountInclVAT - DepositAmount;
                        //JCO<<
                    end;

                    FormattedLinePrice := Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                    FormattedLineAmount := Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedVATAmount := Format(VATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));

                    //JCO>>
                    FormattedLineDiscountAmount := Format(LineDiscountAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    SrNoJCO += 1;
                    FormattedLinePrice := CurrencySymbol + FormattedLinePrice;
                    FormattedLineAmount := CurrencySymbol + FormattedLineAmount;
                    FormattedVATAmount := CurrencySymbol + FormattedTotalVATAmount;
                    FormattedLineDiscountAmount := CurrencySymbol + FormattedLineDiscountAmount;
                    if Line."Line Discount %" <> 0 then
                        FormattedLineDiscPercent := format(Line."Line Discount %") + '%';
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source Type", 37);
                    ReservationEntry.SetRange("Source Subtype", 1);
                    ReservationEntry.SetRange("Source ID", Line."Document No.");
                    ReservationEntry.SetRange("Source Ref. No.", Line."Line No.");
                    ReservationEntry.SetRange("Item No.", Line."No.");
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
                    //11/03/2024>>
                    else if Line."Quantity Shipped" <> 0 then begin
                        SalesShipmentLine.SetRange("Order No.", Line."No.");
                        SalesShipmentLine.SetRange("Order Line No.", Line."Line No.");
                        if SalesShipmentLine.FindSet() then
                            repeat
                                ItemLedgerEntry.Reset();
                                ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
                                ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                                ItemLedgerEntry.SetFilter("Serial No.", '<>%1', '');
                                if ItemLedgerEntry.FindSet() then
                                    repeat
                                        if SerialNumberText <> '' then
                                            SerialNumberText := SerialNumberText + ' ,' + ItemLedgerEntry."Serial No."
                                        else
                                            SerialNumberText := ItemLedgerEntry."Serial No.";
                                    //JCO111524>>
                                    until ItemLedgerEntry.Next() = 0;
                                case ItemLedgerEntry.Count of
                                    1:
                                        SerialNumberText := 'SERIAL NO.: ' + SerialNumberText;
                                    0:
                                        SerialNumberText := '';
                                    else
                                        SerialNumberText := 'SERIAL NOS.: ' + SerialNumberText;
                                end;
                            //JCO111524<<
                            until SalesShipmentLine.Next() = 0;
                        // case SalesShipmentLine.Count of
                        //     1:
                        //         SerialNumberText := 'SERIAL NO.: ' + SerialNumberText;
                        //     0:
                        //         SerialNumberText := '';
                        //     else
                        //         SerialNumberText := 'SERIAL NOS.: ' + SerialNumberText;
                        // end;
                    end;
                    //11/03/2024<<

                    FullItemDescription := Line.Description;
                    SalesLineComment.Reset();
                    SalesLineComment.SetRange("Document Type", Line."Document Type");
                    SalesLineComment.SetRange("Document No.", Line."Document No.");
                    SalesLineComment.SetRange(Type, SalesLineComment.Type::" ");
                    SalesLineComment.SetRange("Attached to Line No.", Line."Line No.");
                    if SalesLineComment.FindSet() then
                        repeat
                            FullItemDescription += ', ' + SalesLineComment.Description;
                        until SalesLineComment.Next() = 0;
                    //JCO<<
                    //JCO110624>>
                    if StrLen(FullItemDescription) < 340 then begin
                        for i := 1 to (340 - StrLen(FullItemDescription)) do
                            BlankSpace += ' ';
                        FullItemDescription += BlankSpace;
                    end;
                    //JCO110624<<

                end;

                trigger OnPreDataItem()
                begin
                    TotalWeight := 0;
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    //JCO>>
                    SrNoJCO := 0;
                    //JCO<<

                    SetRange(Type, Type::Item);

                    OnAfterLineOnPreDataItem(Header, Line);
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
                }
            }
        }

        actions
        {
        }
    }

    rendering
    {
        layout("StandardSalesProFormaInv.rdlc")
        {
            Type = RDLC;
            LayoutFile = './StandardSalesProFormaInvJCO.rdl';
            Caption = 'Standard Sales Proforma Invoice (RDL)';
            Summary = 'The Standard Sales Proforma Invoice (RDL) provides a detailed layout.';
        }
        layout("StandardSalesProFormaInv.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardSalesProFormaInv.docx';
            Caption = 'Standard Sales Proforma Invoice (Word)';
            Summary = 'The Standard Sales Proforma Invoice (Word) provides a basic layout.';
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
        OnInitReportForGlobalVariable(IsHandled, LegalOfficeTxt, LegalOfficeLbl);
    end;

    var
        DummyVATAmountLine: Record "VAT Amount Line";
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
        ////JCO>>
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
        LineDiscountAmount: Decimal;
        DepositAmount: Decimal;
        BalanceAmount: Decimal;
        ////JCO<<
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
        //JCO>>
        ShipFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        ShowDiscount: Boolean;
        FormattedLineDiscountAmount: Text;
        //JCO<<
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
        //JCO>>
        SerialNumberText: Text;
        //JCO<<
        CurrencyCode: Code[10];
        TotalWeight: Decimal;
        TotalAmount: Decimal;
        TotalVATAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LinePrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;
        ShowWorkDescription: Boolean;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        Clear(DepositAmount);
        FormatAddress.SetLanguageCode(SalesHeader."Language Code");
        Customer.Get(SalesHeader."Sell-to Customer No.");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName := SalespersonPurchaser.Name;

        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        ShipmentMethodDescription := ShipmentMethod.Description;

        FormatAddress.GetCompanyAddr(SalesHeader."Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
        FormatAddress.SalesHeaderBillTo(CustomerAddress, SalesHeader);

        //JCO>>
        FormatDocument.SetPaymentTerms(PaymentTermsJCO, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        PaymentTermsDescription := PaymentTermsJCO.Description;
        FormatAddress.SalesHeaderShipTo(ShipToAddress, CustomerAddress, SalesHeader);
        LocationForAddrJCO.Get(SalesHeader."Location Code");
        FormatAddress.Location(ShipFromAddress, LocationForAddrJCO);

        SalesInvoiceHeader.SetRange("Prepayment Order No.", SalesHeader."No.");
        if SalesInvoiceHeader.FindFirst() then
            SalesInvoiceHeader.CalcFields(Amount);

        SalesCrMemoHeader.SetRange("Prepayment Order No.", SalesHeader."No.");
        if SalesCrMemoHeader.FindFirst() then
            SalesCrMemoHeader.CalcFields(Amount);
        DepositAmount := SalesInvoiceHeader.Amount - SalesCrMemoHeader.Amount;
        //JCO<<
        if SalesHeader."Currency Code" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode := GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
            //JCO>>
            CurrencySymbol := GeneralLedgerSetup."Local Currency Symbol";
            //JCO<<
        end else begin
            CurrencyCode := SalesHeader."Currency Code";
            Currency.Get(SalesHeader."Currency Code");
            //JCO>>
            CurrencySymbol := Currency.Symbol;
            //JCO<<
        end;

        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    local procedure GetItemForRec(ItemNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeGetItemForRec(ItemNo, IsHandled);
        if IsHandled then
            exit;

        Item.Get(ItemNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesHeader: Record "Sales Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeGetItemForRec(ItemNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text)
    begin
    end;
}

