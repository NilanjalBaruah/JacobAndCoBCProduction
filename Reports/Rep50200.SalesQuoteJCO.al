
report 50200 "Sales Quote JCOARC"
{
    Caption = 'Sales Quote';
    DefaultRenderingLayout = "SalesQuoteARCJCO.rdl";
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(CancelDate; Format("Quote Valid Until Date", 0, 4))
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
            column(PageLbl; PageLbl)
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
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(Currency; CurrencyCode)
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
            column(SalesPersonLbl; SalesPersonLbl)
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
            column(AmountLbl; Line.FieldCaption(Amount))
            {
            }
            column(VATPctLbl; Line.FieldCaption("VAT %"))
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(ShowDisc; ShowDiscount)
            {
            }
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
                column(Quantity; "Quantity")
                {
                }
                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmountDec; LineAmount)
                {
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmountDec; VATAmount)
                {
                }
                column(TagPrice; FormattedTagPrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(LineDiscountPercent; FormattedLineDiscPercent)
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
                    Location: Record Location;
                    ReservationEntry: Record "Reservation Entry";
                    SalesLineComment: Record "Sales Line";
                    AutoFormatType: Enum "Auto Format";
                    BlankSpace: Text;
                    i: Integer;
                begin
                    Clear(FullItemDescription);
                    Clear(SerialNumberText);
                    Clear(FormattedLineDiscPercent);
                    if Type = Type::" " then begin
                        SalesLineComment.SetRange("Document Type", "Document Type");
                        SalesLineComment.SetRange("Document No.", "Document No.");
                        SalesLineComment.SetFilter("Line No.", '<=%1', "Line No.");
                        SalesLineComment.SetFilter(Type, '<>%1', SalesLineComment.Type::" ");
                        if SalesLineComment.FindLast() then
                            if SalesLineComment.Type = SalesLineComment.Type::Item then
                                CurrReport.Skip();
                    end;
                    if Type = Type::Item then begin
                        GetItemForRec("No.");
                        if IsShipment() then
                            if Location.RequireShipment("Location Code") and ("Quantity Shipped" = 0) then
                                "Qty. to Invoice" := Quantity;
                    end else
                        Item.Init();
                    if Quantity = 0 then begin
                        LinePrice := "Unit Price";
                        LineAmount := 0;
                        VATAmount := 0;
                        TagPrice := 0;
                    end else begin
                        TagPrice := "Unit Price";
                        LinePrice := Round(Amount / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount := Round(Amount * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        if Currency.Code = '' then
                            VATAmount := "Amount Including VAT" - Amount
                        else
                            VATAmount := Round(
                                Amount * "VAT %" / 100 * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");

                        TotalAmount += LineAmount;
                    end;
                    if Type <> Type::" " then begin
                        FormattedTagPrice := CurrencySymbol + Format(TagPrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                        FormattedLinePrice := CurrencySymbol + Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                        FormattedLineAmount := CurrencySymbol + Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                        if Line."Line Discount %" <> 0 then
                            FormattedLineDiscPercent := format(Line."Line Discount %") + '%';
                    end else begin
                        FormattedLinePrice := '';
                        FormattedTagPrice := '';
                        FormattedLineAmount := '';
                    end;
                    if Type = Type::Item then begin
                        SrNoJCO += 1;
                        SrNoJCOText := Format(SrNoJCO);
                    end else
                        SrNoJCOText := '';
                    if Type = Type::Item then begin
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
                            if SerialNumberText <> '' then
                                ShowSerialNoLine := true;
                        end;
                    end;
                    GetFullDescription(Line);
                end;

                trigger OnPreDataItem()
                begin
                    TotalAmount := 0;
                    SrNoJCO := 0;
                end;
            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;
                column(TotalValue; FormattedTotalAmount)
                {
                }

                trigger OnPreDataItem()
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    FormattedTotalAmount := CurrencySymbol + Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                FormatDocumentFields(Header);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
        }

        actions
        {
        }
    }

    rendering
    {
        layout("SalesQuoteARCJCO.rdl")
        {
            Type = RDLC;
            LayoutFile = './SalesQuoteARCJCO.rdl';
            Caption = 'Sales Quote (RDL)';
            Summary = 'The Sales Quote (RDL) provides a detailed layout.';
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
        ShowDiscount := true;
        IsHandled := false;
    end;

    var
        DummyCurrency: Record Currency;
        AutoFormat: Codeunit "Auto Format";
        LanguageMgt: Codeunit Language;
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        CurrencySymbol: Text[10];
        FullItemDescription: Text;
        PaymentTermsDescription: Text;

        DocumentTitleLbl: Label 'SALES QUOTE';
        PageLbl: Label 'PAGE NO.';
        ItemLbl: Label 'STYLE/ GL';
        YourReferenceLbl: Label 'Customer Ref#';
        ExternalDocNoLbl: Label 'Customer PO#';
        ShipmentMethodLbl: Label 'Ship Via';
        CustomerNoLbl: Label 'CUST. CODE';
        PaymentTermsLbl: Label 'TERMS';
        SrNoJCO: Integer;
        SrNoJCOText: Text[3];

    protected var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        Currency: Record Currency;
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        ShowDiscount: Boolean;
        FormattedLineDiscPercent: Text;
        SalesPersonLblText: Text;
        SalesPersonLbl: Label 'Salesman';
        TotalAmountLbl: Text[50];
        TotalAmountInclVATLbl: Text[50];
        FormattedLinePrice: Text;
        FormattedTagPrice: Text;
        FormattedLineAmount: Text;
        FormattedTotalAmount: Text;
        SerialNumberText: Text;
        ShowSerialNoLine: Boolean;
        CurrencyCode: Code[10];
        TotalAmount: Decimal;
        LinePrice: Decimal;
        TagPrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;

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
        PaymentTermsJCO: Record "Payment Terms";
    begin
        FormatAddress.SetLanguageCode(SalesHeader."Language Code");
        Customer.Get(SalesHeader."Sell-to Customer No.");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName := SalespersonPurchaser.Name;

        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        ShipmentMethodDescription := ShipmentMethod.Description;

        FormatAddress.GetCompanyAddr(SalesHeader."Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
        FormatAddress.SalesHeaderBillTo(CustomerAddress, SalesHeader);

        FormatDocument.SetPaymentTerms(PaymentTermsJCO, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        PaymentTermsDescription := PaymentTermsJCO.Description;
        FormatAddress.SalesHeaderShipTo(ShipToAddress, CustomerAddress, SalesHeader);
        if SalesHeader."Currency Code" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode := GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
            CurrencySymbol := GeneralLedgerSetup."Local Currency Symbol";
        end else begin
            CurrencyCode := SalesHeader."Currency Code";
            Currency.Get(SalesHeader."Currency Code");
            CurrencySymbol := Currency.Symbol;
        end;
        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    local procedure GetFullDescription(SalesLine: Record "Sales Line")
    var
        SalesLineComment: Record "Sales Line";
        NextSalesLine: Record "Sales Line";
        NextSalesLineNo: Integer;
        BlankSpace: Text;
        i: Integer;
    begin
        Clear(BlankSpace);
        FullItemDescription := SalesLine.Description;
        if SalesLine.Type = SalesLine.Type::Item then begin
            NextSalesLine.SetRange("Document Type", SalesLine."Document Type");
            NextSalesLine.SetRange("Document No.", SalesLine."Document No.");
            NextSalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" ");
            NextSalesLine.SetFilter("Line No.", '>%1', SalesLine."Line No.");
            If NextSalesLine.FindFirst() then
                NextSalesLineNo := NextSalesLine."Line No.";
            if SalesLine.Type = SalesLine.Type::Item then begin
                SalesLineComment.SetRange("Document Type", SalesLine."Document Type");
                SalesLineComment.SetRange("Document No.", SalesLine."Document No.");
                SalesLineComment.SetRange(Type, SalesLineComment.Type::" ");
                if NextSalesLineNo <> 0 then
                    SalesLineComment.SetFilter("Line No.", '%1..%2', SalesLine."Line No.", NextSalesLineNo)
                else
                    SalesLineComment.SetFilter("Line No.", '%1..', SalesLine."Line No.");
                if SalesLineComment.FindSet() then
                    repeat
                        FullItemDescription += ', ' + SalesLineComment.Description
                    until SalesLineComment.Next() = 0;
                GetItemForRec(SalesLine."No.");
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