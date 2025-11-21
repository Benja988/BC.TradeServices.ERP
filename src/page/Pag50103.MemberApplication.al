page 50103 "Member Application"
{
    ApplicationArea = All;
    Caption = 'Member Application';
    PageType = Card;
    SourceTable = MemberApplication;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';

                    ApplicationArea = All;
                    Importance = Standard;
                    // Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
            }
            group(Input)
            {
                Caption = 'Input';
                field(Value1; Value1)
                {
                    ApplicationArea = All;
                    Caption = 'Value 1';
                }
                field(Value2; Value2)
                {
                    ApplicationArea = All;
                    Caption = 'Value 2';
                }
            }
            group(Output)
            {
                Caption = 'Output';
                field(Result; Result)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(Execute)
            {
                ApplicationArea = All;
                Caption = 'Execute';
                Image = ExecuteBatch;

                trigger OnAction()
                begin
                    Result := Value1 > Value2;
                end;
            }
        }
    }

    /* trigger OnOpenPage()
    begin
        Message('The value of %1 is %2', 'YesOrNo', YesOrNo);
        Message('The value of %1 is %2', 'Amount', Amount);
        Message('The value of %1 is %2', 'When Was It', "When Was It");
        Message('The value of %1 is %2', 'What Time', "What Time");
        Message('The value of %1 is %2', 'Description', Description);
        Message('The value of %1 is %2', 'Code Number', "Code Number");
        Message('The value of %1 is %2', 'Ch', Ch);
        Message('The value of %1 is %2', 'Color', Color);
    end; */

#if DEBUG
    trigger OnOpenPage()
    var
        TableHeader: Record MemberApplication;
        
    begin
        // Message('Only in debug versions');
        // Rec.TestDatesFunctions();
        // TodaysDay();
        TableHeader.MyFunction();
    end;
#endif

    procedure TodaysDay()
    var
        Days: Text[50];
        Selection: Integer;
    begin
        Days := 'Monday, Tuesday, Wednesday, Thursday, Friday';
        Selection := StrMenu(Days, 1, 'Which day is today ?');
        Message('You Selected %1.', Selection);
        if GuiAllowed then
            Message('Hello');
    end;

    Procedure GetCustomerByName(Name: Text): Record Customer;
    var
        Customer: Record Customer;
    begin
        Customer.SetFilter(Name, '@' + Name + '*');
        Customer.FindFirst();
        exit(Customer);
    end;



    var
        LoopNo: Integer;
        YesOrNo: Boolean;
        Amount: Decimal;
        "When Was It": Date;
        "What Time": Time;
        Description: Text[30];
        "Code Number": Code[10];
        Ch: Char;
        Color: Option Red,Orange,Yellow,Green,Blue,Violet;
        Value1: Integer;
        Value2: Integer;
        Result: Boolean;
        NoFieldVisible: Boolean;
}
