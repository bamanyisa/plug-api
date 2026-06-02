Doorkeeper::OpenidConnect.configure do
  issuer { Rails.application.credentials.doorkeeper_jwt_issuer.presence || ENV.fetch("DOORKEEPER_JWT_ISSUER", "https://api.plug.ug") }

  signing_key { Rails.application.credentials.doorkeeper_jwt_secret.presence || ENV.fetch("DOORKEEPER_JWT_SECRET", "dev-doorkeeper-jwt-secret") }

  signing_algorithm :hs256

  subject do |resource_owner, _application|
    resource_owner.id.to_s
  end

  resource_owner_from_access_token do |access_token|
    User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    resource_owner.last_sign_in_at if resource_owner.respond_to?(:last_sign_in_at)
  end

  expiration 2.hours.to_i

  claims do
    normal_claim :email do |resource_owner|
      resource_owner.email
    end

    normal_claim :role do |resource_owner|
      resource_owner.role
    end

    normal_claim :organization_id do |resource_owner|
      resource_owner.organization_id
    end

    normal_claim :fineract_tenant_id do |resource_owner|
      resource_owner.organization&.fineract_tenant_id
    end

    normal_claim :preferred_username do |resource_owner|
      resource_owner.fineract_username || resource_owner.email
    end
  end
end
