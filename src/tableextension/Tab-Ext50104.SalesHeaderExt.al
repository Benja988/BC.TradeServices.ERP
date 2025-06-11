tableextension 50104 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50100; "Customer Reference No."; Code[20])
        {
            Caption = 'Customer Reference No.';
            DataClassification = ToBeClassified;
        }
    }
}
