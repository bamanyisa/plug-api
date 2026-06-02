module Api
  module V1
    class DisbursementsController < BaseController
      def index
        records = policy_scope(Disbursement).order(created_at: :desc).page(params[:page])
        render json: { data: DisbursementBlueprint.render_as_hash(records), meta: pagination_meta(records) }
      end

      def show
        record = Disbursement.find(params[:id])
        authorize record
        render json: DisbursementBlueprint.render_as_hash(record)
      end
    end
  end
end
