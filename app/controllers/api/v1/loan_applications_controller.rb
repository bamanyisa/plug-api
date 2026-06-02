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
        record.update!(status: "submitted", submitted_at: Time.current)
        CreateLoanFromApplicationJob.perform_later(current_user.organization_id, record.id)
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      def approve
        record = LoanApplication.find(params[:id])
        authorize record, :approve?
        record.update!(status: "approved", approved_at: Time.current, approved_by: current_user)
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      def reject
        record = LoanApplication.find(params[:id])
        authorize record, :reject?
        record.update!(status: "rejected", rejected_at: Time.current, rejection_reason: params[:rejection_reason], approved_by: current_user)
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      def withdraw
        record = LoanApplication.find(params[:id])
        authorize record, :withdraw?
        record.update!(status: "withdrawn")
        render json: LoanApplicationBlueprint.render_as_hash(record)
      end

      private

      def loan_application_params
        params.permit(:borrower_id, :loan_product_id, :assigned_officer_id, :requested_amount, :requested_term, :purpose, additional_fields: {})
      end
    end
  end
end
