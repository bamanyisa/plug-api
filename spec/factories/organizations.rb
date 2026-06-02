FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "Org #{n}" }
    sequence(:slug) { |n| "org-#{n}" }
    sequence(:fineract_tenant_id) { |n| "tenant-#{n}" }
    fineract_base_url { "https://fineract.example.com" }
    fineract_service_auth { "Zm9vOmJhcg==" }
    timezone { "UTC" }
    currency { "USD" }
    active { true }
  end
end
