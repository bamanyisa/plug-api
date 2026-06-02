class LoanApplicationPolicy < ApplicationPolicy
  def submit?
    same_org?
  end

  def approve?
    same_org? && approver?
  end

  def reject?
    same_org? && approver?
  end

  def withdraw?
    same_org?
  end

  private

  def approver?
    user.role.in?(%w[org_admin loan_officer])
  end
end
