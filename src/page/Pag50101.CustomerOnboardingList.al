page 50101 "Customer Onboarding List"
{
    ApplicationArea = All;
    Caption = 'Customer Onboarding List';
    PageType = List;
    SourceTable = CustomerOnboarding;
    UsageCategory = Lists;
    CardPageId = "Customer Onboarding Card";

    // SourceTableView = sorting("Submission Date") order(descending);
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                    ApplicationArea = all;
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
                    ToolTip = 'Specifies the value of the Submitted By field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ToolTip = 'Specifies the value of the Rejection Reason field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachment (Optional) field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Created Customer No."; Rec."Created Customer No.")
                {
                    ToolTip = 'Specifies the value of the Created Customer No. field.', Comment = '%';
                    ApplicationArea = all;
                }
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

        
    }
    actions
        {
            area(Navigation)
            {
                group(reporting002)
                {
                    action(print)
                    {
                        Caption = 'Print';
                        Image = Print;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            Message('Printing Onboarding Records ...');
                        end;
                    }
                }
            }
            area(Processing)
            {
                action(ApproveCustomer)
                {
                    Caption = 'Approve';
                    ApplicationArea = All;
                    Image = Approve;
                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                    begin
                        // status := status::Approved;
                        // Modify(true);
                        // Message('Customer Onboarding Approved');
                    end;
                }
            }
        }

        trigger OnOpenPage()
        begin
            Message('Welcome to Customer Onboarding List.');
        end;
}
