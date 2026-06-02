class LoanProduct < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :organization
  has_many :loan_applications, dependent: :restrict_with_exception
  has_many :loans, dependent: :restrict_with_exception

  validates :organization, :name, :short_name, :currency_code, presence: true
end
