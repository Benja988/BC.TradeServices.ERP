tableextension 50103 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50100; "Custom Warranty (Months)"; Integer)
        {
            Caption = 'Custom Warranty (Months)';
            DataClassification = ToBeClassified;
        }
    }
}
