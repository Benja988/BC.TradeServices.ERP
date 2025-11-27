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
                field("Full Name";Rec."Full Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        // SetNoFieldVisible();
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

    // =========================================================





    var
        NoFieldVisible: Boolean;
        IsMemberNoInitialized: Boolean;
        MemberNoIsVisible: Boolean;
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
}
