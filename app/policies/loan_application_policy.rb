class LoanApplicationPolicy < ApplicationPolicy
  def submit?
    same_org?
  end

  def reject?
    same_org? && user.role.in?(%w[org_admin loan_officer])
  end
end
