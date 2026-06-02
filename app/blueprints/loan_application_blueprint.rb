class LoanApplicationBlueprint < Blueprinter::Base
  identifier :id
  fields :borrower_id, :fineract_product_id, :fineract_loan_id,
         :assigned_officer_id, :status, :requested_amount,
         :requested_term, :purpose, :rejection_reason, :created_at, :updated_at
end
