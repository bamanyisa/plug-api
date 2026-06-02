class ApplicationJob < ActiveJob::Base
  queue_as :default

  # All subclass jobs MUST call with_tenant to restore tenant context.
  # ActsAsTenant.current_tenant is NOT propagated across Sidekiq thread boundaries.
  def with_tenant(organization_id)
    org = Organization.find(organization_id)
    ActsAsTenant.with_tenant(org) { yield org }
  end

  def system_token
    Fineract::SystemToken.fetch
  end
end
