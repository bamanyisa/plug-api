module Api
  module V1
    class DisbursementsController < BaseController
      def index
        render json: fineract.get("/loans/#{params[:loan_id]}/transactions")
      end

      def show
        render json: fineract.get("/loans/#{params[:loan_id]}/transactions/#{params[:id]}")
      end

      private

      def fineract
        Fineract::BaseClient.new(current_user.organization, fineract_token)
      end
    end
  end
end
