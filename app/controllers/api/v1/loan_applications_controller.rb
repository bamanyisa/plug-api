module Api
  module V1
    class LoanApplicationsController < BaseController
      def index
        records = policy_scope(LoanApplication).order(created_at: :desc).page(params[:page])
        render json: { data: LoanApplicationBlueprint.render_as_hash(records), meta: pagination_meta(records) }
      end

      def show
        record = LoanApplication.find(params[:id])
        authorize record
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      def create
        record = LoanApplication.new(loan_application_params)
        authorize record
        record.save!
        render json: LoanApplicationBlueprint.render_as_hash(record), status: :created
      end

      def submit
        record = LoanApplication.find(params[:id])
        authorize record, :submit?

        response = fineract.post("/loans", {
          clientId:          record.borrower.fineract_client_id,
          productId:         record.fineract_product_id,
          principal:         record.requested_amount,
          loanTermFrequency: record.requested_term,
          submittedOnDate:   Date.current.strftime("%Y-%m-%d"),
          loanType:          "individual",
          locale:            "en",
          dateFormat:        "yyyy-MM-dd"
        })

        record.update!(status: "submitted", fineract_loan_id: response["loanId"] || response["resourceId"])
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      def reject
        record = LoanApplication.find(params[:id])
        authorize record, :reject?
        record.update!(status: "rejected", rejection_reason: params[:rejection_reason])
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      private

      def loan_application_params
        params.permit(:borrower_id, :fineract_product_id, :assigned_officer_id,
                      :requested_amount, :requested_term, :purpose)
      end

      def fineract
        Fineract::BaseClient.new(current_user.organization, fineract_token)
      end
    end
  end
end
