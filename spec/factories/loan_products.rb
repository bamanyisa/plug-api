FactoryBot.define do
  factory :loan_product do
    association :organization
    name { "SME Loan" }
    short_name { "SME" }
    currency_code { "USD" }
  end
end
