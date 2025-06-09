tableextension 50101 VendorExtension extends Vendor
{
    fields
    {
        field(50100; "Vendor Category"; Option)
        {
            Caption = 'Vendor Category';
            OptionMembers = Domestic,International;
            DataClassification = ToBeClassified;
        }
        field(50101; "Preferred Vendor"; Boolean)
        {
            Caption = 'Preferred Vendor';
            DataClassification = ToBeClassified;
        }
        
    }
}
