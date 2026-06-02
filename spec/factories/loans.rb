FactoryBot.define do
  factory :loan do
    association :organization
    association :borrower
    association :loan_product
    fineract_loan_id { 1001 }
    status { "submitted" }
    principal_amount { 1000 }
  end
end
