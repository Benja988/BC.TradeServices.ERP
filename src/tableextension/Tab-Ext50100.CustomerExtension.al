tableextension 50100 CustomerExtension extends Customer
{
    fields
    {
        field(50100; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers= Regular,B2B,B2C;
            DataClassification = ToBeClassified;
        }
        field(50101; "Account Manager"; Code[50])
        {
            Caption = 'Account Manager';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Customer Type" = "Customer Type"::B2B) and ("Account Manager" = '') then
                    Error('B2B customers must have an Account Manager assigned');
            end;
        }
        
    }

}
