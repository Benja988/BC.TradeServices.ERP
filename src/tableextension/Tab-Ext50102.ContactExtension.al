tableextension 50102 ContactExtension extends Contact
{
    fields
    {
        field(50110; "Linkedin Profile"; Text[100])
        {
            Caption = 'Linkedin Profile';
            DataClassification = ToBeClassified;
        }

        field(50111; "Lead Source"; Option)
        {
            OptionMembers = Web,Email,Phone,Referral,Other;
            DataClassification = CustomerContent;
        }
        field(50112; "Lead Score"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50113; "Is Qualified Lead"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        
    }
}
