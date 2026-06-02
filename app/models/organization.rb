class Organization < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception
  has_many :borrowers, dependent: :restrict_with_exception
  has_many :loan_products, dependent: :restrict_with_exception
  has_many :loan_applications, dependent: :restrict_with_exception
  has_many :loans, dependent: :restrict_with_exception
  has_many :disbursements, dependent: :restrict_with_exception

  validates :name, :slug, :fineract_tenant_id, :fineract_base_url, presence: true
end
