pageextension 50101 VendorCardExtension extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            group("Custom Info")
            {
                field("Vendor Category";Rec."Vendor Category")
                {
                    ApplicationArea = All;
                }
                field("Preferred Vendor";Rec."Preferred Vendor")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
