Rails.application.routes.draw do
  resources :profile
  resources :categories
  resources :liabilities
  resources :assets
  get 'balance', to: 'income_statement#index'
  devise_scope :user do
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
    }
    unauthenticated do
      root 'devise/sessions#new'
    end
    authenticated do
      root 'income_statement#index', as: :authenticated_root
    end
  end

  namespace :api do
    devise_for :users, defaults: { format: :json },
               class_name: "ApiUser",
               skip: [:registrations, :invitations,
                      :passwords, :confirmations,
                      :unlocks],
               path: "",
               path_names: { sign_in: "login",
                             sign_out: "logout" }
    devise_scope :user do
      get "login", to: "users/sessions#new"
      delete "logout", to: "users/sessions#destroy"
    end
  end
end
