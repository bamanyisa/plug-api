module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: :register
      skip_before_action :set_current_tenant, only: :register

      def register
        organization = Organization.find(params[:organization_id])
        user = organization.users.new(email: params[:email], password: params[:password], role: params[:role] || "loan_officer")
        user.save!

        app = Doorkeeper::Application.find_by(uid: params[:client_id])
        token = Doorkeeper::AccessToken.create!(
          resource_owner_id: user.id,
          application_id: app&.id,
          scopes: "api",
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i
        )

        render json: { user: { id: user.id, email: user.email, role: user.role }, token: token.token }, status: :created
      end
    end
  end
end
