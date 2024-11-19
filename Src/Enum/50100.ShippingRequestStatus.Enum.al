enum 50100 "JCO Shipping Request Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Production update Received")
    {
        Caption = 'Production update Received';
    }
    value(2; "Shipping Request Sent")
    {
        Caption = 'Shipping Request Sent';
    }
    value(3; "Shipment-In Transit")
    {
        Caption = 'Shipment-In Transit';
    }
    value(4; "Shipment Received")
    {
        Caption = 'Shipment Received';
    }
}