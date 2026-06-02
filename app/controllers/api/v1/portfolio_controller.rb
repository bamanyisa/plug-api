module Api
  module V1
    class PortfolioController < BaseController
      def summary
        client = Fineract::BaseClient.new(current_user.organization, fineract_token)
        render json: {
          borrowers:         policy_scope(Borrower).count,
          loan_applications: policy_scope(LoanApplication).group(:status).count,
          loans:             client.get("/loans/summary")
        }
      end
    end
  end
end
