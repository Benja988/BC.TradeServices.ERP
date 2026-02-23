pageextension 50107 "Purch Invoice Approval Ext" extends "Purchase Invoice"
{
    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchaseHeader: Record "Purchase Header";
                TempPurchLine: Record "Purchase Line" temporary;
                CheckDimensions: Codeunit "Check Dimensions";
            begin
                if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, Rec."No.") then
                    exit;

                FillTempPurchLines(PurchaseHeader, TempPurchLine);
                CheckDimensions.CheckPurchDim(PurchaseHeader, TempPurchLine);
            end;
        }
    }

    local procedure FillTempPurchLines(PurchaseHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary)
    var
        PurchLine: Record "Purchase Line";
    begin
        TempPurchLine.Reset();
        TempPurchLine.DeleteAll();

        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");

        if PurchLine.FindSet() then
            repeat
                TempPurchLine := PurchLine;
                TempPurchLine.Insert(true);
            until PurchLine.Next() = 0;
    end;
}