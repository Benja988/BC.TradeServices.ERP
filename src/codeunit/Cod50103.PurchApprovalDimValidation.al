codeunit 50103 "Purch Approval Dim Validation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckPurchaseApprovalPossible', '', false, false)]
    local procedure ValidateDimensionsBeforeApproval(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        TempPurchLine: Record "Purchase Line" temporary;
        CheckDimensions: Codeunit "Check Dimensions";
    begin
        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) then
            exit;

        FillTempPurchLines(PurchaseHeader, TempPurchLine);
        CheckDimensions.CheckPurchDim(PurchaseHeader, TempPurchLine);
        
        IsHandled := false;
    end;

    local procedure FillTempPurchLines(PurchaseHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary)
    var
        PurchLine: Record "Purchase Line";
    begin
        TempPurchLine.DeleteAll();
        TempPurchLine.Reset();
        
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