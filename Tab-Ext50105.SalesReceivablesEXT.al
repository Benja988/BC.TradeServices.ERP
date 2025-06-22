tableextension 50105 "Sales & Receivables EXT" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Customer Onboarding No."; Code[20])
        {
            Caption = 'Customer Onboarding No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
