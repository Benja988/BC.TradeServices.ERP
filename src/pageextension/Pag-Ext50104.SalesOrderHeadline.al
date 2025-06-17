pageextension 50104 SalesOrderHeadline extends "Headline RC Order Processor"
{
    layout
    {
        addlast(content)
        {
            field(headlineText; headlineTextYoutube)
            {
                ApplicationArea = all;

                trigger OnDrillDown()
                var
                    DrillDownURLText: label 'https://aka.ms/bcYoutube', Locked = true;
                begin
                    Hyperlink(DrillDownURLText);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        headlineTextYoutube := 'Watch our YouTube channel for more information about our products and services.';
    end;

    var
        headlineTextYoutube: Text;
}
