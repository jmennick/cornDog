Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: redirect('/accounts')
  resources :accounts

  # namespace :pdf, format: :pdf do
  #   get :chart_of_accounts, to: 'chart_of_accounts#chart_of_accounts'
  #   get :test, to: 'test#test'
  # end

  # scope 'api', format: :json do
  #   jsonapi_resources :accounts
  #   scope only: %i(index create update) do
  #     jsonapi_resources :current_asset_accounts
  #     jsonapi_resources :long_term_asset_accounts
  #     jsonapi_resources :current_liability_accounts
  #     jsonapi_resources :long_term_asset_accounts
  #     jsonapi_resources :expense_accounts
  #     jsonapi_resources :revenue_accounts
  #   end
  # end
end
