codeunit 50101 Validations
{

    trigger OnRun()
    begin

    end;

    local procedure CheckForPlusSign(TextToVerify: Text)
    var
        myInt: Integer;
    begin
        if TextToVerify.Contains('+') then
            Message('A + sign has been found.');
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Address', false, false)]
    local procedure TableCustomerOnAfterValidateEventAddress(var Rec: Record Customer)
    begin
        CheckForPlusSign(Rec.Address);
    end;


    // =========================================================
    // Event Subscriber test
    // =========================================================
    [EventSubscriber(ObjectType::Table, Database::"SACCO Member Application", 'OnAfterValidateEvent', 'Email', false, false)]
    local procedure TableSACCOMemberOnAfterValidateEvent(var Rec: Record "SACCO Member Application")
    begin
        CheckForPlusSign1(Rec.Email);
    end;

    local procedure CheckForPlusSign1(TextToVerify: Text)
    begin
        if TextToVerify.Contains('@') then
            Message('A @ sign has been found.');
    end;


    // ==========================================================
    // Validate PhoNo
    // ==========================================================
    /*[EventSubscriber(ObjectType::Table, Database::"SACCO Member Application", OnAfterValidateEvent, 'Phone No.', false, false)]
     local procedure ValidatePhoneNo(var Rec: Record "SACCO Member Application"; var xRec: Record "SACCO Member Application")
    var
        Phone: Text;
        ErrorMsg: Text;
    begin
        Phone := Rec."Phone No.";

        Phone := DelChr(Phone, '=', ' ');

        if Phone = '' then
            exit;

        if CopyStr(Phone, 1, 1) = '+' then
            Phone := CopyStr(Phone, 2);

        if not IsDigitsOnly(Phone) then begin
            ErrorMsg := 'Phone number must contain only digits, optionally starting with a + sign.';
            Error(ErrorMsg);
        end;

        if StrLen(Phone) < 7 then
            Error('Phone number is too short.');

        if StrLen(Phone) > 15 then
            Error('Phone number is too long.');
    end;

    local procedure IsDigitsOnly(InputText: Text): Boolean
    var
        i: Integer;
    begin
        for i := 1 to StrLen(InputText) do
            if not (InputText[i] in ['0' .. '9']) then
                exit(false);
        exit(true);
    end;
 */

    // =======================================================
    // Kenya Specific Phone No Validation
    // =================================================
    [EventSubscriber(ObjectType::Table, Database::"SACCO Member Application", OnAfterValidateEvent, "Phone No.", false, false)]
    local procedure KenyaPhonNoValidation(var Rec: Record "SACCO Member Application"; var xRec: Record "SACCO Member Application")
    var
        PhoneNo: Text;
    begin
        PhoneNo := Rec."Phone No.";
        PhoneNo := DelChr(PhoneNo, '=', ' '); /* Removes White Spaces */

        /* +254 Format */
        if CopyStr(PhoneNo, 1, 4) = '+254' then begin
            if StrLen(PhoneNo) <> 13 then
                Error('Invalid phone number. +254 format must be exactly 13 characters.');
            Exit;
        end;

        /* 07X format */
        if CopyStr(PhoneNo, 1, 2) = '07' then begin
            if StrLen(PhoneNo) <> 10 then
                Error('Invalid phone number. 07 format must be exactly 10 characters.');
            Exit;
        end;

        /* 01X Format */
        if CopyStr(PhoneNo, 1, 2) = '01' then begin
            if StrLen(PhoneNo) <> 10 then
                Error('Invalid phone number. 01 format must be exactly 10 characters.');
            Exit;
        end;
        Error('Invalid phone number format. Use +2547XXXXXXXX or 07XXXXXXXX or 01XXXXXXXX.');
    end;


    //🔧 As Business Central developers, we often deal with operations that can fail—like inserting records or calling external APIs. Instead of cluttering code with manual error handling, AL gives us a neat tool: `TryFunction`.



/* [TryFunction]
procedure InsertCustomerSafe(Customer: Record Customer): Boolean;
begin
    Customer.Insert();
    exit(true);
end;

procedure CreateCustomer()
var
    Customer: Record Customer;
    Success: Boolean;
begin
    Customer.Init();
    Customer.Name := 'Test Customer';
    Success := InsertCustomerSafe(Customer);

    if not Success then
        Message('Customer could not be created. Handle gracefully here.');
end; */



/* codeunit 50103 "Purch Approval Dim Validation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckPurchaseApprovalPossible', '', false, false)]
    local procedure ValidateDimensionsBeforeApproval(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        TempPurchLine: Record "Purchase Line" temporary;
        CheckDimensions: Codeunit "Check Dimensions";
    begin
        // Only validate purchase invoices and credit memos (per assignment)
        if not (PurchaseHeader."Document Type" in [
            PurchaseHeader."Document Type"::Invoice,
            PurchaseHeader."Document Type"::"Credit Memo"
        ]) then
            exit;

        // Reuse the exact same validation logic as posting
        FillTempPurchLines(PurchaseHeader, TempPurchLine);
        CheckDimensions.CheckPurchDim(PurchaseHeader, TempPurchLine);
        
        // If we get here, dimensions are valid - let approval continue
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
} */


/* codeunit 50103 "Purch Approval Dim Validation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.",
    'OnAfterCheckPurchaseApprovalPossible', '', false, false)]
    local procedure ValidateDimensionsOnCheckApprovalPossible(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        CheckDimensions: Codeunit "Check Dimensions";
        DimMgt: Codeunit DimensionManagement;
        DimSetEntry: Record "Dimension Set Entry";
        DiagnosticMsg: Text;
        LineCount: Integer;
    begin
        if not (PurchaseHeader."Document Type" in [
            PurchaseHeader."Document Type"::Invoice,
            PurchaseHeader."Document Type"::"Credit Memo"
        ]) then
            exit;

        // Display header dimensions
        DiagnosticMsg := StrSubstNo('=== HEADER DIMENSIONS ===\Document: %1 %2\Dimension Set ID: %3\',
            PurchaseHeader."Document Type", PurchaseHeader."No.", PurchaseHeader."Dimension Set ID");

        DimSetEntry.SetRange("Dimension Set ID", PurchaseHeader."Dimension Set ID");
        if DimSetEntry.FindSet() then
            repeat
                DiagnosticMsg += StrSubstNo('  %1 = %2\', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
            until DimSetEntry.Next() = 0
        else
            DiagnosticMsg += '  (No dimensions)\';

        // Load purchase lines into temporary table and display their dimensions
        DiagnosticMsg += '\=== LINE DIMENSIONS ===\';
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter(Type, '<>%1', PurchaseLine.Type::" ");
        if PurchaseLine.FindSet() then
            repeat
                LineCount += 1;
                TempPurchLine := PurchaseLine;
                TempPurchLine.Insert();

                DiagnosticMsg += StrSubstNo('Line %1 (Type: %2, No.: %3):\',
                    PurchaseLine."Line No.", PurchaseLine.Type, PurchaseLine."No.");
                DiagnosticMsg += StrSubstNo('  Dimension Set ID: %1\', PurchaseLine."Dimension Set ID");

                DimSetEntry.SetRange("Dimension Set ID", PurchaseLine."Dimension Set ID");
                if DimSetEntry.FindSet() then
                    repeat
                        DiagnosticMsg += StrSubstNo('    %1 = %2\', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                    until DimSetEntry.Next() = 0
                else
                    DiagnosticMsg += '    (No dimensions)\';
            until PurchaseLine.Next() = 0;

        DiagnosticMsg += StrSubstNo('\Total lines to validate: %1', LineCount);

        // Show diagnostic message
        Message(DiagnosticMsg);

        // Set flags to force line validation
        PurchaseHeader.Invoice := true;  // This forces the dimension check on lines

        // Validate dimensions - will throw error if invalid
        CheckDimensions.CheckPurchDim(PurchaseHeader, TempPurchLine);
    end;
} */

procedure ValidatePurchaseDimensions(var PurchaseHeader: Record "Purchase Header")
    var
        TempPurchLine: Record "Purchase Line" temporary;
        CheckDimensions: Codeunit "Check Dimensions";
    begin
        Message('VALIDATION STARTED for Document: %1 %2', PurchaseHeader."Document Type", PurchaseHeader."No.");

        // Only validate purchase invoices and credit memos
        if not (PurchaseHeader."Document Type" in [
            PurchaseHeader."Document Type"::Invoice,
            PurchaseHeader."Document Type"::"Credit Memo"
        ]) then begin
            Message('Document type is not Invoice or Credit Memo. Skipping validation.');
            exit;
        end;

        Message('Document type is valid. Proceeding with validation.');

        // Fill temporary lines for validation
        FillTempPurchLines(PurchaseHeader, TempPurchLine);
        
        Message('Filled %1 purchase lines for validation', TempPurchLine.Count);

        // Validate header dimensions (combination + posting restrictions)
        Message('Starting header dimension validation...');
        ValidateHeaderDimensions(PurchaseHeader);
        Message('Header validation PASSED');

        // Validate line dimensions (combination + posting restrictions)
        if TempPurchLine.FindSet() then begin
            Message('Starting line dimension validation for %1 lines...', TempPurchLine.Count);
            repeat
                Message('Validating Line No: %1, Type: %2, No: %3', TempPurchLine."Line No.", TempPurchLine.Type, TempPurchLine."No.");
                ValidateLineDimensions(TempPurchLine);
                Message('Line %1 validation PASSED', TempPurchLine."Line No.");
            until TempPurchLine.Next() = 0;
        end else
            Message('No lines to validate!');

        // Use the standard CheckPurchDim to catch anything else
        Message('Running standard CheckPurchDim...');
        CheckDimensions.CheckPurchDim(PurchaseHeader, TempPurchLine);
        
        Message('ALL VALIDATIONS PASSED! Document can be sent for approval.');
    end;

    procedure ValidateSingleLine(var PurchaseLine: Record "Purchase Line")
    begin
        Message('ValidateSingleLine called for Line No: %1', PurchaseLine."Line No.");
        ValidateLineDimensions(PurchaseLine);
    end;

    local procedure FillTempPurchLines(PurchaseHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary)
    var
        PurchLine: Record "Purchase Line";
        LineCount: Integer;
    begin
        Message('FillTempPurchLines START');
        
        TempPurchLine.DeleteAll();
        TempPurchLine.Reset();

        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");

        Message('Looking for lines in Document: %1 %2', PurchaseHeader."Document Type", PurchaseHeader."No.");

        if PurchLine.FindSet() then begin
            repeat
                LineCount += 1;
                TempPurchLine := PurchLine;
                if TempPurchLine.Insert(true) then
                    Message('Inserted line %1: Type=%2, No=%3, Dim Set ID=%4', 
                        TempPurchLine."Line No.", TempPurchLine.Type, TempPurchLine."No.", TempPurchLine."Dimension Set ID");
            until PurchLine.Next() = 0;
            Message('Total lines found: %1', LineCount);
        end else
            Message('NO LINES FOUND!');
    end;

    local procedure ValidateHeaderDimensions(PurchaseHeader: Record "Purchase Header")
    var
        DimMgt: Codeunit DimensionManagement;
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorContextElement: Codeunit "Error Context Element";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        HeaderDimensionBlockedErr: Label 'The combination of dimensions used in %1 %2 is blocked.';
        ContextErrorMessage: Text[250];
    begin
        Message('ValidateHeaderDimensions START - Dim Set ID: %1', PurchaseHeader."Dimension Set ID");

        if PurchaseHeader."Dimension Set ID" = 0 then begin
            Message('Header has no dimensions. Skipping header validation.');
            exit;
        end;

        ContextErrorMessage := StrSubstNo(HeaderDimensionBlockedErr, PurchaseHeader."Document Type", PurchaseHeader."No.");
        ErrorMessageMgt.PushContext(ErrorContextElement, PurchaseHeader.RecordId, 0, ContextErrorMessage);
        
        // Check dimension combination
        Message('Checking dimension combination...');
        if not DimMgt.CheckDimIDComb(PurchaseHeader."Dimension Set ID") then
            Error(ContextErrorMessage + ' ' + DimMgt.GetDimErr());
        Message('Dimension combination check PASSED');

        // Check dimension value posting restrictions
        Message('Checking dimension value posting restrictions...');
        TableID[1] := DATABASE::Vendor;
        No[1] := PurchaseHeader."Pay-to Vendor No.";
        TableID[2] := DATABASE::"Salesperson/Purchaser";
        No[2] := PurchaseHeader."Purchaser Code";
        TableID[3] := DATABASE::Campaign;
        No[3] := PurchaseHeader."Campaign No.";
        TableID[4] := DATABASE::"Responsibility Center";
        No[4] := PurchaseHeader."Responsibility Center";

        Message('Checking: Vendor=%1, Purchaser=%2, Campaign=%3, Resp Center=%4', 
            No[1], No[2], No[3], No[4]);

        if not DimMgt.CheckDimValuePosting(TableID, No, PurchaseHeader."Dimension Set ID") then
            Error(DimMgt.GetDimErr());
        
        Message('Dimension value posting check PASSED');
        
        ErrorMessageMgt.PopContext(ErrorContextElement);
    end;

    local procedure ValidateLineDimensions(PurchaseLine: Record "Purchase Line")
    var
        DimMgt: Codeunit DimensionManagement;
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorContextElement: Codeunit "Error Context Element";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        LineDimensionBlockedErr: Label 'The combination of dimensions used in %1 %2, line no. %3 is blocked.';
        ContextErrorMessage: Text[250];
    begin
        Message('ValidateLineDimensions START - Line %1, Dim Set ID: %2', PurchaseLine."Line No.", PurchaseLine."Dimension Set ID");

        if PurchaseLine."Dimension Set ID" = 0 then begin
            Message('Line %1 has no dimensions. Skipping line validation.', PurchaseLine."Line No.");
            exit;
        end;

        ContextErrorMessage := StrSubstNo(LineDimensionBlockedErr, PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.");
        ErrorMessageMgt.PushContext(ErrorContextElement, PurchaseLine.RecordId, 0, ContextErrorMessage);
        
        // Check dimension combination
        Message('Checking line dimension combination...');
        if not DimMgt.CheckDimIDComb(PurchaseLine."Dimension Set ID") then
            Error(ContextErrorMessage + ' ' + DimMgt.GetDimErr());
        Message('Line dimension combination check PASSED');

        // Check dimension value posting restrictions for lines
        Message('Setting up dimension value posting check for line type: %1', PurchaseLine.Type);
        case PurchaseLine.Type of
            PurchaseLine.Type::"G/L Account":
                begin
                    TableID[1] := DATABASE::"G/L Account";
                    No[1] := PurchaseLine."No.";
                    Message('Checking G/L Account: %1', No[1]);
                end;
            PurchaseLine.Type::Item:
                begin
                    TableID[1] := DATABASE::Item;
                    No[1] := PurchaseLine."No.";
                    Message('Checking Item: %1', No[1]);
                end;
            PurchaseLine.Type::"Fixed Asset":
                begin
                    TableID[1] := DATABASE::"Fixed Asset";
                    No[1] := PurchaseLine."No.";
                    Message('Checking Fixed Asset: %1', No[1]);
                end;
            PurchaseLine.Type::"Charge (Item)":
                begin
                    TableID[1] := DATABASE::"Item Charge";
                    No[1] := PurchaseLine."No.";
                    Message('Checking Item Charge: %1', No[1]);
                end;
        end;

        // Add Job if applicable
        if PurchaseLine."Job No." <> '' then begin
            TableID[2] := DATABASE::Job;
            No[2] := PurchaseLine."Job No.";
            Message('Also checking Job: %1', No[2]);
        end;

        if not DimMgt.CheckDimValuePosting(TableID, No, PurchaseLine."Dimension Set ID") then
            Error(DimMgt.GetDimErr());
        
        Message('Line dimension value posting check PASSED');
        
        ErrorMessageMgt.PopContext(ErrorContextElement);
    end;


    
}
