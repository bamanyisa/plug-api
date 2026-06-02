Doorkeeper::JWT.configure do
  secret = Rails.application.credentials.doorkeeper_jwt_secret.presence || ENV["DOORKEEPER_JWT_SECRET"].presence || "dev-doorkeeper-jwt-secret"
  secret_key secret
  signing_method :hs512

  token_payload do |opts|
    user = User.find(opts[:resource_owner_id])
    {
      iss: "plug-api",
      iat: Time.now.to_i,
      jti: SecureRandom.uuid,
      sub: user.id,
      email: user.email,
      role: user.role,
      organization_id: user.organization_id,
      fineract_tenant_id: user.organization.fineract_tenant_id,
      preferred_username: user.fineract_username
    }
  end
end
