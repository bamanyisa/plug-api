FactoryBot.define do
  factory :loan_application do
    association :organization
    association :borrower
    fineract_product_id { 1 }
    requested_amount { 1000 }
    status { "draft" }
  end
end
