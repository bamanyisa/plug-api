module Api
  module V1
    class LoansController < BaseController
      def index
        records = policy_scope(Loan).order(created_at: :desc).page(params[:page])
        render json: { data: LoanBlueprint.render_as_hash(records), meta: pagination_meta(records) }
      end

      def show
        record = Loan.find(params[:id])
        authorize record
        render json: LoanBlueprint.render_as_hash(record)
      end

      def disburse
        record = Loan.find(params[:id])
        authorize record, :disburse?
        disbursement = Disbursement.create!(
          organization: record.organization,
          loan: record,
          disbursed_by: current_user,
          amount: params[:amount],
          disbursed_on: params[:disbursed_on] || Date.current,
          payment_type: params[:payment_type]
        )
        DisburseLoanJob.perform_later(current_user.organization_id, disbursement.id)
        render json: DisbursementBlueprint.render_as_hash(disbursement), status: :accepted
      end

      def schedule
        record = Loan.find(params[:id])
        authorize record, :schedule?
        response = Fineract::ScheduleService.new(record.organization).get(record.fineract_loan_id)
        render json: response
      end
    end
  end
end
