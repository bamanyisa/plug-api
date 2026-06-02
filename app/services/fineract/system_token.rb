module Fineract
  # Obtains a short-lived Doorkeeper JWT using the system client credentials.
  # Used by background jobs that run outside of a user request context.
  module SystemToken
    def self.fetch
      app = Doorkeeper::Application.find_by!(name: "plug-system")

      response = Faraday.post(
        "#{Rails.application.routes.url_helpers.root_url}oauth/token",
        {
          grant_type:    "client_credentials",
          client_id:     app.uid,
          client_secret: app.secret
        }
      )

      body = JSON.parse(response.body)
      body["access_token"] or raise "Failed to obtain system token: #{body}"
    end
  end
end
