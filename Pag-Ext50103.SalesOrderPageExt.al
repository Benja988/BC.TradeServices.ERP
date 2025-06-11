pageextension 50103 SalesOrderPageExt extends "Sales Order"
{
    layout
    {
        addlast(Content)
        {
            group("Custom Details")
            {
                field("Customer Reference No."; Rec."Customer Reference No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
