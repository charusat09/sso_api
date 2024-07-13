Rails.application.routes.draw do
  # Devise routes
  devise_for :users, skip: [:sessions, :registrations, :confirmations], controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Doorkeeper routes
  use_doorkeeper

  # API routes
  namespace :api do
    namespace :v1 do
      resources :tests, only: [:index]
    end
  end
end
