namespace JCO.JCO;

using Microsoft.Finance.GeneralLedger.Account;

tableextension 50250 "GLAccount ARCJCO" extends "G/L Account"
{
    fields
    {
        field(50250; "Long Description JCOARC"; Text[200])
        {
            Caption = 'Long Description';
            Editable = false;
        }
    }
}