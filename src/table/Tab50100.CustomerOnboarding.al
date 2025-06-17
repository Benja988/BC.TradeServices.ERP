table 50100 CustomerOnboarding
{
    Caption = 'CustomerOnboarding';
    DataClassification = ToBeClassified;
    TableType = Normal;
    DataPerCompany = true;
    // Access = Public;
    Description = 'Handles Pre-customer registration data.';
    // Permissions = tabledata Customer = RIMD;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(4; "Phone Number"; Text[100])
        {
            Caption = 'Phone Number';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(5; "Business Type"; Enum "Business Type")
        {
            Caption = 'Business Type';
            DataClassification = ToBeClassified;
        }
        field(6; "Region Code"; Code[10])
        {
            Caption = 'Region Code';
            DataClassification = ToBeClassified;
            TableRelation = Territory.Code;
            ValidateTableRelation = true;
        }
        field(7; "Requested Credit Limit"; Decimal)
        {
            Caption = 'Requested Credit Limit';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(8; Status; Enum "Onboarding Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(9; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
            DataClassification = ToBeClassified;
            Editable = false;
            // InitValue = workdate;
        }
        field(10; "Submitted By"; Code[50])
        {
            Caption = 'Submitted By';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(11; "Rejection Reason"; Text[250])
        {
            Caption = 'Rejection Reason';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(12; Attachment; MediaSet)
        {
            Caption = 'Attachment (Optional)';
        }
        field(13; "Created Customer No."; Code[20])
        {
            Caption = 'Created Customer No.';
        }
        field(14; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(NameIdx; "Customer Name") {}
        key(EmailIdx; "Email") {}
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer Name", Email, "Phone Number")
        {

        }
    }

    trigger OnInsert()
    begin
        // "Submission Date" := Today;
        "Submitted By" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Modified DateTime" :=CurrentDateTime;
    end;
}
