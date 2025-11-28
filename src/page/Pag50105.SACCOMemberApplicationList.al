page 50105 "SACCO Member Application List"
{
    ApplicationArea = All;
    Caption = 'SACCO Member Application List';
    PageType = List;
    SourceTable = "SACCO Member Application";
    CardPageId = "SACCO Member Application Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Mobile Banking Enabled"; Rec."Mobile Banking Enabled")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;


}
