class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  ROLES = %w[super_admin org_admin loan_officer cashier auditor].freeze

  acts_as_tenant :organization

  belongs_to :organization

  validates :organization, :role, presence: true
  validates :role, inclusion: { in: ROLES }

  has_many :assigned_loan_applications, class_name: "LoanApplication", foreign_key: :assigned_officer_id, dependent: :nullify, inverse_of: :assigned_officer
  has_many :approved_loan_applications, class_name: "LoanApplication", foreign_key: :approved_by_id, dependent: :nullify, inverse_of: :approved_by
end
