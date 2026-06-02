class LoanProductBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :short_name, :currency_code, :currency_decimal_places, :min_principal, :max_principal,
         :default_principal, :nominal_interest_rate, :amortization_type, :interest_type,
         :repayment_frequency, :repayment_every, :number_of_repayments, :fineract_product_id,
         :sync_status, :synced_at, :active, :created_at, :updated_at
end
