table 50101 MemberApplication
{
    Caption = 'MemberApplication';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            OptimizeForTextSearch = true;
        }
        field(2; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldCust: Record MemberApplication): Boolean
    var
        Cust: Record MemberApplication;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        Cust := Rec;
        SalesSetup.Get();
        SalesSetup.TestField("Customer Nos.");
        if NoSeries.LookupRelatedNoSeries(SalesSetup."Customer Nos.", OldCust."No. Series", Cust."No. Series") then begin
            Cust."No." := NoSeries.GetNextNo(Cust."No. Series");
            Rec := Cust;
            OnAssistEditOnBeforeExit(Cust);
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAssistEditOnBeforeExit(var Member: Record MemberApplication)
    begin
    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.CustomerNoIsVisible();
    end;


    procedure SelectColor()
    var
        Color: Option Green,red,Yellow;
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
        PurchaseAmount[5, 3] := 0;
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
            c := a - b;

        if a > b then begin
            c := a - b;
            Message('%1', c);
        end;

        if a > b then
            c := a - b
        else
            c := a + b;

        // TestString.
    end;

    procedure TestStringFucntions()
    var
        position: Integer;
    begin
        // StrPos(Text, Substring);
        Message('%1', StrPos(TestString, 'brown'));
        // position := Text.StrSubstNo()

    end;

    procedure TestDatesFunctions()
    var
        TodaysDate: Date;
        MydatePart: Integer;
        MyWeekPart: Integer;
    begin
        TodaysDate := Today;
        MydatePart := Date2DMY(Today(), 1);
        MyWeekPart := Date2DWY(Today(), 2);
        Message('1 week from now is %1', CalcDate('1W', TodaysDate));
        Message('Today is %1 and week %2', MydatePart, MyWeekPart);

    end;

    procedure CalculatePrice(): Decimal
    begin

    end;

    procedure MyFunction(): Integer
    var
        myResult: Integer;
    begin
        myResult := Power(2, 3);
        exit(myResult);
        Message('2 Raise to Power 3 is %1', myResult);
    end;

    

    [IntegrationEvent(false, false)]
    local procedure MyProcedure()
    begin
    end;


    var
        SalesAmount: array[10] of Integer;
        PurchaseAmount: array[6, 9] of Integer;

        TestString: label 'The quick brown fox jumped over the lazy dogs';
        NoFieldVisible: Boolean;


}
