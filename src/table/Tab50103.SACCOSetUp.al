table 50103 "SACCO SetUp"
{
    Caption = 'SACCO Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        // ==================== GENERAL ====================
        field(2; "SACCO Name"; Text[100])
        {
            Caption = 'SACCO Full Name';
        }
        field(3; "Name 2"; Text[100])
        {
            Caption = 'Name 2';
        }
        field(4; Address; Text[100]) { }
        field(5; "Address 2"; Text[100]) { }
        field(6; City; Text[50]) { }
        field(7; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = true;
        }
        field(8; County; Text[50]) { }
        field(9; "Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(10; "E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;
        }
        field(11; "Website"; Text[100])
        {
            ExtendedDatatype = URL;
        }

        // ==================== NUMBER SERIES ====================
        field(20; "Member Nos."; Code[20])
        {
            Caption = 'Member Nos.';
            TableRelation = "No. Series";
        }
        field(21; "Member Application Nos."; Code[20])
        {
            Caption = 'Member Application Nos.';
            TableRelation = "No. Series";
        }
        field(22; "FOSA Account Nos."; Code[20])
        {
            Caption = 'FOSA Account Nos.';
            TableRelation = "No. Series";
        }
        field(23; "Loan Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(24; "Guarantor Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(25; "Dividend Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }

        // ==================== MEMBERSHIP SETTINGS ====================
        field(30; "Minimum Share Capital"; Decimal)
        {
            Caption = 'Minimum Share Capital Required';
            MinValue = 0;
        }
        field(31; "Registration Fee"; Decimal)
        {
            Caption = 'One-Time Registration Fee';
        }
        field(32; "Monthly Minimum Contribution"; Decimal)
        {
            Caption = 'Minimum Monthly Share Contribution';
        }
        field(33; "Allow Multiple Accounts"; Boolean)
        {
            Caption = 'Allow Member to Have Multiple FOSA Accounts';
        }
        field(34; "Auto Approve Junior Accounts"; Boolean) { }

        // ==================== LOANS SETTINGS ====================
        field(40; "Default Loan Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(41; "Max. Loan Multiplier"; Decimal)
        {
            Caption = 'Maximum Loan = Deposits × Multiplier';
        }
        field(42; "Default Interest Rate %"; Decimal) { }
        field(43; "Default Repayment Period"; Integer)
        {
            Caption = 'Default Repayment Period (Months)';
        }
        field(44; "Require Guarantors"; Boolean) { }
        field(45; "Minimum Guarantors"; Integer) { }

        // ==================== DIVIDENDS & INTEREST ====================
        field(50; "Dividend Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(51; "Interest on Deposits Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(52; "Default Dividend Rate %"; Decimal) { }
        field(53; "Pay Dividends Annually"; Boolean) { InitValue = true; }

        // ==================== FOSA & BANKING ====================
        field(60; "Default FOSA Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(61; "FOSA Transaction Charge"; Decimal) { }
        field(62; "ATM Card Fee"; Decimal) { }
        field(63; "Cheque Book Fee"; Decimal) { }

        // ==================== MOBILE & USSD BANKING ====================
        field(70; "Mobile Banking Enabled"; Boolean) { }
        field(71; "USSD Code"; Text[10])
        {
            Caption = 'USSD Short Code e.g. *123#';
        }
        field(72; "M-PESA Paybill No."; Code[20]) { }
        field(73; "M-PESA Account No."; Code[20]) { }

        // ==================== CRB & COMPLIANCE ====================
        field(80; "CRB Integration Enabled"; Boolean) { }
        field(81; "CRB Provider"; Text[50]) { }
        field(82; "CRB API URL"; Text[250])
        {
            ExtendedDatatype = URL;
        }
        field(83; "CRB Username"; Text[50]) { }
        field(84; "CRB Password"; Blob) { } // Use protected variable in code

        // ==================== SMS & EMAIL SETTINGS ====================
        field(90; "SMS Provider URL"; Text[250]) { }
        field(91; "SMS Username"; Text[50]) { }
        field(92; "SMS Password"; Blob) { }
        field(93; "Default SMS Sender ID"; Text[11]) { }

        // ==================== BRANCH & DIMENSIONS ====================
        field(100; "Branch Dimension Code"; Code[20])
        {
            Caption = 'Branch Global Dimension';
            TableRelation = "Dimension";
        }

        // ==================== ATTACHMENTS & DOCUMENTS ====================
        field(110; "Require ID Copy"; Boolean)
        {
            InitValue = true;
        }
        field(111; "Require Passport Photo"; Boolean)
        {
            InitValue = true;
        }
        field(112; "Require Signature Specimen"; Boolean)
        {
            InitValue = true;
        }

        // ==================== LOGO & BRANDING ====================
        field(120; Logo; MediaSet)
        {
            Caption = 'SACCO Logo';
        }
        field(121; "Stamp/Signature"; Media)
        {
            Caption = 'Authorized Signatory Stamp/Signature';
        }

        // ==================== DEFAULT ACCOUNTS (G/L) ====================
        field(130; "Registration Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(131; "Share Capital Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(132; "Loan Interest Income Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(133; "Default Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        
    end;
}
