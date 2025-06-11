tableextension 50100 CustomerExtension extends Customer
{
    fields
    {
        field(50100; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = Regular,B2B,B2C;

            trigger OnValidate()
            begin
                ValidateCustomerType();
            end;
        }
        field(50101; "Account Manager"; Code[50])
        {
            Caption = 'Account Manager';
            DataClassification = CustomerContent;
            
        }
    }


    local procedure ValidateCustomerType()
    begin
        if ("Customer Type" = "Customer Type"::B2B) and ("Account Manager" = '') then
            Error('B2B Customers must have an Account Manager assigned.')
    end;

}
