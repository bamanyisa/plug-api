module Api
  module V1
    class BaseController < ApplicationController
      rescue_from Fineract::NotFoundError,   with: :fineract_not_found
      rescue_from Fineract::ValidationError, with: :fineract_validation_error
      rescue_from Fineract::Error,           with: :fineract_error

      private

      def fineract_not_found(e)
        render json: { error: e.message }, status: :not_found
      end

      def fineract_validation_error(e)
        render json: { error: e.message, details: e.fineract_errors }, status: :unprocessable_entity
      end

      def fineract_error(e)
        render json: { error: e.message }, status: :bad_gateway
      end
    end
  end
end
