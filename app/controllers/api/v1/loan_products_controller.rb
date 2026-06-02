module Api
  module V1
    class LoanProductsController < BaseController
      def index
        render json: fineract.get("/loanproducts")
      end

      def show
        render json: fineract.get("/loanproducts/#{params[:id]}")
      end

      def create
        render json: fineract.post("/loanproducts", loan_product_params), status: :created
      end

      def update
        render json: fineract.put("/loanproducts/#{params[:id]}", loan_product_params)
      end

      private

      def loan_product_params
        params.permit(:name, :shortName, :currencyCode, :digitsAfterDecimal,
                      :minPrincipal, :maxPrincipal, :principal,
                      :interestRatePerPeriod, :repaymentEvery, :numberOfRepayments,
                      :amortizationType, :interestType, :repaymentFrequencyType,
                      :locale, :dateFormat)
      end

      def fineract
        Fineract::BaseClient.new(current_user.organization, fineract_token)
      end
    end
  end
end
