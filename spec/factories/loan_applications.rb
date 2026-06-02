FactoryBot.define do
  factory :loan_application do
    association :organization
    association :borrower
    association :loan_product
    requested_amount { 1000 }
    status { "draft" }
  end
end
