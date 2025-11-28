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
    [EventSubscriber(ObjectType::Table, Database::"SACCO Member Application", OnAfterValidateEvent, 'Phone No.', false, false)]
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



}
