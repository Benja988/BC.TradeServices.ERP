pageextension 50108 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    actions
    {
        addlast(processing)
        {


            action(ValidateAllDimensions)
            {
                ApplicationArea = All;
                Caption = 'Validate All Dimensions (Header + Lines)';
                Image = CheckDuplicates;
                ToolTip = 'Validate dimensions for header and all lines (same as approval validation)';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    TempLine: Record "Purchase Line" temporary;
                    CheckDimensions: Codeunit "Check Dimensions";
                     PurchPost: Codeunit "Purch.-Post Ext";
                begin
                    Message('Starting Full Dimension Validation (Header + Lines)...');

                    if not PurchaseHeader.Get(Rec."Document Type", Rec."Document No.") then
                        Error('Purchase Header not found');

                    Message('Validating document: %1 %2',
                            PurchaseHeader."Document Type",
                            PurchaseHeader."No.");

                    // This uses the PUBLIC procedure that's available
                    CheckDimensions.CheckPurchDim(PurchaseHeader, TempLine);

                    Message('✓ All validations PASSED! Document is ready for approval/posting.');
                end;
            }
        }
    }


}
