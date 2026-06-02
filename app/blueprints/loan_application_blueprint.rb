class LoanApplicationBlueprint < Blueprinter::Base
  identifier :id
  fields :borrower_id, :loan_product_id, :assigned_officer_id, :approved_by_id, :status, :requested_amount,
         :requested_term, :purpose, :additional_fields, :submitted_at, :approved_at,
         :rejected_at, :disbursed_at, :rejection_reason, :created_at, :updated_at
end
