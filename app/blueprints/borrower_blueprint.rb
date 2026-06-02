class BorrowerBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :email, :phone, :national_id, :date_of_birth, :gender, :address,
         :fineract_client_id, :fineract_external_id, :created_at, :updated_at
end
