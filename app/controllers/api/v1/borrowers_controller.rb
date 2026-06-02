module Api
  module V1
    class BorrowersController < BaseController
      def index
        borrowers = policy_scope(Borrower).order(created_at: :desc).page(params[:page])
        render json: { data: BorrowerBlueprint.render_as_hash(borrowers), meta: pagination_meta(borrowers) }
      end

      def show
        borrower = Borrower.find(params[:id])
        authorize borrower
        render json: BorrowerBlueprint.render_as_hash(borrower)
      end

      def create
        borrower = Borrower.new(borrower_params.merge(fineract_external_id: SecureRandom.uuid))
        authorize borrower
        borrower.save!
        SyncBorrowerToFineractJob.perform_later(current_user.organization_id, borrower.id)
        render json: BorrowerBlueprint.render_as_hash(borrower), status: :created
      end

      def update
        borrower = Borrower.find(params[:id])
        authorize borrower
        borrower.update!(borrower_params)
        render json: BorrowerBlueprint.render_as_hash(borrower)
      end

      private

      def borrower_params
        params.permit(:first_name, :last_name, :email, :phone, :national_id, :date_of_birth, :gender, :address)
      end
    end
  end
end
