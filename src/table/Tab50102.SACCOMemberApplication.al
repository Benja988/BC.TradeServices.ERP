table 50102 "SACCO Member Application"
{
    Caption = 'SACCO Member Application';
    DataClassification = CustomerContent;
    LookupPageId = "SACCO Member Application Card";
    DrillDownPageId = "SACCO Member Application List";
    TableType = Normal;

    // Icon for modern UI (BC SaaS)
    // Icon = 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z';

    fields
    {
        // ==================== DOCUMENT NO. & SERIES ====================
        field(1; "No."; Code[20])
        {
            OptimizeForTextSearch = true;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SACCOSetup.Get();
                    NoSeries.TestManual(SACCOSetup."Member Application Nos.");
                    "No. Series" := '';
                end;
                OnAfterValidateNo(Rec, xRec);
            end;
        }

        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        // ==================== PERSONAL INFORMATION ====================
        field(10; "First Name"; Text[50])
        {
            Caption = 'First Name';
            NotBlank = true;
            trigger OnValidate()
            begin
                UpdateFullName();
            end;
        }
        field(11; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
            trigger OnValidate()
            begin
                UpdateFullName();
            end;
        }
        field(12; "Surname"; Text[50])
        {
            Caption = 'Surname';
            NotBlank = true;
            trigger OnValidate()
            begin
                UpdateFullName();
            end;
        }
        field(13; "Full Name"; Text[150])
        {
            Caption = 'Full Name';
            Editable = false;
        }

        field(15; "Name as per ID"; Text[150])
        {
            Caption = 'Name as per National ID/Passport';
        }
        field(16; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            NotBlank = true;

            trigger OnValidate()
            begin

                Age := Date2DMY(Today, 3) - Date2DMY("Date of Birth", 3);
                if Age < 18 then
                    Error('Applicant must be at least 18years old');
            end;
        }
        field(17; Age; Integer)
        {
            Caption = 'Age (Years)';
            Editable = false;
            MinValue = 18;

        }
        field(18; Gender; Enum Gender)
        {
            Caption = 'Gender';
        }
        field(19; "Marital Status"; Enum "Marital Status")
        {
            Caption = 'Marital Status';
        }

        // ==================== IDENTITY DOCUMENTS ====================
        field(20; "ID Type"; Option)
        {
            Caption = 'ID Type';
            OptionMembers = "National ID","Passport","Alien ID";
            OptionCaption = 'National ID,Passport,Alien ID';
        }
        field(21; "National ID No."; Code[20])
        {
            Caption = 'National ID / Passport / Alien ID No.';
            NotBlank = true;
        }
        field(22; "KRA PIN"; Code[11])
        {
            Caption = 'KRA PIN';
        }
        field(23; "HUDUMA Number"; Code[20])
        {
            Caption = 'HUDUMA Number';
        }
        field(24; "Passport No."; Code[20])
        {
            Caption = 'Passport No.';
        }

        // ==================== CONTACT DETAILS ====================
        field(29; "Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
            Caption = 'Mobile Phone No.';

            /* Validated by eventsubscriber */
        }

        field(30; "Phone No. 2"; Text[30])
        {
            ExtendedDatatype = PhoneNo;
            Caption = 'Mobile Phone No. 2';

            trigger OnValidate()
            var
                Regex: Codeunit Regex;
                Pattern: Text;
            begin
                Pattern := '^((\+2547\d{8})|(07\d{8})|(01\d{8}))$';
                if not Regex.IsMatch(Rec."Phone No. 2", Pattern) then
                    Error('Invalid phone number format. Expected +2547XXXXXXXX, 07XXXXXXXX or 01XXXXXXXX.');
            end;
        }
        field(31; "Alternative Phone No."; Text[30])
        {
            Caption = 'Alternative Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                TyperHelper: Codeunit "Type Helper";
                PhonNoCannotContainLettersErr: Label 'Phone Number cannot contain Letters';
            begin
                if not TyperHelper.IsPhoneNumber("Alternative Phone No.") then
                    FieldError("Alternative Phone No.", PhonNoCannotContainLettersErr);
            end;
        }
        field(32; Email; Text[80])
        {
            Caption = 'Personal Email';
            ExtendedDatatype = EMail;


            trigger OnValidate()
            var
                EmailMgt: Codeunit Email;
                Pattern: Text;
                Regex: Codeunit Regex;
                EmailInvalidErr: Label 'The Email you have entered is invalid';
            begin
                Pattern := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
                if not Regex.IsMatch(Email, Pattern) then
                    FieldError(Email, EmailInvalidErr);
            end;
        }
        field(33; "Postal Address"; Text[100])
        {
            Caption = 'Postal Address';
        }
        field(34; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            TableRelation = "Post Code";
            // ValidateTableRelation = true;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                if "Postal Code" <> '' then begin
                    PostCode.Get("Postal Code");
                    "Town/City" := PostCode.City;
                    County := PostCode.County;
                end;
            end;
        }
        field(35; "Town/City"; Text[50])
        {
            Caption = 'Town/City';
        }
        field(36; County; Text[50])
        {
            Caption = 'County';
        }
        field(37; "Physical Address"; Text[150])
        {
            Caption = 'Physical/Residence Address';
        }

        // ==================== EMPLOYMENT & INCOME ====================
        field(40; "Employment Status"; Enum "Employment Status")
        {
            Caption = 'Employment Status';
        }
        field(41; "Employer Name"; Text[100])
        {
            Caption = 'Employer / Business Name';
        }
        field(42; "Payroll/Staff No."; Code[30])
        {
            Caption = 'Payroll / Staff No.';
        }
        field(43; "Monthly Income"; Decimal)
        {
            Caption = 'Average Monthly Income (KES)';
            MinValue = 0;
            AutoFormatType = 1;
        }

        // ==================== SACCO MEMBERSHIP DETAILS ====================
        field(50; "Member Type"; Enum "SACCO Member Type")
        {
            Caption = 'Member Type';
        }
        field(51; "Account Category"; Option)
        {
            Caption = 'Account(s) to Open';
            OptionMembers = "BOSA Only","FOSA Only","BOSA & FOSA";
        }
        field(52; "Introduced By Member No."; Code[20])
        {
            Caption = 'Introduced By (Member No.)';
            // TableRelation = "Member Register"."No." WHERE("Customer Type" = CONST(Member));
        }
        field(53; "Introducer Name"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = Lookup("Member Register"."First Name" + ' ' + "Member Register".Surname WHERE("No." = FIELD("Introduced By Member No.")));
            Editable = false;
        }

        // ==================== BANK & MOBILE BANKING ====================
        field(60; "Bank Account Name"; Text[100]) { }
        field(61; "Bank Account No."; Code[30]) { }
        field(62; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(63; "Bank Branch Name"; Text[50]) { }
        field(64; "Mobile Banking Enabled"; Boolean)
        {
            Caption = 'Register for Mobile Banking (*999#)';
        }

        // ==================== ATTACHMENTS STATUS ====================
        field(70; "ID Copy Attached"; Boolean) { Caption = 'ID Copy'; }
        field(71; "Passport Photo Attached"; Boolean) { Caption = 'Passport Photo'; }
        field(72; "Signature Specimen Attached"; Boolean) { Caption = 'Signature Specimen'; }
        field(73; "KRA PIN Attached"; Boolean) { Caption = 'KRA PIN Certificate'; }

        // ==================== WORKFLOW & STATUS ====================
        field(100; Status; Enum "Approval Status")
        {
            Caption = 'Application Status';
            Editable = false;
            InitValue = Open;
        }
        field(101; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(102; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(103; "Date Submitted"; Date) { }
        field(104; "Submitted By"; Code[50]) { }

        field(110; "Approved Date"; DateTime) { Editable = false; }
        field(111; "Approved By"; Code[50]) { Editable = false; }
        field(112; "Rejection Reason"; Text[250]) { }
        field(113; "Rejected By"; Code[50]) { Editable = false; }

        field(120; "Assigned Member No."; Code[20])
        {
            Caption = 'Allocated Member No.';
            Editable = false;
            // TableRelation = "Member Register"."No.";
        }

        // ==================== DIMENSIONS ====================
        field(130; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(131; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(132; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Search1; "Full Name") { }
        key(Search2; "National ID No.") { }
        key(Search3; "Phone No.") { }
        key(Search4; Email) { }
        key(Status; Status) { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Full Name", "Phone No.", Status, "Created Date")
        {
        }
        fieldgroup(Brick; "No.", "Full Name", "Phone No.", "National ID No.", Status, "Created Date")
        {
            // IconUrl = 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z';
        }
    }



    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SACCOSetup: Record "SACCO Setup";
        MembApp: Record "SACCO Member Application";

        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeInsert(Rec, IsHandled);
        if IsHandled then
            exit;

        if "No." = '' then begin
            SACCOSetup.Get();
            SACCOSetup.TestField("Member Application Nos.");

            NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(SACCOSetup."Member Application Nos.", xRec."No. Series", 0D, "No.", "No. Series", IsHandled);
            if not IsHandled then begin

                "No. Series" := SACCOSetup."Member Application Nos.";
                if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "No." := NoSeries.GetNextNo("No. Series");
                MembApp.ReadIsolation(IsolationLevel::ReadUncommitted);
                MembApp.SetLoadFields("No.");
                while MembApp.Get("No.") do
                    "No." := NoSeries.GetNextNo("No. Series");

                NoSeriesMgt.RaiseObsoleteOnAfterInitSeries("No. Series", SACCOSetup."Member Application Nos.", 0D, "No.");
            end;

        end;

        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        Status := Status::Open;
    end;

    trigger OnModify()
    begin
        if Status <> Status::Open then
            Error('Cannot modify an application that is %1.', Status);
    end;

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error('Cannot delete an application that is %1.', Status);
    end;


    // =====================Assist Edit==========================
    procedure AssistEdit(OldMemb: Record "SACCO Member Application"): Boolean
    var
        MembApp: Record "SACCO Member Application";
    begin
        MembApp := Rec;
        SACCOSetup.Get();
        SACCOSetup.TestField("Member Application Nos.");
        if NoSeries.LookupRelatedNoSeries(SACCOSetup."Member Application Nos.", OldMemb."No. Series", MembApp."No. Series") then begin
            Rec := MembApp;
            OnAssistEditOnBeforeExit(Rec);
            exit(true);
        end;
    end;
    // ==========================================================


    // =================Geting Full Name of Member =============
    local procedure UpdateFullName()
    var
        FullName: Text[150];
    begin
        FullName := "First Name";

        if "Middle Name" <> '' then
            FullName := FullName + ' ' + "Middle Name";
        if Surname <> '' then
            FullName := FullName + ' ' + Surname;

        "Full Name" := FullName;
    end;
    // =========================================================



    var
        SACCOSetup: Record "SACCO Setup";
        NoSeries: Codeunit "No. Series";

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateNo(var MembApp: Record "SACCO Member Application"; xMembApp: Record "SACCO Member Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAssistEditOnBeforeExit(var MembApp: Record "SACCO Member Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsert(var MembApp: Record "SACCO Member Application"; var IsHandled: Boolean)
    begin
    end;
}