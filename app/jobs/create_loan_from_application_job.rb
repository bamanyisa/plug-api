class CreateLoanFromApplicationJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do
      application = LoanApplication.find(record_id)
      response = Fineract::LoansService.new(application.organization).submit(application)

      Loan.create!(
        organization: application.organization,
        borrower: application.borrower,
        loan_product: application.loan_product,
        loan_application: application,
        assigned_officer: application.assigned_officer,
        fineract_loan_id: response["loanId"] || response["resourceId"],
        status: "submitted",
        principal_amount: application.requested_amount
      )
    end
  end
end
