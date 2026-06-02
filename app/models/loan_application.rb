class LoanApplication < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :organization
  belongs_to :borrower
  belongs_to :assigned_officer, class_name: "User", optional: true

  STATUSES = %w[draft submitted rejected].freeze

  validates :organization, :borrower, :fineract_product_id, :requested_amount, presence: true
  validates :status, inclusion: { in: STATUSES }
end
