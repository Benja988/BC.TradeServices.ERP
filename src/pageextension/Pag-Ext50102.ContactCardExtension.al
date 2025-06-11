pageextension 50102 ContactCardExtension extends "Contact Card"
{
    layout
    {
        addlast(General)
        {
            field("Linkedin Profile";Rec."Linkedin Profile")
            {
                ApplicationArea = All;
            }
            field("Lead Source";Rec."Lead Source")
            {
                ApplicationArea = All;
            }
            field("Lead Score";Rec."Lead Score")
            {
                ApplicationArea = All;
            }
            field("Is Qualified Lead";Rec."Is Qualified Lead")
            {
                ApplicationArea = All;
            }
        }

        addlast(factboxes)
        {
            part(ContactInteractions; "Contact Interactions Part")
            {
                SubPageLink = "Contact No." = field("No.");
                ApplicationArea = All;
            }
        }
    }

   
    



    actions
    {
        addlast(navigation)
        {
            action(CreateCustomer1)
            {
                ApplicationArea = All;
                Caption = 'Create Customer';
                ToolTip = 'Test Customer Creation';
                Image = Customer;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    ContactBusinessRelation: Record "Contact Business Relation";

                begin
                    ContactBusinessRelation.Init();
                    ContactBusinessRelation.Validate("Contact No.", Rec."No.");
                    ContactBusinessRelation.Validate("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                    ContactBusinessRelation.Insert(true);
                    Message('Customer record linked to this contact');
                end;
            }
        }
    }
}
