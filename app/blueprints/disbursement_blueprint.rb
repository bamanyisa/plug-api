class DisbursementBlueprint < Blueprinter::Base
  identifier :id
  fields :loan_id, :disbursed_by_id, :amount, :disbursed_on, :payment_type, :status,
         :fineract_transaction_id, :fineract_transaction_ref, :failure_reason, :created_at, :updated_at
end
