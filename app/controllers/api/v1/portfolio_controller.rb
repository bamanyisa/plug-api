module Api
  module V1
    class PortfolioController < BaseController
      def summary
        loans = policy_scope(Loan)
        disbursements = policy_scope(Disbursement)

        render json: {
          borrowers_count: policy_scope(Borrower).count,
          loan_products_count: policy_scope(LoanProduct).count,
          loan_applications_count: policy_scope(LoanApplication).count,
          loans_count: loans.count,
          disbursements_count: disbursements.count,
          total_principal: loans.sum(:principal_amount),
          total_disbursed: disbursements.sum(:amount)
        }
      end
    end
  end
end
