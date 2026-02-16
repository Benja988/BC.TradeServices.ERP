pageextension 50107 "Purch Invoice Approval Ext" extends "Purchase Invoice"
{
    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchaseLine: Record "Purchase Line";
                DimensionValidator: Codeunit "Purch Approval Dim Validation";
                PurchPost: Codeunit "Purch.-Post";
            begin
                /* PurchaseHeader.Get(Rec."Document Type", Rec."No.");
                DimensionValidator.ValidatePurchaseDimensions(PurchaseHeader);
                PurchPost.FillTempLines(PurchaseHeader, PurchaseLine); */
            end;
        }
    }
}
