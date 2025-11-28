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
    [EventSubscriber(ObjectType::Table, Database::"SACCO Member Application", OnAfterValidateEvent, "Alternative Phone No.", false, false)]
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



}
