page 50100 "Contact Interactions Part"
{
    ApplicationArea = All;
    Caption = 'Contact Interactions Part';
    PageType = ListPart;
    SourceTable = "Interaction Log Entry";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Interaction Group Code"; Rec."Interaction Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the interaction group used to create this interaction. This field is not editable.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the interaction.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

    end;
}
