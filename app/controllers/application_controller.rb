class ApplicationController < ActionController::API
  include Doorkeeper::Rails::Helpers
  include Pundit::Authorization

  before_action :doorkeeper_authorize!
  before_action :set_current_tenant

  rescue_from Pundit::NotAuthorizedError,   with: :not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def current_user
    # Use without_tenant so this bootstrap lookup works even if require_tenant!
    # is set globally — tenant isn't known yet at this point in the request.
    @current_user ||= ActsAsTenant.without_tenant { User.find(doorkeeper_token.resource_owner_id) }
  end

  # The raw JWT — passed to Fineract services so Fineract can authenticate
  # the user directly via its OAuth2 configuration (JWKS from Doorkeeper).
  def fineract_token
    doorkeeper_token.token
  end

  def set_current_tenant
    ActsAsTenant.current_tenant = current_user.organization
  end

  def not_authorized
    render json: { error: "Forbidden" }, status: :forbidden
  end

  def not_found
    render json: { error: "Not found" }, status: :not_found
  end

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      total_pages:  collection.total_pages,
      total_count:  collection.total_count
    }
  end
end
