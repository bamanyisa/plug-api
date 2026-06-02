module Api
  module V1
    class LoansController < BaseController
      def index
        render json: fineract.get("/loans", clientId: params[:borrower_id], limit: params[:limit], offset: params[:offset])
      end

      def show
        render json: fineract.get("/loans/#{params[:id]}")
      end

      def schedule
        render json: fineract.get("/loans/#{params[:id]}/repaymentschedule")
      end

      def approve
        render json: fineract.post("/loans/#{params[:id]}/commands?command=approve", approve_params)
      end

      def disburse
        render json: fineract.post("/loans/#{params[:id]}/disbursements", disburse_params)
      end

      private

      def approve_params
        params.permit(:approvedOnDate, :note, :locale, :dateFormat)
      end

      def disburse_params
        params.permit(:actualDisbursementDate, :transactionAmount, :paymentTypeId, :locale, :dateFormat)
      end

      def fineract
        Fineract::BaseClient.new(current_user.organization, fineract_token)
      end
    end
  end
end
