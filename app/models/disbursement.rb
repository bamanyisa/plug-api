class Disbursement < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :organization
  belongs_to :loan
  belongs_to :disbursed_by, class_name: "User", optional: true

  validates :organization, :loan, :amount, :disbursed_on, presence: true
end
