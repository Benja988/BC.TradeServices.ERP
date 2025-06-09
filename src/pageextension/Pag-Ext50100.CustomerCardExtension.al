pageextension 50100 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group("Custom Info")
            {
                field("Customer Type";Rec."Customer Type")
                {

                }
                field("Account Manager";Rec."Account Manager")
                {
                    
                }
            }
        }
    }
}
