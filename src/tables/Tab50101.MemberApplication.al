table 50101 MemberApplication
{
    Caption = 'MemberApplication';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    procedure SelectColor()
    var
        Color: Option Green, red, Yellow;
    begin
        Color := Color::red;
        Message('The selected color is: %1', Color);
    end;

    procedure AccessSalesAmount()
    begin
        SalesAmount[5] := 0;
    end;

    procedure AccessPurchaseAmount()
    begin
        PurchaseAmount[5,3] := 0;
    end;

    procedure AddCustomerNames()
    var
        CustomerNames: List of [Text];
        CountriesDictionary: Dictionary of [Code[20], List of [Text]];
    begin
        CustomerNames.Add('Benjamin');
        Message(CustomerNames.Get(1));

        CountriesDictionary.Add('US', CustomerNames);
    end;

    procedure ConditionalStatement()
    var
        a: Integer;
        b: Integer;
        c: Integer;
    begin
        a := 10;
        b := 5;

        if a > b then
            c := a-b;
        
        if a > b then begin
            c := a-b;
            Message('%1', c);
        end;

        if a > b then 
            c := a - b
        else
            c := a + b;
    end;

    var
        SalesAmount: array[10] of Integer;
        PurchaseAmount: array[6,9] of Integer;


}
