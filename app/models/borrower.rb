class Borrower < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :organization
  has_many :loan_applications, dependent: :restrict_with_exception
  has_many :loans, dependent: :restrict_with_exception

  validates :organization, :first_name, :last_name, presence: true
end
