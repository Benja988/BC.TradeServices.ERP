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
                field("No.";Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name";Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name";Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field(SurName;Rec.SurName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
