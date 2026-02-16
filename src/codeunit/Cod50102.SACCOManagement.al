codeunit 50102 "SACCO Management"
{
   Access = Public;
    
    var
        CheckDimensions: Codeunit "Check Dimensions";
        DimMgt: Codeunit DimensionManagement;
        PurchHeader: Record "Purchase Header";
        TempPurchLine: Record "Purchase Line" temporary;
        
    /// <summary>
    /// Validates ALL dimensions on a purchase document (header + all lines)
    /// </summary>
    procedure ValidateAllPurchDimensions(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        TempValidationLine: Record "Purchase Line" temporary;
    begin
        // Set error collection mode
        DimMgt.SetCollectErrorsMode();
        
        // APPROACH 1: If you need to validate ALL lines regardless of quantities,
        // we need to create a temporary line record with forced quantities
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter(Type, '<>%1', PurchaseLine.Type::" ");
        
        if PurchaseLine.FindSet() then
            repeat
                // Create a copy of the line with forced positive quantity
                // This tricks CheckPurchDim into validating it
                TempValidationLine := PurchaseLine;
                TempValidationLine."Qty. to Invoice" := TempValidationLine.Quantity;
                TempValidationLine."Qty. to Receive" := TempValidationLine.Quantity;
                TempValidationLine."Return Qty. to Ship" := TempValidationLine.Quantity;
                TempValidationLine.Insert();
            until PurchaseLine.Next() = 0;
        
        // Call the public procedure with our forced lines
        CheckDimensions.CheckPurchDim(PurchaseHeader, TempValidationLine);
        
        // Clean up
        TempValidationLine.DeleteAll();
    end;
    
    /// <summary>
    /// Validates dimensions exactly like posting does
    /// </summary>
    procedure ValidatePurchDimensionsForPosting(PurchaseHeader: Record "Purchase Header")
    var
        TempLine: Record "Purchase Line" temporary;
    begin
        // This matches exactly what posting uses - only lines with quantities
        CheckDimensions.CheckPurchDim(PurchaseHeader, TempLine);
    end;
}
