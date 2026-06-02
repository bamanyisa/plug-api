class Loan < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :organization
  belongs_to :borrower
  belongs_to :loan_product
  belongs_to :loan_application, optional: true
  belongs_to :assigned_officer, class_name: "User", optional: true

  has_many :disbursements, dependent: :restrict_with_exception

  validates :organization, :borrower, :loan_product, :fineract_loan_id, presence: true
end
