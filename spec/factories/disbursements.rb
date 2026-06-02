FactoryBot.define do
  factory :disbursement do
    association :organization
    association :loan
    amount { 1000 }
    disbursed_on { Date.current }
    status { "pending" }
  end
end
