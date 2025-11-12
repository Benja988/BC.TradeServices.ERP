pageextension 50105 SalesOrder extends "Order Processor Role Center"
{
    actions
    {
        addlast(sections)
        {
            group(CustomerOnboarding)
            {
                Caption = 'Customer Onboarding';

                action("CustomerOnboarding001")
                {
                    ApplicationArea = all;
                    Caption = 'New Customers';
                    RunObject = page "Customer Onboarding List";
                    RunPageLink = Status = const(New);
                }
                action("CustomerOnboarding002")
                {
                    ApplicationArea = all;
                    Caption = 'Pending Customers';
                    RunObject = page "Customer Onboarding List";
                    RunPageLink = Status = const(pending);
                }
                action("CustomerOnboarding003")
                {
                    ApplicationArea = all;
                    Caption = 'Approved Customers';
                    RunObject = page "Customer Onboarding List";
                    RunPageLink = Status = const(Approved);
                }
                action("CustomerOnboarding004")
                {
                    ApplicationArea = all;
                    Caption = 'Rejected Customers';
                    RunObject = page "Customer Onboarding List";
                    RunPageLink = Status = const(Rejected);
                }
            }

            group(DataTypes)
            {
                Caption = '(AL Study)';
                action("Test001")
                {
                    ApplicationArea=All;
                    Caption='Member Application';
                    RunObject = Page "Member Application";
                }
            }
        }
    }
}
