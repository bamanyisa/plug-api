class LoanBlueprint < Blueprinter::Base
  identifier :id
  fields :borrower_id, :loan_product_id, :loan_application_id, :assigned_officer_id,
         :fineract_loan_id, :fineract_account_no, :status, :principal_amount, :outstanding_balance,
         :disbursed_on, :expected_maturity_date, :created_at, :updated_at
end
