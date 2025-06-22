page 50102 "Customer Onboarding Card"
{
    ApplicationArea = All;
    Caption = 'Customer Onboarding Card';
    PageType = Card;
    SourceTable = CustomerOnboarding;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No.";Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("No. Series";Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Business Type"; Rec."Business Type")
                {
                    ToolTip = 'Specifies the value of the Business Type field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Region Code"; Rec."Region Code")
                {
                    ToolTip = 'Specifies the value of the Region Code field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Requested Credit Limit"; Rec."Requested Credit Limit")
                {
                    ToolTip = 'Specifies the value of the Requested Credit Limit field.', Comment = '%';
                    ApplicationArea = all;
                }

                
                field("Created Customer No."; Rec."Created Customer No.")
                {
                    ToolTip = 'Specifies the value of the Created Customer No. field.', Comment = '%';
                    ApplicationArea = all;
                }
                
            }
            group(Status001)
            {
                Caption = 'Status';
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ToolTip = 'Specifies the value of the Submission Date field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Submitted By field.', Comment = '%';
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ToolTip = 'Specifies the value of the Rejection Reason field.', Comment = '%';
                    ApplicationArea = all;
                }
            }
            group(Attachment001)
            {
                Caption = 'Attachement';
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachment (Optional) field.', Comment = '%';
                    ApplicationArea = all;
                }
            }
            group(Audit)
            {
                Caption = 'Audit';
                field("Last Modified DateTime"; Rec."Last Modified DateTime")
                {
                    ToolTip = 'Specifies the value of the Last Modified DateTime field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    ApplicationArea = all;
                }

                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                    ApplicationArea = all;
                }
            }
        }

        area(FactBoxes)
        {
            // part(UserDetails; "User Info FactBox")
            // {
            //     ApplicationArea = All;
            //     // SubPageLink = "User Name" = field("Submitted By");
            // }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateCustomer)
            {
                Caption = 'Create Customer';
                Image = Customer;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    if rec.Status <> rec.Status::Approved then
                        Error('Customer must be approved first.');

                    Message('Customer record would be created here.');
                end;
            }
        }
    }
}
