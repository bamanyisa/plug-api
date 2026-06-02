class LoanApplication < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :organization
  belongs_to :borrower
  belongs_to :loan_product
  belongs_to :assigned_officer, class_name: "User", optional: true
  belongs_to :approved_by, class_name: "User", optional: true

  has_one :loan, dependent: :nullify

  validates :organization, :borrower, :loan_product, :status, :requested_amount, presence: true
end
