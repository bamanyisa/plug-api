Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("ALLOWED_ORIGINS", "http://localhost:3000").split(",")
    resource "/api/*", headers: :any, methods: %i[get post put patch delete options]
    resource "/oauth/*", headers: :any, methods: %i[post options]
    resource "/health", headers: :any, methods: %i[get]
  end
end
