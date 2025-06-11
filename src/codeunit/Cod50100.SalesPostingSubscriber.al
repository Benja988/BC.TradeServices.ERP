codeunit 50100 SalesPostingSubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]

    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        if SalesHeader."Customer Reference No." = '' then
            Error('Customer Reference No. must be filled before posting.');
    end;

    
}
