FactoryBot.define do
  factory :borrower do
    association :organization
    first_name { "Sarah" }
    last_name { "Nakato" }
    phone { "+256700000000" }
  end
end
