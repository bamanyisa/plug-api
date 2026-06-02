module Api
  module V1
    class LoanProductsController < BaseController
      def index
        records = policy_scope(LoanProduct).order(created_at: :desc).page(params[:page])
        render json: { data: LoanProductBlueprint.render_as_hash(records), meta: pagination_meta(records) }
      end

      def show
        record = LoanProduct.find(params[:id])
        authorize record
        render json: LoanProductBlueprint.render_as_hash(record)
      end

      def create
        record = LoanProduct.new(loan_product_params)
        authorize record
        record.save!
        SyncLoanProductToFineractJob.perform_later(current_user.organization_id, record.id)
        render json: LoanProductBlueprint.render_as_hash(record), status: :created
      end

      def update
        record = LoanProduct.find(params[:id])
        authorize record
        record.update!(loan_product_params)
        render json: LoanProductBlueprint.render_as_hash(record)
      end

      private

      def loan_product_params
        params.permit(:name, :short_name, :currency_code, :currency_decimal_places, :min_principal, :max_principal,
                      :default_principal, :nominal_interest_rate, :amortization_type, :interest_type,
                      :repayment_frequency, :repayment_every, :number_of_repayments, :active)
      end
    end
  end
end
