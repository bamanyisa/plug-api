class LoanPolicy < ApplicationPolicy
  def disburse?
    same_org? && user.role.in?(%w[org_admin loan_officer cashier])
  end

  def schedule?
    same_org?
  end
end
