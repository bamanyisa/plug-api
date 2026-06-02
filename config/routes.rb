Rails.application.routes.draw do
  use_doorkeeper
  use_doorkeeper_openid_connect

  get "up",     to: "rails/health#show", as: :rails_health_check
  get "health", to: proc { [200, { "Content-Type" => "application/json" }, ['{"status":"ok"}']] }

  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"

      # Plug-owned: identity + pre-submission workflow
      resources :borrowers,         only: %i[index create show update]
      resources :loan_applications, only: %i[index create show] do
        member do
          post :submit
          post :reject
        end
      end

      # Fineract proxy: financial data lives in Fineract
      resources :loan_products, only: %i[index create show update]
      resources :loans,         only: %i[index show] do
        member do
          post :approve
          post :disburse
          get  :schedule
        end
      end
      resources :disbursements, only: %i[index show]

      get "portfolio/summary", to: "portfolio#summary"
    end
  end
end
