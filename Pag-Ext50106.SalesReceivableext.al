pageextension 50106 "Sales & Receivable ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Customer Onboarding No."; Rec."Customer Onboarding No.")
            {
                Caption = 'Customer Onboarding No.';
                ApplicationArea = All;
            }

        }
    }
}
