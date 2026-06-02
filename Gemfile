source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "pg",    "~> 1.1"
gem "puma",  ">= 5.0"

# Auth
gem "devise"
gem "doorkeeper"
gem "doorkeeper-jwt"
gem "doorkeeper-openid_connect"  # exposes /.well-known/openid-configuration for Fineract OIDC discovery

# Multi-tenancy
gem "acts_as_tenant"

# Authorization
gem "pundit"

# Serialization
gem "blueprinter"

# Fineract HTTP client
gem "faraday"
gem "faraday-retry"

# Background jobs
gem "sidekiq", "~> 7.0"
gem "redis",   "~> 5.0"

# Utilities
gem "rack-cors"
gem "kaminari"

# System
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "kamal",    require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "shoulda-matchers"
  gem "database_cleaner-active_record"
  gem "webmock"
  gem "vcr"
  gem "brakeman",             require: false
  gem "rubocop-rails-omakase", require: false
end
