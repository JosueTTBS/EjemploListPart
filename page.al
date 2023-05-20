page 50100 PAgeTest
{
    Caption = 'Sales Invoice';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));

    AboutTitle = 'About sales invoice details';
    AboutText = 'You can update and add to the sales invoice until you post it. If you leave the invoice without posting, you can return to it later from the list of ongoing invoices.';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                part(SalesLines; "Sales Invoice Subform")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = IsSalesLinesEditable;
                    // Enabled = IsSalesLinesEditable;
                    SubPageLink = "Document No." = FIELD("No.");
                    // UpdatePropagation = Both;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(XML)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    v_SalesLine: Record "Sales Line";
                    v_TestS: Page "Sales Invoice Subform";
                    v_almacen: Record "Sales Line";
                begin
                    v_SalesLine.Get(Rec);

                    codeunitform.XMLv4(Rec);
                end;
            }
            action(TestPrint)
            {
                ApplicationArea = All;

                trigger OnAction()

                begin
                    codeunitTestPrint.PrintSalesHeader(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
        codeunitform: Codeunit XMLtestSUBFORM;
        codeunitTestPrint: Codeunit TestPrint;


}