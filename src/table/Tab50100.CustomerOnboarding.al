// namespace Microsoft.Sales.Customer;

table 50100 CustomerOnboarding
{
    Caption = 'CustomerOnboarding';
    DataClassification = ToBeClassified;
    TableType = Normal;
    DataPerCompany = true;
    Access = Public;
    Description = 'Handles Pre-customer registration data.';
    Permissions = tabledata Customer = RIMD;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                // SalesSetup.Get();
                // if "No." <> xRec."No." then
                //     NoSeriesMgt.TestManual(SalesSetup."Customer Onboarding No.");
                // "No. Series":='';

                TestNoSeries();
                // if "No." = '' then
                //     "No." := "No.";
                    
            end;
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
        field(15; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(NameIdx; "Customer Name") { }
        key(EmailIdx; "Email") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer Name", Email, "Phone Number")
        {

        }
    }

    trigger OnInsert()
    var
        CustomerOnboard: Record CustomerOnboarding;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsHandled: Boolean;

    begin
        // "Submission Date" := Today;
        "Submitted By" := UserId;
        // SalesSetup.Get();
        // SalesSetup.TestField(SalesSetup."Customer Onboarding No.");
        // if "No." = '' then
        //     NoSeriesMgt.InitSeries(SalesSetup."Customer Onboarding No.", xRec."No. Series", 0D, "No.", "No. Series");

        IsHandled := false;
        OnBeforeInsert(Rec, IsHandled);
        if IsHandled then
            exit;
        
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Customer Onboarding No.");

            NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(SalesSetup."Customer Onboarding No.", xRec."No. Series", 0D, "No.", "No. Series", IsHandled);
            if not IsHandled then begin
                "No. Series" := SalesSetup."Customer Onboarding No.";
                if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "No." := NoSeries.GetNextNo("No. Series");
                CustomerOnboard.ReadIsolation(IsolationLevel::ReadUncommitted);
                CustomerOnboard.SetLoadFields("No.");
                while CustomerOnboard.Get("No.") do
                    "No." := NoSeries.GetNextNo("No. Series");
                NoSeriesMgt.RaiseObsoleteOnAfterInitSeries("No. Series", SalesSetup."Customer Onboarding No.", 0D, "No.");
            end;
        end;

        OnAfterOnInsert(Rec, xRec);

    end;

    trigger OnModify()
    begin
        "Last Modified DateTime" := CurrentDateTime;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";

    local procedure TestNoSeries()
    var
        Customer: Record Customer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeTestNoSeries(Rec, xRec, IsHandled);
        OnBeforeTestNoSeries(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if "No." <> xRec."No." then
            if not Customer.Get(Rec."No.") then begin
                SalesSetup.Get();
                NoSeries.TestManual(SalesSetup."Customer Nos.");
                "No. Series" := '';
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var CustomerOnboarding: Record CustomerOnboarding; xCustomerOnboarding: Record CustomerOnboarding; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsert(var CustomerOnboarding: Record CustomerOnboarding; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var CustomerOnboarding: Record CustomerOnboarding; xCustomerOnboarding: Record CustomerOnboarding)
    begin
    end;
}
