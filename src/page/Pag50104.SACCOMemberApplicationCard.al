page 50104 "SACCO Member Application Card"
{
    ApplicationArea = All;
    Caption = 'SACCO Member Application Card';
    PageType = Card;
    SourceTable = "SACCO Member Application";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Member Application Number';
                    // Visible = NoFieldVisible; /* If you want to make the number Invisible */

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                    trigger OnValidate()
                    begin

                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }

                field("Name as per ID"; Rec."Name as per ID")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }

                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group("Identity Documents")
            {
                field("ID Type"; Rec."ID Type")
                {
                    ApplicationArea = All;
                }
                field("National ID No."; Rec."National ID No.")
                {
                    ApplicationArea = All;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                }

                field("HUDUMA Number"; Rec."HUDUMA Number")
                {
                    ApplicationArea = All;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                }

            }
            group("Contact Details")
            {
                Caption = 'Contact Details';
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("Alternative Phone No."; Rec."Alternative Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                }
                field("Town/City"; Rec."Town/City")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }

                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                }
            }
            group("Employment & Income")
            {
                field("Employment Status"; Rec."Employment Status")
                {
                    ApplicationArea = All;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = All;
                }
                field("Monthly Income"; Rec."Monthly Income")
                {
                    ApplicationArea = All;
                }
            }
            group("Sacco Membership Details")
            {
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = All;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = All;
                }
                field("Introduced By Member No."; Rec."Introduced By Member No.")
                {
                    ApplicationArea = All;
                }
                field("Introducer Name"; Rec."Introducer Name")
                {
                    ApplicationArea = All;
                }
                field("Assigned Member No."; Rec."Assigned Member No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Bank & Mobile Banking")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile Banking Enabled"; Rec."Mobile Banking Enabled")
                {
                    ApplicationArea = All;
                }
            }
            group(Attachments)
            {
                field("ID Copy Attached"; Rec."ID Copy Attached")
                {
                    ApplicationArea = All;
                }
                field("Passport Photo Attached"; Rec."Passport Photo Attached")
                {
                    ApplicationArea = All;
                }
                field("Signature Specimen Attached"; Rec."Signature Specimen Attached")
                {
                    ApplicationArea = All;
                }
                field("KRA PIN Attached"; Rec."KRA PIN Attached")
                {
                    ApplicationArea = All;
                }
            }

            group(Audit)
            {
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                    ApplicationArea = All;
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        // SetNoFieldVisible();
        Message('Welcome to my Sacco App (Member Application)');
    end;

    // ====================== Field Visibility ===========================

    local procedure SetNoFieldVisible()
    var

    begin
        NoFieldVisible := MemberNoVisible();
    end;

    procedure MemberNoVisible(): Boolean
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        IsVisible: Boolean;
    begin
        IsHandled := false;
        IsVisible := false;
        OnBeforeMemberNoIsVisible(IsVisible, IsHandled);
        if IsHandled then
            exit(IsVisible);
        if IsMemberNoInitialized then
            exit(MemberNoVisible);
        IsMemberNoInitialized := true;

        NoSeriesCode := DetermineMemberSeriesNo();
        MemberNoIsVisible := DocumentNoVisibility.ForceShowNoSeriesForDocNo(NoSeriesCode);
        exit(MemberNoVisible);
    end;

    local procedure DetermineMemberSeriesNo(): Code[20]
    var
        SACCOSetup: Record "SACCO SetUp";
    begin
        SACCOSetup.SetLoadFields("Member Application Nos.");
        SACCOSetup.Get();
        exit(SACCOSetup."Member Application Nos.");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMemberNoIsVisible(var IsVisible: Boolean; var IsHandled: Boolean)
    begin
    end;
    // ==========================================================

    var
        NoFieldVisible: Boolean;
        IsMemberNoInitialized: Boolean;
        MemberNoIsVisible: Boolean;
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
}
