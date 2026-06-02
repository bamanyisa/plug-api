Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do |_routes|
    user = User.find_by(email: params[:username])
    user if user&.valid_password?(params[:password])
  end

  grant_flows %w[password authorization_code client_credentials refresh_token]
  access_token_expires_in 2.hours
  use_refresh_token
  default_scopes :api
end
