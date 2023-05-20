codeunit 50832 TestPrint
{


    procedure PrintSalesHeader(NewSalesHeader: Record "Sales Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader := NewSalesHeader;
        SalesHeader.SetRecFilter();
        // CalcSalesDiscount(SalesHeader);
        ReportSelection.PrintWithCheckForCust(ReportSelection.Usage::"S.Test", SalesHeader, SalesHeader.FieldNo("Bill-to Customer No."));
    end;



    local procedure CalcSalesDiscount(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        if SalesSetup."Calc. Inv. Discount" then begin
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            OnCalcSalesDiscOnAfterSetFilters(SalesLine, SalesHeader);
            SalesLine.FindFirst();
            OnCalcSalesDiscOnBeforeRun(SalesHeader, SalesLine);
            CODEUNIT.Run(CODEUNIT::"Sales-Calc. Discount", SalesLine);
            SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.");
            Commit();
        end;

        OnAfterCalcSalesDiscount(SalesHeader, SalesLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCalcSalesDiscOnAfterSetFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCalcSalesDiscOnBeforeRun(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcSalesDiscount(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;








    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
        ReportSelection: Record "Report Selections";
}