FactoryBot.define do
  factory :user do
    association :organization
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "secret123" }
    role { "loan_officer" }
  end
end
