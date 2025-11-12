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

    var

}
